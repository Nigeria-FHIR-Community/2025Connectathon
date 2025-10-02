// ==============================================
// Profile: NgReferralInitiationBundle
// ==============================================
Profile: NgReferralInitiationBundle
Parent: Bundle
Id: ng-referral-initiation-bundle
Title: "2-NG MNCH Referral Initiation Bundle"
Description: "Bundle profile for a simple referral initiation from a PHC to a secondary hospital. Constrains a collection Bundle to include exactly one Patient, one requesting Organization (PHC), one receiving Organization (Secondary Hospital), and one ServiceRequest. Designed to align with 'bundle-referral-initiation' example."

// Bundle basics
* type 1..1 MS
* type = #collection (exactly)
* entry 4..* MS
* entry.fullUrl 1..1 MS
* entry.resource 1..1 MS

// Slice entries by the profile of the inlined resource
* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #open

// Required slices: Patient, Requesting Organization, Receiving Organization, ServiceRequest
* entry contains
    patient 1..1 MS and
    requesterOrg 1..1 MS and
    recipientOrg 1..1 MS and
    serviceRequest 1..1 MS

// Patient slice
* entry[patient].fullUrl ^short = "Local URN UUID used by ServiceRequest.subject"
* entry[patient].resource only NgPatient

// Requesting Organization (PHC) slice
* entry[requesterOrg].fullUrl ^short = "Local URN UUID used by ServiceRequest.requester"
* entry[requesterOrg].resource only NgOrganization

// Receiving Organization (Secondary Hospital) slice
* entry[recipientOrg].fullUrl ^short = "Local URN UUID used by ServiceRequest.performer"
* entry[recipientOrg].resource only NgOrganization

// ServiceRequest slice
* entry[serviceRequest].resource only NgServiceRequest
* entry[serviceRequest].fullUrl ^short = "Local URN UUID for the referral request itself"

// --------------------
// Invariants (soft; to reduce QA friction)
// --------------------

// Prefer URN UUID fullUrls for intra-bundle references
Invariant: ngref-uuid-fullurl
Description: "Entries SHOULD use URN UUID fullUrls for local intra-bundle references."
Severity: #warning
Expression: "entry.fullUrl.all(matches('^urn:uuid:'))"

// ServiceRequest.subject/requester/performer SHOULD be local URN UUIDs
Invariant: ngref-uuid-sr-refs
Description: "ServiceRequest subject/requester/performer references SHOULD be local URN UUIDs."
Severity: #warning
Expression: "entry.resource.ofType(ServiceRequest).subject.reference.all(matches('^urn:uuid:')) and entry.resource.ofType(ServiceRequest).requester.reference.all(matches('^urn:uuid:')) and entry.resource.ofType(ServiceRequest).performer.reference.all(matches('^urn:uuid:'))"

// ServiceRequest.subject MUST resolve to a Patient entry in this Bundle
Invariant: ngref-local-subject
Description: "ServiceRequest.subject MUST reference a Patient present in the same Bundle."
Severity: #error
Expression: "entry.resource.ofType(ServiceRequest).subject.reference.all($this in entry.fullUrl)"

// ServiceRequest.requester MUST resolve to an Organization entry in this Bundle
Invariant: ngref-local-requester
Description: "ServiceRequest.requester MUST reference an Organization present in the same Bundle."
Severity: #error
Expression: "entry.resource.ofType(ServiceRequest).requester.reference.all($this in entry.fullUrl)"

// ServiceRequest.performer SHOULD resolve to an Organization entry in this Bundle
Invariant: ngref-local-performer
Description: "ServiceRequest.performer SHOULD reference an Organization present in the same Bundle."
Severity: #warning
Expression: "entry.resource.ofType(ServiceRequest).performer.reference.all($this in entry.fullUrl)"




// ====================================================================
// Bundle: Referral Initiation (PHC → Secondary Hospital)
// Simple, minimal, FSH example using URN UUID local references
// ====================================================================

