Profile: NgTask
Parent: Task
Title: "NG Task"
Description: "Minimal Task profile for the 2025 Connectathon (referrals, claims, pharmacy, devices)."

// Core, practical constraints
* status 1..1 MS
* intent 1..1 MS
* code 0..1 MS
* focus 0..1 MS
* for 0..1 MS
* authoredOn 0..1
* lastModified 0..1
* requester 0..1
* owner 0..1
* reasonCode 0..1
* priority 0..1
* input 0..*
* output 0..*
* note 0..*

// Reference targets
* for only Reference(NgPatient)
* focus only Reference(NgServiceRequest or NgDeviceRequest or NgClaim)
* requester only Reference(NgPractitioner or NgPractitionerRole or NgOrganization)
* owner only Reference(NgPractitioner or NgPractitionerRole or NgOrganization)

// Value set bindings
* status from http://hl7.org/fhir/ValueSet/task-status (required)
* intent from http://hl7.org/fhir/ValueSet/task-intent (required)
* priority from http://hl7.org/fhir/ValueSet/request-priority (required)


// -----------------------------
// Example Instance
// -----------------------------
Instance: NgTask-001
InstanceOf: NgTask
Usage: #example
Title: "Example NG Task"
Description: "Minimal Task to coordinate a referral based on a ServiceRequest."
* status = #in-progress
* intent = #order
* code.text = "Coordinate referral"
* focus = Reference(NgServiceRequest-001)
* for = Reference(NgPatient-001)
* authoredOn = 2025-11-11T10:00:00Z
* requester = Reference(NgPractitioner-001)
* owner = Reference(NgPractitionerRole-001)
* priority = #routine
* input[0].type.text = "Notes"
* input[0].valueString = "Patient contacted; appointment set for 12 Nov 2025."
* output[0].type.text = "Outcome"
* output[0].valueString = "Referral accepted by clinic."
