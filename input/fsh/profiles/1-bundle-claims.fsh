Profile: NgTransactionBundle
Parent: Bundle
Id: ng-transaction-bundle
Title: "1-NG HMO-Hospital Transaction Bundle"
Description: """
Transaction bundle for Nigerian HMO-Hospital claims submissions. This bundle MUST contain 
a Coverage and a Claim entry, representing the minimum dataset required for claims processing.
Designed for supporting cross-organizational healthcare claims processing in Nigeria's DHIN ecosystem.
"""

// Version and metadata (drawing from IPS pattern)
* ^version = "1.0.0"
* ^date = "2025-10-15"
* ^publisher = "DHIN 2025 Connectathon"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
* ^purpose = "A claims transaction bundle designed for Nigerian HMO-to-Hospital submissions, containing essential coverage and claim information. The bundle is minimal and non-exhaustive but clinically and administratively relevant for claims processing."

// Enforce the invariant
* obeys ngbun-uuid-fullurl and ngbun-claim-cov-localref

// Bundle type
* type 1..1 MS
* type = #transaction (exactly)

// Identifier for the bundle (IPS pattern: identifier is required and MS)
* identifier 1..1 MS
* identifier ^short = "Persistent identifier for this transaction bundle"
* identifier ^definition = "A unique identifier assigned to this claims transaction bundle for tracking and auditing purposes."

// Timestamp (IPS pattern: timestamp is required and MS)
* timestamp 1..1 MS
* timestamp ^short = "When the bundle was assembled"
* timestamp ^definition = "The date/time when this claims transaction bundle was assembled by the HMO or submitting system."

// Entry constraints
* entry 2..* MS
* entry ^short = "Entry resource in the claims transaction bundle"
* entry ^definition = "An entry resource included in the claims transaction bundle. Must contain at least one Coverage and one Claim."
* entry ^comment = "Must contain at least one Coverage resource and one Claim resource. Additional supporting resources (Patient, Practitioner, Organization, etc.) may be included as needed."

// Entry elements (following IPS pattern for transaction bundles)
* entry.fullUrl 1..1 MS
* entry.fullUrl ^short = "URN UUID for the entry"
* entry.fullUrl ^definition = "A URN UUID that identifies this entry within the bundle and allows for internal references."
* entry.resource 1..1 MS
* entry.request 1..1 MS
* entry.request.method 1..1 MS
* entry.request.url 1..1 MS

// Prohibit search/response (IPS pattern)
* entry.search ..0
* entry.response ..0

// Slice entries by profile (IPS slicing pattern)
* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.discriminator[+].type = #type
* entry ^slicing.discriminator[=].path = "resource"
* entry ^slicing.rules = #open
* entry ^slicing.description = "Slicing based on the profile and type of the entry resource"

// Define required and optional slices (following IPS pattern)
* entry contains
    coverage 1..1 MS and
    claim 1..1 MS and
    patient 0..* and
    practitioner 0..* and
    practitionerrole 0..* and
    organization 0..* and
    location 0..* and
    procedure 0..* and
    condition 0..* and
    medicationrequest 0..* and
    medication 0..* and
    device 0..* and
    observation 0..*

// Required: Coverage slice
* entry[coverage] ^short = "Coverage information for the claim"
* entry[coverage] ^definition = "The health insurance coverage under which the claim is being submitted."
* entry[coverage].resource 1..1
* entry[coverage].resource only NgCoverage
* entry[coverage].request.method = #POST
* entry[coverage].request.url = "Coverage"

// Required: Claim slice
* entry[claim] ^short = "The claim being submitted"
* entry[claim] ^definition = "The healthcare claim requesting payment or reimbursement from the HMO."
* entry[claim].resource 1..1
* entry[claim].resource only NgClaim
* entry[claim].request.method = #POST
* entry[claim].request.url = "Claim"

// Optional: Patient slice
* entry[patient] ^short = "Patient demographic information"
* entry[patient] ^definition = "The patient for whom the services were provided."
* entry[patient].resource 1..1
* entry[patient].resource only Patient
* entry[patient].request.method = #POST
* entry[patient].request.url = "Patient"

