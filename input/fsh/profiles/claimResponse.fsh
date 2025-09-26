Profile: NgClaimResponse
Parent: ClaimResponse
Id: ng-claimresponse
Title: "NG ClaimResponse"
Description: "A profile representing responses from insurers regarding submitted claims."

* status 1..1 MS
* type 1..1 MS
* use 1..1 MS
* patient 1..1 MS
* created 1..1 MS
* insurer 1..1 MS
* outcome 1..1 MS
* item 0..* MS


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
* patient = Reference(NgPatient/NgPatient-002)
* created = 2025-11-04T12:45:00Z
* insurer = Reference(NgOrganization/NgOrganization-001)
* request = Reference(NgClaim/NgClaim-001)
* outcome = #complete
* disposition = "Approved in full."

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
* payment.type = #capitation


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
* patient = Reference(Patient/NgPatient-002)
* created = 2025-11-04T12:50:00Z
* insurer = Reference(Organization/NHIA)
* request = Reference(Claim/NgClaim-001)
* outcome = #partial
* disposition = "Partially approved; copay applied."

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
* payment.type = #copay

