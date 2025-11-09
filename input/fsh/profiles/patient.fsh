Profile: NgPatient
Parent: Patient
Title: "NG Patient"
Description: "Nigeria 2025 Connectathon Patient Profile"


* meta.lastUpdated 1..1 MS
* meta.lastUpdated ^short = "The date and time when the client record was created or last updated."
* identifier 1..* MS
* identifier ^short = "The identifier set given to a Client at different points (can be the National ID, the Hospital specific MRN, Connectathon number, or even phone number)"

// STEP 1: Declare the slice
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "type.coding.code"
* identifier ^slicing.rules = #open
* identifier ^slicing.ordered = false

// STEP 2: Declare the slice
* identifier contains 
    NationalIDNo 0..1 MS and 
    MedicalRecordsNumber 0..1 MS and  
    BirthCertificateNo 0..1 MS and 
    PhoneNumber 0..1 MS and
    InsuranceNumber 0..1 MS and
    Pseudonym 0..1 MS

// STEP 3: Add constraints to the slice
* identifier[NationalIDNo].value 1..1
* identifier[NationalIDNo].value ^short = "The NIN number of the client which is a unique 11 digit number"
* identifier[NationalIDNo].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[NationalIDNo].system ^short = "NIMC's identifier in the system autheticated to https://nimc.org/nin"
* identifier[NationalIDNo].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[NationalIDNo].type.coding.code = #NIN
* identifier[NationalIDNo].type.coding.display = "National Identity Number of Client or Caregiver"


