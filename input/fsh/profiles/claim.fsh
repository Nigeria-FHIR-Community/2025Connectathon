Profile: NgClaim
Parent: Claim
Id: ng-claim
Title: "NG Claim"
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
* procedure.procedureReference only Reference(NgProcedure)
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

// EXAMPLES 


// ==============================================
// Claim Example — Pharmacy item for NgPatient-002
// ==============================================
Instance: NgClaim-001
InstanceOf: NgClaim
Usage: #example
Title: "Example NG Claim (ePharmacy)"
Description: "Pharmacy claim submitted by Kano Central Hospital Pharmacy for NgPatient-002."

// Core
* status = #active
* type.coding[0].system = "http://terminology.hl7.org/CodeSystem/claim-type"
* type.coding[0].code = #pharmacy
* use = #claim
* created = 2025-11-04T12:30:00Z

// Parties
* patient = Reference(NgPatient/NgPatient-002)
* provider = Reference(NgOrganization/NgOrganization-001)

// Optional business identifier
* identifier[0].system = "https://claims.example.ng/ids"
* identifier[0].value  = "CLM-2025-0001"

// Payee (provider is the pharmacist)
* payee.type.coding[0].system = "http://terminology.hl7.org/CodeSystem/payeetype"
* payee.type.coding[0].code   = #provider
* payee.party = Reference(NgPractitioner/NgPractitioner-002)

// Priority
* priority.coding[0].system = "http://terminology.hl7.org/CodeSystem/processpriority"
* priority.coding[0].code = #normal

// Diagnosis (links to item via diagnosisSequence)
* diagnosis[0].sequence = 1
* diagnosis[0].diagnosisCodeableConcept.coding[0].system = "http://snomed.info/sct"
* diagnosis[0].diagnosisCodeableConcept.coding[0].code = #59621000
* diagnosis[0].diagnosisCodeableConcept.coding[0].display = "Essential hypertension"

// Line item (30 capsules of amoxicillin as an example)
* item[0].sequence = 1
* item[0].productOrService.coding[0].system = "http://www.whocc.no/atc"
* item[0].productOrService.coding[0].code = #J01CA04
* item[0].productOrService.coding[0].display = "Amoxicillin"
* item[0].quantity.value = 30
* item[0].unitPrice.value = 500
* item[0].unitPrice.currency = #NGN
* item[0].net.value = 15000
* item[0].net.currency = #NGN
* item[0].diagnosisSequence[0] = 1

// Insurance
* insurance[0].focal = true
* insurance[0].identifier.system = "http://nhia.gov.ng/insurance-no"
* insurance[0].identifier.value  = "NHIA-0011223344"
* insurance[0].coverage = Reference(NgCoverage/NgCoverage-001)
* insurance[0].preAuthRef[0] = "PA-2025-ABC123"
* insurance[0].businessArrangement = "NHIA-PlanA-2025"
* insurance[0].sequence = 654

// (Optional) Claim total to match item.net
* total.value = 15000
* total.currency = #NGN