// Optional: Practitioner slice
* entry[practitioner] ^short = "Healthcare provider information"
* entry[practitioner] ^definition = "Healthcare practitioners involved in providing the claimed services."
* entry[practitioner].resource 1..1
* entry[practitioner].resource only Practitioner
* entry[practitioner].request.method = #POST
* entry[practitioner].request.url = "Practitioner"

// Optional: PractitionerRole slice
* entry[practitionerrole] ^short = "Practitioner role information"
* entry[practitionerrole] ^definition = "The role(s) of practitioners involved in the care."
* entry[practitionerrole].resource 1..1
* entry[practitionerrole].resource only PractitionerRole
* entry[practitionerrole].request.method = #POST
* entry[practitionerrole].request.url = "PractitionerRole"

// Optional: Organization slice
* entry[organization] ^short = "Healthcare organization information"
* entry[organization] ^definition = "Organizations involved in the care (e.g., hospitals, HMOs, laboratories)."
* entry[organization].resource 1..1
* entry[organization].resource only Organization
* entry[organization].request.method = #POST
* entry[organization].request.url = "Organization"

// Optional: Location slice
* entry[location] ^short = "Service delivery location"
* entry[location] ^definition = "Physical locations where services were provided."
* entry[location].resource 1..1
* entry[location].resource only Location
* entry[location].request.method = #POST
* entry[location].request.url = "Location"

// Optional: Procedure slice
* entry[procedure] ^short = "Procedures performed"
* entry[procedure] ^definition = "Clinical procedures performed as part of the claimed services."
* entry[procedure].resource 1..1
* entry[procedure].resource only Procedure
* entry[procedure].request.method = #POST
* entry[procedure].request.url = "Procedure"

// Optional: Condition slice
* entry[condition] ^short = "Diagnoses and conditions"
* entry[condition] ^definition = "Diagnoses and conditions relevant to the claim."
* entry[condition].resource 1..1
* entry[condition].resource only Condition
* entry[condition].request.method = #POST
* entry[condition].request.url = "Condition"

// Optional: MedicationRequest slice
* entry[medicationrequest] ^short = "Medication prescriptions"
* entry[medicationrequest] ^definition = "Medication prescriptions included in the claim."
* entry[medicationrequest].resource 1..1
* entry[medicationrequest].resource only MedicationRequest
* entry[medicationrequest].request.method = #POST
* entry[medicationrequest].request.url = "MedicationRequest"

// Optional: Medication slice
* entry[medication] ^short = "Medication details"
* entry[medication] ^definition = "Detailed medication information referenced by prescriptions."
* entry[medication].resource 1..1
* entry[medication].resource only Medication
* entry[medication].request.method = #POST
* entry[medication].request.url = "Medication"

// Optional: Device slice
* entry[device] ^short = "Medical devices"
* entry[device] ^definition = "Medical devices used or implanted during care."
* entry[device].resource 1..1
* entry[device].resource only Device
* entry[device].request.method = #POST
* entry[device].request.url = "Device"

// Optional: Observation slice
* entry[observation] ^short = "Clinical observations and results"
* entry[observation] ^definition = "Laboratory results, vital signs, and other observations."
* entry[observation].resource 1..1
* entry[observation].resource only Observation
* entry[observation].request.method = #POST
* entry[observation].request.url = "Observation"

// --------------------
// Invariants
// --------------------
Invariant: ngbun-uuid-fullurl
Description: "Transaction entries SHOULD use URN UUID fullUrls for local intra-bundle references."
Severity: #warning
Expression: "entry.fullUrl.all(matches('^urn:uuid:[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$'))"

Invariant: ngbun-claim-cov-localref
Description: "Claim.insurance.coverage references SHOULD be local URN UUIDs when the Coverage is in the same transaction."
Severity: #warning
Expression: "entry.resource.ofType(Claim).insurance.coverage.reference.all(matches('^urn:uuid:[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$'))" 