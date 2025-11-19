// ============================================================================
// PROFILE: MNCH Referral Transaction Bundle
// ============================================================================
Profile: NgMNCHReferralBundle
Parent: Bundle
Id: ng-mnch-referral-bundle
Title: "3-NGReferral MNCH Transaction Bundle"
Description: """
Transaction bundle for MNCH referrals between facilities and/or payers.
MUST contain a Patient and a ServiceRequest (the referral order).
Optional entries (Communication, Task, etc.) may support initiation, response, and tracking.
"""
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-mnch-referral-bundle"
* ^version = "1.0.1"
* ^status = #active
* ^date = "2025-11-19"
* ^publisher = "DHIN 2025 Connectathon"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
* ^purpose = "Requires Patient + ServiceRequest; supports Communication and Task for end-to-end referral."

// Bundle metadata
* type 1..1 MS
* type = #transaction (exactly)
* identifier 1..1 MS
* timestamp 1..1 MS

// Entries + slicing
* entry 1..* MS
* entry.fullUrl 1..1
* entry.resource 1..1
* entry.search ..0
* entry.response ..0
* entry.request 1..1
* entry.request.method 1..1
* entry.request.url 1..1

* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path  = "resource"
* entry ^slicing.rules = #open
* entry ^comment = "Must contain one Patient and one ServiceRequest (referral)."

// Named slices
* entry contains
    patient        1..1 MS and
    referral       1..1 MS and
    communication  0..* MS and
    task           0..* MS

// Slice types
* entry[patient].resource only NgPatient
* entry[referral].resource only NgServiceRequest
* entry[communication].resource only NgCommunication
* entry[task].resource only NgTask

// Recommended request URLs for transaction (server will route by resource type)
* entry[patient].request.url = "Patient"
* entry[referral].request.url = "ServiceRequest"
* entry[communication].request.url = "Communication"
* entry[task].request.url = "Task"

// ============================================================================
// EXAMPLE 1: Referral Initiation (Requested)
// ============================================================================
Instance: bundle-referral-initiation
InstanceOf: NgMNCHReferralBundle
Usage: #example
Title: "MNCH Referral — Initiation (High BP, ?Preeclampsia)"
Description: "Nkwo PHC refers Ada to NAUTH (urgent ANC specialist review)."
* type = #transaction
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-bundle-identifier-cs"
* identifier.value = "BND-REF-0001"
* timestamp = "2025-10-16T08:30:00+01:00"

// Patient (Ada)
* entry[patient].fullUrl = "urn:uuid:c0a1f00d-4433-42aa-acdd-eeff00112233"
* entry[patient].resource = NgPatient-ADA-001
* entry[patient].request.method = #POST
* entry[patient].request.url = "Patient"

// Referral (ServiceRequest)
* entry[referral].fullUrl = "urn:uuid:c0a1f00d-7f9c-2d3e-a6f0-1b2c3d4e5f22"
* entry[referral].resource = NgServiceRequest-ANC-001
* entry[referral].resource.status = #active
* entry[referral].resource.intent = #order
* entry[referral].resource.priority = #asap
* entry[referral].resource.category.text = "Obstetrics referral"
* entry[referral].resource.code.text = "ANC specialist review — ?Preeclampsia (BP 160/105, Prot +2)"
* entry[referral].resource.subject = Reference(urn:uuid:c0a1f00d-4433-42aa-acdd-eeff00112233)
* entry[referral].resource.authoredOn = "2025-10-16T08:29:30+01:00"
* entry[referral].resource.reasonCode[0].text = "Elevated BP, dizziness, proteinuria +2; high-risk pregnancy"
* entry[referral].request.method = #POST
* entry[referral].request.url = "ServiceRequest"

// Task (requested → NAUTH)
* entry[+].fullUrl = "urn:uuid:c0a1f00d-6071-4a82-ab93-cd34ef567026"
* entry[=].resource = NgTask-REF-INIT-001
* entry[=].resource.status = #requested
* entry[=].resource.intent = #order
* entry[=].resource.priority = #urgent
* entry[=].resource.code.text = "Process MNCH referral (High-risk pregnancy management)"
* entry[=].resource.for = Reference(urn:uuid:c0a1f00d-4433-42aa-acdd-eeff00112233)
* entry[=].resource.focus = Reference(urn:uuid:c0a1f00d-7f9c-2d3e-a6f0-1b2c3d4e5f22)
* entry[=].resource.authoredOn = "2025-10-16T08:30:00+01:00"
* entry[=].request.method = #POST
* entry[=].request.url = "Task"

