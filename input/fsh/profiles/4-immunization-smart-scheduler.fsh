// ======================================================================
// Profile: NgImmSmartSchedulerBundle
// ======================================================================
Profile: NgImmSmartSchedulerBundle
Parent: Bundle
Id: ng-imm-smart-scheduler-bundle
Title: "4-NG Immunization SMART Scheduler Bundle"
Description: "A minimal transaction bundle to schedule an immunization visit with optional recommendations."

* ^status = #active

// Bundle basics
* type 1..1 MS
* type = #transaction (exactly)
* entry 2..* MS
* entry.fullUrl 1..1 MS
* entry.resource 1..1 MS
* entry.request 0..1 MS
* entry.request.method 1..1
* entry.request.url 1..1

// Slice entries by resource profile/type
* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #open

// Named slices (minimum set for scheduling, rec optional)
* entry contains
    patient 1..1 MS and
    org 0..1 MS and
    location 0..1 MS and
    appointment 1..1 MS and
    immRec 0..1 MS

// Resource type restrictions
* entry[patient].resource only NgPatient
* entry[org].resource only NgOrganization
* entry[location].resource only NgLocation
* entry[appointment].resource only NgAppointment
* entry[immRec].resource only NgImmunizationRecommendation

// Helpful short hints
* entry.fullUrl ^short = "Prefer URN UUID (urn:uuid:...) for intra-bundle references."
* entry[appointment].request.url ^short = "Appointment"
* entry[patient].request.url ^short = "Patient"
* entry[org].request.url ^short = "Organization"
* entry[location].request.url ^short = "Location"
* entry[immRec].request.url ^short = "ImmunizationRecommendation"





// ======================================================================
// Example: Immunization SMART Scheduler – Create Appointment
// ======================================================================
Instance: ImmSmartScheduler-Book-001
InstanceOf: NgImmSmartSchedulerBundle
Usage: #example
Title: "SMART Scheduler – Immunization Appointment Booking"
Description: "Books an immunization appointment and carries a next-dose recommendation."

* type = #transaction

// ---------------- Patient -------------------------------------- 
* entry[0].fullUrl = "urn:uuid:992211bb-e5f6-4789-a123-456789abcdef"
* entry[0].resource = NgPatient-IMMSS-001
* entry[0].request.method = #POST
* entry[0].request.url = "Patient"


// ---------------- Organization (Facility owner) ----------------
* entry[+].fullUrl = "urn:uuid:9922aabb-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgOrganization-IMMSS-001
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"


// ---------------- Location (Clinic room / vaccination point) ---
* entry[+].fullUrl = "urn:uuid:99ee11bb-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgLocation-IMMSS-001
* entry[=].request.method = #POST
* entry[=].request.url = "Location"


// ---------------- Appointment (the booking) --------------------
* entry[+].fullUrl = "urn:uuid:ff2211bb-e5f6-4789-a123-456789abcdef"
* entry[=].resource = Appointment-IMMSS-001
* entry[=].request.method = #POST
* entry[=].request.url = "Appointment"


// ---------------- ImmunizationRecommendation (optional) --------
* entry[+].fullUrl = "urn:uuid:ddd211bb-e5f6-4789-a123-456789abcdef"
* entry[=].resource = ImmRec-IMMSS-001
* entry[=].request.method = #POST
* entry[=].request.url = "ImmunizationRecommendation"



// ======================================================================
// Inline resources
// ======================================================================

// Patient (NgPatient requires meta.lastUpdated, identifiers & basic demo)
Instance: NgPatient-IMMSS-001
InstanceOf: NgPatient
Usage: #inline
Title: "Child – Musa Danladi"
* meta.lastUpdated = "2025-11-06T08:10:00+01:00"
* identifier[PhoneNumber].value = "08031234567"
* identifier[PhoneNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.code = #MOBILE
* identifier[PhoneNumber].type.coding.display = "mobile"
* name.given[0] = "Musa"
* name.family = "Danladi"
* gender = #male
* birthDate = "2025-06-01"
* active = true
* address.line[0] = "No. 4 PHC Crescent"
* address.city = "Garki"
* address.district = "fc-municipal"
* address.state = "FC"

// Organization (facility record)
Instance: NgOrganization-IMMSS-001
InstanceOf: NgOrganization
Usage: #inline
Title: "Apo Primary Health Centre"
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier.value = "HCF-12346"
* active = true
* name = "Apo PHC"
* type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type.coding.code = #phc-center-l1
* type.coding.display = "PHC Center Level 1"
* telecom[0].system = #phone
* telecom[0].value = "09-222-7788"
* address.line[0] = "Apo Resettlement"
* address.city = "Abuja"
* address.district = "fc-municipal"
* address.state = "FC"

// Location (where the jab happens)
Instance: NgLocation-IMMSS-001
InstanceOf: NgLocation
Usage: #inline
Title: "Apo PHC – Immunization Room"
* status = #active
* name = "Immunization Room 1"
* type[0].text = "Clinic Room"
* address.line[0] = "Apo Resettlement"
* address.city = "Abuja"
* address.district = "fc-municipal"
* address.state = "FC"
* address.country = "NG"
* position.latitude = 9.0223
* position.longitude = 7.4974
* managingOrganization = Reference(urn:uuid:9922aabb-e5f6-4789-a123-456789abcdef)

// Appointment
Instance: Appointment-IMMSS-001
InstanceOf: Appointment
Usage: #inline
Title: "Immunization Appointment – Musa"
* status = #booked
* serviceCategory[0].text = "Immunization"
* serviceType[0].text = "Childhood vaccine visit"
* description = "BCG / OPV0 visit"
* start = "2025-11-08T09:00:00+01:00"
* end   = "2025-11-08T09:15:00+01:00"
* created = "2025-11-06T08:12:00+01:00"
* participant[0].type[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/v3-ParticipationType"
* participant[0].type[0].coding[0].code = #PART
* participant[0].status = #accepted
* participant[0].actor = Reference(urn:uuid:992211bb-e5f6-4789-a123-456789abcdef)
* participant[1].type[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/v3-ParticipationType"
* participant[1].type[0].coding[0].code = #BBY
* participant[1].status = #accepted
* participant[1].actor = Reference(urn:uuid:99ee11bb-e5f6-4789-a123-456789abcdef)
* participant[2].type[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/v3-ParticipationType"
* participant[2].type[0].coding[0].code = #CST
* participant[2].status = #accepted
* participant[2].actor = Reference(urn:uuid:992211bb-e5f6-4789-a123-456789abcdef)
* minutesDuration = 15
* priority = 5

// ImmunizationRecommendation (optional helper for next dose)
Instance: ImmRec-IMMSS-001
InstanceOf: ImmunizationRecommendation
Usage: #inline
Title: "Next-Dose Recommendation"
* patient = Reference(urn:uuid:992211bb-e5f6-4789-a123-456789abcdef)
* date = "2025-11-06"
* recommendation[0].forecastStatus.coding[0].system = "http://terminology.hl7.org/CodeSystem/immunization-recommendation-status"
* recommendation[0].forecastStatus.coding[0].code = #due
* recommendation[0].forecastStatus.text = "Dose due"
* recommendation[0].description = "Initial newborn vaccines"
* recommendation[0].vaccineCode[0].text = "BCG"
* recommendation[0].vaccineCode[+].text = "OPV0"
* recommendation[0].targetDisease[0].text = "Tuberculosis"
* recommendation[0].dateCriterion[0].code.text = "recommended"
* recommendation[0].dateCriterion[0].value = "2025-11-08"
* recommendation[0].supportingPatientInformation[0].display = "Birth date: 2025-06-01"
