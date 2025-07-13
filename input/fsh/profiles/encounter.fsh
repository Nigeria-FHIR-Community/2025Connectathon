Profile: NgePEncounter
Parent: Encounter
Title: "NG-eP Encounter"
Id: ng-ep-encounter 
Description: "A profile for encounters in the Nigerian  prescription guide, used to document prescription visits and related healthcare interactions."
* ^version = "1.0.0"
* ^status = #active
* ^publisher = "DHIN"
* status ^short = "Status of the prescription encounter"
* subject 1..1 MS
* subject only Reference(NgePPatient)
* participant 1..* MS
* participant.individual only Reference(NgePPractitioner) 
* location 1..1 MS
* location.location only Reference(NgePLocation)
* serviceProvider 1..1 MS
* serviceProvider only Reference(NgePOrganization)


