// ======================================================================
// Profile: NgConsent
// ======================================================================
Profile: NgConsent
Parent: Consent
Id: ng-consent
Title: "NG Consent"
Description: "Minimal consent profile for Nigerian implementations (e.g., NDPR / NIS ISO/TR 17975 use). Keeps constraints light to reduce QA noise."

* ^status = #active
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-consent"

// Core must-haves
* status 1..1 MS
* scope 1..1 MS
* category 1..* MS
* patient 1..1 MS
* dateTime 0..1
* performer 0..*      // e.g., provider org or practitioner collecting consent
* organization 0..*   // custodian or responsible org
* policyRule 0..1
* source[x] 0..1

// Provision basics
* provision 1..1 MS
* provision.type 1..1               // #permit | #deny
* provision.period 0..1
* provision.purpose 0..*            // v3-ActReason (e.g., TREAT, HPAY)

// Value set hints (no hard bindings here to keep QA low)
//* scope from http://hl7.org/fhir/ValueSet/consent-scope (preferred)
//* category from http://terminology.hl7.org/ValueSet/consent-category (preferred)

// ----------------------------------------------------------------------
// Example: NgConsent-001 (with inline Patient + Organization)
// ----------------------------------------------------------------------
Instance: NgConsent-001
InstanceOf: NgConsent
Usage: #example
Title: "Consent for Care and Billing (Patient-Privacy)"
Description: "Patient permits use/disclosure for treatment and payment for one year; captured and held by the provider organization."
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/consentcategorycodes"
* category[0].coding[0].code = #emrgonly
* category[0].coding[0].display = "Emergency Only Disclosure"
* patient = Reference(NgPatient-Consent-001)
* dateTime = "2025-10-21T10:00:00+01:00"
//* performer[0] = Reference(NgOrganization-Consent-Org-001)
//* organization[0] = Reference(NgOrganization-Consent-Org-001)
* policyRule.text = "NIS ISO/TR 17975:2019 (Consent); aligned with NDPR."
* sourceAttachment.title = "Signed consent form (scanned PDF)"
* sourceAttachment.contentType = #application/pdf
* sourceAttachment.url = "https://example.org/consents/PR-2025-10-21.pdf"

// Provision (permit TREAT and HPAY within period)
* provision.type = #permit
* provision.period.start = "2025-10-21"
* provision.period.end   = "2026-10-20"
//* provision.purpose[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/v3-ActReason"
//* provision.purpose[0].coding[0].code   = #TREAT
//* provision.purpose[1].coding[0].system = "http://terminology.hl7.org/CodeSystem/v3-ActReason"
//* provision.purpose[1].coding[0].code   = #HPAY


// -------------------- Inline Support: NgPatient (minimal) --------------------
Instance: NgPatient-Consent-001
InstanceOf: NgPatient
Usage: #example
Title: "Consent Patient (Minimal)"
Description: "Nigeria 2025 Connectathon Consent Patient Profile"
* meta.lastUpdated = "2025-10-21T09:59:00+01:00"
* identifier[PhoneNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.code = #MOBILE
* identifier[PhoneNumber].value = "08070001234"
* active = true
* name.family = "Okon"
* name.given[0] = "Eko"
* gender = #female
* birthDate = "1992-06-18"
* address.city = "Uyo"
* address.district = "ak-uyo"
* address.state = "AK"


// -------------------- Inline Support: NgOrganization (minimal) --------------
Instance: NgOrganization-Consent-Org-001
InstanceOf: NgOrganization
Usage: #inline
Title: "Sunrise Family Clinic (Custodian)"
Description: "Nigeria 2025 Connectathon Consent Organization Profile"
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier.value = "HCF-12347"
* active = true
* name = "Sunrise Family Clinic"
* type.coding.system = "http://terminology.hl7.org/CodeSystem/organization-type"
* type.coding.code = #prov
* type.coding.display = "Healthcare Provider"
* telecom[0].system = #phone
* telecom[0].value = "0810-222-3333"
* address.line[0] = "12 Clinic Road"
* address.city = "Uyo"
* address.district = "ak-uyo"
* address.state = "AK"
