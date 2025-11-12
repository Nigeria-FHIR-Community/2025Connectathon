Profile: NgEncounter
Parent: Encounter
Title: "NG Encounter"
Id: ng-encounter 
Description: "A profile for encounters in the Nigerian used to health visits and related healthcare interactions."
* ^version = "1.0.0"
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-encounter"
* ^status = #active
* ^publisher = "DHIN"
* status ^short = "Status of the encounter"
* subject 1..1 MS
* subject only Reference(NgPatient)
* participant 1..* MS
* participant.individual only Reference(NgPractitioner) 
* location 1..1 MS
* location.location only Reference(NgLocation)
* serviceProvider 1..1 MS
* serviceProvider only Reference(NgOrganization)


// EXAMPLES

// ==============================================
// 1) NgEncounter-001 — MNCH ANC visit (Asokoro)
// ==============================================
Instance: NgEncounter-001
InstanceOf: NgEncounter
Usage: #example
Title: "Example Ng Encounter (MNCH ANC)"
Description: "Antenatal care visit at Asokoro District Hospital."
* status = #finished
* class = http://terminology.hl7.org/CodeSystem/v3-ActCode#AMB "ambulatory"
* subject = Reference(NgPatient-001)
* participant[0].individual = Reference(NgPractitioner-001)
* location.location = Reference(NgLocation-002)
* serviceProvider = Reference(NgOrganization-003)
* period.start = 2025-11-04T09:00:00Z
* period.end   = 2025-11-04T09:35:00Z


// ==============================================
// 2) NgEncounter-002 — ePharmacy dispensing (Kano)
// ==============================================
Instance: NgEncounter-002
InstanceOf: NgEncounter
Usage: #example
Title: "Example Ng Encounter (ePharmacy Dispense)"
Description: "Outpatient pharmacy encounter at Kano Central Hospital Pharmacy."
* status = #finished
* class = http://terminology.hl7.org/CodeSystem/v3-ActCode#AMB "ambulatory"
* subject = Reference(NgPatient-002)
* participant[0].individual = Reference(NgPractitioner-002)
* location.location = Reference(NgLocation-003)
* serviceProvider = Reference(NgOrganization-002)
* period.start = 2025-11-04T12:15:00Z
* period.end   = 2025-11-04T12:25:00Z


// ==============================================
// 3) NgEncounter-003 — Immunization visit (Gwagwalada)
// ==============================================
Instance: NgEncounter-003
InstanceOf: NgEncounter
Usage: #example
Title: "Example Ng Encounter (Immunization Visit)"
Description: "RI session at Gwagwalada Model PHC."
* status = #finished
* class = http://terminology.hl7.org/CodeSystem/v3-ActCode#AMB "ambulatory"
* subject = Reference(NgPatient-003)
* participant[0].individual = Reference(NgPractitioner-003)
* location.location = Reference(NgLocation-002)
* serviceProvider = Reference(NgOrganization-001)
* period.start = 2025-11-04T10:05:00Z
* period.end   = 2025-11-04T10:20:00Z


