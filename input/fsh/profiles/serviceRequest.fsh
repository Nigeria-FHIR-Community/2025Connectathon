Profile: NgServiceRequest
Parent: ServiceRequest
Title: "NG ServiceRequest"
Id: ng-service-request
Description: "Minimal ServiceRequest profile for the 2025 Connectathon (referrals and orders)."
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-service-request"
// Core, practical constraints
* status 1..1 MS
* status from http://hl7.org/fhir/ValueSet/request-status (required)
* intent 1..1 MS
* intent from http://hl7.org/fhir/ValueSet/request-intent (required)
* code 0..1 MS
* subject 1..1 MS
* subject only Reference(NgPatient)
* authoredOn 0..1
* occurrence[x] 0..1
* requester 0..1
* requester only Reference(NgPractitioner or NgPatient or NgOrganization)
* performerType 0..1
* performer 0..*
* performer only Reference(NgPractitioner or NgOrganization)
* reasonReference 0..*
* reasonReference only Reference(NgCondition or NgObservation)
* supportingInfo 0..*
* priority 0..1


// EXAMPLES

// ==================================================================
// 1) MNCH referral — Obstetric Ultrasound for NgPatient-002 (pregnant)
// ==================================================================
Instance: NgServiceRequest-001
InstanceOf: NgServiceRequest
Usage: #example
Title: "Example Ng ServiceRequest (Obstetric Ultrasound)"
Description: "Ultrasound order for pregnant client."
* status = #active
* intent = #order
* code.text = "Obstetric ultrasound"
* subject = Reference(NgPatient-002)
* authoredOn = "2025-11-03T10:15:00+01:00"
* occurrenceDateTime = "2025-11-10T09:00:00+01:00"
* requester = Reference(NgPractitioner-001)
* performer[0] = Reference(NgOrganization-002)
* priority = #urgent
// Reason references are constrained to NgCondition or NgObservation
* reasonReference[0] = Reference(NgObservation-003) // pregnancy status obs
* supportingInfo[0] = Reference(NgObservation-003)

// ==================================================================
// 2) ePharmacy/chronic care — Fasting Blood Glucose for NgPatient-001
// ==================================================================
Instance: NgServiceRequest-002
InstanceOf: NgServiceRequest
Usage: #example
Title: "Example Ng ServiceRequest (Fasting Blood Glucose)"
Description: "Lab order for diabetes follow-up."
* status = #active
* intent = #order
* code.text = "Fasting blood glucose"
* subject = Reference(NgPatient-001)
* authoredOn = "2025-11-04T08:30:00+01:00"
* occurrenceDateTime = "2025-11-05T07:30:00+01:00"
* requester = Reference(NgPractitioner-002)
* performerType.text = "Laboratory service"
* performer[0] = Reference(NgOrganization-001)
* priority = #routine
* reasonCode[0].text = "Diabetes mellitus follow-up"
* supportingInfo[0] = Reference(NgMedicationRequest-003) // insulin therapy context