Instance: bundle-referral-initiation
InstanceOf: NgReferralInitiationBundle
Usage: #example
Title: "Referral Initiation from PHC to Secondary Hospital"
Description: "PHC raises a ServiceRequest to refer a maternal health patient to a secondary hospital."
* type = #collection

// -- Entries (Patient, Requesting Org, Receiving Org, ServiceRequest) --
* entry[0].fullUrl = "urn:uuid:pat-001"
* entry[0].resource = NgPatient-Ref-001

* entry[+].fullUrl = "urn:uuid:org-001"
* entry[=].resource = NgOrganization-PHC-Ref

* entry[+].fullUrl = "urn:uuid:org-002"
* entry[=].resource = NgOrganization-Secondary-Ref

* entry[+].fullUrl = "urn:uuid:sr-001"
* entry[=].resource = NgServiceRequest-Referral-Init-001



// =========================
// Patient (NgPatient)
// =========================
Instance: NgPatient-Ref-001
InstanceOf: NgPatient
Usage: #inline
Title: "Referred Patient (MNCH)"
* meta.lastUpdated = "2025-10-02T09:00:00+01:00"
* identifier[PhoneNumber].value = "08031234567"
* identifier[PhoneNumber].system = "http://mtnonline.com/phone-no"
* identifier[PhoneNumber].type.coding[0].system = "http://mtnonline.com/phone-no"
* identifier[PhoneNumber].type.coding[0].code = #MOBILE
* identifier[PhoneNumber].type.coding[0].display = "Primary Mobile Phone Number of the Client or CareGiver"
* name.given[0] = "Aisha"
* name.family = "Okafor"
* gender = #female
* active = true
* address.line[0] = "12 PHC Road"
* address.city = "Surulere"
* address.district = "surulere"
* address.state = "LA"



// =========================
// Requesting Organization (PHC) — NgOrganization
// =========================
Instance: NgOrganization-PHC-Ref
InstanceOf: NgOrganization
Usage: #inline
Title: "Idera Maternal PHC (Requesting)"
* identifier[0].system = "https://hfr.health.gov.ng/facility-id"
* identifier[0].value = "HCF-98765"
* active = true
* name = "Idera Maternal PHC"
* type.coding[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type.coding[0].code = #phc-center-l2
* type.coding[0].display = "PHC Center Level 2"
* address.line[0] = "12 PHC Road"
* address.city = "Surulere"
* address.district = "surulere"
* address.state = "LA"



// =========================
// Receiving Organization (Secondary Hospital) — NgOrganization
// =========================
Instance: NgOrganization-Secondary-Ref
InstanceOf: NgOrganization
Usage: #inline
Title: "General Hospital Ikeja (Receiving)"
* identifier[0].system = "https://hfr.health.gov.ng/facility-id"
* identifier[0].value = "HCF-12345"
* active = true
* name = "General Hospital Ikeja"
* type.coding[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type.coding[0].code = #hospital
* type.coding[0].display = "Secondary Hospital"
* address.line[0] = "1 Hospital Avenue"
* address.city = "Ikeja"
* address.district = "ikeja"
* address.state = "LA"



// =========================
// ServiceRequest (Referral) — NgServiceRequest
// =========================
Instance: NgServiceRequest-Referral-Init-001
InstanceOf: NgServiceRequest
Usage: #inline
Title: "MNCH Referral to Secondary Hospital"
Description: "Referral for ANC complication from PHC to OB/GYN at secondary hospital."
* status = #active
* intent = #order
* code.text = "MNCH referral (ANC complication)"
* subject = Reference(urn:uuid:pat-001)
* authoredOn = "2025-10-02"
* requester = Reference(urn:uuid:org-001)
* performer[0] = Reference(urn:uuid:org-002)
* priority = #urgent
* reasonCode[0].coding[0].system = "http://snomed.info/sct"
* reasonCode[0].coding[0].code = #387712008
* reasonCode[0].coding[0].display = "Pre-eclampsia"
