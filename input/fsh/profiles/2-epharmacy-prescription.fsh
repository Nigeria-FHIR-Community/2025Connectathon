// ======================================================================
// Profile: NgPrescriptionBundle
// ======================================================================
Profile: NgPrescriptionBundle
Parent: Bundle
Id: ng-prescription-bundle
Title: "2-NGePharmacy 1 Prescription Bundle (Request/Response)"
Description: """
Single Bundle profile that supports BOTH:
- Prescription Request (type=transaction): Patient, Practitioner, Provider Org, 
  MedicationRequest(s), and Medication(s) for new prescriptions
- Prescription Response (type=collection): Patient (echo), Pharmacy Org, 
  MedicationRequest(s) with dispense status, and optional MedicationDispense records
"""
* ^status = #active

// Core
* type 1..1 MS
* entry 2..* MS
* entry.fullUrl 1..1 MS
* entry.resource 1..1 MS
* entry.request 0..1
* entry.request.method 1..1
* entry.request.url 1..1

// Slice by resource profile
* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #open

// Named slices
* entry contains
    patient 1..1 MS and
    practitioner 0..1 MS and
    providerOrg 0..1 MS and
    pharmacyOrg 0..1 MS and
    medication 0..* MS and
    medicationRequest 0..* MS and
    medicationDispense 0..* MS

* entry[patient].resource only NgPatient
* entry[practitioner].resource only NgPractitioner
* entry[providerOrg].resource only NgProviderOrganization
* entry[pharmacyOrg].resource only NgPharmacyOrganization
* entry[medication].resource only NgMedication
* entry[medicationRequest].resource only NgMedicationRequest
* entry[medicationDispense].resource only NgMedicationDispense

* entry.fullUrl ^short = "Prefer URN UUID (urn:uuid:...) for intra-bundle references."

// ===============================================================
// REQUEST BUNDLE (transaction) - New Prescription
// ===============================================================
Instance: Prescription-Request
InstanceOf: NgPrescriptionBundle
Usage: #example
Title: "Prescription - Request (Transaction)"
Description: "Physician creates prescription for patient with multiple medications."
* type = #transaction

// Patient
* entry[0].fullUrl = "urn:uuid:aaa99988-e5f6-4789-a123-456789abcdef"
* entry[0].resource = NgPatient-Rx-001
* entry[0].request.method = #POST
* entry[0].request.url = "Patient"

// Practitioner (prescriber)
* entry[+].fullUrl = "urn:uuid:bbb88877-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgPractitioner-Rx-001
* entry[=].request.method = #POST
* entry[=].request.url = "Practitioner"

// Provider Organization (Hospital/Clinic)
* entry[+].fullUrl = "urn:uuid:ccc77766-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgOrganization-Provider-Rx-001
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

// Medication 1: Metformin 500 mg
* entry[+].fullUrl = "urn:uuid:ddd66655-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedication-Amoxicillin-001
* entry[=].request.method = #POST
* entry[=].request.url = "Medication"

// Medication 2: Atorvastatin 20 mg
* entry[+].fullUrl = "urn:uuid:eee55544-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedication-Ibuprofen-001
* entry[=].request.method = #POST
* entry[=].request.url = "Medication"

// Medication 3: Amlodipine 5 mg
* entry[+].fullUrl = "urn:uuid:fff44433-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedication-VitaminB-001
* entry[=].request.method = #POST
* entry[=].request.url = "Medication"

// MedicationRequest 1: Metformin
* entry[+].fullUrl = "urn:uuid:aaa33322-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedicationRequest-Amoxicillin-001
* entry[=].request.method = #POST
* entry[=].request.url = "MedicationRequest"

// MedicationRequest 2: Atorvastatin
* entry[+].fullUrl = "urn:uuid:bbb22211-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedicationRequest-Ibuprofen-001
* entry[=].request.method = #POST
* entry[=].request.url = "MedicationRequest"

// MedicationRequest 3: Amlodipine
* entry[+].fullUrl = "urn:uuid:ccc11100-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedicationRequest-VitaminB-001
* entry[=].request.method = #POST
* entry[=].request.url = "MedicationRequest"

