Profile: NgExplanationOfBenefit
Parent: ExplanationOfBenefit
Id: ng-explanationofbenefit
Title: "NG ExplanationOfBenefit"
Description: "A profile detailing adjudicated claim results."

* status 1..1 MS
* type 1..1 MS
* patient 1..1 MS
* created 1..1 MS
* insurer 1..1 MS
* provider 1..1
* benefitPeriod 0..1
* use 1..1
* outcome 1..1



// EXAMPLES
// ==============================================
// EOB-001 — Approved in full (maps to NgClaimResponse-001)
// ==============================================
Instance: NgExplanationOfBenefit-001
InstanceOf: NgExplanationOfBenefit
Usage: #example
Title: "Example Ng EOB (Approved)"
Description: "EOB for fully approved pharmacy claim."
* status = #active
* type.coding[0].system = "http://terminology.hl7.org/CodeSystem/claim-type"
* type.coding[0].code = #pharmacy
* use = #claim
* outcome = #complete
* created = 2025-11-04T12:46:00Z

* patient = Reference(NgPatient-002)
* insurer = Reference(NgOrganization-002)
* provider = Reference(NgOrganization-001)
* claim = Reference(Claim/NgClaim-001)
* claimResponse = Reference(NgClaimResponse-001)

// Optional benefit period (plan year)
* benefitPeriod.start = 2025-01-01
* benefitPeriod.end   = 2025-12-31

// Insurance used for this adjudication
* insurance[0].focal = true
* insurance[0].coverage = Reference(NgCoverage-001)

// Totals and payment (mirrors ClaimResponse)
* total[0].category = http://terminology.hl7.org/CodeSystem/adjudication#benefit "Benefit Amount"
* total[0].amount.value = 15000
* total[0].amount.currency = #NGN
* payment.amount.value = 15000
* payment.amount.currency = #NGN
* payment.date = 2025-11-05



// ==============================================
// EOB-002 — Partial approval with copay (maps to NgClaimResponse-002)
// ==============================================
Instance: NgExplanationOfBenefit-002
InstanceOf: NgExplanationOfBenefit
Usage: #example
Title: "Example Ng EOB (Partial with Copay)"
Description: "EOB documenting partial approval and member copay."
* status = #active
* type.coding[0].system = "http://terminology.hl7.org/CodeSystem/claim-type"
* type.coding[0].code = #pharmacy
* use = #claim
* outcome = #partial
* created = 2025-11-04T12:51:00Z

* patient = Reference(NgPatient-002)
* insurer = Reference(NgOrganization-001)
* provider = Reference(NgOrganization-001)
* claim = Reference(NgClaim-001)
* claimResponse = Reference(NgClaimResponse-002)

// Optional benefit period (plan year)
* benefitPeriod.start = 2025-01-01
* benefitPeriod.end   = 2025-12-31

// Insurance used for this adjudication
* insurance[0].focal = true
* insurance[0].coverage = Reference(NgCoverage-001)

// Totals and payment (mirrors ClaimResponse)
* total[0].category = http://terminology.hl7.org/CodeSystem/adjudication#benefit "Benefit Amount"
* total[0].amount.value = 12000
* total[0].amount.currency = #NGN
* total[1].category = http://terminology.hl7.org/CodeSystem/adjudication#copay "Copay"
* total[1].amount.value = 3000
* total[1].amount.currency = #NGN
* payment.amount.value = 12000
* payment.amount.currency = #NGN
* payment.date = 2025-11-05
