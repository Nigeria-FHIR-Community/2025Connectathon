// ============================================================================
// PROFILE: NG IPS Document Bundle
// ============================================================================
Profile: NgIPSDocumentBundle
Parent: Bundle
Id: ng-ips-document-bundle
Title: "6-NG IPS Document Bundle"
Description: """
A document Bundle wrapping an NG IPS Composition and its referenced resources
for use in the DHIN 2025 Connectathon. The first entry is the IPS Composition,
and subsequent entries carry the Patient, Conditions, Medications, Immunizations,
Procedures, Results, Devices, and CarePlan referenced by the Composition.
"""
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-ips-document-bundle"
* ^version = "1.0.0"
* ^status = #active
* ^publisher = "DHIN 2025 Connectathon"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
* ^experimental = false

// ---- Narrative (kept short)
* ^text.status = #generated
* ^text.div = """
<div xmlns="http://www.w3.org/1999/xhtml">
  <h2>NG IPS Document Bundle</h2>
  <p>
    A FHIR document Bundle where the first entry is an NG IPS Composition
    (<code>NgIPSComposition</code>), followed by the Patient and other
    resources referenced in the summary (conditions, medications,
    immunizations, procedures, results, devices, care plan).
  </p>
</div>
"""

// ---------------------------------------------------------------------------
// BUNDLE METADATA
// ---------------------------------------------------------------------------
* type 1..1 MS
* type = #document (exactly)

* identifier 0..1 MS
* identifier ^short = "Identifier for this IPS document bundle"

* timestamp 1..1 MS
* timestamp ^short = "When the bundle (document) was assembled"

// ---------------------------------------------------------------------------
// ENTRIES + SLICING
// ---------------------------------------------------------------------------
* entry 1..* MS
* entry ^short = "Entries that compose the IPS document"
* entry.fullUrl 1..
* entry.search ..0
* entry.request ..0
* entry.response ..0

// Slice entries by resource type/profile
* entry ^slicing.discriminator[0].type = #type
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.discriminator[1].type = #profile
* entry ^slicing.discriminator[1].path = "resource"
* entry ^slicing.rules = #open
* entry ^comment = "Must contain exactly one Composition (NgIPSComposition). Other content is optional but recommended."

* entry contains
    composition 1..1 MS and
    patient 0..1 MS and
    practitioner 0..* MS and
    organization 0..* MS and
    condition 0..* MS and
    medicationRequest 0..* MS and
    medicationDispense 0..* MS and
    immunization 0..* MS and
    procedure 0..* MS and
    observation 0..* MS and
    device 0..* MS and
    carePlan 0..* MS

// ---------------------------------------------------------------------------
// REQUIRED COMPOSITION ENTRY
// ---------------------------------------------------------------------------
* entry[composition].resource 1..1
* entry[composition].resource only NgIPSComposition
* entry[composition].fullUrl 1..1
* entry[composition].fullUrl ^short = "Document Composition (NG IPS)"

// ---------------------------------------------------------------------------
// OPTIONAL SUPPORTING ENTRIES (typed to NG profiles)
// ---------------------------------------------------------------------------

// Patient
* entry[patient].resource only NgPatient
* entry[patient].fullUrl 1..1

// Practitioner(s)
* entry[practitioner].resource only NgPractitioner
* entry[practitioner].fullUrl 1..1

// Organization(s)
* entry[organization].resource only NgOrganization
* entry[organization].fullUrl 1..1

// Conditions (problems)
* entry[condition].resource only NgCondition
* entry[condition].fullUrl 1..1

// Medications
* entry[medicationRequest].resource only NgMedicationRequest
* entry[medicationRequest].fullUrl 1..1

* entry[medicationDispense].resource only NgMedicationDispense
* entry[medicationDispense].fullUrl 1..1

// Immunizations
* entry[immunization].resource only NgImmunization
* entry[immunization].fullUrl 1..1

// Procedures
* entry[procedure].resource only NgProcedure
* entry[procedure].fullUrl 1..1

// Observations (results)
* entry[observation].resource only NgObservation
* entry[observation].fullUrl 1..1

// Devices
* entry[device].resource only NgDevice
* entry[device].fullUrl 1..1

// Care Plan
* entry[carePlan].resource only NgCarePlan
* entry[carePlan].fullUrl 1..1








/* // ============================================================================
// EXAMPLE: NG IPS Document Bundle (for Connectathon)
// ============================================================================
Instance: NgIPSBundle-Example-001
InstanceOf: Bundle
Title: "NG IPS Document Bundle — Example"
Usage: #example

* type = #document
* timestamp = "2025-10-25T10:00:00+01:00"
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-bundle-identifier-cs"
* identifier.value = "IPS-BND-0001"

// ---------------------------------------------------------------------------
// 1) COMPOSITION - first entry as required by IPS
// ---------------------------------------------------------------------------
* entry[0].fullUrl = "urn:uuid:00104001-e5f6-4789-a123-456789abcdef"
* entry[0].resource = NgIPSComposition-001


// ---------------------------------------------------------------------------
// 2) PATIENT
// ---------------------------------------------------------------------------
* entry[+].fullUrl = "urn:uuid:00114455-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgPatient-001

// ---------------------------------------------------------------------------
// 3) PRACTITIONER (author)
// ---------------------------------------------------------------------------
* entry[+].fullUrl = "urn:uuid:00124455-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgPractitioner-001

// ---------------------------------------------------------------------------
// 4) ORGANIZATION (author/facility)
// ---------------------------------------------------------------------------
* entry[+].fullUrl = "urn:uuid:00134455-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgOrganization-001

// ---------------------------------------------------------------------------
// 5) CONDITIONS
// ---------------------------------------------------------------------------
* entry[+].fullUrl = "urn:uuid:00125455-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgCondition-001

// ---------------------------------------------------------------------------
// 6) MEDICATION REQUEST (medication history)
// ---------------------------------------------------------------------------
* entry[+].fullUrl = "urn:uuid:00126455-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedicationRequest-001

// ---------------------------------------------------------------------------
// 7) MEDICATION DISPENSE (dispense history)
// ---------------------------------------------------------------------------
* entry[+].fullUrl = "urn:uuid:00127455-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedicationDispense-001

// ---------------------------------------------------------------------------
// 8) IMMUNIZATIONS
// ---------------------------------------------------------------------------
* entry[+].fullUrl = "urn:uuid:00128455-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgImmunization-001

* entry[+].fullUrl = "urn:uuid:00234455-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgImmunization-002

// ---------------------------------------------------------------------------
// 9) PROCEDURE (e.g., C-section history)
// ---------------------------------------------------------------------------
* entry[+].fullUrl = "urn:uuid:00124455-65f6-4789-a123-456789abcdef"
* entry[=].resource = NgProcedure-001

// ---------------------------------------------------------------------------
// 10) OBSERVATIONS (results)
// ---------------------------------------------------------------------------
* entry[+].fullUrl = "urn:uuid:00124455-e5f8-4789-a123-456789abcdef"
* entry[=].resource = NgObservation-001

// ---------------------------------------------------------------------------
// 11) DEVICE
// ---------------------------------------------------------------------------
* entry[+].fullUrl = "urn:uuid:00124456-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgDevice-001

// ---------------------------------------------------------------------------
// 12) CARE PLAN (plan of care)
// ---------------------------------------------------------------------------
* entry[+].fullUrl = "urn:uuid:00124455-e5f6-4789-a123-456789a2cdef"
* entry[=].resource = NgCarePlan-001
 */