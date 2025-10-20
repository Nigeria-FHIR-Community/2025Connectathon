// ====================================================================
// Profile: NgReferralInitiationBundle
// ====================================================================
Profile: NgReferralInitiationBundle
Parent: Bundle
Id: ng-referral-initiation-bundle
Title: "2-NG MNCH Referral Initiation Bundle"
Description: "Bundle profile for a simple referral initiation from a PHC to a secondary hospital."

* type 1..1 MS
* type = #collection (exactly)
* entry 4..4 MS
* entry.fullUrl 1..1 MS
* entry.resource 1..1 MS
* entry.search ..0
* entry.response ..0

* obeys ngref-uuid-fullurl and ngref-uuid-sr-refs and ngref-local-subject and ngref-local-requester and ngref-local-performer

* entry ^slicing.discriminator[0].type = #type
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.discriminator[+].type = #profile
* entry ^slicing.discriminator[=].path = "resource"
* entry ^slicing.rules = #closed
* entry ^slicing.ordered = true

* entry contains
    patient 1..1 MS and
    requesterOrg 1..1 MS and
    recipientOrg 1..1 MS and
    serviceRequest 1..1 MS

* entry[patient].fullUrl ^short = "Local URN used by ServiceRequest.subject (e.g., urn:pat-001)"
* entry[patient].resource only NgPatient

* entry[requesterOrg].fullUrl ^short = "Local URN used by ServiceRequest.requester (e.g., urn:org-001)"
* entry[requesterOrg].resource only NgOrganization
* entry[requesterOrg].resource.type.coding.code = #phc-center-l2

* entry[recipientOrg].fullUrl ^short = "Local URN used by ServiceRequest.performer (e.g., urn:org-002)"
* entry[recipientOrg].resource only NgOrganization
* entry[recipientOrg].resource.type.coding.code = #hospital

* entry[serviceRequest].resource only NgServiceRequest
* entry[serviceRequest].fullUrl ^short = "Local URN for the referral request (e.g., urn:sr-001)"

Invariant: ngref-uuid-fullurl
Description: "Entries SHOULD use custom URN fullUrls like urn:pat-001, urn:org-001, etc."
Severity: #warning
Expression: "entry.fullUrl.all(matches('^urn:(pat|org|sr)-[0-9]+$'))"

Invariant: ngref-uuid-sr-refs
Description: "ServiceRequest subject/requester/performer references SHOULD be custom URNs."
Severity: #warning
Expression: "entry.resource.ofType(ServiceRequest).subject.reference.all(matches('^urn:(pat|org|sr)-[0-9]+$')) and entry.resource.ofType(ServiceRequest).requester.reference.all(matches('^urn:(pat|org|sr)-[0-9]+$')) and entry.resource.ofType(ServiceRequest).performer.reference.all(matches('^urn:(pat|org|sr)-[0-9]+$'))"

Invariant: ngref-local-subject
Description: "ServiceRequest.subject MUST reference a Patient present in the same Bundle."
Severity: #error
Expression: "entry.resource.ofType(ServiceRequest).subject.reference.all($this in entry.fullUrl)"

Invariant: ngref-local-requester
Description: "ServiceRequest.requester MUST reference an Organization present in the same Bundle."
Severity: #error
Expression: "entry.resource.ofType(ServiceRequest).requester.reference.all($this in entry.fullUrl)"

Invariant: ngref-local-performer
Description: "ServiceRequest.performer SHOULD reference an Organization present in the same Bundle."
Severity: #warning
Expression: "entry.resource.ofType(ServiceRequest).performer.reference.all($this in entry.fullUrl)"

// ====================================================================
// Bundle: Referral Initiation
// ====================================================================
Instance: bundle-referral-initiation
InstanceOf: NgReferralInitiationBundle
Usage: #example
Title: "Referral Initiation from PHC to Secondary Hospital"
Description: "PHC raises a ServiceRequest to refer a maternal health patient to a secondary hospital."
* meta.profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-referral-initiation-bundle"
* type = #collection

* entry[patient].fullUrl = "urn:pat-001"
* entry[patient].resource = NgPatient-Ref-001

