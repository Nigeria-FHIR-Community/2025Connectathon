Profile: NgMedicationRequest
Parent: MedicationRequest
Id: ng-medication-request
Title: "NG MedicationRequest"
Description: "A MedicationRequest profile with some of core elements for demonstration purposes."

* dosageInstruction MS
* supportingInformation MS
* eventHistory MS
* basedOn MS
* intent MS
* groupIdentifier MS
* subject MS
* instantiatesCanonical MS
* courseOfTherapyType MS
* reported[x] MS
* reasonCode MS
* identifier MS
* status MS
* dispenseRequest MS
* category MS
* reasonReference MS
* detectedIssue MS
* requester MS
* subject only Reference(NgPatient)
* medication[x] only Reference(NgMedication)


// EXAMPLES
// ==============================================
// 1) Amoxicillin for acute sinusitis (outpatient)
// ==============================================
Instance: NgMedicationRequest-001
InstanceOf: NgMedicationRequest
Usage: #example
Title: "Example Ng MedicationRequest (Amoxicillin)"
Description: "Order for Amoxicillin 500 mg capsule x30."
* identifier.system = "https://www.dhin-hie.org/ig/prescription-id"
* identifier.value  = "RX-2025-0001"
* groupIdentifier.system = "https://www.dhin-hie.org/ig/prescription-group"
* groupIdentifier.value  = "GRP-2025-1001"

* status = #active
* intent = #order
* category[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/medicationrequest-category"
* category[0].coding[0].code = #outpatient
* reportedBoolean = false

* subject = Reference(NgPatient/NgPatient-002)
* medicationReference = Reference(NgMedication/NgMedication-001)
* requester = Reference(NgPractitioner/NgPractitioner-002)

* reasonCode[0].text = "Acute bacterial sinusitis"
* supportingInformation[0] = Reference(NgObservation/NgObservation-001) // optional but MS-friendly

* courseOfTherapyType.text = "Acute (10 days)"
* dosageInstruction[0].text = "Take 1 capsule orally every 8 hours for 10 days."

* dispenseRequest.quantity.value = 30
* dispenseRequest.quantity.unit  = "1"
* dispenseRequest.quantity.system = "http://unitsofmeasure.org"
* dispenseRequest.quantity.code  = #1
* dispenseRequest.expectedSupplyDuration.value = 10
* dispenseRequest.expectedSupplyDuration.unit  = "days"
* dispenseRequest.expectedSupplyDuration.system = "http://unitsofmeasure.org"
* dispenseRequest.expectedSupplyDuration.code  = #d


// ==============================================
// 2) Paracetamol suspension for fever (pediatrics)
// ==============================================
Instance: NgMedicationRequest-002
InstanceOf: NgMedicationRequest
Usage: #example
Title: "Example Ng MedicationRequest (Paracetamol Suspension)"
Description: "Order for Paracetamol 250 mg/5 mL, 100 mL."
* identifier.system = "https://www.dhin-hie.org/ig/prescription-id"
* identifier.value  = "RX-2025-0002"
* groupIdentifier.system = "https://www.dhin-hie.org/ig/prescription-group"
* groupIdentifier.value  = "GRP-2025-2001"

* status = #active
* intent = #order
* category[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/medicationrequest-category"
* category[0].coding[0].code = #outpatient
* reportedBoolean = false

* subject = Reference(NgPatient/NgPatient-003)
* medicationReference = Reference(NgMedication/NgMedication-002)
* requester = Reference(NgPractitioner/NgPractitioner-003)

* reasonCode[0].text = "Fever"
* courseOfTherapyType.text = "Symptomatic short course"
* dosageInstruction[0].text = "Give 5 mL orally every 6 hours as needed for fever."

* dispenseRequest.quantity.value = 100
* dispenseRequest.quantity.unit  = "mL"
* dispenseRequest.quantity.system = "http://unitsofmeasure.org"
* dispenseRequest.quantity.code  = #mL
* dispenseRequest.expectedSupplyDuration.value = 5
* dispenseRequest.expectedSupplyDuration.unit  = "days"
* dispenseRequest.expectedSupplyDuration.system = "http://unitsofmeasure.org"
* dispenseRequest.expectedSupplyDuration.code  = #d
* dispenseRequest.performer = Reference(NgOrganization/NgOrganization-003)


// ==============================================
// 3) Insulin for diabetes (community/chronic therapy)
// ==============================================
Instance: NgMedicationRequest-003
InstanceOf: NgMedicationRequest
Usage: #example
Title: "Example MedicationRequest (Insulin 100 IU/mL)"
Description: "Order for Insulin 100 IU/mL vial, ongoing therapy."
* identifier.system = "https://www.dhin-hie.org/ig/prescription-id"
* identifier.value  = "RX-2025-0003"
* groupIdentifier.system = "https://www.dhin-hie.org/ig/prescription-group"
* groupIdentifier.value  = "GRP-2025-3001"

* status = #active
* intent = #order
* category[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/medicationrequest-category"
* category[0].coding[0].code = #community
* reportedBoolean = false

* subject = Reference(NgPatient/NgPatient-001)
* medicationReference = Reference(NgMedication/NgMedication-003)
* requester = Reference(NgPractitioner/NgPractitioner-001)

* reasonCode[0].text = "Type 1 diabetes mellitus"
* courseOfTherapyType.text = "Long-term (chronic) therapy"
* dosageInstruction[0].text = "Inject 10 units subcutaneously before breakfast daily."

* dispenseRequest.quantity.value = 10
* dispenseRequest.quantity.unit  = "mL"
* dispenseRequest.quantity.system = "http://unitsofmeasure.org"
* dispenseRequest.quantity.code  = #mL
* dispenseRequest.numberOfRepeatsAllowed = 3
* dispenseRequest.expectedSupplyDuration.value = 30
* dispenseRequest.expectedSupplyDuration.unit  = "days"
* dispenseRequest.expectedSupplyDuration.system = "http://unitsofmeasure.org"
* dispenseRequest.expectedSupplyDuration.code  = #d
* dispenseRequest.performer = Reference(NgOrganization/NgOrganization-002)
