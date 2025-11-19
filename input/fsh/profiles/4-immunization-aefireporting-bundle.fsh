// ======================================================================
// Profile: NgAefiReportBundle
// ======================================================================
Profile: NgAefiReportBundle
Parent: Bundle
Id: ng-aefi-report-bundle
Title: "4-NG AEFI Report Bundle"
Description: "Minimal transaction bundle to report an AEFI with Patient, Immunization, AdverseEvent, and supporting data."

* ^status = #active
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-aefi-report-bundle"

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



// ======================================================================
// Example: AEFI Report — Mild Rash after Measles-Rubella (MR)
// ======================================================================
Instance: NgAefiReport-001
InstanceOf: NgAefiReportBundle
Usage: #example
Title: "AEFI Report – Mild Rash after MR (Makurdi)"
Description: "Wadata PHC reports a mild rash AEFI for a 14-month-old after Measles-Rubella vaccine."

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

// ---------------- Location (immunization room) --------------
* entry[+].fullUrl = "urn:uuid:12c2aabb-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgLocation-AEFI-001
* entry[=].request.method = #POST
* entry[=].request.url = "Location"

// ---------------- Encounter (follow-up/triage) -------------------------
* entry[+].fullUrl = "urn:uuid:121daabb-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgEncounter-AEFI-001
* entry[=].request.method = #POST
* entry[=].request.url = "Encounter"

// ---------------- Immunization (index vaccination) -------------
* entry[+].fullUrl = "urn:uuid:121faabb-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgImmunization-AEFI-001
* entry[=].request.method = #POST
* entry[=].request.url = "Immunization"

// ---------------- Observation (AEFI: rash) --------------------------
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
Title: "Infant – Terfa Dooshima"
* meta.lastUpdated = "2025-11-06T08:30:00+01:00"
* identifier[PhoneNumber].value = "08030001111"
* identifier[PhoneNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.code = #MOBILE
* identifier[PhoneNumber].type.coding.display = "mobile"
* name.given[0] = "Terfa"
* name.family = "Dooshima"
* gender = #male
* birthDate = "2024-09-06"
* active = true
* address.line[0] = "Wadata PHC Road"
* address.city = "Makurdi"
* address.district = "be-makurdi"
* address.state = "BE"            // Benue


// Organization (reporting)
Instance: NgOrganization-AEFI-001
InstanceOf: NgOrganization
Usage: #inline
Title: "Wadata PHC, Makurdi"
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier.value = "HCF-55667"
* active = true
* name = "Wadata Primary Health Centre"
* type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type.coding.code = #phc-center-l1
* type.coding.display = "PHC Center Level 1"
* telecom[0].system = #phone
* telecom[0].value = "0803-000-0000"
* address.line[0] = "Wadata"
* address.city = "Makurdi"
* address.district = "be-makurdi"
* address.state = "BE"

// Practitioner (recorder)
Instance: NgPractitioner-AEFI-001
InstanceOf: NgPractitioner
Usage: #inline
Title: "Nurse Gloria Anum"
* identifier[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-mdcn"
* identifier[0].value = "MDCN-12347"
* active = true
* name.given = "Gloria"
* name.family = "Anum"
* telecom[0].system = #phone
* telecom[0].value = "0803-555-7788"
* birthDate = "1988-06-12"

// Location
Instance: NgLocation-AEFI-001
InstanceOf: NgLocation
Usage: #inline
Title: "Wadata PHC – Immunization Room"
* status = #active
* name = "Immunization Room A"
* type[0].text = "Clinic Room"
* address.line[0] = "Wadata"
* address.city = "Makurdi"
* address.district = "be-makurdi"
* address.state = "BE"
* address.country = "NG"
* position.latitude = 7.730
* position.longitude = 8.536
* managingOrganization = Reference(urn:uuid:1a12aabb-e5f6-4789-a123-456789abcdef)

// Encounter (optional)
Instance: NgEncounter-AEFI-001
InstanceOf: NgEncounter
Usage: #inline
Title: "AEFI Follow-up Visit"
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
Title: "Measles-Rubella (MR) Dose"
* status = #completed
* vaccineCode.text = "Measles-Rubella (MR)"
* vaccineCode.coding =  https://sandbox.dhin-hie.org/ig/CodeSystem/ng-vaccine-local#IMMZ.Z.DE2
* patient = Reference(urn:uuid:1212aabb-e5f6-4789-a123-456789abcdef)
* lotNumber = "MR-2025-04-B"
* expirationDate = "2026-09-15"
* doseQuantity.value = 0.5
* doseQuantity.unit = "mL"
* doseQuantity.system = "http://unitsofmeasure.org"
* doseQuantity.code = #mL
* site.text = "Left deltoid"
* route.text = "Intramuscular"
* performer[0].actor = Reference(urn:uuid:1b12aabb-e5f6-4789-a123-456789abcdef)
* occurrenceDateTime = 2024-07-10T10:00:00+01:00

// Observation – AEFI (rash) at 23:47 same day
Instance: NgObservation-007
InstanceOf: NgObservation
Usage: #inline
Title: "AEFI – Mild maculopapular rash"
* status = #final
* category[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/observation-category"
* category[0].coding[0].code = #social-history
* category[0].coding[0].display = "Social History"
* code.coding[0].system = "http://loinc.org"
* code.coding[0].code = #30525-0
* code.coding[0].display = "Age"
* subject = Reference(urn:uuid:1212aabb-e5f6-4789-a123-456789abcdef)
* effectiveDateTime = "2025-11-06T23:47:00+01:00"
* performer[0] = Reference(urn:uuid:1b12aabb-e5f6-4789-a123-456789abcdef)
* interpretation[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation"
* interpretation[0].coding[0].code = #N
* interpretation[0].coding[0].display = "Normal/Expected"
* note[0].text = "Batch MR-2025-04-B. No other reports from same batch to date. Mother counseled; WhatsApp hotline provided."

* component[ageInYears].valueQuantity.value = 45
* component[ageInYears].valueQuantity.system = "http://unitsofmeasure.org"
* component[ageInYears].valueQuantity.code = #yr
* component[ageInYears].valueQuantity.unit = "year"