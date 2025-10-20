// ====================================================================
// Profile: NgClientRegistrationBundle
// ====================================================================
Profile: NgClientRegistrationBundle
Parent: Bundle
Id: ng-client-registration-bundle
Title: "3-NG Immunization Client Registration Bundle"
Description: "A simple collection Bundle for registering an immunization client. Requires exactly one NgPatient and optionally includes the registering NgOrganization. Designed for low-QA use in DHIN 2025 Connectathon."

// Bundle basics
* type 1..1 MS
* type = #collection (exactly)
* entry 1..* MS
* entry.fullUrl 1..1 MS
* entry.resource 1..1 MS

// Slice entries by the profile of the inlined resource
* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #open

// Required & optional slices
* entry contains
    patient 1..1 MS and
    organization 0..1 MS

// Patient slice (required)
* entry[patient].resource only NgPatient
* entry[patient].fullUrl ^short = "Prefer URN UUID for intra-bundle references"

// Organization slice (optional: registering facility)
* entry[organization].resource only NgOrganization
* entry[organization].fullUrl ^short = "Prefer URN UUID for intra-bundle references"

// --------------------
// Invariants (soft; keep QA low)
// --------------------
Invariant: ngcr-uuid-fullurl
Description: "Entries SHOULD use URN UUID fullUrls for local intra-bundle references."
Severity: #warning
Expression: "entry.fullUrl.all(matches('^urn:uuid:'))"

Invariant: ngcr-patient-managing-org-local
Description: "If Patient.managingOrganization is present, it SHOULD reference an Organization in the same Bundle via a URN UUID."
Severity: #warning
Expression: "entry.resource.ofType(Patient).managingOrganization.reference.exists() implies entry.resource.ofType(Patient).managingOrganization.reference.all(matches('^urn:uuid:'))"


// ====================================================================
// Example: bundle-client-registration
// A very simple registration package with one Patient and one Organization
// ====================================================================
Instance: bundle-client-registration
InstanceOf: NgClientRegistrationBundle
Usage: #example
Title: "Client Registration Bundle (Immunization)"
Description: "Simple collection bundle registering a child for immunization at a PHC."
* type = #collection

// --- Entries ---
* entry[0].fullUrl = "urn:uuid:pat-cr-001"
* entry[0].resource = NgPatient-CR-Client-001

* entry[+].fullUrl = "urn:uuid:org-phc-001"
* entry[=].resource = NgOrganization-CR-PHC-001


// ====================================================================
// Inline Instance: Patient (NgPatient)
// Meets minimal constraints (identifier, meta.lastUpdated, name, gender)
// ====================================================================
Instance: NgPatient-CR-Client-001
InstanceOf: NgPatient
Usage: #inline
Title: "Immunization Client (Child)"
Description: "Child registered for RI; includes caregiver contact."
* meta.lastUpdated = "2025-10-02T09:10:00+01:00"
* identifier[PhoneNumber].value = "08031234567"
* identifier[PhoneNumber].system = "http://mtnonline.com/phone-no"
* identifier[PhoneNumber].type.coding[0].system = "http://mtnonline.com/phone-no"
* identifier[PhoneNumber].type.coding[0].code = #MOBILE
* identifier[PhoneNumber].type.coding[0].display = "Primary Mobile Phone Number of the Client or CareGiver"
* name.given[0] = "Chidi"
* name.family = "Adeyemi"
* gender = #male
* active = true
* birthDate = "2024-02-15"
* address.line[0] = "No. 4 Market Street"
* address.city = "Ikeja"
* address.district = "ikeja"
* address.state = "LA"
* managingOrganization = Reference(urn:uuid:org-phc-001)
// Caregiver contact (optional, kept minimal)
* contact[0].name.given[0] = "Amaka"
* contact[0].name.family = "Adeyemi"
* contact[0].telecom[0].system = #phone
* contact[0].telecom[0].value = "08090001122"
* contact[0].relationship.text = "MOTHER"
* contact[0].address.line[0] = "No. 4 Market Street"
* contact[0].address.city = "Ikeja"
* contact[0].address.district = "ikeja"
* contact[0].address.state = "LA"


// ====================================================================
// Inline Instance: Organization (NgOrganization)
// Minimal active PHC with type and address
// ====================================================================
Instance: NgOrganization-CR-PHC-001
InstanceOf: NgOrganization
Usage: #inline
Title: "Olowo PHC (Registering Facility)"
Description: "Primary Health Centre where the client is registered."
* identifier[0].system = "https://hfr.health.gov.ng/facility-id"
* identifier[0].value = "HCF-556677"
* active = true
* name = "Olowo Primary Health Centre"
* type.coding[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type.coding[0].code = #phc-center-l2
* type.coding[0].display = "PHC Center Level 2"
* address.line[0] = "PHC Crescent, Ward B"
* address.city = "Ikeja"
* address.district = "ikeja"
* address.state = "LA"
