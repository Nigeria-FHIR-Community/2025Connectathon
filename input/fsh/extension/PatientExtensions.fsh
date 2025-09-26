// These are the extensions used to capture a Patient's demographic information (Not even captured in related person)
// Extension using value[x] directly



Extension: NGAdministrativeWard
Id: nigeria-administrative-ward
Title: "NG Administrative Wards "
Description: "Captures the administrative ward within a geographic address "
* ^context[0].type = #element
* ^context[0].expression = "Address"
* ^status = #active
* ^publisher = "DHIN"
* value[x] only CodeableConcept
* valueCodeableConcept from NGWardsVS (preferred)



Extension: NGBirthWeight
Id:  birth-weight
Title:  "NG Weight at birth"
Description: "Weight  of the Immunization Client at birth"
* ^context[0].type = #element
* ^context[0].expression = "Patient"
* value[x] only decimal