// ============================================================================
// EXAMPLE 2: Referral Response (Accepted by NAUTH)
// ============================================================================
Instance: bundle-referral-response
InstanceOf: NgMNCHReferralBundle
Usage: #example
Title: "MNCH Referral — Response (Acceptance by NAUTH)"
Description: "Receiving specialist accepts referral; bed reserved, triage notified."
* type = #transaction
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-bundle-identifier-cs"
* identifier.value = "BND-REF-0002"
* timestamp = "2025-10-16T09:05:00+01:00"

// Patient (echo)
* entry[patient].fullUrl = "urn:uuid:c0a1f00d-4433-42aa-acdd-eeff00112233"
* entry[patient].resource = NgPatient-ADA-001
* entry[patient].request.method = #POST
* entry[patient].request.url = "Patient"

// Referral (echo)
* entry[referral].fullUrl = "urn:uuid:c0a1f00d-7f9c-2d3e-a6f0-1b2c3d4e5f22"
* entry[referral].resource = NgServiceRequest-ANC-001
* entry[referral].request.method = #POST
* entry[referral].request.url = "ServiceRequest"

// Task (accepted)
* entry[+].fullUrl = "urn:uuid:c0a1f00d-6071-4a82-ab93-cd34ef567026"
* entry[=].resource = NgTask-REF-INIT-001
* entry[=].resource.status = #accepted
* entry[=].resource.intent = #order
* entry[=].resource.lastModified = "2025-10-16T09:04:30+01:00"
* entry[=].resource.note[0].text = "Bed reserved in high-risk ward; triage alerted; MgSO₄ prepared."
* entry[=].request.method = #PUT
* entry[=].request.url = "Task"

// Communication back to PHC
* entry[+].fullUrl = "urn:uuid:c0a1f00d-2aa1-77bb-8899-0011ccddeeff"
* entry[=].resource = NgCommunication-REF-ACK-001
* entry[=].resource.status = #completed
* entry[=].resource.category.text = "Referral Acknowledgment"
* entry[=].resource.subject = Reference(urn:uuid:c0a1f00d-4433-42aa-acdd-eeff00112233)
* entry[=].resource.sent = "2025-10-16T09:05:00+01:00"
* entry[=].resource.payload[0].contentString = "Referral accepted. Bed reserved; please advise patient to proceed to NAUTH Obstetric Emergency."
* entry[=].request.method = #POST
* entry[=].request.url = "Communication"

// ============================================================================
// EXAMPLE 3: Tracking (In-Progress at NAUTH)
// ============================================================================
Instance: bundle-referral-tracking
InstanceOf: NgMNCHReferralBundle
Usage: #example
Title: "MNCH Referral — Tracking (In Progress, MgSO₄ started)"
Description: "Arrival at NAUTH; treatment initiated; ongoing monitoring."
* type = #transaction
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-bundle-identifier-cs"
* identifier.value = "BND-REF-0003"
* timestamp = "2025-10-16T14:40:00+01:00"

// Patient (echo)
* entry[patient].fullUrl = "urn:uuid:c0a1f00d-4433-42aa-acdd-eeff00112233"
* entry[patient].resource = NgPatient-ADA-001
* entry[patient].request.method = #POST
* entry[patient].request.url = "Patient"

// Referral (echo)
* entry[referral].fullUrl = "urn:uuid:c0a1f00d-7f9c-2d3e-a6f0-1b2c3d4e5f22"
* entry[referral].resource = NgServiceRequest-ANC-001
* entry[referral].request.method = #POST
* entry[referral].request.url = "ServiceRequest"

// Task (in-progress + note)
* entry[+].fullUrl = "urn:uuid:c0a1f00d-6071-4a82-ab93-cd34ef567026"
* entry[=].resource = NgTask-REF-INIT-001
* entry[=].resource.status = #in-progress
* entry[=].resource.lastModified = "2025-10-16T14:35:00+01:00"
* entry[=].resource.description = "Arrival 14:35; BP 165/110; Loading dose MgSO₄; FHR 140, reactive; admit high-risk ward."
* entry[=].request.method = #PUT
* entry[=].request.url = "Task"

// ============================================================================
// EXAMPLE 4: Completion + Communication (Loop Closure)
// ============================================================================
Instance: bundle-referral-completed
InstanceOf: NgMNCHReferralBundle
Usage: #example
Title: "MNCH Referral — Completed (Stabilized) + Feedback"
Description: "Stabilized after 6 hrs; plan for observation and PHC follow-up."
* type = #transaction
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-bundle-identifier-cs"
* identifier.value = "BND-REF-0004"
* timestamp = "2025-10-17T02:30:00+01:00"

