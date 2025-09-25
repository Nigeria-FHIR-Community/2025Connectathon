Profile: NgClaim
Parent: Claim
Id: ng-claim
Title: "NG-Claim"
Description: "A profile representing submitted claims from providers to payers."

* identifier 0..*
* identifier ^short = "Business Identifier for claim"
* status 1..1 MS
* type 1..1 MS
* use 1..1 MS
* use ^short = "what the claim is for (Required - claim | preauthorization | predetermination)"
* patient only Reference(NgPatient)
* patient ^short = "The recipient of the products and services"
* created 1..1 MS
* provider 1..1 MS
* provider ^short = "The party responsible for the claim"
* prescription 0..1
* payee 0..1 
* payee ^short = "Recipient of benefits payable"
* payee.type 1..1
* payee.party only Reference(NgPractitioner)
* priority 1..1
* procedure 0..*
* procedure.sequence 1..1
* procedure.procedureReference only Reference(NgClaimProcedure)
* diagnosis 0..* MS
* diagnosis.onAdmission 0..1
* diagnosis.packageCode 0..1
* diagnosis.type 0..1
* item 1..* MS
* insurance 1..* MS
* insurance.focal 1..1
* insurance.identifier 0..1
* insurance.identifier ^short = "Pre-assigned insurance number"
* insurance.coverage 1..1
* insurance.preAuthRef 0..*
* insurance.claimResponse only Reference(NgClaimResponse)
* insurance.businessArrangement 0..1