// -----------------------------
// Profile: NgMedicationDispense
// -----------------------------
Profile: NgMedicationDispense
Parent: MedicationDispense
Title: "NG MedicationDispense"
Id: ng-medication-dispense
Description: "Minimal MedicationDispense profile for the 2025 Connectathon (ePharmacy)."
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-medication-dispense"
// Core elements 
* status 1..1 MS
* medication[x] 1..1 MS
* medication[x] only CodeableConcept or Reference(NgMedication)
* subject 1..1 MS
* subject only Reference(NgPatient)
* quantity 0..1 MS
* whenHandedOver 0..1 MS
* authorizingPrescription 0..* MS
* authorizingPrescription only Reference(NgMedicationRequest)
* performer 0..*
* performer.actor 1..1 MS
* performer.actor only Reference(NgPractitioner or NgPractitionerRole or NgOrganization)
* dosageInstruction 0..*
* note 0..*

// Value set binding (R4 canonical)
* status from http://hl7.org/fhir/ValueSet/medicationdispense-status (required)

// EXAMPLES

// ==============================================
// 1) Amoxicillin capsules for NgPatient-002
// ==============================================
Instance: NgMedicationDispense-001
InstanceOf: NgMedicationDispense
Usage: #example
Title: "Example Ng MedicationDispense (Amoxicillin 500 mg CAPS x30)"
Description: "Completed outpatient dispensing."
* id = "00127455-e5f6-4789-a123-456789abcdef"
* status = #completed
* medicationReference = Reference(NgMedication-001)
* subject = Reference(NgPatient-002)
* quantity.value = 30
* quantity.unit = "1"
* quantity.system = "http://unitsofmeasure.org"
* quantity.code = #1
* whenHandedOver = 2025-11-04T12:20:00+01:00
* performer[0].actor = Reference(NgPractitioner-002)
* dosageInstruction[0].text = "Take 1 capsule orally every 8 hours for 10 days."
* note[0].text = "Dispensed after coverage verification."


// ==============================================
// 2) Paracetamol suspension for NgPatient-003
// ==============================================
Instance: NgMedicationDispense-002
InstanceOf: NgMedicationDispense
Usage: #example
Title: "Example Ng MedicationDispense (Paracetamol 250 mg/5 mL, 100 mL)"
Description: "Completed pediatric dispensing."
* status = #completed
* medicationReference = Reference(NgMedication-002)
* subject = Reference(Patient/NgPatient-003)
* quantity.value = 100
* quantity.unit = "mL"
* quantity.system = "http://unitsofmeasure.org"
* quantity.code = #mL
* whenHandedOver = 2025-11-04T12:25:00+01:00
* performer[0].actor = Reference(NgPractitioner-003)
* dosageInstruction[0].text = "5 mL orally every 6 hours as needed for fever."
* note[0].text = "Shake well before use."


// ==============================================
// 3) Insulin vial for NgPatient-001 (using CodeableConcept medication)
// ==============================================
Instance: NgMedicationDispense-003
InstanceOf: NgMedicationDispense
Usage: #example
Title: "Example Ng MedicationDispense (Insulin 100 IU/mL, 10 mL)"
Description: "Completed insulin dispensing."
* status = #completed
* medicationCodeableConcept.text = "Insulin (short-acting) 100 IU/mL vial"
* subject = Reference(NgPatient-001)
* quantity.value = 10
* quantity.unit = "mL"
* quantity.system = "http://unitsofmeasure.org"
* quantity.code = #mL
* whenHandedOver = 2025-11-04T12:40:00+01:00
* performer[0].actor = Reference(NgPractitioner-001)
* dosageInstruction[0].text = "Inject 10 units subcutaneously before breakfast daily."
* note[0].text = "Keep refrigerated. Do not freeze."