* entry[requesterOrg].fullUrl = "urn:org-001"
* entry[requesterOrg].resource = NgOrganization-PHC-Ref

* entry[recipientOrg].fullUrl = "urn:org-002"
* entry[recipientOrg].resource = NgOrganization-Secondary-Ref

* entry[serviceRequest].fullUrl = "urn:sr-001"
* entry[serviceRequest].resource = NgServiceRequest-Referral-Init-001

// =========================
// Patient (NgPatient)
// =========================
Instance: NgPatient-Ref-001
InstanceOf: NgPatient
Usage: #inline
Title: "Referred Patient (MNCH)"
* meta.profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/NgPatient"
* meta.lastUpdated = "2025-10-02T09:00:00+01:00"
* identifier[MedicalRecordsNumber].type.coding[0].system = "http://asokoro.org/medicalrecord-no"
* identifier[MedicalRecordsNumber].type.coding[0].code = #MRN
* identifier[MedicalRecordsNumber].type.coding[0].display = "Medical Record Number"
* identifier[MedicalRecordsNumber].system = "http://asokoro.org/medicalrecord-no"
* identifier[MedicalRecordsNumber].value = "PAT-2025-001"
* identifier[PhoneNumber].type.coding[0].system = "http://mtnonline.com/phone-no"
* identifier[PhoneNumber].type.coding[0].code = #MOBILE
* identifier[PhoneNumber].type.coding[0].display = "Primary Mobile Phone Number of the Client or CareGiver"
* identifier[PhoneNumber].system = "http://mtnonline.com/phone-no"
* identifier[PhoneNumber].value = "+2348031234567"
* name.given[0] = "Aisha"
* name.family = "Okafor"
* gender = #female
* active = true
* address.line[0] = "12 PHC Road"
* address.city = "Surulere"
* address.district = #la-surulere
* address.state = #LA
* address.country = "NG"

// =========================
// Requesting Organization (PHC)
// =========================
Instance: NgOrganization-PHC-Ref
InstanceOf: NgOrganization
Usage: #inline
Title: "Idera Maternal PHC (Requesting)"
* meta.profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/NgOrganization"
* identifier[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier[0].value = "HCF-98765"
* active = true
* name = "Idera Maternal PHC"
* type.coding[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type.coding[0].code = #phc-center-l2
* type.coding[0].display = "PHC Center Level 2"
* address.line[0] = "12 PHC Road"
* address.city = "Surulere"
* address.district = #la-surulere
* address.state = #LA
* address.country = "NG"

// =========================
// Receiving Organization (Secondary Hospital)
// =========================
Instance: NgOrganization-Secondary-Ref
InstanceOf: NgOrganization
Usage: #inline
Title: "General Hospital Ikeja (Receiving)"
* meta.profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/NgOrganization"
* identifier[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier[0].value = "HCF-12345"
* active = true
* name = "General Hospital Ikeja"
* type.coding[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type.coding[0].code = #hospital
* type.coding[0].display = "Secondary Hospital"
* address.line[0] = "1 Hospital Avenue"
* address.city = "Ikeja"
* address.district = #la-ikeja
* address.state = #LA
* address.country = "NG"

// =========================
// ServiceRequest (Referral)
// =========================
Instance: NgServiceRequest-Referral-Init-001
InstanceOf: NgServiceRequest
Usage: #inline
Title: "MNCH Referral to Secondary Hospital"
Description: "Referral for ANC complication from PHC to OB/GYN at secondary hospital."
* meta.profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/NgServiceRequest"
* status = #active
* intent = #order
* code.coding[0].system = "http://snomed.info/sct"
* code.coding[0].code = #416432009
* code.coding[0].display = "Referral to obstetrician (procedure)"
* code.text = "MNCH referral (ANC complication)"
* subject = Reference(urn:pat-001)
* authoredOn = "2025-10-02T09:00:00+01:00"
* requester = Reference(urn:org-001)
* performer[0] = Reference(urn:org-002)
* priority = #urgent
* reasonCode[0].coding[0].system = "http://snomed.info/sct"
* reasonCode[0].coding[0].code = #398254007
* reasonCode[0].coding[0].display = "Pre-eclampsia"
