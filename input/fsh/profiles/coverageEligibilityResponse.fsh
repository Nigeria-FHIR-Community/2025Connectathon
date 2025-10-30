Profile: NgCoverageEligibilityResponse
Parent: CoverageEligibilityResponse
Id: ng-claim-coverageeligibilityresponse
Title: "NG Claim Coverage Eligibility Response"
Description: "Profile defining the response from an HMO to an eligibilty request"

* identifier 0..* MS
* status from http://hl7.org/fhir/ValueSet/fm-status
* purpose from http://hl7.org/fhir/eligibilityresponse-purpose
* patient only Reference(NgPatient)
* created 1..1 MS
* requestor only Reference(NgOrganization)
* request only Reference(NgCoverageEligibilityRequest)
* insurer only Reference(NgOrganization)
* outcome from http://hl7.org/fhir/ValueSet/remittance-outcome
* disposition 0..1 MS
* insurance 0..1
* insurance.coverage only Reference(NgCoverage)
* insurance.benefitPeriod 0..1
* insurance.benefitPeriod.start 0..1
* insurance.benefitPeriod.end 0..1
* insurance.item 0..*
* insurance.item.category from http://hl7.org/fhir/ValueSet/ex-benefitcategory
* insurance.item.benefit 0..* MS
* insurance.item.benefit.type from http://terminology.hl7.org/CodeSystem/benefit-type 