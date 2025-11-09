
Profile: NgPractitioner
Parent: Practitioner
Title: "NG Practitioner"
Description: "Profile for a Nigerian Practitioner" 
* identifier 0..* MS
* identifier.system 1..1
* identifier.system ^short = "The namespace for the identifier value e.g a MDCN URL"
* identifier.value 1..1
* identifier.value ^short = "The value that is unique from the identity provider"
* active 0..1
* active ^short = "A boolean indicating that this practitioner is active"
* name MS
* name.given 1..1
* name.given ^short = "The first name of the practitioner e.g. of the Routine Immunization officer"
* name.family 1..1
* name.given ^short = "The surname of the practitioner e.g. of the Routine Immunization officer"
* telecom 0..* MS
* telecom.system 1..1 
* telecom.system ^short = "The preferred communication medium e.g. email | mobile"
* telecom.value 1..1 
* telecom.system ^short = "The contact communication information e.g. nkiru@test.com | 08092299999"
* birthDate MS 
* birthDate ^short = "The date of birth of the healthcare professional"
* qualification.issuer only Reference(NgOrganization)
* qualification.issuer ^short = "The regulating organization that issue the qualification"
* qualification.period 0..1
* qualification.period ^short = "The time duration this qualification is valid"
* qualification.code.text 0..1
* qualification.code.text ^short = "The public certificate number"


// Hide dataelements

* name.use 0..0 



// EXAMPLES 

// ==============================================
// NgPractitioner-001 — MNCH Referral (Obstetrician)
// ==============================================
Instance: NgPractitioner-001
InstanceOf: NgPractitioner
Usage: #example
Title: "Example Ng Practitioner (MNCH)"
Description: "Obstetrician supporting ANC referrals."
* active = true
* identifier[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-mdcn"
* identifier[0].value = #MDCN-45231
* name.family = "Adebayo"
* name.given = "Kehinde"
* telecom[0].system = #phone
* telecom[0].value = "+2348030001122"
* telecom[1].system = #email
* telecom[1].value = "kehinde.adebayo@example.org"
* birthDate = 1982-01-15
* qualification[0].code.text = "Obstetrics & Gynaecology"
* qualification[0].period.start = 2016-01-01


// ==============================================
// NgPractitioner-002 — ePharmacy & Claims (Pharmacist)
// ==============================================
Instance: NgPractitioner-002
InstanceOf: NgPractitioner
Usage: #example
Title: "Example Ng Practitioner (ePharmacy & Claims)"
Description: "Pharmacist dispensing and submitting claims."
* active = true
* identifier[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-pcn"
* identifier[0].value = #PCN-45231
* name.family = "Okeke"
* name.given = "Nkiru"
* telecom[0].system = #phone
* telecom[0].value = "+2348057788990"
* telecom[1].system = #email
* telecom[1].value = "nkiru.okeke@pharm.example.ng"
* birthDate = 1990-06-24
* qualification[0].code.text = "Registered Pharmacist"
* qualification[0].period.start = 2018-07-01


// ==============================================
// NgPractitioner-003 — Medical Devices (CHEW / device operator)
// ==============================================
Instance: NgPractitioner-003
InstanceOf: NgPractitioner
Usage: #example
Title: "Example Ng Practitioner (Medical Devices)"
Description: "CHEW operating connected vitals devices."
* active = true
* identifier[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-mdcn"
* identifier[0].value = #CHEW-12347
* name.family = "Garba"
* name.given = "Hauwa"
* telecom[0].system = #phone
* telecom[0].value = "+2348123456677"
* telecom[1].system = #email
* telecom[1].value = "hauwa.garba@example.org"
* birthDate = 1995-11-09
* qualification[0].code.text = "Community Health Extension Worker"
* qualification[0].period.start = 2020-03-01


// ======================================================================
// NIS ISO/TR 25237 – Pseudonymized Practitioner (NgPractitioner)
// Applied controls:
// 1) Removed direct identifiers (MDCN #, phone, email, legal name).
// 2) Introduced a stable pseudonym identifier for re-linkage under governance.
// 3) Coarsened birthDate to first day of month (policy choice).
// 4) Kept non-direct info (qualification, validity period).
// ======================================================================

Instance: NgPractitioner-001-Pseudo
InstanceOf: NgPractitioner
Usage: #example
Title: "Pseudonymized Ng Practitioner (MNCH)"
Description: "ISO 25237-compliant pseudonymization of NgPractitioner-001; direct identifiers suppressed, linkage via controlled pseudonym."

* active = true

// Required identifier replaced with pseudonym token
* identifier[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-mdcn"
* identifier[0].value  = "PRSN-9C4E-7B12-OB01"

// Neutral alias (profile requires given & family)
* name.family = "Clinician"
* name.given  = "Alias-01"

// Contact points removed entirely to avoid direct contact identifiers

// Coarsened DoB (original 1982-01-15 → 1982-01-01)
* birthDate = 1982-01-01

// Non-identifying professional info retained
* qualification[0].code.text = "Obstetrics & Gynaecology"
* qualification[0].period.start = 2016-01-01
