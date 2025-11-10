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

// Invariants
Invariant: ngrx-transaction-shape
Description: "If Bundle.type = 'transaction', include ≥1 MedicationRequest and every entry has request.method & request.url."
Severity: #error
Expression: "(type = 'transaction') implies (entry.resource.ofType(MedicationRequest).count() >= 1 and entry.request.all(method.exists() and url.exists()))"

Invariant: ngrx-collection-shape
Description: "If Bundle.type = 'collection', include ≥1 MedicationRequest or MedicationDispense."
Severity: #error
Expression: "(type = 'collection') implies (entry.resource.ofType(MedicationRequest).count() >= 1 or entry.resource.ofType(MedicationDispense).count() >= 1)"

Invariant: ngrx-urn-uuids
Description: "Entries SHOULD use URN UUID fullUrls for local intra-bundle references."
Severity: #warning
Expression: "entry.fullUrl.all(matches('^urn:uuid:'))"


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

// Medication 1: Amoxicillin
* entry[+].fullUrl = "urn:uuid:ddd66655-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedication-Amoxicillin-001
* entry[=].request.method = #POST
* entry[=].request.url = "Medication"

// Medication 2: Ibuprofen
* entry[+].fullUrl = "urn:uuid:eee55544-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedication-Ibuprofen-001
* entry[=].request.method = #POST
* entry[=].request.url = "Medication"

// Medication 3: Vitamin B Complex
* entry[+].fullUrl = "urn:uuid:fff44433-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedication-VitaminB-001
* entry[=].request.method = #POST
* entry[=].request.url = "Medication"

// MedicationRequest 1: Amoxicillin prescription
* entry[+].fullUrl = "urn:uuid:aaa33322-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedicationRequest-Amoxicillin-001
* entry[=].request.method = #POST
* entry[=].request.url = "MedicationRequest"

// MedicationRequest 2: Ibuprofen prescription
* entry[+].fullUrl = "urn:uuid:bbb22211-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedicationRequest-Ibuprofen-001
* entry[=].request.method = #POST
* entry[=].request.url = "MedicationRequest"

// MedicationRequest 3: Vitamin B prescription
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

// Medication 1: Amoxicillin (echo)
* entry[+].fullUrl = "urn:uuid:ddd66655-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedication-Amoxicillin-001

// Medication 2: Ibuprofen (echo)
* entry[+].fullUrl = "urn:uuid:eee55544-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedication-Ibuprofen-001

// Medication 3: Vitamin B (echo)
* entry[+].fullUrl = "urn:uuid:fff44433-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedication-VitaminB-001

// MedicationRequest 1: Updated with dispense reference
* entry[+].fullUrl = "urn:uuid:aaa33322-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedicationRequest-Amoxicillin-001-Updated

// MedicationRequest 2: Updated with dispense reference
* entry[+].fullUrl = "urn:uuid:bbb22211-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedicationRequest-Ibuprofen-001-Updated

// MedicationRequest 3: Updated with dispense reference
* entry[+].fullUrl = "urn:uuid:ccc11100-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedicationRequest-VitaminB-001-Updated

// MedicationDispense 1: Amoxicillin dispensed
* entry[+].fullUrl = "urn:uuid:ddd11122-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedicationDispense-Amoxicillin-001

// MedicationDispense 2: Ibuprofen dispensed
* entry[+].fullUrl = "urn:uuid:eee22233-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedicationDispense-Ibuprofen-001

// MedicationDispense 3: Vitamin B dispensed
* entry[+].fullUrl = "urn:uuid:fff33344-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgMedicationDispense-VitaminB-001


// ===============================================================
// Inline Resources
// ===============================================================

