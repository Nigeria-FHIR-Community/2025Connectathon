Profile: NgCoverageEligibilityResponse
Parent: CoverageEligibilityResponse
Id: ng-coverage-eligibility-response
Title: "NG Claim Coverage Eligibility Response"
Description: "Profile defining the response from an HMO to an eligibilty request"
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-coverage-eligibility-response"

* identifier 0..* MS
* status 1..1 MS
* status from http://hl7.org/fhir/ValueSet/fm-status
* purpose 1..* MS
* purpose from http://hl7.org/fhir/ValueSet/eligibilityresponse-purpose
* patient 1..1 MS
* patient only Reference(NgPatient)
* created 1..1 MS
* requestor 0..1
* requestor only Reference(NgProviderOrganization)
* request 1..1 MS
* request only Reference(NgCoverageEligibilityRequest)
* outcome 1..1 MS
* outcome from http://hl7.org/fhir/ValueSet/remittance-outcome
* insurer 1..1 MS
* insurer only Reference(NgInsurerOrganization)






// ===============================================================
// Example 1: Eligibility Response - Initial Coverage Verification
// ===============================================================
Instance: NgCoverageEligibilityResponse-ChikaEmergency
InstanceOf: NgCoverageEligibilityResponse
Usage: #example
Title: "Eligibility Response - Chika Coverage Confirmed"
Description: """
Truth HMO's instant response (3 seconds) to Sister Blessing's eligibility check.
Screen lights up green: -Active policy. Outpatient benefits in force. Copay: ₦2,500-
Patient cleared for emergency treatment.
"""

