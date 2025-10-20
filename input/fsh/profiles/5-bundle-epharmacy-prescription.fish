// ====================================================================
// Profile: NgPrescriptionBundle
// ====================================================================
Profile: NgPrescriptionBundle
Parent: Bundle
Id: ng-prescription-bundle
Title: "5-NG ePharmacy Prescription Bundle"
Description: "Transaction bundle carrying a prescription from prescriber to pharmacy. Must include 1 Patient, 1 Practitioner, 1 Organization (prescriber org), ≥1 Medication, and ≥1 MedicationRequest. Designed to keep QA noise low for DHIN 2025 Connectathon."

// Bundle basics
* type 1..1 MS
* type = #transaction (exactly)
* entry 5..* MS
* entry.fullUrl 1..1
* entry.resource 1..1
* entry.request 1..1
* entry.request.method 1..1
* entry.request.url 1..1

// Slice entries by the profile of the inlined resource
* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #open

// Required slices
* entry contains
    patient 1..1 MS and
    practitioner 1..1 MS and
    organization 1..1 MS and
    medication 1..* MS and
    medicationRequest 1..* MS and
    coverage 0..1

// Patient slice
* entry[patient].resource only NgPatient
* entry[patient].request.method = #POST
* entry[patient].request.url = "Patient"

// Practitioner slice
* entry[practitioner].resource only NgPractitioner
* entry[practitioner].request.method = #POST
* entry[practitioner].request.url = "Practitioner"

// Organization slice (prescriber org)
* entry[organization].resource only NgOrganization
* entry[organization].request.method = #POST
* entry[organization].request.url = "Organization"

// Medication slice
* entry[medication].resource only NgMedication
* entry[medication].request.method = #POST
* entry[medication].request.url = "Medication"

// MedicationRequest slice
* entry[medicationRequest].resource only NgMedicationRequest
* entry[medicationRequest].request.method = #POST
* entry[medicationRequest].request.url = "MedicationRequest"

// Optional Coverage slice (payer context)
* entry[coverage].resource only NgCoverage
* entry[coverage].request.method = #POST
* entry[coverage].request.url = "Coverage"

// --------------------
// Invariants (soft; reduce QA friction)
// --------------------
Invariant: ngpx-uuid-fullurl
Description: "Entries SHOULD use URN UUID fullUrls for local intra-bundle references."
Severity: #warning
Expression: "entry.fullUrl.all(matches('^urn:uuid:'))"

Invariant: ngpx-mr-local-refs
Description: "MedicationRequest.subject and MedicationRequest.medication[x] SHOULD be local URN UUIDs within the same Bundle."
Severity: #warning
Expression: "entry.resource.ofType(MedicationRequest).subject.reference.all(matches('^urn:uuid:')) and entry.resource.ofType(MedicationRequest).medication.where(reference.exists()).reference.all(matches('^urn:uuid:'))"

