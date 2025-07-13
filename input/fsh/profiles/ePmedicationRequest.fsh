Profile: NgePMedicationRequest
Parent: MedicationRequest
Id: ep-medication-request
Title: "NG-eP MedicationRequest Profile"
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
* subject only Reference(NgePPatient)
* medication[x] only Reference(NgePMedication)