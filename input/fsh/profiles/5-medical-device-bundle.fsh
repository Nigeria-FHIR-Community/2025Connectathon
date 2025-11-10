// ======================================================================
// Profile: NgDeviceDataBundle
// ======================================================================
Profile: NgDeviceDataBundle
Parent: Bundle
Id: ng-device-data-bundle
Title: "5-NG Device Data Bundle (Chemistry Analyzer / Wearable)"
Description: """
Single Bundle profile supporting BOTH:
  • Chemistry analyzer result sharing (type = collection)
  • Wearable (e.g., Apple Watch) data upload via an app to a FHIR server (type = transaction)
Includes Patient, Device, optional Organization (source), and ≥1 Observation.
Kept minimal to reduce QA noise.
"""
* ^status = #active

// -------------------- Bundle core --------------------
* type 1..1 MS
* entry 1..* MS
* entry.fullUrl 1..1 MS
* entry.resource 1..1 MS
* entry.request 0..1
* entry.request.method 1..1
* entry.request.url 1..1

// -------------------- Slice entries by resource/profile --------------------
* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #open

* entry contains
    patient     1..1 MS and
    device      1..1 MS and
    sourceOrg   0..1 MS and
    observation 1..* MS and
    provenance  0..1 MS

* entry[patient].resource only NgPatient
* entry[device].resource only NgDevice
* entry[sourceOrg].resource only NgOrganization
* entry[observation].resource only NgObservation
* entry[provenance].resource only NgProvenance

* entry.fullUrl ^short = "Prefer URN UUID (urn:uuid:...) for intra-bundle references."

// -------------------- Helpful soft invariants (warnings) --------------------
Invariant: ngdev-type
Description: "Bundle.type SHOULD be either 'transaction' (wearable upload) or 'collection' (lab sharing)."
Severity: #warning
Expression: "type in ('transaction'|'collection')"

Invariant: ngdev-urn-uuids
Description: "Entries SHOULD use URN UUID fullUrls for local intra-bundle references."
Severity: #warning
Expression: "entry.fullUrl.all(matches('^urn:uuid:'))"

Invariant: ngdev-obs-links
Description: "Observation.subject SHOULD be local URN UUIDs within the same bundle."
Severity: #warning
Expression: "entry.resource.ofType(Observation).all(subject.reference.matches('^urn:uuid:'))"


// ======================================================================
// Example 1: Chemistry Analyzer — Result Sharing (collection)
// ======================================================================
Instance: NgDeviceData-ChemistryAnalyzer-Collection
InstanceOf: NgDeviceDataBundle
Usage: #example
Title: "Chemistry Analyzer Result Sharing (Collection)"
Description: "Lab shares a serum glucose result from a chemistry analyzer to an EHR/LIS."
* type = #collection

// Patient
* entry[0].fullUrl = "urn:uuid:aaabbb11-e5f6-4789-a123-456789abcdef"
* entry[0].resource = NgPatient-Chem-001

// Source Organization (Laboratory)
* entry[+].fullUrl = "urn:uuid:bbbccc22-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgOrganization-Lab-001

// Device (Chemistry Analyzer)
* entry[+].fullUrl = "urn:uuid:cccddd33-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgDevice-ChemAnalyzer-001

// Observation (Glucose)
* entry[+].fullUrl = "urn:uuid:dddeee44-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgObservation-Glucose-001


// ======================================================================
// Example 2: Apple Watch via App — Wearable Upload (transaction)
// ======================================================================
Instance: NgDeviceData-AppleWatch-Transaction
InstanceOf: NgDeviceDataBundle
Usage: #example
Title: "Apple Watch Data Upload (Transaction)"
Description: "Mobile app uploads wearable-derived observations (heart rate and daily steps) to a FHIR server."
* type = #transaction

// Patient
* entry[0].fullUrl = "urn:uuid:eeefff55-e5f6-4789-a123-456789abcdef"
* entry[0].resource = NgPatient-Watch-001
* entry[0].request.method = #POST
* entry[0].request.url = "Patient"

// Source Org (App vendor) - optional
* entry[+].fullUrl = "urn:uuid:fffaaa66-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgOrganization-AppVendor-001
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

// Device (Apple Watch)
* entry[+].fullUrl = "urn:uuid:aaabbb77-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgDevice-AppleWatch-001
* entry[=].request.method = #POST
* entry[=].request.url = "Device"