// ===============================================================
// RESPONSE BUNDLE (collection) - Prescription Fulfillment
// ===============================================================
Instance: Prescription-Response
InstanceOf: NgPrescriptionBundle
Usage: #example
Title: "Prescription - Response (Collection)"
Description: "Pharmacy response with dispense records for filled prescriptions."
* type = #collection

// Patient (echo)
* entry[0].fullUrl = "urn:uuid:aaa99988-e5f6-4789-a123-456789abcdef"
* entry[0].resource = NgPatient-Rx-001

// Practitioner (Dispenser)
* entry[+].fullUrl = "urn:uuid:bbb88877-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgPractitioner-Rx-001

// Pharmacy Organization
* entry[+].fullUrl = "urn:uuid:aaa00011-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgOrganization-Pharmacy-001

// Medication 1: Metformin (echo)
* entry[+].fullUrl = "urn:uuid:ddd66655-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedication-Amoxicillin-001

// Medication 2: Atorvastatin (echo)
* entry[+].fullUrl = "urn:uuid:eee55544-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedication-Ibuprofen-001

// Medication 3: Amlodipine (echo)
* entry[+].fullUrl = "urn:uuid:fff44433-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedication-VitaminB-001

// MedicationRequest 1: Updated with dispense reference (Metformin)
* entry[+].fullUrl = "urn:uuid:aaa33322-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedicationRequest-Amoxicillin-001-Updated

// MedicationRequest 2: Updated with dispense reference (Atorvastatin)
* entry[+].fullUrl = "urn:uuid:bbb22211-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedicationRequest-Ibuprofen-001-Updated

// MedicationRequest 3: Updated with dispense reference (Amlodipine)
* entry[+].fullUrl = "urn:uuid:ccc11100-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedicationRequest-VitaminB-001-Updated

// MedicationDispense — Metformin
* entry[+].fullUrl = "urn:uuid:ddd11122-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedicationDispense-Amoxicillin-001

// MedicationDispense — Atorvastatin
* entry[+].fullUrl = "urn:uuid:eee22233-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedicationDispense-Ibuprofen-001

// MedicationDispense — Amlodipine
* entry[+].fullUrl = "urn:uuid:fff33344-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedicationDispense-VitaminB-001

// ===============================================================
// Inline Resources
// ===============================================================

