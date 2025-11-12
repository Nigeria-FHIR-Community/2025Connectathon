Profile: NgCondition
Parent: Condition
Title: "NG Condition"
Id: ng-condition
Description: "Minimal Condition profile for the 2025 Connectathon."
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-condition"

// Core constraints
* clinicalStatus 1..1 MS
* verificationStatus 0..1 MS
* code 1..1 MS
* subject 1..1 MS
* encounter 0..1
* onset[x] 0..1
* abatement[x] 0..1
* category 0..* MS
* severity 0..1
* bodySite 0..*
* recorder 0..1
* asserter 0..1
* stage 0..*
* evidence 0..*

// Reference targets
* subject only Reference(NgPatient)
* encounter only Reference(NgEncounter)
* recorder only Reference(NgPractitioner or NgPatient or NgRelatedPerson)
* asserter only Reference(NgPractitioner or NgPractitionerRole or NgPatient or NgRelatedPerson)

// Value set bindings (R4 canonicals)
* clinicalStatus from http://hl7.org/fhir/ValueSet/condition-clinical (required)
* verificationStatus from http://hl7.org/fhir/ValueSet/condition-ver-status (required)
* category from http://hl7.org/fhir/ValueSet/condition-category (extensible)
* severity from http://hl7.org/fhir/ValueSet/condition-severity (preferred)
* bodySite from http://hl7.org/fhir/ValueSet/body-site (example)


// -----------------------------
// Example Instance
// -----------------------------
Instance: NgCondition-001
InstanceOf: NgCondition
Usage: #example
Title: "Example NG Condition"
Description: "Essential hypertension on problem list."
* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed
* category[0] = http://terminology.hl7.org/CodeSystem/condition-category#problem-list-item "Problem List Item"
* severity = http://snomed.info/sct#6736007 "Moderate (severity modifier)"
* code.coding[0].system = "http://snomed.info/sct"
* code.coding[0].code = #59621000
* code.coding[0].display = "Essential hypertension"
* code.text = "Hypertension"
* subject = Reference(NgPatient-001)
* encounter = Reference(NgEncounter-001)
* onsetDateTime = 2025-09-01
* recorder = Reference(NgPractitioner-001)
* asserter = Reference(NgPatient-001)