// -------------------- NgPatient --------------------------------
Instance: NgPatient-Rx-001
InstanceOf: NgPatient
Usage: #inline
Title: "Prescription Patient - Folake Adeyemi"
* meta.lastUpdated = "2025-10-28T08:00:00+01:00"
* identifier[PhoneNumber].value = "08056789012"
* identifier[PhoneNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.code = #MOBILE
* identifier[PhoneNumber].type.coding.display = "mobile"
* name.given[0] = "Folake"
* name.family = "Adeyemi"
* gender = #female
* birthDate = "1985-03-18"
* active = true
* address.line[0] = "88 Medication Lane"
* address.city = "Ikeja"
* address.district = "la-ikeja"
* address.state = "LA"

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
Title: "Lagos General Hospital"
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier.value = "HCF-LA-8899"
* active = true
* name = "Lagos General Hospital"
* type.coding.system = "http://terminology.hl7.org/CodeSystem/organization-type"
* type.coding.code = #prov
* type.coding.display = "Healthcare Provider"
* telecom[0].system = #phone
* telecom[0].value = "01-789-4561"
* address.line[0] = "50 Marina Road"
* address.city = "Ikeja"
* address.district = "la-ikeja"
* address.state = "LA"
* extension[NGOrganizationOwner].valueCodeableConcept.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-location-owner-cs"
* extension[NGOrganizationOwner].valueCodeableConcept.coding.code = #public

// -------------------- NgOrganization (Pharmacy) ----------------
Instance: NgOrganization-Pharmacy-001
InstanceOf: NgPharmacyOrganization
Usage: #inline
Title: "CarePlus Pharmacy"
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier.value = "PHARM-LA-5566"
* active = true
* name = "CarePlus Pharmacy"
* type.coding.system = "http://terminology.hl7.org/CodeSystem/organization-type"
* type.coding.code = #cg
* type.coding.display = "Community Group"
* telecom[0].system = #phone
* telecom[0].value = "01-456-7890"
* address.line[0] = "33 Pharmacy Plaza"
* address.city = "Ikeja"
* address.district = "la-ikeja"
* address.state = "LA"

// -------------------- NgMedication 1: Amoxicillin -------------
Instance: NgMedication-Amoxicillin-001
InstanceOf: NgMedication
Usage: #inline
Title: "Amoxicillin 500mg Capsules"
* code.coding[0].system = "http://www.whocc.no/atc"
* code.coding[0].code = #J01CA04
* code.coding[0].display = "Amoxicillin"
* code.text = "Amoxicillin 500mg Capsules"
* status = #active
* form.coding.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* form.coding.code = #CAP
* form.coding.display = "Capsule"
* amount.numerator.value = 500
* amount.numerator.unit = "mg"
* amount.numerator.system = "http://unitsofmeasure.org"
* amount.numerator.code = #mg
* amount.denominator.value = 1
* amount.denominator.unit = "Capsule"
* amount.denominator.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* amount.denominator.code = #CAP
* ingredient[0].itemCodeableConcept.text = "Amoxicillin trihydrate"
* ingredient[0].strength.numerator.value = 500
* ingredient[0].strength.numerator.unit = "mg"
* ingredient[0].strength.denominator.value = 1
* ingredient[0].strength.denominator.unit = "Capsule"

// -------------------- NgMedication 2: Ibuprofen ---------------
Instance: NgMedication-Ibuprofen-001
InstanceOf: NgMedication
Usage: #inline
Title: "Ibuprofen 400mg Tablets"
* code.coding[0].system = "http://www.whocc.no/atc"
* code.coding[0].code = #M01AE01
* code.coding[0].display = "Ibuprofen"
* code.text = "Ibuprofen 400mg Tablets"
* status = #active
* form.coding.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* form.coding.code = #TAB
* form.coding.display = "Tablet"
* amount.numerator.value = 400
* amount.numerator.unit = "mg"
* amount.numerator.system = "http://unitsofmeasure.org"
* amount.numerator.code = #mg
* amount.denominator.value = 1
* amount.denominator.unit = "Tablet"
* amount.denominator.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* amount.denominator.code = #TAB
* ingredient[0].itemCodeableConcept.text = "Ibuprofen"
* ingredient[0].strength.numerator.value = 400
* ingredient[0].strength.numerator.unit = "mg"
* ingredient[0].strength.denominator.value = 1
* ingredient[0].strength.denominator.unit = "Tablet"

// -------------------- NgMedication 3: Vitamin B ---------------
Instance: NgMedication-VitaminB-001
InstanceOf: NgMedication
Usage: #inline
Title: "Vitamin B Complex Tablets"
* code.coding[0].system = "http://www.whocc.no/atc"
* code.coding[0].code = #A11EA
* code.coding[0].display = "Vitamin B-complex, plain"
* code.text = "Vitamin B Complex Tablets"
* status = #active
* form.coding.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* form.coding.code = #TAB
* form.coding.display = "Tablet"
* ingredient[0].itemCodeableConcept.text = "Thiamine (B1)"
* ingredient[0].strength.numerator.value = 10
* ingredient[0].strength.numerator.unit = "mg"
* ingredient[0].strength.denominator.value = 1
* ingredient[0].strength.denominator.unit = "Tablet"
* ingredient[+].itemCodeableConcept.text = "Riboflavin (B2)"
* ingredient[=].strength.numerator.value = 10
* ingredient[=].strength.numerator.unit = "mg"
* ingredient[=].strength.denominator.value = 1
* ingredient[=].strength.denominator.unit = "Tablet"
* ingredient[+].itemCodeableConcept.text = "Niacin (B3)"
* ingredient[=].strength.numerator.value = 50
* ingredient[=].strength.numerator.unit = "mg"
* ingredient[=].strength.denominator.value = 1
* ingredient[=].strength.denominator.unit = "Tablet"

// -------------------- MedicationRequest 1: Amoxicillin --------
Instance: NgMedicationRequest-Amoxicillin-001
InstanceOf: NgMedicationRequest
Usage: #inline
Title: "Prescription for Amoxicillin"
* status = #active
* intent = #order
* medicationReference = Reference(urn:uuid:ddd66655-e5f6-4789-a123-456789abcdef)
* subject = Reference(urn:uuid:aaa99988-e5f6-4789-a123-456789abcdef)
* authoredOn = "2025-10-28T08:15:00+01:00"
* requester = Reference(urn:uuid:bbb88877-e5f6-4789-a123-456789abcdef)
* dosageInstruction[0].text = "Take 1 capsule three times daily for 7 days"
* dosageInstruction[0].timing.repeat.frequency = 3
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].timing.repeat.duration = 7
* dosageInstruction[0].timing.repeat.durationUnit = #d
* dosageInstruction[0].route.coding.system = "http://snomed.info/sct"
* dosageInstruction[0].route.coding.code = #26643006
* dosageInstruction[0].route.coding.display = "Oral route"
* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 1
* dosageInstruction[0].doseAndRate[0].doseQuantity.unit = "Capsule"
* dosageInstruction[0].doseAndRate[0].doseQuantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dosageInstruction[0].doseAndRate[0].doseQuantity.code = #CAP
* dispenseRequest.numberOfRepeatsAllowed = 0
* dispenseRequest.quantity.value = 21
* dispenseRequest.quantity.unit = "Capsule"
* dispenseRequest.quantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dispenseRequest.quantity.code = #CAP
* dispenseRequest.expectedSupplyDuration.value = 7
* dispenseRequest.expectedSupplyDuration.unit = "days"
* dispenseRequest.expectedSupplyDuration.system = "http://unitsofmeasure.org"
* dispenseRequest.expectedSupplyDuration.code = #d

