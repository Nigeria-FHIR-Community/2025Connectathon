Profile: NgEncounter
Parent: Encounter
Title: "NG Encounter"
Id: nigeria-encounter 
Description: "A profile for encounters in the Nigerian used to health visits and related healthcare interactions."
* ^version = "1.0.0"
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


