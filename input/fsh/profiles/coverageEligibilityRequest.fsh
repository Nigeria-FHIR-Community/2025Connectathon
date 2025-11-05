Profile: NgCoverageEligibilityRequest
Parent: CoverageEligibilityRequest
Id: ng-claim-coverageeligibilityrequest
Title: "NG Claim Coverage Eligibility Request"
Description: "A profile verifying a patient's active insurance coverage and covered services.."

* identifier 0..* MS
* status from http://hl7.org/fhir/ValueSet/fm-status 
* purpose 1..* MS
* patient only Reference(NgPatient)
* created 1..1 MS
* provider only Reference(NgPractitioner)
* insurer only Reference(NgOrganization)
* insurance.coverage only Reference(NgCoverage)
* item.category from http://hl7.org/fhir/ValueSet/ex-benefitcategory
