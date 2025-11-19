Profile: NgClaimResponse
Parent: ClaimResponse
Id: ng-claim-response
Title: "NG ClaimResponse"
Description: "A profile representing responses from insurers regarding submitted claims."
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-claim-response"

* identifier 0..1
* status 1..1 MS
* status from http://hl7.org/fhir/ValueSet/fm-status 
* type 1..1 MS
* type from http://hl7.org/fhir/ValueSet/claim-type (required)
* use 1..1 MS
* use from http://hl7.org/fhir/ValueSet/claim-use (required)
* patient 1..1 MS
* patient only Reference(NgPatient)
* created 1..1 MS
* insurer only Reference(NgInsurerOrganization)
* requestor only Reference(NgOrganization)
* request 0..1 MS
* request only Reference(NgClaim)
* outcome 1..1 MS
* outcome from http://hl7.org/fhir/ValueSet/remittance-outcome
* disposition 0..1
* preAuthRef 0..1 MS
* preAuthPeriod 0..1 MS





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
* insurer = Reference(Organization-Truth-HMO)
* request = Reference(NgClaim-001)
* outcome = #complete
* disposition = "Approved in full."
* preAuthRef = "1234"




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
* insurer = Reference(Organization-Truth-HMO)
* request = Reference(NgClaim-001)
* outcome = #partial
* disposition = "Partially approved; copay applied."
* preAuthRef = "5678"


