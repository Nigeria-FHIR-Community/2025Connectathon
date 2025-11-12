// ======================================================================
// Profile: NgAppointment
// ======================================================================
Profile: NgAppointment
Parent: Appointment
Id: ng-appointment
Title: "NG Appointment"
Description: "Minimal Appointment profile for DHIN 2025 Connectathon (e.g., immunization, ePharmacy counseling, referrals)."

* ^status = #active
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-appointment"

// Core, practical constraints
* status 1..1 MS
* description 0..1 MS
* start 0..1 MS
* end 0..1 MS

* participant 1..* MS
* participant.status 1..1
* participant.required 0..1
* participant.actor 0..1
* participant.actor only Reference(
    NgPatient or
    NgPractitioner or
    NgPractitionerRole or
    NgLocation
  )

// Helpful shorts
* status ^short = "proposed | pending | booked | arrived | fulfilled | cancelled | noshow | checked-in"
* participant.status ^short = "accepted | declined | tentative | needs-action"
* participant.actor ^short = "Who is involved (patient, clinician, facility, etc.)"
* start ^short = "Start date/time of the appointment"
* end ^short   = "End date/time of the appointment"



// ======================================================================
// Example: NgAppointment-001 (very minimal, low-QA)
// ======================================================================
Instance: NgAppointment-001
InstanceOf: NgAppointment
Usage: #example
Title: "Booked Appointment – Immunization Slot"
Description: "Simple booked appointment between a patient and a clinician at a facility."

* status = #booked
* description = "Child immunization visit (MCV1)"
* start = "2025-11-06T10:30:00+01:00"
* end   = "2025-11-06T10:45:00+01:00"

// Patient participant
* participant[0].status = #accepted
* participant[0].required = #required
* participant[0].actor = Reference(NgPatient-001)

// Practitioner participant
* participant[+].status = #accepted
* participant[=].required = #required
* participant[=].actor = Reference(NgPractitioner-001)