// -------------------- MedicationRequest 2: Ibuprofen ----------
Instance: NgMedicationRequest-Ibuprofen-001
InstanceOf: NgMedicationRequest
Usage: #inline
Title: "Prescription for Ibuprofen"
* status = #active
* intent = #order
* medicationReference = Reference(urn:uuid:eee55544-e5f6-4789-a123-456789abcdef)
* subject = Reference(urn:uuid:aaa99988-e5f6-4789-a123-456789abcdef)
* authoredOn = "2025-10-28T08:15:00+01:00"
* requester = Reference(urn:uuid:bbb88877-e5f6-4789-a123-456789abcdef)
* dosageInstruction[0].text = "Take 1 tablet every 6-8 hours as needed for pain, not to exceed 3 tablets per day"
* dosageInstruction[0].asNeededBoolean = true
* dosageInstruction[0].timing.repeat.frequency = 3
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].route.coding.system = "http://snomed.info/sct"
* dosageInstruction[0].route.coding.code = #26643006
* dosageInstruction[0].route.coding.display = "Oral route"
* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 1
* dosageInstruction[0].doseAndRate[0].doseQuantity.unit = "Tablet"
* dosageInstruction[0].doseAndRate[0].doseQuantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dosageInstruction[0].doseAndRate[0].doseQuantity.code = #TAB
* dosageInstruction[0].maxDosePerPeriod.numerator.value = 3
* dosageInstruction[0].maxDosePerPeriod.numerator.unit = "Tablet"
* dosageInstruction[0].maxDosePerPeriod.denominator.value = 1
* dosageInstruction[0].maxDosePerPeriod.denominator.unit = "day"
* dispenseRequest.numberOfRepeatsAllowed = 1
* dispenseRequest.quantity.value = 30
* dispenseRequest.quantity.unit = "Tablet"
* dispenseRequest.quantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dispenseRequest.quantity.code = #TAB
* dispenseRequest.expectedSupplyDuration.value = 10
* dispenseRequest.expectedSupplyDuration.unit = "days"
* dispenseRequest.expectedSupplyDuration.system = "http://unitsofmeasure.org"
* dispenseRequest.expectedSupplyDuration.code = #d

