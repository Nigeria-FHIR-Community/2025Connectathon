// ======================================================================
// Profile: NgAefiReportBundle
// ======================================================================
Profile: NgAefiReportBundle
Parent: Bundle
Id: ng-aefi-report-bundle
Title: "4-NG AEFI Report Bundle"
Description: "Minimal transaction bundle to report an AEFI with Patient, Immunization, AdverseEvent, and supporting data."

* ^status = #active

// Bundle basics
* type 1..1 MS
* type = #transaction (exactly)
* entry 2..* MS
* entry.fullUrl 1..1 MS
* entry.resource 1..1 MS
* entry.request 1..1 MS
* entry.request.method 1..1
* entry.request.url 1..1

// Slice entries by resource/profile
* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #open

// Named slices
* entry contains
    patient 1..1 MS and
    organization 1..1 MS and
    practitioner 0..1 MS and
    location 0..1 MS and
    encounter 0..1 MS and
    immunization 1..1 MS and
    observation 0..* MS

// Resource restrictions
* entry[patient].resource only NgPatient
* entry[organization].resource only NgOrganization
* entry[practitioner].resource only NgPractitioner
* entry[location].resource only NgLocation
* entry[encounter].resource only NgEncounter
* entry[immunization].resource only NgImmunization
* entry[observation].resource only NgObservation

// Hints
* entry.fullUrl ^short = "Use URN UUIDs (urn:uuid:...) for local references where possible."
* entry[patient].request.url ^short = "Patient"
* entry[organization].request.url ^short = "Organization"
* entry[practitioner].request.url ^short = "Practitioner"
* entry[location].request.url ^short = "Location"
* entry[encounter].request.url ^short = "Encounter"
* entry[immunization].request.url ^short = "Immunization"
* entry[observation].request.url ^short = "Observation"

// Soft guidance (warnings) to keep QA low
Invariant: ngaefi-urns
Description: "Entries SHOULD use URN UUID fullUrls for intra-bundle references."
Severity: #warning
Expression: "entry.fullUrl.all(matches('^urn:uuid:'))"

Invariant: ngaefi-linking
Description: "AdverseEvent.subject SHOULD reference the in-bundle Patient and suspectEntity.instance SHOULD reference the in-bundle Immunization."
Severity: #warning
Expression: "entry.resource.ofType(AdverseEvent).subject.reference.all(matches('^urn:uuid:')) and entry.resource.ofType(AdverseEvent).suspectEntity.instance.reference.all(matches('^urn:uuid:'))"




// ======================================================================
// Example: AEFI Report — Post-Immunization Fever & Injection-site Swelling
// ======================================================================
Instance: NgAefiReport-001
InstanceOf: NgAefiReportBundle
Usage: #example
Title: "AEFI Report – Fever and Local Swelling after Penta1"
Description: "Hospital reports an AEFI for a child following Penta1 administration."

* type = #transaction

// ---------------- Patient -------------------------------------- 
* entry[0].fullUrl = "urn:uuid:1212aabb-e5f6-4789-a123-456789abcdef"
* entry[0].resource = NgPatient-AEFI-001
* entry[0].request.method = #POST
* entry[0].request.url = "Patient"

// ---------------- Organization (reporting facility) ------------
* entry[+].fullUrl = "urn:uuid:1a12aabb-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgOrganization-AEFI-001
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

// ---------------- Practitioner (recorder) ----------------------
* entry[+].fullUrl = "urn:uuid:1b12aabb-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgPractitioner-AEFI-001
* entry[=].request.method = #POST
* entry[=].request.url = "Practitioner"

// ---------------- Location (optional clinic room) --------------
* entry[+].fullUrl = "urn:uuid:12c2aabb-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgLocation-AEFI-001
* entry[=].request.method = #POST
* entry[=].request.url = "Location"

// ---------------- Encounter (optional) -------------------------
* entry[+].fullUrl = "urn:uuid:121daabb-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgEncounter-AEFI-001
* entry[=].request.method = #POST
* entry[=].request.url = "Encounter"

// ---------------- Immunization (index vaccination) -------------
* entry[+].fullUrl = "urn:uuid:121faabb-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgImmunization-AEFI-001
* entry[=].request.method = #POST
* entry[=].request.url = "Immunization"

// ---------------- Observation (fever) --------------------------
* entry[+].fullUrl = "urn:uuid:12ffaabb-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgObservation-001
* entry[=].request.method = #POST
* entry[=].request.url = "Observation"



// ======================================================================
// Inline resources (kept minimal, aligned with prior Ng* profiles)
// ======================================================================

