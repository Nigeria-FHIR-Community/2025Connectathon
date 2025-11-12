Profile: NgOrganization
Parent: Organization
Id: ng-organization 
Title: "NG Organization"
Description: "An organization profile representing healthcare facilities responsible for health services or other types of organizations."
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-organization"


* identifier 1..* MS
* identifier.system 1..1
* identifier.system ^short = "The facility type regulator or identifity provider if not health facility (E.g. HERFAMA in Lagos State)"
* identifier.value 1..1
* identifier.value ^short = "The facility or organization uniqe identifier"
* active 1..1 MS
* active ^short = "Boolean to indicate if institution is active or inactive"
* name 1..1 MS
* name ^short = "The name of the organization or health facility"
* type 1..* MS
* type ^short = "The type of the organization or health facility"
* telecom 0..*
* telecom.system 1..1
* telecom.system ^short = "The organization type of contact detail"
* telecom.value 1..1
* telecom.value ^short = "The organization contact detail"
* partOf only Reference(NgOrganization)
* partOf ^short = "The Organization which this organization forms a part"

* address 1..* MS
* address.line 1..*
* address.line ^short = "The organization contact address line"
* address.city 1..1
* address.city ^short = "The organization contact address city, town or settlement"
* address.district from NGLGAsVS
* address.district ^short = "The organization contact address LGA"
* address.state from NGStatesVS
* address.state ^short = "The organization contact address state"

* extension contains NGOrganizationOwner named NGOrganizationOwner 0..1 MS


// Hide these
* telecom.use 0..0









// EXAMPLES 
// ==============================================
// 1) Asokoro District Hospital (Public, Hospital)
// ==============================================
Instance: NgOrganization-001
InstanceOf: NgOrganization
Usage: #example
Title: "Example Asokoro District Hospital"
Description: "Public secondary hospital in FCT (AMAC)."
* identifier[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier[0].value = #HOSPITAL1234
* active = true
* name = "Asokoro District Hospital"
* type[0].coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type[0].coding.code = #hospital
* type[0].coding.display = "Secondary Hospital"
* type[0].text = "Secondary Hospital"
* telecom[0].system = #phone
* telecom[0].value = "+234-800-111-2222"
* telecom[1].system = #email
* telecom[1].value = "info@asokorodh.example.ng"
* address[0].line[0] = "Plot 12, Yakubu Gowon Crescent, Asokoro"
* address[0].city = "Abuja"
* address[0].district = #fc-municipal
* address[0].state = #FC
* extension[NGOrganizationOwner].valueCodeableConcept.coding[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-location-owner-cs"
* extension[NGOrganizationOwner].valueCodeableConcept.coding[0].code = #public
* extension[NGOrganizationOwner].valueCodeableConcept.coding[0].display = "Public Health Institution Location"


// ==============================================
// 2) Kano Central Hospital Pharmacy (Private dept)
// ==============================================
Instance: NgOrganization-002
InstanceOf: NgOrganization
Usage: #example
Title: "Example Kano Central Hospital Pharmacy"
Description: "Pharmacy department serving outpatient dispensing; Kano Municipal."
* identifier[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier[0].value = #HCF-12347
* active = true
* name = "Kano Central Hospital Pharmacy"
* type[0].coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type[0].coding.code = #hospital
* type[0].coding.display = "Secondary Hospital"
* type[0].text = "Hospital Department"
* telecom[0].system = #phone
* telecom[0].value = "+234-803-555-7788"
* telecom[1].system = #email
* telecom[1].value = "pharmacy@kanocentral.example.ng"
* address[0].line[0] = "No. 7 Kiru Road"
* address[0].city = "Kabo"
* address[0].district = #kn-kabo
* address[0].state = #KN
* extension[NGOrganizationOwner].valueCodeableConcept.coding[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-location-owner-cs"
* extension[NGOrganizationOwner].valueCodeableConcept.coding[0].code = #private
* extension[NGOrganizationOwner].valueCodeableConcept.coding[0].display = "Private Health Institution Location"


// ==============================================
// 3) Gwagwalada Model PHC (Public, PHC L2)
// ==============================================
Instance: NgOrganization-003
InstanceOf: NgOrganization
Usage: #example
Title: "Example Gwagwalada Model PHC"
Description: "Public PHC facility in FCT Gwagwalada Area Council."
* identifier[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier[0].value = #CLM-2025-0001
* active = true
* name = "Gwagwalada Model PHC"
* type[0].coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type[0].coding.code = #phc-center-l2
* type[0].coding.display = "PHC Center Level 2"
* type[0].text = "Primary Health Care Centre (Level 2)"
* telecom[0].system = #phone
* telecom[0].value = "+234-812-000-4455"
* address[0].line[0] = "Opposite Central Market"
* address[0].city = "Gwagwalada"
* address[0].district = #fc-gwagwalada
* address[0].state = #FC
* extension[NGOrganizationOwner].valueCodeableConcept.coding[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-location-owner-cs"
* extension[NGOrganizationOwner].valueCodeableConcept.coding[0].code = #public
* extension[NGOrganizationOwner].valueCodeableConcept.coding[0].display = "Public Health Institution Location"







// Create these sub organization profiles

Profile: NgProviderOrganization
Parent: NgOrganization
Id: ng-provider-organization
Title: "NG Provider Organization"
Description: "Organization profile for healthcare providers (hospitals, clinics)"
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-provider-organization"
* type 1..* MS
* type from NgProviderOrgTypeVS (required)

Profile: NgInsurerOrganization
Parent: NgOrganization
Id: ng-insurer-organization
Title: "NG Insurer Organization"
Description: "Organization profile for insurance payers/HMOs"
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-insurer-organization"
* type 1..* MS
* type from NgInsurerOrgTypeVS (required)


Profile: NgPharmacyOrganization
Parent: NgOrganization
Id: ng-pharmacy-organization
Title: "NG Pharmacy Organization"
Description: "Organization profile for pharmacies and dispensing facilities"
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-pharmacy-organization"
* type 1..* MS
* type from NgPharmacyOrganizationVS (required)