// -------------------- MedicationRequest 3: Vitamin B ----------
Instance: NgMedicationRequest-VitaminB-001
InstanceOf: NgMedicationRequest
Usage: #inline
Title: "Prescription for Vitamin B Complex"
* status = #active
* intent = #order
* medicationReference = Reference(urn:uuid:fff44433-e5f6-4789-a123-456789abcdef)
* subject = Reference(urn:uuid:aaa99988-e5f6-4789-a123-456789abcdef)
* authoredOn = "2025-10-28T08:15:00+01:00"
* requester = Reference(urn:uuid:bbb88877-e5f6-4789-a123-456789abcdef)
* dosageInstruction[0].text = "Take 1 tablet once daily with food for 30 days"
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
Title: "Prescription for Amoxicillin (Updated)"
* status = #completed
* intent = #order
* medicationReference = Reference(urn:uuid:ddd66655-e5f6-4789-a123-456789abcdef)
* subject = Reference(urn:uuid:aaa99988-e5f6-4789-a123-456789abcdef)
* authoredOn = "2025-10-28T08:15:00+01:00"
* requester = Reference(urn:uuid:bbb88877-e5f6-4789-a123-456789abcdef)
* dosageInstruction[0].text = "Take 1 capsule three times daily for 7 days"
* dosageInstruction[0].timing.repeat.frequency = 3
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].timing.repeat.duration = 7
* dosageInstruction[0].timing.repeat.durationUnit = #d
* dosageInstruction[0].route.coding.system = "http://snomed.info/sct"
* dosageInstruction[0].route.coding.code = #26643006
* dosageInstruction[0].route.coding.display = "Oral route"
* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 1
* dosageInstruction[0].doseAndRate[0].doseQuantity.unit = "Capsule"
* dosageInstruction[0].doseAndRate[0].doseQuantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dosageInstruction[0].doseAndRate[0].doseQuantity.code = #CAP
* dispenseRequest.numberOfRepeatsAllowed = 0
* dispenseRequest.quantity.value = 21
* dispenseRequest.quantity.unit = "Capsule"
* dispenseRequest.quantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dispenseRequest.quantity.code = #CAP
* dispenseRequest.expectedSupplyDuration.value = 7
* dispenseRequest.expectedSupplyDuration.unit = "days"
* dispenseRequest.expectedSupplyDuration.system = "http://unitsofmeasure.org"
* dispenseRequest.expectedSupplyDuration.code = #d

Instance: NgMedicationRequest-Ibuprofen-001-Updated
InstanceOf: NgMedicationRequest
Usage: #inline
Title: "Prescription for Ibuprofen (Updated)"
* status = #completed
* intent = #order
* medicationReference = Reference(urn:uuid:eee55544-e5f6-4789-a123-456789abcdef)
* subject = Reference(urn:uuid:aaa99988-e5f6-4789-a123-456789abcdef)
* authoredOn = "2025-10-28T08:15:00+01:00"
* requester = Reference(urn:uuid:bbb88877-e5f6-4789-a123-456789abcdef)
* dosageInstruction[0].text = "Take 1 tablet every 6-8 hours as needed for pain, not to exceed 3 tablets per day"
* dosageInstruction[0].asNeededBoolean = true
* dosageInstruction[0].timing.repeat.frequency = 3
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].route.coding.system = "http://snomed.info/sct"
* dosageInstruction[0].route.coding.code = #26643006
* dosageInstruction[0].route.coding.display = "Oral route"
* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 1
* dosageInstruction[0].doseAndRate[0].doseQuantity.unit = "Tablet"
* dosageInstruction[0].doseAndRate[0].doseQuantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dosageInstruction[0].doseAndRate[0].doseQuantity.code = #TAB
* dosageInstruction[0].maxDosePerPeriod.numerator.value = 3
* dosageInstruction[0].maxDosePerPeriod.numerator.unit = "Tablet"
* dosageInstruction[0].maxDosePerPeriod.denominator.value = 1
* dosageInstruction[0].maxDosePerPeriod.denominator.unit = "day"
* dispenseRequest.numberOfRepeatsAllowed = 1
* dispenseRequest.quantity.value = 30
* dispenseRequest.quantity.unit = "Tablet"
* dispenseRequest.quantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dispenseRequest.quantity.code = #TAB
* dispenseRequest.expectedSupplyDuration.value = 10
* dispenseRequest.expectedSupplyDuration.unit = "days"
* dispenseRequest.expectedSupplyDuration.system = "http://unitsofmeasure.org"
* dispenseRequest.expectedSupplyDuration.code = #d