// Patient (NgPatient requires meta.lastUpdated)
Instance: NgPatient-AEFI-001
InstanceOf: NgPatient
Usage: #inline
Title: "Infant – Aisha Musa"
* meta.lastUpdated = "2025-11-06T08:30:00+01:00"
* identifier[PhoneNumber].value = "08030001111"
* identifier[PhoneNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.code = #MOBILE
* identifier[PhoneNumber].type.coding.display = "mobile"
* name.given[0] = "Aisha"
* name.family = "Musa"
* gender = #female
* birthDate = "2025-06-20"
* active = true
* address.line[0] = "No. 7 PHC Close"
* address.city = "Garki"
* address.district = "fc-municipal"
* address.state = "FC"

// Organization (reporting)
Instance: NgOrganization-AEFI-001
InstanceOf: NgOrganization
Usage: #inline
Title: "Garki PHC"
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier.value = "HCF-55667"
* active = true
* name = "Garki Primary Health Centre"
* type.coding.system = "https://www.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type.coding.code = #clinic
* type.coding.display = "Primary Health Centre"
* telecom[0].system = #phone
* telecom[0].value = "09-111-2222"
* address.line[0] = "12 Immunization Lane"
* address.city = "Abuja"
* address.district = "fc-municipal"
* address.state = "FC"

// Practitioner (recorder)
Instance: NgPractitioner-AEFI-001
InstanceOf: NgPractitioner
Usage: #inline
Title: "Nurse Joy Okoye"
* identifier[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-mdcn"
* identifier[0].value = "MDCN-12347"
* active = true
* name.given = "Joy"
* name.family = "Okoye"
* telecom[0].system = #phone
* telecom[0].value = "08070001234"
* birthDate = "1990-01-05"

// Location
Instance: NgLocation-AEFI-001
InstanceOf: NgLocation
Usage: #inline
Title: "Garki PHC – Immunization Room"
* status = #active
* name = "Immunization Room A"
* type[0].text = "Clinic Room"
* address.line[0] = "12 Immunization Lane"
* address.city = "Abuja"
* address.district = "fc-municipal"
* address.state = "FC"
* address.country = "NG"
* position.latitude = 9.033
* position.longitude = 7.492
* managingOrganization = Reference(urn:uuid:1a12aabb-e5f6-4789-a123-456789abcdef)

// Encounter (optional)
Instance: NgEncounter-AEFI-001
InstanceOf: NgEncounter
Usage: #inline
Title: "AEFI Triage Visit"
* status = #finished
* subject = Reference(urn:uuid:1212aabb-e5f6-4789-a123-456789abcdef)
* participant[0].individual = Reference(urn:uuid:1b12aabb-e5f6-4789-a123-456789abcdef)
* location.location = Reference(urn:uuid:12c2aabb-e5f6-4789-a123-456789abcdef)
* serviceProvider = Reference(urn:uuid:1a12aabb-e5f6-4789-a123-456789abcdef)
* class = http://terminology.hl7.org/CodeSystem/v3-ActCode#AMB

// Immunization (index dose; keep binding light via text)
Instance: NgImmunization-AEFI-001
InstanceOf: NgImmunization
Usage: #inline
Title: "Hepatitise B Dose"
* status = #completed
* vaccineCode.text = "HepB birth dose"
* vaccineCode.coding =  https://sandbox.dhin-hie.org/ig/CodeSystem/ng-vaccine-local#IMMZ.Z.DE2
* patient = Reference(urn:uuid:1212aabb-e5f6-4789-a123-456789abcdef)
* occurrenceDateTime = "2025-11-05T10:00:00+01:00"
* lotNumber = "PENTA-LOT-2025-11-A"
* expirationDate = "2026-05-31"
* doseQuantity.value = 0.5
* doseQuantity.unit = "mL"
* site.text = "Left anterolateral thigh"
* route.text = "Intramuscular"
* performer[0].actor = Reference(urn:uuid:1b12aabb-e5f6-4789-a123-456789abcdef)

// Observation – Fever (temperature)
// Instance: Obs-AEFI-Temp-001
// InstanceOf: NgObservation
// Usage: #inline
// Title: "Fever 38.8 °C"
// * status = #final
// * category[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/observation-category"
// * category[0].coding[0].code = #social-history
// * code.coding[0].system = "http://loinc.org"
// * code.coding[0].code = #30525-0
// * code.coding[0].display = "Age"
// * subject = Reference(urn:uuid:1212aabb-e5f6-4789-a123-456789abcdef)
// * effectiveDateTime = "2025-11-05T20:30:00+01:00"
// * valueQuantity.value = 38.8
// * valueQuantity.unit = "°C"
// * valueQuantity.system = "http://unitsofmeasure.org"
// * valueQuantity.code = #Cel