// -------------------- NgPatient --------------------------------
Instance: NgPatient-Rx-001
InstanceOf: NgPatient
Usage: #inline
Title: "Prescription Patient - Ibrahim Yusuf"
* meta.lastUpdated = "2025-10-28T08:00:00+01:00"
* identifier[PhoneNumber].value = "08056789012"
* identifier[PhoneNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.code = #MOBILE
* identifier[PhoneNumber].type.coding.display = "mobile"
* name.given[0] = "Mallam"
* name.given[1] = "Ibrahim"
* name.family = "Yusuf"
* gender = #male
* birthDate = "1985-03-18"
* active = true
* address.line[0] = "88 Medication Lane"
* address.city = "Kano City"
* address.district = "kn-gezawa"
* address.state = "KN"

// -------------------- NgPractitioner ---------------------------
Instance: NgPractitioner-Rx-001
InstanceOf: NgPractitioner
Usage: #example
Title: "Prescribing Physician - Dr. Oluwaseun Bakare"
Description: "Prescribing Physician - Dr. Oluwaseun Bakare"
* identifier[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-mdcn"
* identifier[0].value = "MDCN-98765"
* active = true
* name.given = "Oluwaseun"
* name.family = "Bakare"
* telecom[0].system = #phone
* telecom[0].value = "08087776666"
* birthDate = "1978-06-22"

// -------------------- NgOrganization (Provider) ----------------
Instance: NgOrganization-Provider-Rx-001
InstanceOf: NgProviderOrganization
Usage: #inline
Title: "Kano General Hospital"
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier.value = "HCF-LA-8899"
* active = true
* name = "Kano General Hospital"
* type.coding.system = "http://terminology.hl7.org/CodeSystem/organization-type"
* type.coding.code = #prov
* type.coding.display = "Healthcare Provider"
* telecom[0].system = #phone
* telecom[0].value = "01-789-4561"
* address.line[0] = "50 Marina Road"
* address.city = "Kano"
* address.district = "kn-gezawa"
* address.state = "KN"
* extension[NGOrganizationOwner].valueCodeableConcept.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-location-owner-cs"
* extension[NGOrganizationOwner].valueCodeableConcept.coding.code = #public

// -------------------- NgOrganization (Pharmacy) ----------------
Instance: NgOrganization-Pharmacy-001
InstanceOf: NgPharmacyOrganization
Usage: #inline
Title: "Medix Pharmacy"
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier.value = "PHARM-LA-5566"
* active = true
* name = "Medix Pharmacy"
* type.coding.system = "http://terminology.hl7.org/CodeSystem/organization-type"
* type.coding.code = #cg
* type.coding.display = "Community Group"
* telecom[0].system = #phone
* telecom[0].value = "01-456-7890"
* address.line[0] = "Medix Pharmacy"
* address.city = "Zoo Road"
* address.district = "kn-gezawa"
* address.state = "KN"

// -------------------- NgMedication 1: Metformin 500 mg --------
Instance: NgMedication-Amoxicillin-001
InstanceOf: NgMedication
Usage: #inline
Title: "Metformin 500 mg Tablets"
* code.coding[0].system = "http://www.whocc.no/atc"
* code.coding[0].code = #A10BA02
* code.coding[0].display = "Metformin"
* code.text = "Metformin 500 mg Tablets"
* status = #active
* manufacturer.display = "Fidson Healthcare Plc"
* form.coding.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* form.coding.code = #TAB
* form.coding.display = "Tablet"
* amount.numerator.value = 500
* amount.numerator.unit = "mg"
* amount.numerator.system = "http://unitsofmeasure.org"
* amount.numerator.code = #mg
* amount.denominator.value = 1
* amount.denominator.unit = "Tablet"
* amount.denominator.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* amount.denominator.code = #TAB
* ingredient[0].itemCodeableConcept.text = "Metformin hydrochloride"
* ingredient[0].strength.numerator.value = 500
* ingredient[0].strength.numerator.unit = "mg"
* ingredient[0].strength.denominator.value = 1
* ingredient[0].strength.denominator.unit = "Tablet"

// -------------------- NgMedication 2: Atorvastatin 20 mg ------
Instance: NgMedication-Ibuprofen-001
InstanceOf: NgMedication
Usage: #inline
Title: "Atorvastatin 20 mg Tablets (Generic)"
* code.coding[0].system = "http://www.whocc.no/atc"
* code.coding[0].code = #C10AA05
* code.coding[0].display = "Atorvastatin"
* code.text = "Atorvastatin 20 mg Tablets"
* status = #active
* form.coding.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* form.coding.code = #TAB
* form.coding.display = "Tablet"
* amount.numerator.value = 20
* amount.numerator.unit = "mg"
* amount.numerator.system = "http://unitsofmeasure.org"
* amount.numerator.code = #mg
* amount.denominator.value = 1
* amount.denominator.unit = "Tablet"
* amount.denominator.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* amount.denominator.code = #TAB
* ingredient[0].itemCodeableConcept.text = "Atorvastatin"
* ingredient[0].strength.numerator.value = 20
* ingredient[0].strength.numerator.unit = "mg"
* ingredient[0].strength.denominator.value = 1
* ingredient[0].strength.denominator.unit = "Tablet"

// -------------------- NgMedication 3: Amlodipine 5 mg ---------
Instance: NgMedication-VitaminB-001
InstanceOf: NgMedication
Usage: #inline
Title: "Amlodipine 5 mg Tablets"
* code.coding[0].system = "http://www.whocc.no/atc"
* code.coding[0].code = #C08CA01
* code.coding[0].display = "Amlodipine"
* code.text = "Amlodipine 5 mg Tablets"
* status = #active
* form.coding.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* form.coding.code = #TAB
* form.coding.display = "Tablet"
* amount.numerator.value = 5
* amount.numerator.unit = "mg"
* amount.numerator.system = "http://unitsofmeasure.org"
* amount.numerator.code = #mg
* amount.denominator.value = 1
* amount.denominator.unit = "Tablet"
* amount.denominator.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* amount.denominator.code = #TAB
* ingredient[0].itemCodeableConcept.text = "Amlodipine"
* ingredient[0].strength.numerator.value = 5
* ingredient[0].strength.numerator.unit = "mg"
* ingredient[0].strength.denominator.value = 1
* ingredient[0].strength.denominator.unit = "Tablet"

// -------------------- MedicationRequest 1: Metformin ----------
Instance: NgMedicationRequest-Amoxicillin-001
InstanceOf: NgMedicationRequest
Usage: #inline
Title: "Prescription for Metformin 500 mg"
* status = #active
* intent = #order
* medicationReference = Reference(urn:uuid:ddd66655-e5f6-4789-a123-456789abcdef)
* subject = Reference(urn:uuid:aaa99988-e5f6-4789-a123-456789abcdef)
* authoredOn = "2025-10-28T08:15:00+01:00"
* requester = Reference(urn:uuid:bbb88877-e5f6-4789-a123-456789abcdef)
* dosageInstruction[0].text = "Take 2 tablets in the morning and 2 tablets at night WITH food for 30 days"
* dosageInstruction[0].timing.repeat.frequency = 2
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].timing.repeat.duration = 30
* dosageInstruction[0].timing.repeat.durationUnit = #d
* dosageInstruction[0].route.coding.system = "http://snomed.info/sct"
* dosageInstruction[0].route.coding.code = #26643006
* dosageInstruction[0].route.coding.display = "Oral route"
* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 2
* dosageInstruction[0].doseAndRate[0].doseQuantity.unit = "Tablet"
* dosageInstruction[0].doseAndRate[0].doseQuantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dosageInstruction[0].doseAndRate[0].doseQuantity.code = #TAB
* dispenseRequest.numberOfRepeatsAllowed = 0
* dispenseRequest.quantity.value = 120
* dispenseRequest.quantity.unit = "Tablet"
* dispenseRequest.quantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dispenseRequest.quantity.code = #TAB
* dispenseRequest.expectedSupplyDuration.value = 30
* dispenseRequest.expectedSupplyDuration.unit = "days"
* dispenseRequest.expectedSupplyDuration.system = "http://unitsofmeasure.org"
* dispenseRequest.expectedSupplyDuration.code = #d

// -------------------- MedicationRequest 2: Atorvastatin -------
Instance: NgMedicationRequest-Ibuprofen-001
InstanceOf: NgMedicationRequest
Usage: #inline
Title: "Prescription for Atorvastatin 20 mg (nightly)"
* status = #active
* intent = #order
* medicationReference = Reference(urn:uuid:eee55544-e5f6-4789-a123-456789abcdef)
* subject = Reference(urn:uuid:aaa99988-e5f6-4789-a123-456789abcdef)
* authoredOn = "2025-10-28T08:15:00+01:00"
* requester = Reference(urn:uuid:bbb88877-e5f6-4789-a123-456789abcdef)
* dosageInstruction[0].text = "Take 1 tablet nightly; avoid grapefruit juice."
* dosageInstruction[0].timing.repeat.frequency = 1
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].route.coding.system = "http://snomed.info/sct"
* dosageInstruction[0].route.coding.code = #26643006
* dosageInstruction[0].route.coding.display = "Oral route"
* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 1
* dosageInstruction[0].doseAndRate[0].doseQuantity.unit = "Tablet"
* dosageInstruction[0].doseAndRate[0].doseQuantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dosageInstruction[0].doseAndRate[0].doseQuantity.code = #TAB
* dispenseRequest.numberOfRepeatsAllowed = 1
* dispenseRequest.quantity.value = 30
* dispenseRequest.quantity.unit = "Tablet"
* dispenseRequest.quantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dispenseRequest.quantity.code = #TAB
* dispenseRequest.expectedSupplyDuration.value = 30
* dispenseRequest.expectedSupplyDuration.unit = "days"
* dispenseRequest.expectedSupplyDuration.system = "http://unitsofmeasure.org"
* dispenseRequest.expectedSupplyDuration.code = #d

