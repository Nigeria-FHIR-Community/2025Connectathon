Profile: NgCoverage
Parent: Coverage
Id: ng-claim-coverage
Title: "NG Claim Coverage"
Description: "A profile capturing a patient's insurance coverage details."

* status 1..1 MS
* type 1..1 MS
* subscriber 0..1 MS
* beneficiary 1..1 MS
* payor 1..1 MS
* period 0..1



// EXAMPLES
// ==============================================
// NgCoverage-001 — Self coverage (NHIA) for NgPatient-002
// ==============================================
Instance: NgCoverage-001
InstanceOf: NgCoverage
Usage: #example
Title: "Example Ng Coverage (NHIA Self Coverage)"
Description: "Active NHIA coverage for NgPatient-002."
* status = #active
* type.coding[0].system = "http://terminology.hl7.org/CodeSystem/coverage-type"
* type.coding[0].code = #EHCPOL
* type.text = "NHIA Plan A"
* subscriber = Reference(Patient/NgPatient-002)
* beneficiary = Reference(Patient/NgPatient-002)
* payor[0] = Reference(Organization/NHIA)
* period.start = 2025-01-01
* period.end   = 2025-12-31



// ==============================================
// NgCoverage-002 — Dependent coverage (NHIA) for child NgPatient-003
// ==============================================
Instance: NgCoverage-002
InstanceOf: NgCoverage
Usage: #example
Title: "Example Ng Coverage (NHIA Dependent Coverage)"
Description: "Active NHIA dependent coverage for NgPatient-003; subscriber is NgPatient-002."
* status = #active
* type.coding[0].system = "http://terminology.hl7.org/CodeSystem/coverage-type"
* type.coding[0].code = #EHCPOL
* type.text = "NHIA Family Plan"
* subscriber = Reference(NgPatient/NgPatient-002)
* beneficiary = Reference(NgPatient/NgPatient-003)
* payor[0] = Reference(NgOrganization/NgOrganization-002)
* period.start = 2025-01-01
* period.end   = 2025-12-31
