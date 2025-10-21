// ============================================================================
// PROFILE: Prescription Information Sharing Bundle
// ============================================================================
Profile: NgPrescriptionBundle
Parent: Bundle
Id: ng-prescription-bundle
Title: "NG Prescription Information Sharing Bundle"
Description: """
Transaction bundle for electronic prescription sharing between prescribers (hospitals/clinics) and dispensers (pharmacies).
This bundle MUST contain a Patient and a MedicationRequest (the prescription order).
Optional entries such as MedicationDispense, Practitioner, Organization, or Task
may be included to support the dispensing process and tracking.
"""
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-prescription-bundle"
* ^version = "1.0.0"
* ^status = #active
* ^date = "2025-10-17"
* ^publisher = "DHIN 2025 Connectathon"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
* ^purpose = "Supports digital prescription information exchange between healthcare prescribers and pharmacy dispensers."

// ---------------------------------------------------------------------------
// BUNDLE METADATA
// ---------------------------------------------------------------------------
* type 1..1 MS
* type = #transaction (exactly)
* identifier 1..1 MS
* identifier ^short = "Identifier for this prescription transaction bundle"
* timestamp 1..1 MS

// ---------------------------------------------------------------------------
// ENTRIES + SLICING
// ---------------------------------------------------------------------------
* entry 2..* MS
* entry.fullUrl 1..
* entry.search ..0
* entry.response ..0
* entry.request 0..1

* entry ^slicing.discriminator[0].type = #type
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.discriminator[1].type = #profile
* entry ^slicing.discriminator[1].path = "resource"
* entry ^slicing.rules = #open
* entry ^comment = "Must contain one Patient and one MedicationRequest. Others optional."

// ---------------------------------------------------------------------------
// NAMED SLICES
// ---------------------------------------------------------------------------
* entry contains
    patient 1..1 MS and
    prescription 1..1 MS and
    practitioner 0..1 MS and
    organization 0..1 MS and
    task 0..1 MS

// ---------------------------------------------------------------------------
// REQUIRED SLICES
// ---------------------------------------------------------------------------
* entry[patient].resource only NgPatient
* entry[patient].request.method = #POST
* entry[patient].request.url = "https://sandbox.dhin-hie.org/ig/resources/NgPatient"

* entry[prescription].resource only NgMedicationRequest
* entry[prescription].request.method = #POST
* entry[prescription].request.url = "https://sandbox.dhin-hie.org/ig/resources/NgMedicationRequest"

// ---------------------------------------------------------------------------
// OPTIONAL SLICES
// ---------------------------------------------------------------------------

* entry[practitioner].resource only NgPractitioner
* entry[practitioner].request.method = #POST
* entry[practitioner].request.url = "https://sandbox.dhin-hie.org/ig/resources/NgPractitioner"

* entry[organization].resource only NgOrganization
* entry[organization].request.method = #POST
* entry[organization].request.url = "https://sandbox.dhin-hie.org/ig/resources/NgOrganization"

* entry[task].resource only NgTask
* entry[task].request.method = #POST
* entry[task].request.url = "https://sandbox.dhin-hie.org/ig/resources/NgTask"






// ============================================================================
// EXAMPLE: Prescription Information Sharing Bundle
// ============================================================================

Instance: bundle-prescription
InstanceOf: NgPrescriptionBundle
Title: "Prescription Information Sharing — Prescriber to Dispenser"
Usage: #example

* type = #transaction
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-bundle-identifier-cs"
* identifier.value = "BND-0041"
* timestamp = "2025-10-17T09:45:00+01:00"

// ---------------------------------------------------------------------------
// PATIENT
// ---------------------------------------------------------------------------
* entry[patient].fullUrl = "urn:uuid:6e8b1c2d-1a23-4bcd-95ef-0a1b2c3d4e21"
* entry[patient].resource = NgPatient-001
* entry[patient].request.method = #POST

// ---------------------------------------------------------------------------
// PRESCRIPTION (MedicationRequest)
// ---------------------------------------------------------------------------
* entry[prescription].fullUrl = "urn:uuid:2b3c4d5e-2222-5f60-9ab1-23456789abcd"
* entry[prescription].resource = NgMedicationRequest-001
* entry[prescription].resource.status = #active
* entry[prescription].resource.intent = #order
* entry[prescription].resource.subject = Reference(urn:uuid:1a2b3c4d-1111-4e5f-8a90-123456789abc)
* entry[prescription].resource.authoredOn = "2025-10-17T09:40:00+01:00"
* entry[prescription].resource.requester = Reference(NgOrganization-001)
* entry[prescription].resource.recorder = Reference(NgPractitioner-001)
* entry[prescription].resource.dosageInstruction[0].text = "Take one capsule by mouth three times daily for 5 days."
* entry[prescription].resource.dispenseRequest.quantity.value = 15
* entry[prescription].resource.dispenseRequest.performer = Reference(NgOrganization-001)
* entry[prescription].request.method = #POST

// ---------------------------------------------------------------------------
// PRACTITIONER (Prescriber)
// ---------------------------------------------------------------------------
* entry[practitioner].fullUrl = "urn:uuid:3c4d5e6f-3333-6f70-9bc2-3456789abcde"
* entry[practitioner].resource = NgPractitioner-001
* entry[practitioner].request.method = #POST

// ---------------------------------------------------------------------------
// ORGANIZATION (Prescribing Facility)
// ---------------------------------------------------------------------------
* entry[organization].fullUrl = "urn:uuid:4d5e6f7a-4444-7080-adc3-456789abcdef"
* entry[organization].resource = NgOrganization-001
* entry[organization].request.method = #POST

// ---------------------------------------------------------------------------
// TASK (Dispenser Task)
// ---------------------------------------------------------------------------
* entry[task].fullUrl = "urn:uuid:5e6f7a8b-5555-8190-bcd4-56789abcdef0"
* entry[task].resource = NgTask-001
* entry[task].resource.status = #requested
* entry[task].resource.intent = #order
* entry[task].resource.code.text = "Dispense prescribed medication"
* entry[task].resource.for = Reference(urn:uuid:1a2b3c4d-1111-4e5f-8a90-123456789abc)
* entry[task].resource.focus = Reference(urn:uuid:2b3c4d5e-2222-5f60-9ab1-23456789abcd)
* entry[task].resource.authoredOn = "2025-10-17T09:43:00+01:00"
* entry[task].resource.requester = Reference(NgOrganization-001)
* entry[task].resource.owner = Reference(NgOrganization-002)
* entry[task].request.method = #POST
