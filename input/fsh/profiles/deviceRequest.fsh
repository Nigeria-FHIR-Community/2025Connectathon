Profile: NgDeviceRequest
Parent: DeviceRequest
Title: "NG DeviceRequest"
Description: "Minimal DeviceRequest profile for the 2025 Connectathon."

// Core elements (kept minimal but practical)
* status 1..1 MS
* intent 1..1 MS
* code[x] 1..1 MS
* code[x] only CodeableConcept or Reference(NgDevice)
* subject 1..1 MS
* subject only Reference(NgPatient)
* occurrence[x] 0..1
* requester 0..1
* requester only Reference(NgPractitioner or NgPractitionerRole or NgOrganization)
* performer 0..1
* performer only Reference(NgPractitioner or NgPractitionerRole or NgOrganization)
* reasonCode 0..*
* reasonReference 0..*
* insurance 0..*
* insurance only Reference(NgCoverage)
* supportingInfo 0..*
* note 0..*

// Value set bindings (built-ins)
* status from http://hl7.org/fhir/ValueSet/request-status (required)
* intent from http://hl7.org/fhir/ValueSet/request-inten (required)


// -----------------------------
// Example Instance
// -----------------------------
Instance: NgDeviceRequest-001
InstanceOf: NgDeviceRequest
Usage: #example
Title: "Example NG DeviceRequest"
Description: "A minimal DeviceRequest for a pulse oximeter for home monitoring."
* status = #active
* intent = #order
* codeReference = Reference(NgDevice/NgDevice-001) // or use codeCodeableConcept.text
* subject = Reference(NgPatient/NgPatient-001)
* occurrenceDateTime = 2025-11-12T09:00:00Z
* requester = Reference(NgPractitioner/NgPractitioner-001)
* performer = Reference(NgOrganization/NgOrganization-001)
* reasonCode[+] = http://snomed.info/sct#301867009 "Monitoring of oxygen saturation"
* insurance[+] = Reference(NgCoverage/NgCoverage-001)
* note[0].text = "Provide patient education on device use."