// A small CodeSystem for identifier types (you can reference your own canonical)
* identifier[MedicalRecordsNumber].value 1..1
* identifier[MedicalRecordsNumber].value ^short = "The specific medical number value given the client at a health institution"
* identifier[MedicalRecordsNumber].system 0..1
* identifier[MedicalRecordsNumber].system ^short = "The institution issuing the MRN number (e.g., Asokoro Hospital) validated at http://asokoro.org/medicalrecord-no"
* identifier[MedicalRecordsNumber].system ^definition = "The URI system that identifies the assigning authority for the medical record number."
* identifier[MedicalRecordsNumber].system ^example[0].label = "Example MRN system"
* identifier[MedicalRecordsNumber].system ^example[0].valueUri = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[MedicalRecordsNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[MedicalRecordsNumber].type.coding.code = #MRN
* identifier[MedicalRecordsNumber].type.coding.display = "Medical Record Number"

* identifier[BirthCertificateNo].value 1..1
* identifier[BirthCertificateNo].value ^short = "The client's birth certificate number"
* identifier[BirthCertificateNo].system 0..1
* identifier[BirthCertificateNo].system ^short = "The institution generating the birth certificate number (e.g., NPC)"
* identifier[BirthCertificateNo].system ^definition = "The URI system identifying the authority that assigns the birth certificate number validated at http://npc.gov.ng/birthCertificate-no."
* identifier[BirthCertificateNo].system ^example[0].label = "Example Birth Certificate number system"
* identifier[BirthCertificateNo].system ^example[0].valueUri = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[BirthCertificateNo].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[BirthCertificateNo].type.coding.code = #BIRTHCERT
* identifier[BirthCertificateNo].type.coding.display = "Birth Certificate Number"


* identifier[PhoneNumber].value 1..1
* identifier[PhoneNumber].value ^short = "Client's phone number which is 11 digits"
* identifier[PhoneNumber].system 0..1
* identifier[PhoneNumber].system ^short = "The provider of the phone number (e.g., MTN)"
* identifier[PhoneNumber].system ^definition = "The URI system identifying the provider of the phone number validated at http://mtnonline.com/phone-no."
* identifier[PhoneNumber].system ^example[0].label = "Example Phone Number system"
* identifier[PhoneNumber].system ^example[0].valueUri = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.code = #MOBILE
* identifier[PhoneNumber].type.coding.display = "mobile"


* identifier[InsuranceNumber].value 1..1
* identifier[InsuranceNumber].value ^short = "The actual insurance number generated at state, national or HMO authorities"
* identifier[InsuranceNumber].system 0..1
* identifier[InsuranceNumber].system ^short = "The generating institution e.g., State, NHIA, or HMO"
* identifier[InsuranceNumber].system ^definition = "The URI system identifying the provider of the insurance number validated at http://nhia.gov.ng/insurance-no."
* identifier[InsuranceNumber].system ^example[0].label = "Example Insurance system"
* identifier[InsuranceNumber].system ^example[0].valueUri = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[InsuranceNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[InsuranceNumber].type.coding.code = #INSUR
* identifier[InsuranceNumber].type.coding.display = "The Insurance or HMO number of the client"



* identifier[Pseudonym].value 1..1
* identifier[Pseudonym].value ^short = "The actual one-way phsedonymized Patient number generated at state or national authorities"
* identifier[Pseudonym].system 0..1
* identifier[Pseudonym].system ^short = "The generating institution e.g., NIMC"
* identifier[Pseudonym].system ^definition = "The URI system identifying the provider of the pseudo number."
* identifier[Pseudonym].system ^example[0].label = "Pseudonymized Patient Identifier system"
* identifier[Pseudonym].system ^example[0].valueUri = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[Pseudonym].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[Pseudonym].type.coding.code = #PSEUDONYM
* identifier[Pseudonym].type.coding.display = "Pseudonymized Identifier"


// OTHER Demographics


* name 1..1 MS
* name.given 1..* 
* name.given ^short = "The other names of the client like the Firstname and Middle names if applicable"
* name.family 1..1
* name.family ^short = "The surname or family name of the client"
* gender from NGGenderVS (required)
* gender ^short = "The sex of the client"
* active 0..1 
* active ^short = "Whether this client's record is in active use"
* birthDate 0..1 MS
* birthDate ^short = "The date of birth of the client in the form dd-mm-yyy"
* active 0..1
* active ^short = "Indicates whether this client's record is in active use or not"
* address 0..* MS
* address.line 0..1 
* address.line ^short = "The house number, street, and name where the client lives"
* address.city 0..1  
* address.city ^short = "The city, village, town or settlement where the client lives"
* address.district from NGLGAsVS (required)
* address.district ^short = "The FHIR name is district, used as Nigeria LGA in this profile"
* address.state from NGStatesVS (required)
* address.state ^short = "The name of the state where the client resides in Nigeria"
* contact 0..* MS
* contact ^short = "The contact information of the client's primary Caregiver, can be a Parent or Guardian"
* contact.name.given 0..* 
* contact.name.given ^short = "The first name of the client's primary Caregiver, can be a Parent or Guardian"
* contact.name.family 0..1 
* contact.name.family ^short = "The surname (family) name of the client's primary Caregiver, can be a Parent or Guardian"
* contact.telecom 0..* MS
* contact.telecom.system 0..1 
* contact.telecom.system ^short = "The primary means to contact the client's primary Caregiver or Guardian"
* contact.telecom.value 0..1 
* contact.telecom.value ^short = "The primary phone/email of the client's primary Caregiver or Guardian"
* contact.relationship.text from NGRelationshipsVS (extensible)
* contact.relationship.text ^short = "The relationship of the client with the primary Caregiver or Guardian (eg. Parent)"
* contact.address.line 0..1 MS
* contact.address.line ^short = "The line address of the client's primary Caregiver or Guardian"
* contact.address.city 0..1
* contact.address.city ^short = "The city, town or settlement where the client's primary Caregiver or Guardian lives"
* contact.address.district from NGLGAsVS (required)
* contact.address.district ^short = "The LGA where the client's primary Caregiver or Guardian lives"
* contact.address.state from NGStatesVS (required)
* contact.address.state ^short = "The State in Nigeria where the client's primary Caregiver or Guardian lives"


* link 0..1
* link.other ^short = "This link provides reference to the client's related persons"
* link.other only Reference(NgRelatedPerson)
* link.type ^short = "The type of Link (eg. reference) client's related persons"
* link.type 1..1



// Include the extensions
* address.extension contains NGAdministrativeWard named administrativeWard 0..1 MS
* contact.address.extension contains NGAdministrativeWard named administrativeWard 0..1 MS


* name.use 0..0 
* identifier.use 0..0
* address.use 0..0
* contact.name.use 0..0
* contact.telecom.use 0..0
* contact.address.use 0..0
* implicitRules 0..0
* modifierExtension 0..0
* contact.modifierExtension 0..0
* link.modifierExtension 0..0




// Examples


// ==============================================
// NgPatient-001 — MNCH Referral (pregnant client)
// ==============================================
Instance: NgPatient-001
InstanceOf: NgPatient
Usage: #example
Title: "Example Ng Patient (MNCH Referral)"
Description: "Adult female referred for ANC; Lagos State, Ikeja LGA."
* meta.lastUpdated = 2025-11-04T08:30:00Z
// Identifiers (sliced)
* identifier[NationalIDNo].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[NationalIDNo].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[NationalIDNo].type.coding.code = #NIN
* identifier[NationalIDNo].value = "23456789012"
* identifier[MedicalRecordsNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[MedicalRecordsNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[MedicalRecordsNumber].type.coding.code = #MRN
* identifier[MedicalRecordsNumber].value = "ASO-2025-0098"
* identifier[PhoneNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.code = #MOBILE
* identifier[PhoneNumber].value = "08051234567"
// Demographics
* active = true
* name.family = "Adebayo"
* name.given[0] = "Kemi"
* gender = #female
* birthDate = 1995-02-14
* address[0].line = "15 Ajayi Street"
* address[0].city = "Ikeja"
* address[0].district = "la-ikeja" 
* address[0].state = "LA"
// Caregiver contact
* contact[0].name.family = "Adebayo"
* contact[0].name.given[0] = "Funke"
* contact[0].telecom[0].system = #phone
* contact[0].telecom[0].value = "+2348059988776"
* contact[0].relationship.text = "Mother"
* contact[0].address.city = "Ikeja"
* contact[0].address.district = "la-ikeja"
* contact[0].address.state = "LA"


// ==============================================
// NgPatient-002 — ePharmacy & Claims (insured)
// ==============================================
Instance: NgPatient-002
InstanceOf: NgPatient
Usage: #example
Title: "Example Ng Patient (ePharmacy & Claims)"
Description: "Adult male on chronic meds; insured with NHIA; Kano Municipal LGA."
* meta.lastUpdated = 2025-11-04T09:10:00Z
// Identifiers (sliced)
* identifier[NationalIDNo].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[NationalIDNo].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[NationalIDNo].type.coding.code = #NIN
* identifier[NationalIDNo].value = "12345678901"
* identifier[MedicalRecordsNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[MedicalRecordsNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[MedicalRecordsNumber].type.coding.code = #MRN
* identifier[MedicalRecordsNumber].value = "KNH-2025-33445"
* identifier[InsuranceNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[InsuranceNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[InsuranceNumber].type.coding.code = #INSUR
* identifier[InsuranceNumber].value = "NHIA-0011223344"
* identifier[PhoneNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.code = #MOBILE
* identifier[PhoneNumber].value = "08031234567"
// Demographics
* active = true
* name.family = "Abdullahi"
* name.given[0] = "Musa"
* gender = #male
* birthDate = 1987-07-06
* address[0].line = "No. 8 Lafia Road"
* address[0].city = "Kano"
* address[0].district = "kn-kano-municipal"
* address[0].state = "KN"
// Contact
* contact[0].name.family = "Abdullahi"
* contact[0].name.given[0] = "Zainab"
* contact[0].telecom[0].system = #phone
* contact[0].telecom[0].value = "+2348031112233"
* contact[0].relationship.text = "Sister"
* contact[0].address.city = "Kano"
* contact[0].address.district = "kn-kano-municipal"
* contact[0].address.state = "KN"


// ==============================================
// NgPatient-003 — Childhood Immunization (under-5)
// ==============================================
Instance: NgPatient-003
InstanceOf: NgPatient
Usage: #example
Title: "Example Ng Patient (Immunization)"
Description: "Male child presenting for routine vaccination; FCT AMAC."
* meta.lastUpdated = 2025-11-04T11:45:00Z
// Identifiers (sliced)
* identifier[BirthCertificateNo].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[BirthCertificateNo].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[BirthCertificateNo].type.coding.code = #BIRTHCERT
* identifier[BirthCertificateNo].value = "NPC-FCT-2019-004321"
* identifier[PhoneNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.code = #MOBILE
* identifier[PhoneNumber].value = "08123456789"
// Demographics
* active = true
* name.family = "Bala"
* name.given[0] = "Suleiman"
* gender = #male
* birthDate = 2019-09-05
* address[0].line = "Plot 7, Mabushi"
* address[0].city = "Abuja"
* address[0].district = "fc-municipal"
* address[0].state = "FC"
// Caregiver contact
* contact[0].name.family = "Bala"
* contact[0].name.given[0] = "Aisha"
* contact[0].telecom[0].system = #phone
* contact[0].telecom[0].value = "+2348122223344"
* contact[0].relationship.text = "Mother"
* contact[0].address.city = "Abuja"
* contact[0].address.district = "fc-municipal"
* contact[0].address.state = "FC"





// ======================================================================
// ISO 25237 – Pseudonymized Patient (NgPatient)
// Approach applied:
// 1) Direct identifiers (NIN, MRN, phone) removed and replaced with a
//    single stable pseudonym (re-linkable under governance, not reversible
//    without a key held outside the dataset).
// 2) Names replaced with neutral alias; no real-world name retained.
// 3) Address generalized (state-level only) to reduce re-identification risk.
// 4) Birth date coarsened to first day of month (policy example); keep year.
// 5) All caregiver contacts removed.
// ======================================================================

Instance: NgPatient-001-Pseudo
InstanceOf: NgPatient
Usage: #example
Title: "Pseudonymized Ng Patient (MNCH Referral)"
Description: "NIS ISO/TR 25237-compliant pseudonymized equivalent of NgPatient-001. Direct identifiers removed; stable pseudonym retained for controlled re-linkage."
* meta.lastUpdated = 2025-11-04T08:30:00Z

// --- Single replacement identifier (stable pseudonym) ---
* identifier[Pseudonym].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[Pseudonym].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[Pseudonym].type.coding.code = #PSEUDONYM
* identifier[Pseudonym].type.coding.display = "Pseudonymized Identifier"
* identifier[Pseudonym].value = "PSN-8A7F-2C19-KE95"   // example token; linkage managed off-platform

// --- Minimal demographics retained ---
* active = true
* gender = #female
// Coarsened DoB (policy choice): original 1995-02-14 → 1995-02-01
* birthDate = 1995-02-01

// Neutral alias (no real name)
* name.family = "Client"
* name.given[0] = "Female-01"

// Address generalized (remove street & city; keep state only)
* address[0].state = "LA"
