Profile: NgCoverageEligibilityRequest
Parent: CoverageEligibilityRequest
Id: ng-coverage-eligibility-request
Title: "NG Claim Coverage Eligibility Request"
Description: "A profile verifying a patient's active insurance coverage and covered services.."
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-coverage-eligibility-request"

* identifier 0..* MS
* status 1..1 MS
* status from http://hl7.org/fhir/ValueSet/fm-status 
* purpose 1..* MS
* purpose from http://hl7.org/fhir/ValueSet/eligibilityrequest-purpose
* patient 1..1 MS
* patient only Reference(NgPatient)
* created 1..1 MS
* provider 0..1 MS
* provider only Reference(NgProviderOrganization)
* insurer 1..1 MS
* insurer only Reference(NgInsurerOrganization)







// == EXAMPLE ==

// ===============================================================
// Example 1: Eligibility Check Request - Chika's Emergency Visit
// ===============================================================
Instance: NgCoverageEligibilityRequest-ChikaEmergency
InstanceOf: NgCoverageEligibilityRequest
Usage: #example
Title: "Eligibility Request - Chika Emergency Ankle Injury"
Description: """
Sister Blessing scans Chika's HMO card at 11:47 PM to verify his coverage 
before emergency treatment for ankle injury. The system checks active policy 
and outpatient benefits in 3 seconds.
"""

* identifier[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/eligibility-request-id"
* identifier[0].value = "ELAPPROVE01"
* status = #active
* purpose[0] = #validation
* patient = Reference(Patient-Chika-Okafor) "Chika Okafor"
* created = "2025-11-06T23:47:00+01:00"
* provider = Reference(Organization-PortHarcourt-Hospital) "Port Harcourt Emergency Hospital"
* insurer = Reference(Organization-Truth-HMO) "Truth HMO"


// ===============================================================
// Supporting Resources - Minimal Data
// ===============================================================

// -------------------- Patient: Chika Okafor --------------------
Instance: Patient-Chika-Okafor
InstanceOf: NgPatient
Usage: #example
Title: "Patient - Chika Okafor"
Description: "Patient with Emergency situation (Welding Supervisor)"
* meta.lastUpdated = "2025-11-06T23:47:00+01:00"
* identifier[PhoneNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].value = "08045678901"
* identifier[PhoneNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.code = #MOBILE
* identifier[PhoneNumber].type.coding.display = "mobile"
* name.given[0] = "Chika"
* name.family = "Okafor"
* gender = #male
* birthDate = "1985-06-15"
* active = true
* address.line[0] = "Industrial Area"
* address.city = "Port Harcourt"
* address.district = "ri-emohua"
* address.state = "RI"


// -------------------- Organization: Port Harcourt Hospital --------------------
Instance: Organization-PortHarcourt-Hospital
InstanceOf: NgProviderOrganization
Usage: #example
Title: "Service Hospital"
Description: "Port Harcourt Emergency Hospital."
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier.value = "HCF-RI-0045"
* active = true
* name = "Port Harcourt Emergency Hospital"
* type.coding.system = "http://terminology.hl7.org/CodeSystem/organization-type"
* type.coding.code = #prov
* type.coding.display = "Healthcare Provider"
* telecom[0].system = #phone
* telecom[0].value = "084-234-5678"
* address.line[0] = "Emergency Services Wing"
* address.city = "Port Harcourt"
* address.district = "ri-emohua"
* address.state = "RI"
* extension[NGOrganizationOwner].valueCodeableConcept.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-location-owner-cs"
* extension[NGOrganizationOwner].valueCodeableConcept.coding.code = #faith-based

// -------------------- Organization: Truth HMO --------------------
Instance: Organization-Truth-HMO
InstanceOf: NgInsurerOrganization
Usage: #example
Title: "Truth HMO"
Description: "Truth Health Management Organization."
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier.value = "HMO-TRUTH-2025"
* active = true
* name = "Truth Health Maintenance Organization"
* alias[0] = "Truth HMO"
* type.coding.system = "http://terminology.hl7.org/CodeSystem/organization-type"
* type.coding.code = #ins
* type.coding.display = "Insurance Company"
* telecom[0].system = #phone
* telecom[0].value = "0700-TRUTH-HMO"
* telecom[1].system = #url
* telecom[1].value = "https://truth-hmo.ng"
* address.line[0] = "HMO Plaza"
* address.city = "Port Harcourt"
* address.district = "ri-emohua"
* address.state = "RI"
