// ============================================================================
// PROFILE: MNCH Referral Transaction Bundle
// ============================================================================
Profile: NgMNCHReferralBundle
Parent: Bundle
Id: ng-mnch-referral-bundle
Title: "3-NGReferral MNCH Transaction Bundle"
Description: "Transaction bundle for MNCH referrals between facilities and/or payers.
The bundle MUST contain a Patient and a ServiceRequest (the referral order).
Optional entries (Communication, Task, Encounter, Organization, Practitioner, etc.)
may be included to support initiation, communication, response, and tracking."

* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-mnch-referral-bundle"
* ^version = "1.0.0"
* ^status = #active
* ^date = "2025-10-15"
* ^publisher = "DHIN 2025 Connectathon"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
* ^purpose = "A transaction bundle pattern for MNCH referrals: requires Patient and ServiceRequest, supports communication, response, and tracking workflows."

// Bundle metadata
* type 1..1 MS
* type = #transaction (exactly)

* identifier 1..1 MS
* identifier ^short = "Identifier for this referral transaction bundle"
* identifier ^definition = "A unique identifier for tracking and auditing the MNCH referral transaction."

* timestamp 1..1 MS
* timestamp ^short = "When the bundle was assembled"
* timestamp ^definition = "The date/time when this referral transaction bundle was assembled by the submitting system."

// Entries + slicing
* entry 1..* MS
* entry.fullUrl 1..
* entry.search ..0
* entry.response ..0

* entry ^slicing.discriminator[0].type = #type
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.discriminator[1].type = #profile
* entry ^slicing.discriminator[1].path = "resource"
* entry ^slicing.rules = #open
* entry ^comment = "Must contain one Patient and one ServiceRequest (referral). Others are allowed."

* entry contains
    patient 0..1 MS and
    referral 1..1 MS and
    //communication 0..* MS and
    task 0..* MS

// Required slices
* entry[patient].resource only NgPatient
* entry[patient].request.method = #POST
* entry[patient].request.url = "https://sandbox.dhin-hie.org/ig/resources/NgPatient"


* entry[referral].resource only NgServiceRequest
* entry[referral].request.method = #POST
* entry[referral].request.url = "https://sandbox.dhin-hie.org/ig/resources/NgServiceRequest"

// Optional slices
// * entry[communication].resource only NgCommunication
// * entry[communication].request.method = #POST
// * entry[communication].request.url = "https://sandbox.dhin-hie.org/ig/resources/NgCommunication"

* entry[task].resource only NgTask
* entry[task].request.method = #POST
* entry[task].request.url = "Task"

// ============================================================================
// 1. EXAMPLE: Referral + Patient + a Communication message referencing the referral
// ============================================================================
Instance: bundle-referral
InstanceOf: NgMNCHReferralBundle
Title: "MNCH Referral — Communication"
Usage: #example
Description: "EXAMPLE: MNCH Referral + Patient + a Communication message referencing the referral"
* type = #transaction
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-bundle-identifier-cs"
* identifier.value = "BND-0021"
* timestamp = "2025-10-16T08:30:00+01:00"

// Patient (local)
* entry[patient].fullUrl = "urn:uuid:6e8b1c2d-1a23-4bcd-95ef-0a1b2c3d4e21"
* entry[patient].resource = NgPatient-001
* entry[patient].request.method = #POST

