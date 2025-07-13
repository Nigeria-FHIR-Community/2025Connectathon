// These are the extensions used to capture a Patient's demographic information (Not even captured in related person)
// Extension using value[x] directly



Extension: NGAdministrativeWard
Id: nigeria-administrative-ward
Title: "NG-eP Administrative Wards "
Description: "Captures the administrative ward within a geographic address "
* ^context[0].type = #element
* ^context[0].expression = "Address"
* ^status = #active
* ^publisher = "NPHCDA"
* value[x] only CodeableConcept
* valueCodeableConcept from NGWardsVS (example)



Extension: NGBirthWeight
Id:  birth-weight
Title:  "NG-eP Weight at birth"
Description: "Weight  of the Immunization Client at birth"
* ^context[0].type = #element
* ^context[0].expression = "Patient"
* value[x] only decimal

