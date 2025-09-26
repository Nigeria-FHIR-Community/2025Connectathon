// ==============================================
// Profile: NgTransactionBundle (regenerated)
// ==============================================
Profile: NgTransactionBundle
Parent: Bundle
Id: ng-transaction-bundle
Title: "NG HMO-Hospital Transaction Bundle"
Description: "Transaction bundle that MUST contain a Coverage and a Claim entry for HMO submissions."

// Bundle basics
* type 1..1 MS
* type = #transaction (exactly)
* entry 2..* MS
* entry.fullUrl 1..1
* entry.resource 1..1
* entry.request 1..1
* entry.request.method 1..1
* entry.request.url 1..1

// Slice entries by the profile of the inlined resource
* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #open

// Required slices: one Coverage (NgCoverage) and one Claim (NgClaim)
* entry contains
    coverage 1..1 MS and
    claim 1..1 MS

// Coverage slice
* entry[coverage].resource only NgCoverage
* entry[coverage].request.method = #POST
* entry[coverage].request.url = "Coverage"

// Claim slice
* entry[claim].resource only NgClaim
* entry[claim].request.method = #POST
* entry[claim].request.url = "Claim"

// --------------------
// Invariants (soft)
// --------------------
Invariant: ngbun-uuid-fullurl
Description: "Transaction entries SHOULD use URN UUID fullUrls for local intra-bundle references."
Severity: #warning
Expression: "entry.fullUrl.all(matches('^urn:uuid:'))"

Invariant: ngbun-claim-cov-localref
Description: "Claim.insurance.coverage references SHOULD be local URN UUIDs when the Coverage is in the same transaction."
Severity: #warning
Expression: "entry.resource.ofType(Claim).insurance.coverage.reference.all(matches('^urn:uuid:'))"


// ==============================================
// Example: Provider submits Coverage + Claim to HMO
// ==============================================
Instance: NgTransactionBundle-Example-01
InstanceOf: NgTransactionBundle
Usage: #example
Title: "NgTransactionBundle-Example-01 (Claim + Coverage)"
Description: "Hospital submits a Coverage and a Claim to the HMO in a single transaction."
* type = #transaction

// ---- Entry 1: Coverage (created at HMO) ----
* entry[0].fullUrl = "urn:uuid:cov-001"
* entry[0].resource = NgCoverage-Tx-001
* entry[0].request.method = #POST
* entry[0].request.url = "Coverage"

// ---- Entry 2: Claim (created at HMO) ----
* entry[+].fullUrl = "urn:uuid:claim-001"
* entry[=].resource = NgClaim-Tx-001
* entry[=].request.method = #POST
* entry[=].request.url = "Claim"


// ==============================================
// Inline resource instances used in the Bundle
// ==============================================

// ---- Coverage (conforms to NgCoverage) ----
Instance: NgCoverage-Tx-001
InstanceOf: NgCoverage
Usage: #inline
Title: "NgCoverage-Tx-001"
Description: "Active coverage for the patient under GreenLife HMO."
* status = #active
* type.coding[0].system = "http://terminology.hl7.org/CodeSystem/coverage-type"
* type.coding[0].code = #EHCPOL
* beneficiary = Reference(Patient/NgPatient-001)
* payor[0] = Reference(Organization/NgOrganization-GreenLifeHMO)
* period.start = 2025-01-01
* period.end   = 2025-12-31

// ---- Claim (conforms to NgClaim) ----
Instance: NgClaim-Tx-001
InstanceOf: NgClaim
Usage: #inline
Title: "NgClaim-Tx-001"
Description: "Professional claim submitted by Asokoro Hospital to GreenLife HMO."
* status = #active
* use = #claim
* type.coding[0].system = "http://terminology.hl7.org/CodeSystem/claim-type"
* type.coding[0].code = #professional
* patient = Reference(Patient/NgPatient-001)
* created = 2025-11-01
* provider = Reference(Organization/NgOrganization-AsokoroHospital)
* prescription = Reference(MedicationRequest/NgMedicationRequest-001)
* priority.coding[0].system = "http://terminology.hl7.org/CodeSystem/processpriority"
* priority.coding[0].code = #normal
// Minimal item and insurance per NgClaim
* item[0].sequence = 1
* item[0].productOrService.text = "Outpatient visit and medication dispensing"
* insurance[0].focal = true
* insurance[0].coverage = Reference(urn:uuid:cov-001)
* insurance[0].preAuthRef[0] = "PA-2025-0915"
