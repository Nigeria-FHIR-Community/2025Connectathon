// ======================================================================
// Profile: NgMedicationDispenseBundle
// ======================================================================
Profile: NgMedicationDispenseBundle
Parent: Bundle
Id: ng-medication-dispense-bundle
Title: "2-NGePharmacy 2 Medication Dispense Bundle"
Description: """
Single Bundle profile that supports BOTH:
- Dispense Request (type=transaction): Pharmacy receives prescription and prepares 
  medications - includes Patient, MedicationRequest(s), Medication(s), and Pharmacy Org
- Dispense Response (type=collection): Pharmacy confirms dispensing - includes Patient (echo), 
  Pharmacy Org, Medication(s), MedicationDispense records with actual quantities dispensed, 
  and optional Payment/Invoice information
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
    pharmacyOrg 0..1 MS and
    medication 0..* MS and
    medicationRequest 0..* MS and
    medicationDispense 0..* MS and
    invoice 0..1 MS

* entry[patient].resource only NgPatient
* entry[practitioner].resource only NgPractitioner
* entry[pharmacyOrg].resource only NgPharmacyOrganization
* entry[medication].resource only NgMedication
* entry[medicationRequest].resource only NgMedicationRequest
* entry[medicationDispense].resource only NgMedicationDispense
* entry[invoice].resource only NgInvoice

* entry.fullUrl ^short = "Prefer URN UUID (urn:uuid:...) for intra-bundle references."

// Invariants
Invariant: ngdisp-transaction-shape
Description: "If Bundle.type = 'transaction', include ≥1 MedicationRequest and every entry has request.method & request.url."
Severity: #error
Expression: "(type = 'transaction') implies (entry.resource.ofType(MedicationRequest).count() >= 1 and entry.request.all(method.exists() and url.exists()))"

Invariant: ngdisp-collection-shape
Description: "If Bundle.type = 'collection', include ≥1 MedicationDispense."
Severity: #error
Expression: "(type = 'collection') implies (entry.resource.ofType(MedicationDispense).count() >= 1)"

Invariant: ngdisp-urn-uuids
Description: "Entries SHOULD use URN UUID fullUrls for local intra-bundle references."
Severity: #warning
Expression: "entry.fullUrl.all(matches('^urn:uuid:'))"


// ===============================================================
// REQUEST BUNDLE (transaction) - Dispense Request
// ===============================================================
Instance: MedicationDispense-Request
InstanceOf: NgMedicationDispenseBundle
Usage: #example
Title: "Medication Dispense - Request (Transaction)"
Description: "Patient presents prescription at pharmacy for dispensing."
* type = #transaction

// Patient
* entry[0].fullUrl = "urn:uuid:bbb11122-f6e5-4789-b234-567890bcdef1"
* entry[0].resource = NgPatient-Disp-001
* entry[0].request.method = #POST
* entry[0].request.url = "Patient"

// Prescribing Practitioner (for reference)
* entry[+].fullUrl = "urn:uuid:ccc22233-f6e5-4789-b234-567890bcdef1"
* entry[=].resource = NgPractitioner-Disp-001
* entry[=].request.method = #POST
* entry[=].request.url = "Practitioner"

// Pharmacy Organization
* entry[+].fullUrl = "urn:uuid:ddd33344-f6e5-4789-b234-567890bcdef1"
* entry[=].resource = NgOrganization-Pharmacy-Disp-001
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

// Medication 1: Metformin
* entry[+].fullUrl = "urn:uuid:eee44455-f6e5-4789-b234-567890bcdef1"
* entry[=].resource = NgMedication-Metformin-001
* entry[=].request.method = #POST
* entry[=].request.url = "Medication"

// Medication 2: Atorvastatin
* entry[+].fullUrl = "urn:uuid:fff55566-f6e5-4789-b234-567890bcdef1"
* entry[=].resource = NgMedication-Atorvastatin-001
* entry[=].request.method = #POST
* entry[=].request.url = "Medication"

// Medication 3: Amlodipine
* entry[+].fullUrl = "urn:uuid:aaa66677-f6e5-4789-b234-567890bcdef1"
* entry[=].resource = NgMedication-Amlodipine-001
* entry[=].request.method = #POST
* entry[=].request.url = "Medication"

// MedicationRequest 1: Metformin
* entry[+].fullUrl = "urn:uuid:bbb77788-f6e5-4789-b234-567890bcdef1"
* entry[=].resource = NgMedicationRequest-Metformin-001
* entry[=].request.method = #POST
* entry[=].request.url = "MedicationRequest"

// MedicationRequest 2: Atorvastatin
* entry[+].fullUrl = "urn:uuid:ccc88899-f6e5-4789-b234-567890bcdef1"
* entry[=].resource = NgMedicationRequest-Atorvastatin-001
* entry[=].request.method = #POST
* entry[=].request.url = "MedicationRequest"

// MedicationRequest 3: Amlodipine
* entry[+].fullUrl = "urn:uuid:ddd99900-f6e5-4789-b234-567890bcdef1"
* entry[=].resource = NgMedicationRequest-Amlodipine-001
* entry[=].request.method = #POST
* entry[=].request.url = "MedicationRequest"


// ===============================================================
// RESPONSE BUNDLE (collection) - Dispense Confirmation
// ===============================================================
Instance: MedicationDispense-Response
InstanceOf: NgMedicationDispenseBundle
Usage: #example
Title: "Medication Dispense - Response (Collection)"
Description: "Pharmacy confirms medication dispensing with actual quantities and payment details."
* type = #collection

// Patient (echo)
* entry[0].fullUrl = "urn:uuid:bbb11122-f6e5-4789-b234-567890bcdef1"
* entry[0].resource = NgPatient-Disp-001

// Pharmacy Organization (echo)
* entry[+].fullUrl = "urn:uuid:ddd33341-f6e5-4789-b234-567890bcdef1"
* entry[=].resource = NgOrganization-Pharmacy-Disp-001

// Medication 1: Metformin (echo)
* entry[+].fullUrl = "urn:uuid:eee44455-f6e5-4789-b234-567890bcdef1"
* entry[=].resource = NgMedication-Metformin-001

// Medication 2: Atorvastatin (echo)
* entry[+].fullUrl = "urn:uuid:fff55566-f6e5-4789-b234-567890bcdef1"
* entry[=].resource = NgMedication-Atorvastatin-001

// Medication 3: Amlodipine (echo)
* entry[+].fullUrl = "urn:uuid:aaa66677-f6e5-4789-b234-567890bcdef1"
* entry[=].resource = NgMedication-Amlodipine-001

// MedicationDispense 1: Metformin
* entry[+].fullUrl = "urn:uuid:eee00011-f6e5-4789-b234-567890bcdef1"
* entry[=].resource = NgMedicationDispense-Metformin-001

// MedicationDispense 2: Atorvastatin
* entry[+].fullUrl = "urn:uuid:fff11122-f6e5-4789-b234-567890bcdef1"
* entry[=].resource = NgMedicationDispense-Atorvastatin-001

// MedicationDispense 3: Amlodipine
* entry[+].fullUrl = "urn:uuid:aaa22233-f6e5-4789-b234-567890bcdef1"
* entry[=].resource = NgMedicationDispense-Amlodipine-001

// Invoice for medications
* entry[+].fullUrl = "urn:uuid:bbb33344-f6e5-4789-b234-567890bcdef1"
* entry[=].resource = NgInvoice-Disp-001


// ===============================================================
// Inline Resources
// ===============================================================

// -------------------- NgPatient --------------------------------
Instance: NgPatient-Disp-001
InstanceOf: NgPatient
Usage: #inline
Title: "Dispense Patient - Ibrahim Musa"
* meta.lastUpdated = "2025-10-29T09:00:00+01:00"
* identifier[PhoneNumber].value = "08067890123"
* identifier[PhoneNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.code = #MOBILE
* identifier[PhoneNumber].type.coding.display = "mobile"
* name.given[0] = "Ibrahim"
* name.family = "Musa"
* gender = #male
* birthDate = "1968-08-25"
* active = true
* address.line[0] = "45 Wellness Street"
* address.city = "Kano"
* address.district = "kn-kano-municipal"
* address.state = "KN"

// -------------------- NgPractitioner ---------------------------
Instance: NgPractitioner-Disp-001
InstanceOf: NgPractitioner
Usage: #inline
Title: "Prescribing Physician - Dr. Fatima Yusuf"
* identifier[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-mdcn"
* identifier[0].value = "MDCN-54321"
* active = true
* name.given = "Fatima"
* name.family = "Yusuf"
* telecom[0].system = #phone
* telecom[0].value = "08076665555"
* birthDate = "1975-04-10"

// -------------------- NgOrganization (Pharmacy) ----------------
Instance: NgOrganization-Pharmacy-Disp-001
InstanceOf: NgPharmacyOrganization
Usage: #inline
Title: "Medix Pharmacy Limited"
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier.value = "PHARM-KN-7788"
* active = true
* name = "Medix Pharmacy Limited"
* type.coding.system = "http://terminology.hl7.org/CodeSystem/organization-type"
* type.coding.code = #cg
* type.coding.display = "Community Group"
* telecom[0].system = #phone
* telecom[0].value = "064-123-4567"
* telecom[+].system = #email
* telecom[=].value = "info@medixpharmacy.ng"
* address.line[0] = "12 Pharmacy Avenue"
* address.city = "Kano"
* address.district = "kn-kano-municipal"
* address.state = "KN"

// -------------------- NgMedication 1: Metformin ---------------
Instance: NgMedication-Metformin-001
InstanceOf: NgMedication
Usage: #inline
Title: "Metformin 500mg Tablets"
* code.coding[0].system = "http://www.whocc.no/atc"
* code.coding[0].code = #A10BA02
* code.coding[0].display = "Metformin"
* code.text = "Metformin 500mg Tablets"
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
* batch.lotNumber = "MET2025-10-A"
* batch.expirationDate = "2026-10-31"

// -------------------- NgMedication 2: Atorvastatin ------------
Instance: NgMedication-Atorvastatin-001
InstanceOf: NgMedication
Usage: #inline
Title: "Atorvastatin 20mg Tablets"
* code.coding[0].system = "http://www.whocc.no/atc"
* code.coding[0].code = #C10AA05
* code.coding[0].display = "Atorvastatin"
* code.text = "Atorvastatin 20mg Tablets"
* status = #active
* manufacturer.display = "Emzor Pharmaceutical Industries"
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
* ingredient[0].itemCodeableConcept.text = "Atorvastatin calcium"
* ingredient[0].strength.numerator.value = 20
* ingredient[0].strength.numerator.unit = "mg"
* ingredient[0].strength.denominator.value = 1
* ingredient[0].strength.denominator.unit = "Tablet"
* batch.lotNumber = "ATOR2025-09-B"
* batch.expirationDate = "2027-09-30"

// -------------------- NgMedication 3: Amlodipine --------------
Instance: NgMedication-Amlodipine-001
InstanceOf: NgMedication
Usage: #inline
Title: "Amlodipine 5mg Tablets"
* code.coding[0].system = "http://www.whocc.no/atc"
* code.coding[0].code = #C08CA01
* code.coding[0].display = "Amlodipine"
* code.text = "Amlodipine 5mg Tablets"
* status = #active
* manufacturer.display = "May & Baker Nigeria Plc"
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
* ingredient[0].itemCodeableConcept.text = "Amlodipine besylate"
* ingredient[0].strength.numerator.value = 5
* ingredient[0].strength.numerator.unit = "mg"
* ingredient[0].strength.denominator.value = 1
* ingredient[0].strength.denominator.unit = "Tablet"
* batch.lotNumber = "AML2025-08-C"
* batch.expirationDate = "2027-08-31"

// -------------------- MedicationRequest 1: Metformin ----------
Instance: NgMedicationRequest-Metformin-001
InstanceOf: NgMedicationRequest
Usage: #inline
Title: "Prescription for Metformin"
* status = #active
* intent = #order
* medicationReference = Reference(urn:uuid:eee44455-f6e5-4789-b234-567890bcdef1)
* subject = Reference(urn:uuid:bbb11122-f6e5-4789-b234-567890bcdef1)
* authoredOn = "2025-10-29T08:00:00+01:00"
* requester = Reference(urn:uuid:ccc22233-f6e5-4789-b234-567890bcdef1)
* reasonCode[0].text = "Type 2 Diabetes Mellitus"
* dosageInstruction[0].text = "Take 1 tablet twice daily with meals for 90 days"
* dosageInstruction[0].timing.repeat.frequency = 2
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].timing.repeat.duration = 90
* dosageInstruction[0].timing.repeat.durationUnit = #d
* dosageInstruction[0].timing.repeat.when[0] = #C
* dosageInstruction[0].route.coding.system = "http://snomed.info/sct"
* dosageInstruction[0].route.coding.code = #26643006
* dosageInstruction[0].route.coding.display = "Oral route"
* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 1
* dosageInstruction[0].doseAndRate[0].doseQuantity.unit = "Tablet"
* dosageInstruction[0].doseAndRate[0].doseQuantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dosageInstruction[0].doseAndRate[0].doseQuantity.code = #TAB
* dispenseRequest.numberOfRepeatsAllowed = 3
* dispenseRequest.quantity.value = 180
* dispenseRequest.quantity.unit = "Tablet"
* dispenseRequest.quantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dispenseRequest.quantity.code = #TAB
* dispenseRequest.expectedSupplyDuration.value = 90
* dispenseRequest.expectedSupplyDuration.unit = "days"
* dispenseRequest.expectedSupplyDuration.system = "http://unitsofmeasure.org"
* dispenseRequest.expectedSupplyDuration.code = #d
* dispenseRequest.validityPeriod.start = "2025-10-29"
* dispenseRequest.validityPeriod.end = "2026-01-29"

// -------------------- MedicationRequest 2: Atorvastatin -------
Instance: NgMedicationRequest-Atorvastatin-001
InstanceOf: NgMedicationRequest
Usage: #inline
Title: "Prescription for Atorvastatin"
* status = #active
* intent = #order
* medicationReference = Reference(urn:uuid:fff55566-f6e5-4789-b234-567890bcdef1)
* subject = Reference(urn:uuid:bbb11122-f6e5-4789-b234-567890bcdef1)
* authoredOn = "2025-10-29T08:00:00+01:00"
* requester = Reference(urn:uuid:ccc22233-f6e5-4789-b234-567890bcdef1)
* reasonCode[0].text = "Hyperlipidemia"
* dosageInstruction[0].text = "Take 1 tablet once daily at bedtime for 90 days"
* dosageInstruction[0].timing.repeat.frequency = 1
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].timing.repeat.duration = 90
* dosageInstruction[0].timing.repeat.durationUnit = #d
* dosageInstruction[0].timing.repeat.when[0] = #HS
* dosageInstruction[0].route.coding.system = "http://snomed.info/sct"
* dosageInstruction[0].route.coding.code = #26643006
* dosageInstruction[0].route.coding.display = "Oral route"
* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 1
* dosageInstruction[0].doseAndRate[0].doseQuantity.unit = "Tablet"
* dosageInstruction[0].doseAndRate[0].doseQuantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dosageInstruction[0].doseAndRate[0].doseQuantity.code = #TAB
* dispenseRequest.numberOfRepeatsAllowed = 3
* dispenseRequest.quantity.value = 90
* dispenseRequest.quantity.unit = "Tablet"
* dispenseRequest.quantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dispenseRequest.quantity.code = #TAB
* dispenseRequest.expectedSupplyDuration.value = 90
* dispenseRequest.expectedSupplyDuration.unit = "days"
* dispenseRequest.expectedSupplyDuration.system = "http://unitsofmeasure.org"
* dispenseRequest.expectedSupplyDuration.code = #d
* dispenseRequest.validityPeriod.start = "2025-10-29"
* dispenseRequest.validityPeriod.end = "2026-01-29"

// -------------------- MedicationRequest 3: Amlodipine ---------
Instance: NgMedicationRequest-Amlodipine-001
InstanceOf: NgMedicationRequest
Usage: #inline
Title: "Prescription for Amlodipine"
* status = #active
* intent = #order
* medicationReference = Reference(urn:uuid:aaa66677-f6e5-4789-b234-567890bcdef1)
* subject = Reference(urn:uuid:bbb11122-f6e5-4789-b234-567890bcdef1)
* authoredOn = "2025-10-29T08:00:00+01:00"
* requester = Reference(urn:uuid:ccc22233-f6e5-4789-b234-567890bcdef1)
* reasonCode[0].text = "Hypertension"
* dosageInstruction[0].text = "Take 1 tablet once daily in the morning for 90 days"
* dosageInstruction[0].timing.repeat.frequency = 1
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].timing.repeat.duration = 90
* dosageInstruction[0].timing.repeat.durationUnit = #d
* dosageInstruction[0].timing.repeat.when[0] = #MORN
* dosageInstruction[0].route.coding.system = "http://snomed.info/sct"
* dosageInstruction[0].route.coding.code = #26643006
* dosageInstruction[0].route.coding.display = "Oral route"
* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 1
* dosageInstruction[0].doseAndRate[0].doseQuantity.unit = "Tablet"
* dosageInstruction[0].doseAndRate[0].doseQuantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dosageInstruction[0].doseAndRate[0].doseQuantity.code = #TAB
* dispenseRequest.numberOfRepeatsAllowed = 3
* dispenseRequest.quantity.value = 90
* dispenseRequest.quantity.unit = "Tablet"
* dispenseRequest.quantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* dispenseRequest.quantity.code = #TAB
* dispenseRequest.expectedSupplyDuration.value = 90
* dispenseRequest.expectedSupplyDuration.unit = "days"
* dispenseRequest.expectedSupplyDuration.system = "http://unitsofmeasure.org"
* dispenseRequest.expectedSupplyDuration.code = #d
* dispenseRequest.validityPeriod.start = "2025-10-29"
* dispenseRequest.validityPeriod.end = "2026-01-29"

// -------------------- MedicationDispense 1: Metformin ---------
Instance: NgMedicationDispense-Metformin-001
InstanceOf: NgMedicationDispense
Usage: #inline
Title: "Dispensed - Metformin 90-day supply"
* status = #completed
* medicationReference = Reference(urn:uuid:eee44455-f6e5-4789-b234-567890bcdef1)
* subject = Reference(urn:uuid:bbb11122-f6e5-4789-b234-567890bcdef1)
* performer[0].actor = Reference(urn:uuid:ccc22233-f6e5-4789-b234-567890bcdef1)
* performer[0].function.coding.system = "http://terminology.hl7.org/CodeSystem/medicationdispense-performer-function"
* performer[0].function.coding.code = #finalchecker
* performer[0].function.coding.display = "Final Checker"
* authorizingPrescription[0] = Reference(urn:uuid:bbb77788-f6e5-4789-b234-567890bcdef1)
* type.coding.system = "http://terminology.hl7.org/CodeSystem/v3-ActCode"
* type.coding.code = #FF
* type.coding.display = "First Fill"
* quantity.value = 180
* quantity.unit = "Tablet"
* quantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* quantity.code = #TAB
* daysSupply.value = 90
* daysSupply.unit = "days"
* daysSupply.system = "http://unitsofmeasure.org"
* daysSupply.code = #d
* whenPrepared = "2025-10-29T11:00:00+01:00"
* whenHandedOver = "2025-10-29T11:30:00+01:00"
* destination.display = "Patient Home Address"
* receiver[0] = Reference(urn:uuid:bbb11122-f6e5-4789-b234-567890bcdef1)
* note[0].text = "Counseled patient on taking with meals to reduce GI upset. Advised to monitor blood glucose levels regularly."
* dosageInstruction[0].text = "Take 1 tablet twice daily with meals for 90 days"
* dosageInstruction[0].timing.repeat.frequency = 2
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].timing.repeat.when[0] = #C
* dosageInstruction[0].route.coding.system = "http://snomed.info/sct"
* dosageInstruction[0].route.coding.code = #26643006
* dosageInstruction[0].route.coding.display = "Oral route"
* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 1
* dosageInstruction[0].doseAndRate[0].doseQuantity.unit = "Tablet"
* substitution.wasSubstituted = false
* substitution.type.coding.system = "http://terminology.hl7.org/CodeSystem/v3-substanceAdminSubstitution"
* substitution.type.coding.code = #N
* substitution.type.coding.display = "none"

// -------------------- MedicationDispense 2: Atorvastatin ------
Instance: NgMedicationDispense-Atorvastatin-001
InstanceOf: NgMedicationDispense
Usage: #inline
Title: "Dispensed - Atorvastatin 90-day supply"
* status = #completed
* medicationReference = Reference(urn:uuid:fff55566-f6e5-4789-b234-567890bcdef1)
* subject = Reference(urn:uuid:bbb11122-f6e5-4789-b234-567890bcdef1)
* performer[0].actor = Reference(urn:uuid:ccc22233-f6e5-4789-b234-567890bcdef1)
* performer[0].function.coding.system = "http://terminology.hl7.org/CodeSystem/medicationdispense-performer-function"
* performer[0].function.coding.code = #finalchecker
* performer[0].function.coding.display = "Final Checker"
* authorizingPrescription[0] = Reference(urn:uuid:ccc88899-f6e5-4789-b234-567890bcdef1)
* type.coding.system = "http://terminology.hl7.org/CodeSystem/v3-ActCode"
* type.coding.code = #FF
* type.coding.display = "First Fill"
* quantity.value = 90
* quantity.unit = "Tablet"
* quantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* quantity.code = #TAB
* daysSupply.value = 90
* daysSupply.unit = "days"
* daysSupply.system = "http://unitsofmeasure.org"
* daysSupply.code = #d
* whenPrepared = "2025-10-29T11:05:00+01:00"
* whenHandedOver = "2025-10-29T11:30:00+01:00"
* destination.display = "Patient Home Address"
* receiver[0] = Reference(urn:uuid:bbb11122-f6e5-4789-b234-567890bcdef1)
* note[0].text = "Counseled patient on taking at bedtime. Advised to report any muscle pain or weakness immediately. Avoid grapefruit juice."
* dosageInstruction[0].text = "Take 1 tablet once daily at bedtime for 90 days"
* dosageInstruction[0].timing.repeat.frequency = 1
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].timing.repeat.when[0] = #HS
* dosageInstruction[0].route.coding.system = "http://snomed.info/sct"
* dosageInstruction[0].route.coding.code = #26643006
* dosageInstruction[0].route.coding.display = "Oral route"
* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 1
* dosageInstruction[0].doseAndRate[0].doseQuantity.unit = "Tablet"
* substitution.wasSubstituted = false
* substitution.type.coding.system = "http://terminology.hl7.org/CodeSystem/v3-substanceAdminSubstitution"
* substitution.type.coding.code = #N
* substitution.type.coding.display = "none"

// -------------------- MedicationDispense 3: Amlodipine --------
Instance: NgMedicationDispense-Amlodipine-001
InstanceOf: NgMedicationDispense
Usage: #inline
Title: "Dispensed - Amlodipine 90-day supply"
* status = #completed
* medicationReference = Reference(urn:uuid:aaa66677-f6e5-4789-b234-567890bcdef1)
* subject = Reference(urn:uuid:bbb11122-f6e5-4789-b234-567890bcdef1)
* performer[0].actor = Reference(urn:uuid:ddd33344-f6e5-4789-b234-567890bcdef1)
* performer[0].function.coding.system = "http://terminology.hl7.org/CodeSystem/medicationdispense-performer-function"
* performer[0].function.coding.code = #finalchecker
* performer[0].function.coding.display = "Final Checker"
* authorizingPrescription[0] = Reference(urn:uuid:ddd99900-f6e5-4789-b234-567890bcdef1)
* type.coding.system = "http://terminology.hl7.org/CodeSystem/v3-ActCode"
* type.coding.code = #FF
* type.coding.display = "First Fill"
* quantity.value = 90
* quantity.unit = "Tablet"
* quantity.system = "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm"
* quantity.code = #TAB
* daysSupply.value = 90
* daysSupply.unit = "days"
* daysSupply.system = "http://unitsofmeasure.org"
* daysSupply.code = #d
* whenPrepared = "2025-10-29T11:10:00+01:00"
* whenHandedOver = "2025-10-29T11:30:00+01:00"
* destination.display = "Patient Home Address"
* receiver[0] = Reference(urn:uuid:bbb11122-f6e5-4789-b234-567890bcdef1)
* note[0].text = "Counseled patient on taking in the morning. Advised to monitor blood pressure regularly. May cause ankle swelling; report if severe."
* dosageInstruction[0].text = "Take 1 tablet once daily in the morning for 90 days"
* dosageInstruction[0].timing.repeat.frequency = 1
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].timing.repeat.when[0] = #MORN
* dosageInstruction[0].route.coding.system = "http://snomed.info/sct"
* dosageInstruction[0].route.coding.code = #26643006
* dosageInstruction[0].route.coding.display = "Oral route"
* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 1
* dosageInstruction[0].doseAndRate[0].doseQuantity.unit = "Tablet"
* substitution.wasSubstituted = false
* substitution.type.coding.system = "http://terminology.hl7.org/CodeSystem/v3-substanceAdminSubstitution"
* substitution.type.coding.code = #N
* substitution.type.coding.display = "none"

// -------------------- NgInvoice (Payment Details) --------------
Instance: NgInvoice-Disp-001
InstanceOf: NgInvoice
Usage: #inline
Title: "Pharmacy Invoice - Chronic Disease Medications"
* status = #balanced
* type.coding.system = "http://terminology.hl7.org/CodeSystem/v3-ActCode"
* type.coding.code = #RXCINV
* type.coding.display = "Rx compound invoice"
* subject = Reference(urn:uuid:bbb11122-f6e5-4789-b234-567890bcdef1)
* participant[0].role.coding.system = "http://terminology.hl7.org/CodeSystem/v3-ParticipationType"
* participant[0].role.coding.code = #PRF
* participant[0].role.coding.display = "performer"
* participant[0].actor = Reference(urn:uuid:ccc22233-f6e5-4789-b234-567890bcdef1)
* issuer = Reference(urn:uuid:ddd33341-f6e5-4789-b234-567890bcdef1)
* date = "2025-10-29"

// Line item 1: Metformin
* lineItem[0].sequence = 1
* lineItem[0].chargeItemCodeableConcept.coding[0].system = "http://www.whocc.no/atc"
* lineItem[0].chargeItemCodeableConcept.coding[0].code = #A10BA02
* lineItem[0].chargeItemCodeableConcept.coding[0].display = "Metformin"
* lineItem[0].chargeItemCodeableConcept.text = "Metformin 500mg x 180 tablets"
* lineItem[0].priceComponent[0].type = #base
* lineItem[0].priceComponent[0].code.text = "Metformin 500mg x 180 tablets"
* lineItem[0].priceComponent[0].factor = 180
* lineItem[0].priceComponent[0].amount.value = 35
* lineItem[0].priceComponent[0].amount.currency = #NGN

// Line item 2: Atorvastatin
* lineItem[1].sequence = 2
* lineItem[1].priceComponent[0].type = #base
* lineItem[1].priceComponent[0].code.text = "Atorvastatin 20mg x 90 tablets"
* lineItem[1].priceComponent[0].factor = 90
* lineItem[1].priceComponent[0].amount.value = 85
* lineItem[1].priceComponent[0].amount.currency = #NGN
* lineItem[1].chargeItemCodeableConcept.coding[0].system = "http://www.whocc.no/atc"
* lineItem[1].chargeItemCodeableConcept.coding[0].code = #C10AA05
* lineItem[1].chargeItemCodeableConcept.coding[0].display = "Atorvastatin"
* lineItem[1].chargeItemCodeableConcept.text = "Atorvastatin 20mg x 90 tablets"

// Line item 3: Amlodipine
* lineItem[2].sequence = 3
* lineItem[2].priceComponent[0].type = #base
* lineItem[2].priceComponent[0].code.text = "Amlodipine 5mg x 90 tablets"
* lineItem[2].priceComponent[0].factor = 90
* lineItem[2].priceComponent[0].amount.value = 45
* lineItem[2].priceComponent[0].amount.currency = #NGN
* lineItem[2].chargeItemCodeableConcept.coding[0].system = "http://www.whocc.no/atc"
* lineItem[2].chargeItemCodeableConcept.coding[0].code = #C08CA01
* lineItem[2].chargeItemCodeableConcept.coding[0].display = "Amlodipine"
* lineItem[2].chargeItemCodeableConcept.text = "Amlodipine 5mg x 90 tablets"


// Line item 4: Dispensing fee
* lineItem[3].sequence = 4
* lineItem[3].priceComponent[0].type = #base
* lineItem[3].priceComponent[0].code.text = "Professional dispensing fee"
* lineItem[3].priceComponent[0].factor = 1
* lineItem[3].priceComponent[0].amount.value = 500
* lineItem[3].priceComponent[0].amount.currency = #NGN
* lineItem[3].chargeItemCodeableConcept.coding[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/pharmacy-charge-items"
* lineItem[3].chargeItemCodeableConcept.coding[0].code = #DISPENSE-FEE
* lineItem[3].chargeItemCodeableConcept.coding[0].display = "Professional dispensing fee"
* lineItem[3].chargeItemCodeableConcept.text = "Professional dispensing fee"


// Subtotal
* totalPriceComponent[0].type = #base
* totalPriceComponent[0].code.text = "Subtotal"
* totalPriceComponent[0].amount.value = 14800
* totalPriceComponent[0].amount.currency = #NGN

// VAT (7.5%)
* totalPriceComponent[+].type = #tax
* totalPriceComponent[=].code.text = "VAT (7.5%)"
* totalPriceComponent[=].amount.value = 1110
* totalPriceComponent[=].amount.currency = #NGN

// Total
* totalGross.value = 15910
* totalGross.currency = #NGN

* totalNet.value = 15910
* totalNet.currency = #NGN

* paymentTerms = "Payment due at time of dispensing. HMO/Insurance coverage subject to verification."
* note[0].text = "Insurance claim submitted to HMO for reimbursement. Patient co-pay: ₦2,500. HMO covered: ₦13,410."