// -------------------- MedicationRequest 3: Amlodipine ---------
Instance: NgMedicationRequest-VitaminB-001
InstanceOf: NgMedicationRequest
Usage: #inline
Title: "Prescription for Amlodipine 5 mg (morning)"
* status = #active
* intent = #order
* medicationReference = Reference(urn:uuid:fff44433-e5f6-4789-a123-456789abcdef)
* subject = Reference(urn:uuid:aaa99988-e5f6-4789-a123-456789abcdef)
* authoredOn = "2025-10-28T08:15:00+01:00"
* requester = Reference(urn:uuid:bbb88877-e5f6-4789-a123-456789abcdef)
* dosageInstruction[0].text = "Take 1 tablet every morning."
* dosageInstruction[0].timing.repeat.frequency = 1
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].timing.repeat.duration = 30
* dosageInstruction[0].timing.repeat.durationUnit = #d
* dosageInstruction[0].route.coding.system = "http://snomed.info/sct"
* dosageInstruction[0].route.coding.code = #26643006
* dosageInstruction[0].route.coding.display = "Oral route"
* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 1
* dosageInstruction[0].doseAndRate[0].doseQuantity.unit = "Tablet"
* dosageInstruction[0].doseAndRate[0].doseQuantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dosageInstruction[0].doseAndRate[0].doseQuantity.code = #TAB
* dispenseRequest.numberOfRepeatsAllowed = 2
* dispenseRequest.quantity.value = 30
* dispenseRequest.quantity.unit = "Tablet"
* dispenseRequest.quantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dispenseRequest.quantity.code = #TAB
* dispenseRequest.expectedSupplyDuration.value = 30
* dispenseRequest.expectedSupplyDuration.unit = "days"
* dispenseRequest.expectedSupplyDuration.system = "http://unitsofmeasure.org"
* dispenseRequest.expectedSupplyDuration.code = #d