// Referral (ServiceRequest) — subject points to patient UUID
* entry[referral].fullUrl = "urn:uuid:7f9c2d3e-2b34-5cde-a6f0-1b2c3d4e5f22"
* entry[referral].resource = NgServiceRequest-001
* entry[referral].resource.status = #active
* entry[referral].resource.intent = #order
* entry[referral].resource.category[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/service-category"
* entry[referral].resource.category[0].coding[0].code = #4
* entry[referral].resource.category[0].coding[0].display = "Child Care /Kindergarten"
* entry[referral].resource.code.text = "MNCH referral for ANC complication"
* entry[referral].resource.subject = Reference(NgPatient-001)
* entry[referral].resource.requester = Reference(NgPractitioner-001)
* entry[referral].resource.performer[0] = Reference(NgOrganization-001)
* entry[referral].request.method = #POST





// ============================================================================
// 2. EXAMPLE: Referral initiation with a Task assigned to a receiving facility
// ============================================================================

Instance: bundle-referral-initiation
InstanceOf: NgMNCHReferralBundle
Title: "MNCH Referral — Initiation"
Description: "EXAMPLE: MNCH Referral Initiation"
Usage: #example

* type = #transaction
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-bundle-identifier-cs"
* identifier.value = "BND-0022"
* timestamp = "2025-10-16T09:00:00+01:00"

// Patient
* entry[patient].fullUrl = "urn:uuid:90b1c2d3-4e56-47f8-8a90-abc123def024"
* entry[patient].resource = NgPatient-002
* entry[patient].request.method = #POST

// Referral (ServiceRequest)
* entry[referral].fullUrl = "urn:uuid:a1c2d3e4-5f67-4890-9ab1-bc23def45625"
* entry[referral].resource = NgServiceRequest-001
* entry[referral].resource.status = #active
* entry[referral].resource.intent = #order
* entry[referral].resource.code.text = "MNCH referral initiation — suspected pre-eclampsia"
* entry[referral].resource.subject = Reference(urn:uuid:90b1c2d3-4e56-47f8-8a90-abc123def024)
* entry[referral].resource.requester = Reference(NgPractitioner-002)
* entry[referral].resource.performer[0] = Reference(NgOrganization-001)
* entry[referral].request.method = #POST

// Task to receiving facility (tracks referral workflow)
* entry[task].fullUrl = "urn:uuid:b2d3e4f5-6071-4a82-ab93-cd34ef567026"
* entry[task].resource = NgTask-001
* entry[task].resource.status = #requested
* entry[task].resource.intent = #order
* entry[task].resource.code.text = "Process MNCH referral"
* entry[task].resource.for = Reference(urn:uuid:90b1c2d3-4e56-47f8-8a90-abc123def024)
* entry[task].resource.focus = Reference(urn:uuid:a1c2d3e4-5f67-4890-9ab1-bc23def45625)
* entry[task].resource.authoredOn = "2025-10-16T09:00:30+01:00"
* entry[task].resource.requester = Reference(NgOrganization-002)
* entry[task].resource.owner = Reference(NgOrganization-001)
* entry[task].request.method = #POST


// ============================================================================
// 3. EXAMPLE: Receiving facility responds — Task accepted & a Communication sent back
// ============================================================================
Instance: bundle-referral-response
InstanceOf: NgMNCHReferralBundle
Title: "MNCH Referral — Response (Acceptance)"
Description: "EXAMPLE: MNCH Referral Response"
Usage: #example

* type = #transaction
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-bundle-identifier-cs"
* identifier.value = "BND-0023"
* timestamp = "2025-10-16T10:10:00+01:00"

// Patient
* entry[patient].fullUrl = "urn:uuid:c3d4e5f6-7182-4b93-ac04-de45f6789027"
* entry[patient].resource = NgPatient-003
* entry[patient].request.method = #POST

// Referral (ServiceRequest)
* entry[referral].fullUrl = "urn:uuid:d4e5f6a7-8293-4ca4-bd15-ef56a7890128"
* entry[referral].resource = NgServiceRequest-001
* entry[referral].resource.status = #active
* entry[referral].resource.intent = #order
* entry[referral].resource.code.text = "MNCH referral — fetal distress"
* entry[referral].resource.subject = Reference(urn:uuid:c3d4e5f6-7182-4b93-ac04-de45f6789027)
* entry[referral].resource.requester = Reference(NgPractitioner-003)
* entry[referral].resource.performer[0] = Reference(NgOrganization-001)
* entry[referral].request.method = #POST

// Task (acceptance)
* entry[task].fullUrl = "urn:uuid:e5f6a7b8-93a4-4db5-ce26-f067a8901329"
* entry[task].resource = NgTask-001
* entry[task].resource.status = #accepted
* entry[task].resource.intent = #order
* entry[task].resource.code.text = "Accept MNCH referral"
* entry[task].resource.for = Reference(urn:uuid:c3d4e5f6-7182-4b93-ac04-de45f6789027)
* entry[task].resource.focus = Reference(urn:uuid:d4e5f6a7-8293-4ca4-bd15-ef56a7890128)
* entry[task].resource.lastModified = "2025-10-16T10:09:00+01:00"
* entry[task].resource.owner = Reference(NgOrganization-001)
* entry[task].request.method = #POST




// =================================================================
// 4. EXAMPLE: Ongoing tracking — Task in progress with update notes
// =================================================================
Instance: bundle-referral-tracking
InstanceOf: NgMNCHReferralBundle
Title: "MNCH Referral — Tracking (In Progress)"
Description: "EXAMPLE: MNCH Referral Tracking"
Usage: #example

* type = #transaction
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-bundle-identifier-cs"
* identifier.value = "BND-0024"
* timestamp = "2025-10-16T11:25:00+01:00"

// Patient
* entry[patient].fullUrl = "urn:uuid:0aa1bb2c-cc33-4dd4-8ee5-ff6677889901"
* entry[patient].resource = NgPatient-002
* entry[patient].request.method = #POST

// Referral (ServiceRequest)
* entry[referral].fullUrl = "urn:uuid:1bb2cc3d-dd44-5ee5-9ff6-00778899aa02"
* entry[referral].resource = NgServiceRequest-002
* entry[referral].resource.status = #active
* entry[referral].resource.intent = #order
* entry[referral].resource.code.text = "MNCH referral — follow-up ANC visit"
* entry[referral].resource.subject = Reference(urn:uuid:0aa1bb2c-cc33-4dd4-8ee5-ff6677889901)
* entry[referral].resource.requester = Reference(NgOrganization-001)
* entry[referral].resource.performer[0] = Reference(NgPractitioner-001)
* entry[referral].request.method = #POST

// Task (in-progress tracking)
* entry[task].fullUrl = "urn:uuid:2cc3dd4e-ee55-6ff6-a007-1899aabbcc03"
* entry[task].resource = NgTask-001
* entry[task].resource.status = #in-progress
* entry[task].resource.intent = #order
* entry[task].resource.code.text = "Track referral status"
* entry[task].resource.for = Reference(urn:uuid:0aa1bb2c-cc33-4dd4-8ee5-ff6677889901)
* entry[task].resource.focus = Reference(urn:uuid:1bb2cc3d-dd44-5ee5-9ff6-00778899aa02)
* entry[task].resource.lastModified = "2025-10-16T11:20:00+01:00"
* entry[task].resource.description = "Ambulance dispatched, ETA 30 minutes."
* entry[task].request.method = #POST