// Patient (echo)
* entry[patient].fullUrl = "urn:uuid:c0a1f00d-4433-42aa-acdd-eeff00112233"
* entry[patient].resource = NgPatient-ADA-001
* entry[patient].request.method = #POST
* entry[patient].request.url = "Patient"

// Referral (echo)
* entry[referral].fullUrl = "urn:uuid:c0a1f00d-7f9c-2d3e-a6f0-1b2c3d4e5f22"
* entry[referral].resource = NgServiceRequest-ANC-001
* entry[referral].request.method = #POST
* entry[referral].request.url = "ServiceRequest"

// Task (completed + outcome)
* entry[+].fullUrl = "urn:uuid:c0a1f00d-6071-4a82-ab93-cd34ef567026"
* entry[=].resource = NgTask-REF-INIT-001
* entry[=].resource.status = #completed
* entry[=].resource.lastModified = "2025-10-17T02:25:00+01:00"
* entry[=].resource.output[0].type.text = "Outcome"
* entry[=].resource.output[0].valueString = "Stabilized; BP 145/95; FHR reassuring; admit 48h; PHC weekly BP checks; specialist review at 32w."
* entry[=].request.method = #PUT
* entry[=].request.url = "Task"

// Communication back to PHC (loop closure)
* entry[+].fullUrl = "urn:uuid:c0a1f00d-4433-22aa-ccdd-eeff00112233"
* entry[=].resource = NgCommunication-REF-COMPLETE-001
* entry[=].resource.status = #completed
* entry[=].resource.category.text = "Referral Feedback"
* entry[=].resource.subject = Reference(urn:uuid:c0a1f00d-4433-42aa-acdd-eeff00112233)
* entry[=].resource.sent = "2025-10-17T02:30:00+01:00"
* entry[=].resource.payload[0].contentString = "Ada stabilized. Keep weekly BP at PHC; specialist to see her at 32 weeks. Thank you for timely referral."
* entry[=].request.method = #POST
* entry[=].request.url = "Communication"



// ============================================================================
// Inline minimal examples used by the bundles
// ============================================================================

// Patient (Ada) — minimal, real story context carried in referral notes
Instance: NgPatient-ADA-001
InstanceOf: NgPatient
Usage: #inline
Title: "Patient — Ada (High-risk pregnancy)"
* active = true
* name[0].family = "Chukwu"
* name[0].given[0] = "Ada"
* gender = #female
* birthDate = "1997-03-02"
* meta.lastUpdated = "2023-10-28T08:00:00+01:00"
* identifier[PhoneNumber].value = "08067467012"
* identifier[PhoneNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.code = #MOBILE
* identifier[PhoneNumber].type.coding.display = "mobile"



// ServiceRequest — ANC Specialist Review
Instance: NgServiceRequest-ANC-001
InstanceOf: NgServiceRequest
Usage: #inline
Title: "ServiceRequest — ANC Specialist Review (?Preeclampsia)"
* status = #active
* intent = #order
* priority = #asap
* code.text = "Urgent ANC specialist review — ?Preeclampsia"
* reasonCode[0].text = "BP 160/105; proteinuria +2; dizziness; high-risk pregnancy"
* subject = Reference(urn:uuid:c0a1f00d-4433-42aa-acdd-eeff00112233)

// Task — shared logical Task updated across bundles
Instance: NgTask-REF-INIT-001
InstanceOf: NgTask
Usage: #inline
Title: "Task — Manage MNCH Referral"
* intent = #order
* code.text = "Process MNCH referral"
* status = #requested

// Communications (ack + completion) minimal shells
Instance: NgCommunication-REF-ACK-001
InstanceOf: NgCommunication
Usage: #inline
Title: "Communication — Referral Acknowledgment"
* status = #completed
* category.text = "Referral Acknowledgment"
* subject = Reference(urn:uuid:c0a1f00d-4433-42aa-acdd-eeff00112233)

Instance: NgCommunication-REF-COMPLETE-001
InstanceOf: NgCommunication
Usage: #inline
Title: "Communication — Referral Completion Feedback"
* status = #completed
* category.text = "Referral Feedback"
* subject = Reference(urn:uuid:c0a1f00d-4433-42aa-acdd-eeff00112233)