// -------------------- Updated MedicationRequests (Response) ----
Instance: NgMedicationRequest-Amoxicillin-001-Updated
InstanceOf: NgMedicationRequest
Usage: #inline
Title: "Prescription for Metformin 500 mg (Updated)"
* status = #completed
* intent = #order
* medicationReference = Reference(urn:uuid:ddd66655-e5f6-4789-a123-456789abcdef)
* subject = Reference(urn:uuid:aaa99988-e5f6-4789-a123-456789abcdef)
* authoredOn = "2025-10-28T08:15:00+01:00"
* requester = Reference(urn:uuid:bbb88877-e5f6-4789-a123-456789abcdef)
* dosageInstruction[0].text = "Take 2 tablets in the morning and 2 tablets at night WITH food for 30 days"
* dosageInstruction[0].timing.repeat.frequency = 2
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].timing.repeat.duration = 30
* dosageInstruction[0].timing.repeat.durationUnit = #d
* dosageInstruction[0].route.coding.system = "http://snomed.info/sct"
* dosageInstruction[0].route.coding.code = #26643006
* dosageInstruction[0].route.coding.display = "Oral route"
* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 2
* dosageInstruction[0].doseAndRate[0].doseQuantity.unit = "Tablet"
* dosageInstruction[0].doseAndRate[0].doseQuantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dosageInstruction[0].doseAndRate[0].doseQuantity.code = #TAB
* dispenseRequest.numberOfRepeatsAllowed = 0
* dispenseRequest.quantity.value = 120
* dispenseRequest.quantity.unit = "Tablet"
* dispenseRequest.quantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dispenseRequest.quantity.code = #TAB
* dispenseRequest.expectedSupplyDuration.value = 30
* dispenseRequest.expectedSupplyDuration.unit = "days"
* dispenseRequest.expectedSupplyDuration.system = "http://unitsofmeasure.org"
* dispenseRequest.expectedSupplyDuration.code = #d

