Profile: NgCoverage
Parent: Coverage
Id: ng-claim-coverage
Title: "NG Claim Coverage"
Description: "A profile capturing a patient's insurance coverage details."

* status from http://hl7.org/fhir/ValueSet/fm-status
* identifier 0..* MS
* type from http://hl7.org/fhir/ValueSet/coverage-type
* subscriber only Reference(NgPatient)
* subscriberId 0..1 MS
* beneficiary only Reference(NgPatient)
* period 0..1
* payor only Reference(NgOrganization)




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
// * type.coding[0].system = "http://terminology.hl7.org/CodeSystem/coverage-copay-type"
// * type.coding[0].code = #emergency
//* type.text = "NHIA Plan A"
* subscriber = Reference(NgPatient-002)
* beneficiary = Reference(NgPatient-002)
* payor[0] = Reference(NgOrganization-001)
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
// * type.coding[0].system = "http://terminology.hl7.org/CodeSystem/coverage-copay-type"
// * type.coding[0].code = #televisit
// * type.text = "NHIA Family Plan"
* subscriber = Reference(NgPatient-002)
* beneficiary = Reference(NgPatient-003)
* payor[0] = Reference(NgOrganization-002)
* period.start = 2025-01-01
* period.end   = 2025-12-31