* identifier[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/eligibility-request-id"
* identifier[0].value = "ELAPPROVE01"
* status = #active
* purpose[0] = #benefits
* patient = Reference(Patient-Chika-Okafor) "Chika Okafor"
* created = "2025-11-06T23:47:03+01:00"
* requestor = Reference(Organization-PortHarcourt-Hospital) "Port Harcourt Emergency Hospital"
* request = Reference(NgCoverageEligibilityRequest-ChikaEmergency)
* outcome = #complete
* insurer = Reference(Organization-Truth-HMO) "Truth HMO"



// ===============================================================
// Example 2: Eligibility Response - Pre-Authorization Approval
// ===============================================================
Instance: NgCoverageEligibilityResponse-ChikaXrayApproved
InstanceOf: NgCoverageEligibilityResponse
Usage: #example
Title: "Eligibility Response - X-ray Pre-Auth Approved"
Description: """
Truth HMO's approval response to Dr. Adeyemi's pre-authorization request.
-Pre-authorization APPROVED. Approved amount: ₦15,000. Patient copay: ₦1,500. 
Authorization code: PA-2025-8847. Valid until: 10-Nov-2025.-
Approval arrives while Chika is being wheeled to radiology.
"""

* identifier[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/eligibility-request-id"
* identifier[0].value = "ELAPPROVE02"
* status = #active
* purpose[0] = #validation
* patient = Reference(Patient-Chika-Okafor) "Chika Okafor"
* created = "2025-11-07T00:09:00+01:00"
* requestor = Reference(Organization-PortHarcourt-Hospital) "Port Harcourt Emergency Hospital"
* request = Reference(NgCoverageEligibilityRequest-ChikaEmergency)

* outcome = #complete
* disposition = "Pre-authorization APPROVED. Approved amount: ₦15,000. Patient copay: ₦1,500. Authorization code: PA-2025-8847. Valid until: 10-Nov-2025."
* insurer = Reference(Organization-Truth-HMO) "Truth HMO"
* preAuthRef[0] = "PA-2025-8847"

* insurance[0].coverage = Reference(Coverage-Chika-TruthHMO) "Truth HMO Policy - Chika Okafor"
* insurance[0].inforce = true

// * insurance[0].item[0].category.coding.system = "http://terminology.hl7.org/CodeSystem/ex-benefitcategory"
// * insurance[0].item[0].category.coding.code = #69
// * insurance[0].item[0].category.coding.display = "Maternity"

* insurance[0].item[0].productOrService.coding[0].system = "http://www.ama-assn.org/go/cpt"
* insurance[0].item[0].productOrService.coding[0].code = #73610
* insurance[0].item[0].productOrService.coding[0].display = "Radiologic examination, ankle; complete, minimum of 3 views"
* insurance[0].item[0].productOrService.text = "Ankle X-ray - Right ankle sprain (ICD-10: S93.4)"

* insurance[0].item[0].authorizationRequired = true
* insurance[0].item[0].authorizationSupporting[0].text = "Emergency presentation with suspected fracture"
* insurance[0].item[0].authorizationUrl = "https://sandbox.dhin-hie.org/ig/CodeSystem/eligibility-request-id#PA-2025-8847"

* insurance[0].item[0].benefit[0].type.coding.system = "http://terminology.hl7.org/CodeSystem/benefit-type"
* insurance[0].item[0].benefit[0].type.coding.code = #benefit
* insurance[0].item[0].benefit[0].type.coding.display = "Benefit"
* insurance[0].item[0].benefit[0].allowedMoney.value = 15000
* insurance[0].item[0].benefit[0].allowedMoney.currency = #NGN
* insurance[0].item[0].benefit[0].usedMoney.value = 0
* insurance[0].item[0].benefit[0].usedMoney.currency = #NGN

* insurance[0].item[0].benefit[1].type.coding.system = "http://terminology.hl7.org/CodeSystem/benefit-type"
* insurance[0].item[0].benefit[1].type.coding.code = #copay
* insurance[0].item[0].benefit[1].type.coding.display = "Copayment per service"
* insurance[0].item[0].benefit[1].allowedMoney.value = 1500
* insurance[0].item[0].benefit[1].allowedMoney.currency = #NGN

* insurance[0].item[0].benefit[2].type.coding.system = "http://terminology.hl7.org/CodeSystem/benefit-type"
* insurance[0].item[0].benefit[2].type.coding.code = #room
* insurance[0].item[0].benefit[2].type.coding.display = "Room"
* insurance[0].item[0].benefit[2].type.text = "HMO Coverage Amount"
* insurance[0].item[0].benefit[2].allowedMoney.value = 13500
* insurance[0].item[0].benefit[2].allowedMoney.currency = #NGN

* insurance[0].item[0].description = "Pre-authorization approved for emergency ankle X-ray. Valid until 10-Nov-2025."


// ===============================================================
// Supporting Resource: Coverage
// ===============================================================
Instance: Coverage-Chika-TruthHMO
InstanceOf: NgCoverage
Usage: #example
Title: "Coverage - Chika"
Description: "Chika's Truth HMO Policy"
* status = #active
* type.coding.system = "http://terminology.hl7.org/CodeSystem/v3-ActCode"
* type.coding.code = #EHCPOL
* type.coding.display = "extended healthcare"
* policyHolder = Reference(Patient-Chika-Okafor) "Chika Okafor"
* subscriber = Reference(Patient-Chika-Okafor) "Chika Okafor"
* subscriberId = "TRUTH-HMO-CHIKA-2025"
* beneficiary = Reference(Patient-Chika-Okafor) "Chika Okafor"
* dependent = "00"
* relationship.coding.system = "http://terminology.hl7.org/CodeSystem/subscriber-relationship"
* relationship.coding.code = #self
* relationship.coding.display = "Self"
* period.start = "2025-01-01"
* period.end = "2025-12-31"
* payor[0] = Reference(Organization-Truth-HMO) "Truth HMO"
* class[0].type.coding.system = "http://terminology.hl7.org/CodeSystem/coverage-class"
* class[0].type.coding.code = #plan
* class[0].type.coding.display = "Plan"
* class[0].value = "Standard Corporate Plan"
* class[0].name = "Truth HMO Corporate Coverage - Employer Sponsored"
* order = 1