Instance: NgMedicationRequest-Ibuprofen-001-Updated
InstanceOf: NgMedicationRequest
Usage: #inline
Title: "Prescription for Atorvastatin 20 mg (Updated)"
* status = #completed
* intent = #order
* medicationReference = Reference(urn:uuid:eee55544-e5f6-4789-a123-456789abcdef)
* subject = Reference(urn:uuid:aaa99988-e5f6-4789-a123-456789abcdef)
* authoredOn = "2025-10-28T08:15:00+01:00"
* requester = Reference(urn:uuid:bbb88877-e5f6-4789-a123-456789abcdef)
* dosageInstruction[0].text = "Take 1 tablet nightly; avoid grapefruit juice."
* dosageInstruction[0].timing.repeat.frequency = 1
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].route.coding.system = "http://snomed.info/sct"
* dosageInstruction[0].route.coding.code = #26643006
* dosageInstruction[0].route.coding.display = "Oral route"
* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 1
* dosageInstruction[0].doseAndRate[0].doseQuantity.unit = "Tablet"
* dosageInstruction[0].doseAndRate[0].doseQuantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dosageInstruction[0].doseAndRate[0].doseQuantity.code = #TAB
* dispenseRequest.numberOfRepeatsAllowed = 1
* dispenseRequest.quantity.value = 30
* dispenseRequest.quantity.unit = "Tablet"
* dispenseRequest.quantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dispenseRequest.quantity.code = #TAB
* dispenseRequest.expectedSupplyDuration.value = 30
* dispenseRequest.expectedSupplyDuration.unit = "days"
* dispenseRequest.expectedSupplyDuration.system = "http://unitsofmeasure.org"
* dispenseRequest.expectedSupplyDuration.code = #d

Instance: NgMedicationRequest-VitaminB-001-Updated
InstanceOf: NgMedicationRequest
Usage: #inline
Title: "Prescription for Amlodipine 5 mg (Updated)"
* status = #completed
* intent = #order
* medicationReference = Reference(urn:uuid:fff44433-e5f6-4789-a123-456789abcdef)
* subject = Reference(urn:uuid:aaa99988-e5f6-4789-a123-456789abcdef)
* authoredOn = "2025-10-28T08:15:00+01:00"
* requester = Reference(urn:uuid:bbb88877-e5f6-4789-a123-456789abcdef)
* dosageInstruction[0].text = "Take 1 tablet every morning."
* dosageInstruction[0].timing.repeat.frequency = 1
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].timing.repeat.duration = 30
* dosageInstruction[0].timing.repeat.durationUnit = #d
* dosageInstruction[0].route.coding.system = "http://snomed.info/sct"
* dosageInstruction[0].route.coding.code = #26643006
* dosageInstruction[0].route.coding.display = "Oral route"
* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 1
* dosageInstruction[0].doseAndRate[0].doseQuantity.unit = "Tablet"
* dosageInstruction[0].doseAndRate[0].doseQuantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dosageInstruction[0].doseAndRate[0].doseQuantity.code = #TAB
* dispenseRequest.numberOfRepeatsAllowed = 2
* dispenseRequest.quantity.value = 30
* dispenseRequest.quantity.unit = "Tablet"
* dispenseRequest.quantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dispenseRequest.quantity.code = #TAB
* dispenseRequest.expectedSupplyDuration.value = 30
* dispenseRequest.expectedSupplyDuration.unit = "days"
* dispenseRequest.expectedSupplyDuration.system = "http://unitsofmeasure.org"
* dispenseRequest.expectedSupplyDuration.code = #d

// -------------------- MedicationDispense 1: Metformin ---------
Instance: NgMedicationDispense-Amoxicillin-001
InstanceOf: NgMedicationDispense
Usage: #inline
Title: "Dispensed - Metformin 500 mg"
* status = #completed
* medicationReference = Reference(urn:uuid:ddd66655-e5f6-4789-a123-456789abcdef)
* subject = Reference(urn:uuid:aaa99988-e5f6-4789-a123-456789abcdef)
* performer[0].actor = Reference(urn:uuid:aaa00011-e5f6-4789-a123-456789abcdef)
* authorizingPrescription[0] = Reference(urn:uuid:aaa33322-e5f6-4789-a123-456789abcdef)
* type.coding.system = "http://terminology.hl7.org/CodeSystem/v3-ActCode"
* type.coding.code = #FF
* type.coding.display = "First Fill"
* quantity.value = 120
* quantity.unit = "Tablet"
* quantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* quantity.code = #TAB
* daysSupply.value = 30
* daysSupply.unit = "days"
* daysSupply.system = "http://unitsofmeasure.org"
* daysSupply.code = #d
* whenPrepared = "2025-10-28T14:30:00+01:00"
* whenHandedOver = "2025-10-28T14:45:00+01:00"
* dosageInstruction[0].text = "Take 2 tablets in the morning and 2 tablets at night WITH food."
* dosageInstruction[0].timing.repeat.frequency = 2
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].route.coding.system = "http://snomed.info/sct"
* dosageInstruction[0].route.coding.code = #26643006
* dosageInstruction[0].route.coding.display = "Oral route"
* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 2
* dosageInstruction[0].doseAndRate[0].doseQuantity.unit = "Tablet"
* dosageInstruction[0].doseAndRate[0].doseQuantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dosageInstruction[0].doseAndRate[0].doseQuantity.code = #TAB

