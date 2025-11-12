Profile: NgLocation
Parent: Location
Title: "NG Location"
Id: ng-location 
Description: "A profile for immunization service locations, including health facilities, outreach sites, and mobile vaccination units."
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-location"
* ^version = "1.0.0"
* ^status = #active
* status 1..1
* name 1..1
* type 1..* MS
* type from NGFacilityTypeVS (extensible)
* address 1..1 MS
* address.extension contains NGAdministrativeWard named NGadministrativeWard 0..1 MS
* address.line 0..1 MS
* address.line ^short = "The line address of the health Location"
* address.city 0..1
* address.city ^short = "The city, town or settlement where the health location"
* address.district from NGLGAsVS (required)
* address.district ^short = "The LGA where the health location"
* address.state from NGStatesVS (required)
* address.state ^short = "The State in Nigeria where the location"
* address.country = "NG" (exactly)
* telecom 0..* MS
* position 0..1
* position.altitude 0..1
* position.longitude 1..1 MS
* position.latitude 1..1 MS
* managingOrganization only Reference(NgOrganization)
* managingOrganization ^short = "Organization responsible for provisioning and upkeep of the location"
* partOf only Reference(NgLocation)
* partOf ^short = "Another location this organization is physically part of"


// EXAMPLES

// ==============================================
// 1) Asokoro OPD (hospital department)
// ==============================================
Instance: NgLocation-001
InstanceOf: NgLocation
Usage: #example
Title: "Example Asokoro OPD"
Description: "Outpatient department at Asokoro District Hospital."

* status = #active
* name = "Asokoro OPD"
* type[0].coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type[0].coding.code = #hospital
* type[0].coding.display = "Secondary Hospital"
* address.line = "Yakubu Gowon Crescent, Asokoro"
* address.city = "Abuja Municipal Area Council"
* address.district = #fc-municipal
* address.state = #FC
* address.country = #NG
* telecom[0].system = #phone
* telecom[0].value = "+234-800-111-2222"
* position.latitude = 9.043
* position.longitude = 7.516
* managingOrganization = Reference(NgOrganization-001)


// ==============================================
// 2) Kano Central Pharmacy Counter (hospital pharmacy)
// ==============================================
Instance: NgLocation-002
InstanceOf: NgLocation
Usage: #example
Title: "Example Kano Central Pharmacy Counter"
Description: "Dispensing counter at Kano Central Hospital Pharmacy."
* status = #active
* name = "Pharmacy Counter"
* type[0].coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type[0].coding.code = #hospital
* type[0].coding.display = "Secondary Hospital"
* address.line = "No. 8 Lafia Road"
* address.city = "Kano Municipal"
* address.district = #kn-kano-municipal
* address.state = #KN
* address.country = #NG
* telecom[0].system = #phone
* telecom[0].value = "+234-803-555-7788"
* position.latitude = 12.000
* position.longitude = 8.500
* managingOrganization = Reference(NgOrganization-002)


// ==============================================
// 3) Gwagwalada Immunization Room (PHC L2)
// ==============================================
Instance: NgLocation-003
InstanceOf: NgLocation
Usage: #example
Title: "Example Gwagwalada Immunization Room"
Description: "RI room at Gwagwalada Model PHC."
* status = #active
* name = "Immunization Room"
* type[0].coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type[0].coding.code = #phc-center-l2
* type[0].coding.display = "PHC Center Level 2"
* address.line = "Opposite Central Market"
* address.city = "Gwagwalada"
* address.district = #fc-gwagwalada
* address.state = #FC
* address.country = #NG
* position.latitude = 8.939
* position.longitude = 7.081
* managingOrganization = Reference(NgOrganization-003)


// ==============================================
// 4) Gurdi Outreach Site (mobile/outreach)
// ==============================================
Instance: NgLocation-004
InstanceOf: NgLocation
Usage: #example
Title: "Example Gurdi Outreach Site"
Description: "Periodic immunization outreach post in Abaji Area Council, FCT."
* status = #active
* name = "Gurdi Outreach Site"
* type[0].coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type[0].coding.code = #outreach
* type[0].coding.display = "Outreach Post"
* address.line = "Primary School Field, Gurdi Ward"
* address.city = "Gurdi"
* address.district = #fc-municipal
* address.state = #FC
* address.country = #NG
// Optional ward extension (uses your NGAdministrativeWard)
* address.extension[NGadministrativeWard].valueCodeableConcept.coding[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-wards"
* address.extension[NGadministrativeWard].valueCodeableConcept.coding[0].code = #fc-amac-gurdi
* address.extension[NGadministrativeWard].valueCodeableConcept.coding[0].display = "Gurdi"
* position.latitude = 8.470
* position.longitude = 6.950
* managingOrganization = Reference(NgOrganization-002)