Instance: NgMedicationRequest-VitaminB-001-Updated
InstanceOf: NgMedicationRequest
Usage: #inline
Title: "Prescription for Vitamin B Complex (Updated)"
* status = #completed
* intent = #order
* medicationReference = Reference(urn:uuid:fff44433-e5f6-4789-a123-456789abcdef)
* subject = Reference(urn:uuid:aaa99988-e5f6-4789-a123-456789abcdef)
* authoredOn = "2025-10-28T08:15:00+01:00"
* requester = Reference(urn:uuid:bbb88877-e5f6-4789-a123-456789abcdef)
* dosageInstruction[0].text = "Take 1 tablet once daily with food for 30 days"
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

// -------------------- MedicationDispense 1: Amoxicillin -------
Instance: NgMedicationDispense-Amoxicillin-001
InstanceOf: NgMedicationDispense
Usage: #inline
Title: "Dispensed - Amoxicillin"
* status = #completed
* medicationReference = Reference(urn:uuid:ddd66655-e5f6-4789-a123-456789abcdef)
* subject = Reference(urn:uuid:aaa99988-e5f6-4789-a123-456789abcdef)
* performer[0].actor = Reference(urn:uuid:aaa00011-e5f6-4789-a123-456789abcdef)
* authorizingPrescription[0] = Reference(urn:uuid:aaa33322-e5f6-4789-a123-456789abcdef)
* type.coding.system = "http://terminology.hl7.org/CodeSystem/v3-ActCode"
* type.coding.code = #FF
* type.coding.display = "First Fill"
* quantity.value = 21
* quantity.unit = "Capsule"
* quantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* quantity.code = #CAP
* daysSupply.value = 7
* daysSupply.unit = "days"
* daysSupply.system = "http://unitsofmeasure.org"
* daysSupply.code = #d
* whenPrepared = "2025-10-28T14:30:00+01:00"
* whenHandedOver = "2025-10-28T14:45:00+01:00"
* dosageInstruction[0].text = "Take 1 capsule three times daily for 7 days"
* dosageInstruction[0].timing.repeat.frequency = 3
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].route.coding.system = "http://snomed.info/sct"
* dosageInstruction[0].route.coding.code = #26643006
* dosageInstruction[0].route.coding.display = "Oral route"
* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 1
* dosageInstruction[0].doseAndRate[0].doseQuantity.unit = "Capsule"
* dosageInstruction[0].doseAndRate[0].doseQuantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dosageInstruction[0].doseAndRate[0].doseQuantity.code = #CAP

// -------------------- MedicationDispense 2: Ibuprofen ---------
Instance: NgMedicationDispense-Ibuprofen-001
InstanceOf: NgMedicationDispense
Usage: #inline
Title: "Dispensed - Ibuprofen"
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
* daysSupply.value = 10
* daysSupply.unit = "days"
* daysSupply.system = "http://unitsofmeasure.org"
* daysSupply.code = #d
* whenPrepared = "2025-10-28T14:35:00+01:00"
* whenHandedOver = "2025-10-28T14:45:00+01:00"
* dosageInstruction[0].text = "Take 1 tablet every 6-8 hours as needed for pain, not to exceed 3 tablets per day"
* dosageInstruction[0].asNeededBoolean = true
* dosageInstruction[0].timing.repeat.frequency = 3
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].route.coding.system = "http://snomed.info/sct"
* dosageInstruction[0].route.coding.code = #26643006
* dosageInstruction[0].route.coding.display = "Oral route"
* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 1
* dosageInstruction[0].doseAndRate[0].doseQuantity.unit = "Tablet"
* dosageInstruction[0].doseAndRate[0].doseQuantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dosageInstruction[0].doseAndRate[0].doseQuantity.code = #TAB
* dosageInstruction[0].maxDosePerPeriod.numerator.value = 3
* dosageInstruction[0].maxDosePerPeriod.numerator.unit = "Tablet"
* dosageInstruction[0].maxDosePerPeriod.denominator.value = 1
* dosageInstruction[0].maxDosePerPeriod.denominator.unit = "day"

// -------------------- MedicationDispense 3: Vitamin B ---------
Instance: NgMedicationDispense-VitaminB-001
InstanceOf: NgMedicationDispense
Usage: #inline
Title: "Dispensed - Vitamin B Complex"
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
* dosageInstruction[0].text = "Take 1 tablet once daily with food for 30 days"
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