// -------------------- MedicationDispense 2: Atorvastatin ------
Instance: NgMedicationDispense-Ibuprofen-001
InstanceOf: NgMedicationDispense
Usage: #inline
Title: "Dispensed - Atorvastatin 20 mg (Generic)"
* status = #completed
* medicationReference = Reference(urn:uuid:eee55544-e5f6-4789-a123-456789abcdef)
* subject = Reference(urn:uuid:aaa99988-e5f6-4789-a123-456789abcdef)
* performer[0].actor = Reference(urn:uuid:aaa00011-e5f6-4789-a123-456789abcdef)
* authorizingPrescription[0] = Reference(urn:uuid:bbb22211-e5f6-4789-a123-456789abcdef)
* type.coding.system = "http://terminology.hl7.org/CodeSystem/v3-ActCode"
* type.coding.code = #FF
* type.coding.display = "First Fill"
* quantity.value = 30
* quantity.unit = "Tablet"
* quantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* quantity.code = #TAB
* daysSupply.value = 30
* daysSupply.unit = "days"
* daysSupply.system = "http://unitsofmeasure.org"
* daysSupply.code = #d
* whenPrepared = "2025-10-28T14:35:00+01:00"
* whenHandedOver = "2025-10-28T14:45:00+01:00"
* dosageInstruction[0].text = "Take 1 tablet nightly; avoid grapefruit juice."
* dosageInstruction[0].timing.repeat.frequency = 1
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].route.coding.system = "http://snomed.info/sct"
* dosageInstruction[0].route.coding.code = #26643006
* dosageInstruction[0].route.coding.display = "Oral route"
* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 1
* dosageInstruction[0].doseAndRate[0].doseQuantity.unit = "Tablet"
* dosageInstruction[0].doseAndRate[0].doseQuantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dosageInstruction[0].doseAndRate[0].doseQuantity.code = #TAB
* note[0].text = "Patient requested lower-cost generic; substituted branded with generic atorvastatin (bioequivalent)."

// -------------------- MedicationDispense 3: Amlodipine --------
Instance: NgMedicationDispense-VitaminB-001
InstanceOf: NgMedicationDispense
Usage: #inline
Title: "Dispensed - Amlodipine 5 mg"
* status = #completed
* medicationReference = Reference(urn:uuid:fff44433-e5f6-4789-a123-456789abcdef)
* subject = Reference(urn:uuid:aaa99988-e5f6-4789-a123-456789abcdef)
* performer[0].actor = Reference(urn:uuid:aaa00011-e5f6-4789-a123-456789abcdef)
* authorizingPrescription[0] = Reference(urn:uuid:ccc11100-e5f6-4789-a123-456789abcdef)
* type.coding.system = "http://terminology.hl7.org/CodeSystem/v3-ActCode"
* type.coding.code = #FF
* type.coding.display = "First Fill"
* quantity.value = 30
* quantity.unit = "Tablet"
* quantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* quantity.code = #TAB
* daysSupply.value = 30
* daysSupply.unit = "days"
* daysSupply.system = "http://unitsofmeasure.org"
* daysSupply.code = #d
* whenPrepared = "2025-10-28T14:40:00+01:00"
* whenHandedOver = "2025-10-28T14:45:00+01:00"
* dosageInstruction[0].text = "Take 1 tablet every morning."
* dosageInstruction[0].timing.repeat.frequency = 1
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].route.coding.system = "http://snomed.info/sct"
* dosageInstruction[0].route.coding.code = #26643006
* dosageInstruction[0].route.coding.display = "Oral route"
* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 1
* dosageInstruction[0].doseAndRate[0].doseQuantity.unit = "Tablet"
* dosageInstruction[0].doseAndRate[0].doseQuantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dosageInstruction[0].doseAndRate[0].doseQuantity.code = #TAB
