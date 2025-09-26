// -----------------------------
// Profile: NgHealthcareService
// -----------------------------
Profile: NgHealthcareService
Parent: HealthcareService
Title: "NG HealthcareService"
Description: "Minimal HealthcareService profile for the 2025 Connectathon (service directory/referrals)."

// Core, practical elements
* name 1..1 MS
* active 0..1 MS
* providedBy 0..1 MS
* providedBy only Reference(NgOrganization)
* category 0..* MS
* type 0..* MS
* specialty 0..*
* location 0..* MS
* location only Reference(NgLocation)
* telecom 0..* MS
* coverageArea 0..*
* coverageArea only Reference(NgLocation)
* referralMethod 0..*
* appointmentRequired 0..1
* availableTime 0..*
* availableTime.daysOfWeek 0..*
* availableTime.allDay 0..1
* availableTime.availableStartTime 0..1
* availableTime.availableEndTime 0..1
* notAvailable 0..*
* availabilityExceptions 0..1
* endpoint 0..*
* endpoint only Reference(Endpoint)

// Light terminology hints (non-restrictive)
* category from http://hl7.org/fhir/ValueSet/service-category (preferred)
* type from http://hl7.org/fhir/ValueSet/service-type (preferred)
* referralMethod from http://hl7.org/fhir/ValueSet/service-referral-method (preferred)


// -----------------------------
// Example Instance
// -----------------------------
Instance: NgHealthcareService-001
InstanceOf: NgHealthcareService
Usage: #example
Title: "Example NG HealthcareService"
Description: "Minimal healthcare service (ANC clinic)."
* active = true
* providedBy = Reference(NgOrganization/NgOrganization-001)
* name = "Asokoro District Hospital ANC Clinic"
* category[0].text = "Maternal health"
* type[0].text = "Antenatal care"
* location[0] = Reference(NgLocation/NgLocation-001)
* telecom[0].system = #phone
* telecom[0].value = "+234-800-123-4567"
* availableTime[0].daysOfWeek[0] = #mon
* availableTime[0].daysOfWeek[1] = #wed
* availableTime[0].availableStartTime = "08:00:00"
* availableTime[0].availableEndTime = "16:00:00"
* appointmentRequired = true
* endpoint[0] = Reference(NgEndpoint/NgEndpoint-001)
