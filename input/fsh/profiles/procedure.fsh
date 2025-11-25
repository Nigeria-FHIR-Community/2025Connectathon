Profile: NgProcedure
Parent: Procedure
Title: "NG Procedure"
Id: ng-procedure
Description: "Minimal Procedure profile for the 2025 Connectathon."
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-procedure"

// Core constraints
* status 1..1 MS
* code 1..1 MS
* subject 1..1 MS
* performed[x] 0..1 MS
* category 0..1 MS
* encounter 0..1
* recorder 0..1
* asserter 0..1
* bodySite 0..*
* reasonCode 0..*
* reasonReference 0..*
* outcome 0..1
* complication 0..*
* performer 0..*
* performer.actor 1..1 MS
* location 0..1
* usedReference 0..*
* report 0..*

// Reference targets
* subject only Reference(NgPatient)
* encounter only Reference(NgEncounter)
* recorder only Reference(NgPractitioner or NgPractitionerRole or NgPatient)
* asserter only Reference(NgPractitioner or NgPractitionerRole or NgPatient or NgRelatedPerson)
* performer.actor only Reference(NgPractitioner or NgPractitionerRole or NgOrganization or NgPatient or NgRelatedPerson or NgDevice)
* location only Reference(NgLocation)
* reasonReference only Reference(NgCondition or NgObservation)
* usedReference only Reference(NgDevice or NgMedication)


// Terminology bindings (R4 canonicals)
* status from http://hl7.org/fhir/ValueSet/event-status (required)
* category from http://hl7.org/fhir/ValueSet/procedure-category (preferred)
* code from http://hl7.org/fhir/ValueSet/procedure-code (example)
* bodySite from http://hl7.org/fhir/ValueSet/body-site (example)


// EXAMPLES
// -----------------------------
// Example Instance
// -----------------------------
Instance: NgProcedure-001
InstanceOf: NgProcedure
Usage: #example
Title: "Example NG Procedure"
Description: "Cesarean section for obstructed labor."
* id = "00124455-65f6-4789-a123-456789abcdef"
* status = #completed
* category.text = "Obstetrics procedure"
* code.coding[0].system = "http://snomed.info/sct"
* code.coding[0].code = #11466000
* code.coding[0].display = "Cesarean section"
* subject = Reference(NgPatient-001)
* encounter = Reference(NgEncounter-001)
* performedDateTime = 2025-11-27T10:30:00Z
* reasonCode[0].text = "Obstructed labor"
* performer[0].actor = Reference(NgPractitioner-001)
* location = Reference(NgLocation-001)
* outcome.text = "Mother and baby stable"
* usedReference[0] = Reference(NgDevice-001)
