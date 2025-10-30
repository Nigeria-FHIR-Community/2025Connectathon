Profile: NgClaimResponse
Parent: ClaimResponse
Id: ng-claimresponse
Title: "NG ClaimResponse"
Description: "A profile representing responses from insurers regarding submitted claims."

* identifier 0..1
* status from http://hl7.org/fhir/ValueSet/fm-status 
* type from http://hl7.org/fhir/ValueSet/claim-type (required)
* use from http://hl7.org/fhir/ValueSet/claim-use (required)
* patient only Reference(NgPatient)
* created 1..1 MS
* insurer only Reference(NgOrganization)
* requestor only Reference(NgOrganization)
* request only Reference(NgClaim)
* outcome from http://hl7.org/fhir/ValueSet/remittance-outcome
* disposition 0..1
* preAuthRef 0..1
* item 0..* MS
* item.itemSequence
* item.adjudication 1..*
* item.adjudication.category from http://hl7.org/fhir/ValueSet/adjudication
* item.adjudication.reason 0..1
* item.adjudication.amount 0..1
* item.adjudication.value 0..1




// EXAMPLES 
// ==============================================
// NgClaimResponse-001 — Approved in full
// ==============================================
Instance: NgClaimResponse-001
InstanceOf: NgClaimResponse
Usage: #example
Title: "Example Ng ClaimResponse (Approved)"
Description: "Full approval of pharmacy claim for NgPatient-002."
* status = #active
* type.coding[0].system = "http://terminology.hl7.org/CodeSystem/claim-type"
* type.coding[0].code = #pharmacy
* use = #claim
* patient = Reference(NgPatient-002)
* created = 2025-11-04T12:45:00Z
* insurer = Reference(NgOrganization-001)
* request = Reference(NgClaim-001)
* outcome = #complete
* disposition = "Approved in full."
* preAuthRef = "1234"

// Item adjudication (matches Claim item sequence 1)
* item[0].itemSequence = 1
* item[0].adjudication[0].category = http://terminology.hl7.org/CodeSystem/adjudication#eligible "Eligible Amount"
* item[0].adjudication[0].amount.value = 15000
* item[0].adjudication[0].amount.currency = #NGN
* item[0].adjudication[1].category = http://terminology.hl7.org/CodeSystem/adjudication#benefit "Benefit Amount"
* item[0].adjudication[1].amount.value = 15000
* item[0].adjudication[1].amount.currency = #NGN

// Totals and payment
* total[0].category = http://terminology.hl7.org/CodeSystem/adjudication#benefit "Benefit Amount"
* total[0].amount.value = 15000
* total[0].amount.currency = #NGN
* payment.amount.value = 15000
* payment.amount.currency = #NGN
* payment.date = 2025-11-05
* payment.type = http://terminology.hl7.org/CodeSystem/ex-paymenttype#complete


// ==============================================
// NgClaimResponse-002 — Partial approval with copay
// ==============================================
Instance: NgClaimResponse-002
InstanceOf: NgClaimResponse
Usage: #example
Title: "Example NG ClaimResponse (Partial with Copay)"
Description: "Partial approval; copay applied per plan rules."
* status = #active
* type.coding[0].system = "http://terminology.hl7.org/CodeSystem/claim-type"
* type.coding[0].code = #pharmacy
* use = #claim
* patient = Reference(NgPatient-002)
* created = 2025-11-04T12:50:00Z
* insurer = Reference(NgOrganization-001)
* request = Reference(NgClaim-001)
* outcome = #partial
* disposition = "Partially approved; copay applied."
* preAuthRef = "5678"

// Item adjudication
* item[0].itemSequence = 1
* item[0].adjudication[0].category = http://terminology.hl7.org/CodeSystem/adjudication#eligible "Eligible Amount"
* item[0].adjudication[0].amount.value = 15000
* item[0].adjudication[0].amount.currency = #NGN
* item[0].adjudication[1].category = http://terminology.hl7.org/CodeSystem/adjudication#copay "Copay"
* item[0].adjudication[1].amount.value = 3000
* item[0].adjudication[1].amount.currency = #NGN
* item[0].adjudication[2].category = http://terminology.hl7.org/CodeSystem/adjudication#benefit "Benefit Amount"
* item[0].adjudication[2].amount.value = 12000
* item[0].adjudication[2].amount.currency = #NGN

// Totals and payment
* total[0].category = http://terminology.hl7.org/CodeSystem/adjudication#benefit "Benefit Amount"
* total[0].amount.value = 12000
* total[0].amount.currency = #NGN
* total[1].category = http://terminology.hl7.org/CodeSystem/adjudication#copay "Copay"
* total[1].amount.value = 3000
* total[1].amount.currency = #NGN
* payment.amount.value = 12000
* payment.amount.currency = #NGN
* payment.date = 2025-11-05
* payment.type = http://terminology.hl7.org/CodeSystem/ex-paymenttype#partial