// Observation 1 — Heart rate (LOINC 8867-4)
* entry[+].fullUrl = "urn:uuid:bbbccc88-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgObservation-HeartRate-001
* entry[=].request.method = #POST
* entry[=].request.url = "Observation"

// Observation 2 — Step count (LOINC 41950-7 Steps in 24h)
* entry[+].fullUrl = "urn:uuid:cccddd99-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgObservation-Steps-001
* entry[=].request.method = #POST
* entry[=].request.url = "Observation"


// ===============================================================
// Inline Resources
// ===============================================================

// -------------------- NgPatient (Chemistry) --------------------
Instance: NgPatient-Chem-001
InstanceOf: NgPatient
Usage: #inline
Title: "Lab Patient (Chem)"
* meta.lastUpdated = "2025-11-06T08:30:00+01:00"
* identifier[PhoneNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].value = "08030001111"
* identifier[PhoneNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.code = #MOBILE
* identifier[PhoneNumber].type.coding.display = "mobile"
* name.given[0] = "Ada"
* name.family = "Eze"
* gender = #female
* birthDate = "1995-03-20"
* active = true
* address.line[0] = "15 Laboratory Street"
* address.city = "Lagos"
* address.district = #la-agege
* address.state = "LA"

// -------------------- NgOrganization (Laboratory) --------------
Instance: NgOrganization-Lab-001
InstanceOf: NgOrganization
Usage: #inline
Title: "Prime Diagnostic Laboratory"
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier.value = "LAB-00981"
* active = true
* name = "Prime Diagnostic Laboratory"
* type.coding.system = "http://terminology.hl7.org/CodeSystem/organization-type"
* type.coding.code = #prov
* type.coding.display = "Healthcare Provider"
* telecom[0].system = #phone
* telecom[0].value = "01-234-5678"
* address.line[0] = "45 Diagnostic Avenue"
* address.city = "Lagos"
* address.district = "la-agege"
* address.state = "LA"

// -------------------- NgDevice (Chemistry Analyzer) ------------
Instance: NgDevice-ChemAnalyzer-001
InstanceOf: NgDevice
Usage: #inline
Title: "ACME ChemAnalyzer XS-200"
* status = #active
* manufacturer = "ACME Diagnostics"
* deviceName[0].name = "ChemAnalyzer XS-200"
* deviceName[0].type = #model-name
* modelNumber = "XS-200"
* serialNumber = "SN-CHM-2025-001"
* type.coding.system = "http://snomed.info/sct"
* type.coding.code = #706689003
* type.coding.display = "Application programme software"

// -------------------- NgObservation (Glucose) ------------------
Instance: NgObservation-Glucose-001
InstanceOf: NgObservation
Usage: #inline
Title: "Serum Glucose"
* status = #final
* category[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/observation-category"
* category[0].coding[0].code = #social-history
* category[0].coding[0].display = "Social History"
* code.coding[0].system = "http://loinc.org"
* code.coding[0].code = #30525-0
* code.coding[0].display = "Age"
* subject = Reference(urn:uuid:aaabbb11-e5f6-4789-a123-456789abcdef)
* effectiveDateTime = "2025-11-06T08:45:00+01:00"
* device = Reference(urn:uuid:cccddd33-e5f6-4789-a123-456789abcdef)
* performer[0] = Reference(urn:uuid:bbbccc22-e5f6-4789-a123-456789abcdef)
* referenceRange[0].low.value = 70
* referenceRange[0].low.unit = "mg/dL"
* referenceRange[0].low.system = "http://unitsofmeasure.org"
* referenceRange[0].low.code = #mg/dL
* referenceRange[0].high.value = 100
* referenceRange[0].high.unit = "mg/dL"
* referenceRange[0].high.system = "http://unitsofmeasure.org"
* referenceRange[0].high.code = #mg/dL
* referenceRange[0].text = "Normal fasting glucose range"
* component[ageInMonths].valueQuantity.value = 104
* component[ageInMonths].valueQuantity.system = "http://unitsofmeasure.org"
//* component[ageInMonths].valueQuantity.code = #mo
* component[ageInMonths].valueQuantity.unit = "month"

// -------------------- NgPatient (Wearable) ---------------------
Instance: NgPatient-Watch-001
InstanceOf: NgPatient
Usage: #inline
Title: "Wearable Patient"
* meta.lastUpdated = "2025-11-06T07:00:00+01:00"
* identifier[PhoneNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].value = "08035556666"
* identifier[PhoneNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.code = #MOBILE
* identifier[PhoneNumber].type.coding.display = "mobile"
* name.given[0] = "Kunle"
* name.family = "Ojo"
* gender = #male
* birthDate = "1992-01-15"
* active = true
* address.line[0] = "88 Tech Boulevard"
* address.city = "Lagos"
* address.district = "la-ikeja"
* address.state = "LA"

// -------------------- NgOrganization (App Vendor) --------------
Instance: NgOrganization-AppVendor-001
InstanceOf: NgOrganization
Usage: #inline
Title: "Wellness App Ltd."
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-device-type-cs"
* identifier.value = "apple"
* active = true
* name = "Wellness App Ltd."
* type.coding.system = "http://terminology.hl7.org/CodeSystem/organization-type"
* type.coding.code = #bus
* type.coding.display = "Non-Healthcare Business or Corporation"
* telecom[0].system = #email
* telecom[0].value = "support@wellnessapp.ng"
* address.line[0] = "Tech Hub Building"
* address.city = "Lagos"
* address.district = #la-agege
* address.state = "LA"

// -------------------- NgDevice (Apple Watch) -------------------
Instance: NgDevice-AppleWatch-001
InstanceOf: NgDevice
Usage: #inline
Title: "Apple Watch Series 8"
* status = #active
* manufacturer = "Apple Inc."
* deviceName[0].name = "Apple Watch Series 8"
* deviceName[0].type = #user-friendly-name
* modelNumber = "Series 8"
* serialNumber = "AW8-2025-XYZ-001"
* type.coding.system = "http://snomed.info/sct"
* type.coding.code = #706635000
* type.coding.display = "Telephone transmitter/receiver system"
* version[0].value = "watchOS 10.1"

// -------------------- NgObservation (Heart Rate) ---------------
Instance: NgObservation-HeartRate-001
InstanceOf: NgObservation
Usage: #inline
Title: "Heart Rate (Apple Watch)"
* status = #final
* category[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/observation-category"
* category[0].coding[0].code = #social-history
* category[0].coding[0].display = "Social History"
* code.coding[0].system = "http://loinc.org"
* code.coding[0].code = #30525-0
* code.coding[0].display = "Age"
* subject = Reference(urn:uuid:eeefff55-e5f6-4789-a123-456789abcdef)
* effectiveDateTime = "2025-11-06T06:50:00+01:00"
* component[ageInMonths].valueQuantity.value = 444
* component[ageInMonths].valueQuantity.system = "http://unitsofmeasure.org"
* component[ageInMonths].valueQuantity.code = #mo
* component[ageInMonths].valueQuantity.unit = "month"
* device = Reference(urn:uuid:aaabbb77-e5f6-4789-a123-456789abcdef)
* performer[0] = Reference(urn:uuid:fffaaa66-e5f6-4789-a123-456789abcdef)
* note[0].text = "Resting heart rate recorded by wearable device"

// -------------------- NgObservation (Step Count) ---------------
Instance: NgObservation-Steps-001
InstanceOf: NgObservation
Usage: #inline
Title: "Daily Step Count (Apple Watch)"
* status = #final
* category[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/observation-category"
* category[0].coding[0].code = #social-history
* category[0].coding[0].display = "Social History"
* code.coding[0].system = "http://loinc.org"
* code.coding[0].code = #30525-0
* code.coding[0].display = "Age"
* subject = Reference(urn:uuid:eeefff55-e5f6-4789-a123-456789abcdef)
* effectivePeriod.start = "2025-11-05T00:00:00+01:00"
* effectivePeriod.end = "2025-11-05T23:59:59+01:00"
* component[ageInMonths].valueQuantity.value = 666
* component[ageInMonths].valueQuantity.system = "http://unitsofmeasure.org"
* component[ageInMonths].valueQuantity.code = #mo
* component[ageInMonths].valueQuantity.unit = "month"
* device = Reference(urn:uuid:aaabbb77-e5f6-4789-a123-456789abcdef)
* performer[0] = Reference(urn:uuid:fffaaa66-e5f6-4789-a123-456789abcdef)
* note[0].text = "Total daily step count tracked by wearable device"