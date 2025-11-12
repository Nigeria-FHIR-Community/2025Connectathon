// ======================================================================
// Instance: DHIN Sandbox Server Capability Statement
// ======================================================================
Instance: DHINSandboxCapabilityStatement
InstanceOf: CapabilityStatement
Usage: #definition
Title: "DHIN Sandbox Server Capability Statement"
Description: """
Capability statement for the DHIN (Digital Health Interoperability Network) Sandbox FHIR Server.
This server supports the Nigeria FHIR Implementation Guide profiles and is used for 
Connectathon testing and development purposes.

**Base URL**: https://sandbox.dhin-hie.org

**FHIR Version**: R4 (4.0.1)

**Supported Formats**: JSON, XML

This capability statement describes the resources, operations, and search parameters 
supported by the DHIN Sandbox Server for the 2025 Connectathon tracks:
1. Claims & Insurance (Eligibility, Pre-Authorization, Billing)
2. ePharmacy (Prescription & Dispense)
3. MNCH Referral
4. Immunization (AEFI & Scheduling)
5. Medical Devices (Wearable & Lab Data)
6. MDCN Registry (Practitioner Verification)
7. PCN Registry (Pharmacy Verification)
8. Standards Adoption (Consent & Pseudonymization)
9. Privacy Use Case
"""

* id = "dhin-sandbox-capability-statement"
// Use a stable canonical for this CapabilityStatement (NOT the /metadata endpoint)
* url = "https://sandbox.dhin-hie.org/ig/CapabilityStatement/dhin-sandbox-capability-statement"
* version = "0.2.0"
* name = "DHINSandboxCapabilityStatement"
* status = #active
* experimental = false
* date = "2025-11-12"
* publisher = "Digital Health Interoperability Network (DHIN)"
* contact[0].name = "DHIN Technical Team"
* contact[0].telecom[0].system = #email
* contact[0].telecom[0].value = "info@dhin-hie.org"
* contact[0].telecom[1].system = #url
* contact[0].telecom[1].value = "https://dhin-hie.org"

* kind = #instance
* implementation.description = "DHIN Sandbox FHIR Server for Connectathon 2025"
* implementation.url = "https://sandbox.dhin-hie.org"

* fhirVersion = #4.0.1
* format[0] = #json
* format[1] = #xml
* patchFormat[0] = #application/json-patch+json
* patchFormat[1] = #application/xml-patch+xml

* implementationGuide[0] = "https://sandbox.dhin-hie.org/ig"

// -------------------- REST Configuration --------------------
* rest[0].mode = #server
* rest[0].documentation = "DHIN Sandbox Server supporting Nigeria FHIR IG profiles for Connectathon 2025"

// Security
* rest[0].security.cors = true
* rest[0].security.description = """
OAuth 2.0 and SMART-on-FHIR authentication may be required for protected endpoints.
Sandbox environment can use relaxed authentication for testing purposes.
All data transmission uses HTTPS/TLS 1.2+.
"""
* rest[0].security.service[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/restful-security-service"
* rest[0].security.service[0].coding[0].code = #OAuth
* rest[0].security.service[0].coding[0].display = "OAuth"
* rest[0].security.service[1].coding[0].system = "http://terminology.hl7.org/CodeSystem/restful-security-service"
* rest[0].security.service[1].coding[0].code = #SMART-on-FHIR
* rest[0].security.service[1].coding[0].display = "SMART-on-FHIR"

// -------------------- Patient Resource --------------------
* rest[0].resource[0].type = #Patient
* rest[0].resource[0].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-patient"
* rest[0].resource[0].documentation = """
Patient resource conforming to NgPatient profile.
Supports all Connectathon tracks requiring patient demographics.
"""
* rest[0].resource[0].interaction[0].code = #read
* rest[0].resource[0].interaction[1].code = #create
* rest[0].resource[0].interaction[2].code = #update
* rest[0].resource[0].interaction[3].code = #delete
* rest[0].resource[0].interaction[4].code = #search-type
* rest[0].resource[0].versioning = #versioned
* rest[0].resource[0].readHistory = true
* rest[0].resource[0].updateCreate = true
* rest[0].resource[0].conditionalCreate = true
* rest[0].resource[0].conditionalUpdate = true
* rest[0].resource[0].conditionalDelete = #single

* rest[0].resource[0].searchParam[0].name = "identifier"
* rest[0].resource[0].searchParam[0].type = #token
* rest[0].resource[0].searchParam[0].documentation = "Search by patient identifier (phone, NIN, etc.)"
* rest[0].resource[0].searchParam[1].name = "name"
* rest[0].resource[0].searchParam[1].type = #string
* rest[0].resource[0].searchParam[1].documentation = "Search by patient name (family or given)"
* rest[0].resource[0].searchParam[2].name = "birthdate"
* rest[0].resource[0].searchParam[2].type = #date
* rest[0].resource[0].searchParam[2].documentation = "Search by date of birth"
* rest[0].resource[0].searchParam[3].name = "gender"
* rest[0].resource[0].searchParam[3].type = #token
* rest[0].resource[0].searchParam[3].documentation = "Search by gender"
* rest[0].resource[0].searchParam[4].name = "address-state"
* rest[0].resource[0].searchParam[4].type = #string
* rest[0].resource[0].searchParam[4].documentation = "Search by state code"

// -------------------- Practitioner Resource --------------------
* rest[0].resource[1].type = #Practitioner
* rest[0].resource[1].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-practitioner"
* rest[0].resource[1].documentation = """
Practitioner resource conforming to NgPractitioner profile.
Supports MDCN registry verification (Track 6).
"""
* rest[0].resource[1].interaction[0].code = #read
* rest[0].resource[1].interaction[1].code = #create
* rest[0].resource[1].interaction[2].code = #update
* rest[0].resource[1].interaction[3].code = #search-type
* rest[0].resource[1].versioning = #versioned
* rest[0].resource[1].readHistory = true
* rest[0].resource[1].updateCreate = true
* rest[0].resource[1].conditionalCreate = true
* rest[0].resource[1].conditionalUpdate = true

* rest[0].resource[1].searchParam[0].name = "identifier"
* rest[0].resource[1].searchParam[0].type = #token
* rest[0].resource[1].searchParam[0].documentation = "Search by MDCN number or other identifier"
* rest[0].resource[1].searchParam[1].name = "name"
* rest[0].resource[1].searchParam[1].type = #string
* rest[0].resource[1].searchParam[1].documentation = "Search by practitioner name"
* rest[0].resource[1].searchParam[2].name = "active"
* rest[0].resource[1].searchParam[2].type = #token
* rest[0].resource[1].searchParam[2].documentation = "Search by active status"

// -------------------- Organization Resource --------------------
* rest[0].resource[2].type = #Organization
* rest[0].resource[2].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-organization"
* rest[0].resource[2].supportedProfile[0] = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-provider-organization"
* rest[0].resource[2].supportedProfile[1] = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-insurer-organization"
* rest[0].resource[2].supportedProfile[2] = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-pharmacy-organization"
* rest[0].resource[2].documentation = """
Organization resource with specialized profiles for providers, insurers, and pharmacies.
Supports Claims (Track 1), ePharmacy (Track 2), and PCN Registry (Track 7).
"""
* rest[0].resource[2].interaction[0].code = #read
* rest[0].resource[2].interaction[1].code = #create
* rest[0].resource[2].interaction[2].code = #update
* rest[0].resource[2].interaction[3].code = #search-type
* rest[0].resource[2].versioning = #versioned
* rest[0].resource[2].readHistory = true
* rest[0].resource[2].updateCreate = true
* rest[0].resource[2].conditionalCreate = true
* rest[0].resource[2].conditionalUpdate = true

* rest[0].resource[2].searchParam[0].name = "identifier"
* rest[0].resource[2].searchParam[0].type = #token
* rest[0].resource[2].searchParam[0].documentation = "Search by facility registry ID, PCN number, etc."
* rest[0].resource[2].searchParam[1].name = "name"
* rest[0].resource[2].searchParam[1].type = #string
* rest[0].resource[2].searchParam[1].documentation = "Search by organization name"
* rest[0].resource[2].searchParam[2].name = "type"
* rest[0].resource[2].searchParam[2].type = #token
* rest[0].resource[2].searchParam[2].documentation = "Search by organization type (prov, pay, pharm)"
* rest[0].resource[2].searchParam[3].name = "address-state"
* rest[0].resource[2].searchParam[3].type = #string
* rest[0].resource[2].searchParam[3].documentation = "Search by state code"
* rest[0].resource[2].searchParam[4].name = "active"
* rest[0].resource[2].searchParam[4].type = #token
* rest[0].resource[2].searchParam[4].documentation = "Search by active status"

// -------------------- Coverage Resource --------------------
* rest[0].resource[3].type = #Coverage
* rest[0].resource[3].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-coverage"
* rest[0].resource[3].documentation = """
Coverage resource for insurance/HMO policies.
Supports Claims & Insurance track (Track 1).
"""
* rest[0].resource[3].interaction[0].code = #read
* rest[0].resource[3].interaction[1].code = #create
* rest[0].resource[3].interaction[2].code = #update
* rest[0].resource[3].interaction[3].code = #search-type
* rest[0].resource[3].versioning = #versioned
* rest[0].resource[3].updateCreate = true

* rest[0].resource[3].searchParam[0].name = "beneficiary"
* rest[0].resource[3].searchParam[0].type = #reference
* rest[0].resource[3].searchParam[0].documentation = "Search by patient reference"
* rest[0].resource[3].searchParam[1].name = "payor"
* rest[0].resource[3].searchParam[1].type = #reference
* rest[0].resource[3].searchParam[1].documentation = "Search by insurance organization"
* rest[0].resource[3].searchParam[2].name = "status"
* rest[0].resource[3].searchParam[2].type = #token
* rest[0].resource[3].searchParam[2].documentation = "Search by coverage status"

// -------------------- CoverageEligibilityRequest Resource --------------------
* rest[0].resource[4].type = #CoverageEligibilityRequest
* rest[0].resource[4].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-coverage-eligibility-request"
* rest[0].resource[4].documentation = """
Eligibility check request resource.
Supports Claims & Insurance track (Track 1 - Eligibility).
"""
* rest[0].resource[4].interaction[0].code = #read
* rest[0].resource[4].interaction[1].code = #create
* rest[0].resource[4].interaction[2].code = #search-type
* rest[0].resource[4].versioning = #versioned

* rest[0].resource[4].searchParam[0].name = "patient"
* rest[0].resource[4].searchParam[0].type = #reference
* rest[0].resource[4].searchParam[0].documentation = "Search by patient reference"
* rest[0].resource[4].searchParam[1].name = "status"
* rest[0].resource[4].searchParam[1].type = #token
* rest[0].resource[4].searchParam[1].documentation = "Search by request status"

// -------------------- CoverageEligibilityResponse Resource --------------------
* rest[0].resource[5].type = #CoverageEligibilityResponse
* rest[0].resource[5].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-coverage-eligibility-response"
* rest[0].resource[5].documentation = """
Eligibility check response resource.
Supports Claims & Insurance track (Track 1 - Eligibility).
"""
* rest[0].resource[5].interaction[0].code = #read
* rest[0].resource[5].interaction[1].code = #create
* rest[0].resource[5].interaction[2].code = #search-type
* rest[0].resource[5].versioning = #versioned

* rest[0].resource[5].searchParam[0].name = "patient"
* rest[0].resource[5].searchParam[0].type = #reference
* rest[0].resource[5].searchParam[0].documentation = "Search by patient reference"
* rest[0].resource[5].searchParam[1].name = "request"
* rest[0].resource[5].searchParam[1].type = #reference
* rest[0].resource[5].searchParam[1].documentation = "Search by eligibility request reference"

// -------------------- Claim Resource --------------------
* rest[0].resource[6].type = #Claim
* rest[0].resource[6].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-claim"
* rest[0].resource[6].documentation = """
Claim resource for pre-authorization and claims submission.
Supports Claims & Insurance track (Track 1 - Pre-Auth & Billing).
"""
* rest[0].resource[6].interaction[0].code = #read
* rest[0].resource[6].interaction[1].code = #create
* rest[0].resource[6].interaction[2].code = #update
* rest[0].resource[6].interaction[3].code = #search-type
* rest[0].resource[6].versioning = #versioned
* rest[0].resource[6].updateCreate = true

* rest[0].resource[6].searchParam[0].name = "patient"
* rest[0].resource[6].searchParam[0].type = #reference
* rest[0].resource[6].searchParam[0].documentation = "Search by patient reference"
* rest[0].resource[6].searchParam[1].name = "use"
* rest[0].resource[6].searchParam[1].type = #token
* rest[0].resource[6].searchParam[1].documentation = "Search by claim use (preauthorization, claim)"
* rest[0].resource[6].searchParam[2].name = "status"
* rest[0].resource[6].searchParam[2].type = #token
* rest[0].resource[6].searchParam[2].documentation = "Search by claim status"
* rest[0].resource[6].searchParam[3].name = "provider"
* rest[0].resource[6].searchParam[3].type = #reference
* rest[0].resource[6].searchParam[3].documentation = "Search by provider organization"

// -------------------- ClaimResponse Resource --------------------
* rest[0].resource[7].type = #ClaimResponse
* rest[0].resource[7].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-claim-response"
* rest[0].resource[7].documentation = """
Claim response resource for adjudication decisions.
Supports Claims & Insurance track (Track 1 - Pre-Auth & Billing).
"""
* rest[0].resource[7].interaction[0].code = #read
* rest[0].resource[7].interaction[1].code = #create
* rest[0].resource[7].interaction[2].code = #search-type
* rest[0].resource[7].versioning = #versioned

* rest[0].resource[7].searchParam[0].name = "patient"
* rest[0].resource[7].searchParam[0].type = #reference
* rest[0].resource[7].searchParam[0].documentation = "Search by patient reference"
* rest[0].resource[7].searchParam[1].name = "request"
* rest[0].resource[7].searchParam[1].type = #reference
* rest[0].resource[7].searchParam[1].documentation = "Search by claim reference"

// -------------------- Invoice Resource --------------------
* rest[0].resource[8].type = #Invoice
* rest[0].resource[8].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-invoice"
* rest[0].resource[8].documentation = """
Invoice resource for billing and payment tracking.
Supports Claims & Insurance and ePharmacy tracks (Track 1 & 2).
"""
* rest[0].resource[8].interaction[0].code = #read
* rest[0].resource[8].interaction[1].code = #create
* rest[0].resource[8].interaction[2].code = #update
* rest[0].resource[8].interaction[3].code = #search-type
* rest[0].resource[8].versioning = #versioned

* rest[0].resource[8].searchParam[0].name = "subject"
* rest[0].resource[8].searchParam[0].type = #reference
* rest[0].resource[8].searchParam[0].documentation = "Search by patient reference"
* rest[0].resource[8].searchParam[1].name = "status"
* rest[0].resource[8].searchParam[1].type = #token
* rest[0].resource[8].searchParam[1].documentation = "Search by invoice status"
* rest[0].resource[8].searchParam[2].name = "date"
* rest[0].resource[8].searchParam[2].type = #date
* rest[0].resource[8].searchParam[2].documentation = "Search by invoice date"

// -------------------- ExplanationOfBenefit Resource --------------------
* rest[0].resource[9].type = #ExplanationOfBenefit
* rest[0].resource[9].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-explanation-of-benefit"
* rest[0].resource[9].documentation = """
Explanation of Benefit resource for detailed claim adjudication.
Supports Claims & Insurance track (Track 1 - Billing).
"""
* rest[0].resource[9].interaction[0].code = #read
* rest[0].resource[9].interaction[1].code = #create
* rest[0].resource[9].interaction[2].code = #search-type
* rest[0].resource[9].versioning = #versioned

* rest[0].resource[9].searchParam[0].name = "patient"
* rest[0].resource[9].searchParam[0].type = #reference
* rest[0].resource[9].searchParam[0].documentation = "Search by patient reference"
* rest[0].resource[9].searchParam[1].name = "claim"
* rest[0].resource[9].searchParam[1].type = #reference
* rest[0].resource[9].searchParam[1].documentation = "Search by claim reference"

// -------------------- Medication Resource --------------------
* rest[0].resource[10].type = #Medication
* rest[0].resource[10].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-medication"
* rest[0].resource[10].documentation = """
Medication resource for drug definitions.
Supports ePharmacy track (Track 2).
"""
* rest[0].resource[10].interaction[0].code = #read
* rest[0].resource[10].interaction[1].code = #create
* rest[0].resource[10].interaction[2].code = #update
* rest[0].resource[10].interaction[3].code = #search-type
* rest[0].resource[10].versioning = #versioned
* rest[0].resource[10].updateCreate = true

* rest[0].resource[10].searchParam[0].name = "code"
* rest[0].resource[10].searchParam[0].type = #token
* rest[0].resource[10].searchParam[0].documentation = "Search by medication code (ATC, RxNorm)"
* rest[0].resource[10].searchParam[1].name = "status"
* rest[0].resource[10].searchParam[1].type = #token
* rest[0].resource[10].searchParam[1].documentation = "Search by medication status"

// -------------------- MedicationRequest Resource --------------------
* rest[0].resource[11].type = #MedicationRequest
* rest[0].resource[11].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-medication-request"
* rest[0].resource[11].documentation = """
MedicationRequest resource for prescriptions.
Supports ePharmacy track (Track 2 - Prescription).
"""
* rest[0].resource[11].interaction[0].code = #read
* rest[0].resource[11].interaction[1].code = #create
* rest[0].resource[11].interaction[2].code = #update
* rest[0].resource[11].interaction[3].code = #search-type
* rest[0].resource[11].versioning = #versioned
* rest[0].resource[11].updateCreate = true

* rest[0].resource[11].searchParam[0].name = "patient"
* rest[0].resource[11].searchParam[0].type = #reference
* rest[0].resource[11].searchParam[0].documentation = "Search by patient reference"
* rest[0].resource[11].searchParam[1].name = "medication"
* rest[0].resource[11].searchParam[1].type = #reference
* rest[0].resource[11].searchParam[1].documentation = "Search by medication reference"
* rest[0].resource[11].searchParam[2].name = "status"
* rest[0].resource[11].searchParam[2].type = #token
* rest[0].resource[11].searchParam[2].documentation = "Search by prescription status"
* rest[0].resource[11].searchParam[3].name = "authoredon"
* rest[0].resource[11].searchParam[3].type = #date
* rest[0].resource[11].searchParam[3].documentation = "Search by prescription date"

// -------------------- MedicationDispense Resource --------------------
* rest[0].resource[12].type = #MedicationDispense
* rest[0].resource[12].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-medication-dispense"
* rest[0].resource[12].documentation = """
MedicationDispense resource for pharmacy dispensing records.
Supports ePharmacy track (Track 2 - Dispense).
"""
* rest[0].resource[12].interaction[0].code = #read
* rest[0].resource[12].interaction[1].code = #create
* rest[0].resource[12].interaction[2].code = #update
* rest[0].resource[12].interaction[3].code = #search-type
* rest[0].resource[12].versioning = #versioned
* rest[0].resource[12].updateCreate = true

* rest[0].resource[12].searchParam[0].name = "patient"
* rest[0].resource[12].searchParam[0].type = #reference
* rest[0].resource[12].searchParam[0].documentation = "Search by patient reference"
* rest[0].resource[12].searchParam[1].name = "prescription"
* rest[0].resource[12].searchParam[1].type = #reference
* rest[0].resource[12].searchParam[1].documentation = "Search by prescription reference"
* rest[0].resource[12].searchParam[2].name = "status"
* rest[0].resource[12].searchParam[2].type = #token
* rest[0].resource[12].searchParam[2].documentation = "Search by dispense status"
* rest[0].resource[12].searchParam[3].name = "whenhandedover"
* rest[0].resource[12].searchParam[3].type = #date
* rest[0].resource[12].searchParam[3].documentation = "Search by handover date"

// -------------------- ServiceRequest Resource --------------------
* rest[0].resource[13].type = #ServiceRequest
* rest[0].resource[13].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-service-request"
* rest[0].resource[13].documentation = """
ServiceRequest resource for referrals and service orders.
Supports MNCH Referral track (Track 3).
"""
* rest[0].resource[13].interaction[0].code = #read
* rest[0].resource[13].interaction[1].code = #create
* rest[0].resource[13].interaction[2].code = #update
* rest[0].resource[13].interaction[3].code = #search-type
* rest[0].resource[13].versioning = #versioned
* rest[0].resource[13].updateCreate = true

* rest[0].resource[13].searchParam[0].name = "patient"
* rest[0].resource[13].searchParam[0].type = #reference
* rest[0].resource[13].searchParam[0].documentation = "Search by patient reference"
* rest[0].resource[13].searchParam[1].name = "status"
* rest[0].resource[13].searchParam[1].type = #token
* rest[0].resource[13].searchParam[1].documentation = "Search by request status"
* rest[0].resource[13].searchParam[2].name = "intent"
* rest[0].resource[13].searchParam[2].type = #token
* rest[0].resource[13].searchParam[2].documentation = "Search by request intent"

// -------------------- Task Resource --------------------
* rest[0].resource[14].type = #Task
* rest[0].resource[14].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-task"
* rest[0].resource[14].documentation = """
Task resource for workflow management (referrals, lab orders).
Supports MNCH Referral and Medical Devices tracks (Track 3 & 5).
"""
* rest[0].resource[14].interaction[0].code = #read
* rest[0].resource[14].interaction[1].code = #create
* rest[0].resource[14].interaction[2].code = #update
* rest[0].resource[14].interaction[3].code = #search-type
* rest[0].resource[14].versioning = #versioned
* rest[0].resource[14].updateCreate = true

* rest[0].resource[14].searchParam[0].name = "patient"
* rest[0].resource[14].searchParam[0].type = #reference
* rest[0].resource[14].searchParam[0].documentation = "Search by patient reference (Task.for)"
* rest[0].resource[14].searchParam[1].name = "status"
* rest[0].resource[14].searchParam[1].type = #token
* rest[0].resource[14].searchParam[1].documentation = "Search by task status"
* rest[0].resource[14].searchParam[2].name = "owner"
* rest[0].resource[14].searchParam[2].type = #reference
* rest[0].resource[14].searchParam[2].documentation = "Search by task owner"
* rest[0].resource[14].searchParam[3].name = "focus"
* rest[0].resource[14].searchParam[3].type = #reference
* rest[0].resource[14].searchParam[3].documentation = "Search by task focus (ServiceRequest, etc.)"

// -------------------- Communication Resource --------------------
* rest[0].resource[15].type = #Communication
* rest[0].resource[15].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-communication"
* rest[0].resource[15].documentation = """
Communication resource for clinical messages and follow-ups.
Supports MNCH Referral track (Track 3).
"""
* rest[0].resource[15].interaction[0].code = #read
* rest[0].resource[15].interaction[1].code = #create
* rest[0].resource[15].interaction[2].code = #search-type
* rest[0].resource[15].versioning = #versioned

* rest[0].resource[15].searchParam[0].name = "subject"
* rest[0].resource[15].searchParam[0].type = #reference
* rest[0].resource[15].searchParam[0].documentation = "Search by communication subject (usually patient)"
* rest[0].resource[15].searchParam[1].name = "sent"
* rest[0].resource[15].searchParam[1].type = #date
* rest[0].resource[15].searchParam[1].documentation = "Search by send date"

// -------------------- Immunization Resource --------------------
* rest[0].resource[16].type = #Immunization
* rest[0].resource[16].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-immunization"
* rest[0].resource[16].documentation = """
Immunization resource for vaccine administration records.
Supports Immunization track (Track 4).
"""
* rest[0].resource[16].interaction[0].code = #read
* rest[0].resource[16].interaction[1].code = #create
* rest[0].resource[16].interaction[2].code = #update
* rest[0].resource[16].interaction[3].code = #search-type
* rest[0].resource[16].versioning = #versioned
* rest[0].resource[16].updateCreate = true

* rest[0].resource[16].searchParam[0].name = "patient"
* rest[0].resource[16].searchParam[0].type = #reference
* rest[0].resource[16].searchParam[0].documentation = "Search by patient reference"
* rest[0].resource[16].searchParam[1].name = "date"
* rest[0].resource[16].searchParam[1].type = #date
* rest[0].resource[16].searchParam[1].documentation = "Search by vaccination date"
* rest[0].resource[16].searchParam[2].name = "vaccine-code"
* rest[0].resource[16].searchParam[2].type = #token
* rest[0].resource[16].searchParam[2].documentation = "Search by vaccine type"
* rest[0].resource[16].searchParam[3].name = "lot-number"
* rest[0].resource[16].searchParam[3].type = #string
* rest[0].resource[16].searchParam[3].documentation = "Search by vaccine lot number"
* rest[0].resource[16].searchParam[4].name = "status"
* rest[0].resource[16].searchParam[4].type = #token
* rest[0].resource[16].searchParam[4].documentation = "Search by immunization status"

// -------------------- ImmunizationRecommendation Resource --------------------
* rest[0].resource[17].type = #ImmunizationRecommendation
* rest[0].resource[17].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-immunization-recommendation"
* rest[0].resource[17].documentation = """
ImmunizationRecommendation resource for vaccine scheduling.
Supports Immunization track (Track 4 - Scheduler).
"""
* rest[0].resource[17].interaction[0].code = #read
* rest[0].resource[17].interaction[1].code = #create
* rest[0].resource[17].interaction[2].code = #update
* rest[0].resource[17].interaction[3].code = #search-type
* rest[0].resource[17].versioning = #versioned
* rest[0].resource[17].updateCreate = true
* rest[0].resource[17].searchParam[0].name = "patient"
* rest[0].resource[17].searchParam[0].type = #reference
* rest[0].resource[17].searchParam[0].documentation = "Search by patient reference"
* rest[0].resource[17].searchParam[1].name = "date"
* rest[0].resource[17].searchParam[1].type = #date
* rest[0].resource[17].searchParam[1].documentation = "Search by recommendation date"
* rest[0].resource[17].searchParam[2].name = "vaccine-type"
* rest[0].resource[17].searchParam[2].type = #token
* rest[0].resource[17].searchParam[2].documentation = "Search by vaccine type"

// -------------------- Appointment Resource --------------------
* rest[0].resource[18].type = #Appointment
* rest[0].resource[18].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-appointment"
* rest[0].resource[18].documentation = """
Appointment resource for scheduling immunizations and clinic visits.
Supports Immunization track (Track 4 - Scheduler).
"""
* rest[0].resource[18].interaction[0].code = #read
* rest[0].resource[18].interaction[1].code = #create
* rest[0].resource[18].interaction[2].code = #update
* rest[0].resource[18].interaction[3].code = #search-type
* rest[0].resource[18].versioning = #versioned
* rest[0].resource[18].updateCreate = true
* rest[0].resource[18].conditionalUpdate = true
* rest[0].resource[18].searchParam[0].name = "patient"
* rest[0].resource[18].searchParam[0].type = #reference
* rest[0].resource[18].searchParam[0].documentation = "Search by patient reference"
* rest[0].resource[18].searchParam[1].name = "date"
* rest[0].resource[18].searchParam[1].type = #date
* rest[0].resource[18].searchParam[1].documentation = "Search by appointment date"
* rest[0].resource[18].searchParam[2].name = "status"
* rest[0].resource[18].searchParam[2].type = #token
* rest[0].resource[18].searchParam[2].documentation = "Search by appointment status"
* rest[0].resource[18].searchParam[3].name = "service-type"
* rest[0].resource[18].searchParam[3].type = #token
* rest[0].resource[18].searchParam[3].documentation = "Search by service type (e.g., immunization)"

// -------------------- Location Resource --------------------
* rest[0].resource[19].type = #Location
* rest[0].resource[19].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-location"
* rest[0].resource[19].documentation = """
Location resource for health facilities and service delivery points.
Supports multiple tracks including Immunization and MNCH Referral (Track 3 & 4).
"""
* rest[0].resource[19].interaction[0].code = #read
* rest[0].resource[19].interaction[1].code = #create
* rest[0].resource[19].interaction[2].code = #update
* rest[0].resource[19].interaction[3].code = #search-type
* rest[0].resource[19].versioning = #versioned
* rest[0].resource[19].updateCreate = true
* rest[0].resource[19].searchParam[0].name = "name"
* rest[0].resource[19].searchParam[0].type = #string
* rest[0].resource[19].searchParam[0].documentation = "Search by location name"
* rest[0].resource[19].searchParam[1].name = "address-state"
* rest[0].resource[19].searchParam[1].type = #string
* rest[0].resource[19].searchParam[1].documentation = "Search by state"
* rest[0].resource[19].searchParam[2].name = "type"
* rest[0].resource[19].searchParam[2].type = #token
* rest[0].resource[19].searchParam[2].documentation = "Search by location type"
* rest[0].resource[19].searchParam[3].name = "status"
* rest[0].resource[19].searchParam[3].type = #token
* rest[0].resource[19].searchParam[3].documentation = "Search by location status"

// -------------------- Observation Resource --------------------
* rest[0].resource[20].type = #Observation
* rest[0].resource[20].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-observation"
// * rest[0].resource[20].profile[1] = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-observation-aefi"
* rest[0].resource[20].documentation = """
Observation resource for clinical findings, vital signs, lab results, and AEFI.
Supports Immunization (AEFI) and Medical Devices tracks (Track 4 & 5).
"""
* rest[0].resource[20].interaction[0].code = #read
* rest[0].resource[20].interaction[1].code = #create
* rest[0].resource[20].interaction[2].code = #update
* rest[0].resource[20].interaction[3].code = #search-type
* rest[0].resource[20].versioning = #versioned
* rest[0].resource[20].updateCreate = true
* rest[0].resource[20].searchParam[0].name = "patient"
* rest[0].resource[20].searchParam[0].type = #reference
* rest[0].resource[20].searchParam[0].documentation = "Search by patient reference"
* rest[0].resource[20].searchParam[1].name = "code"
* rest[0].resource[20].searchParam[1].type = #token
* rest[0].resource[20].searchParam[1].documentation = "Search by observation code (LOINC, SNOMED)"
* rest[0].resource[20].searchParam[2].name = "category"
* rest[0].resource[20].searchParam[2].type = #token
* rest[0].resource[20].searchParam[2].documentation = "Search by observation category"
* rest[0].resource[20].searchParam[3].name = "date"
* rest[0].resource[20].searchParam[3].type = #date
* rest[0].resource[20].searchParam[3].documentation = "Search by observation date"
* rest[0].resource[20].searchParam[4].name = "device"
* rest[0].resource[20].searchParam[4].type = #reference
* rest[0].resource[20].searchParam[4].documentation = "Search by device reference"
* rest[0].resource[20].searchParam[5].name = "status"
* rest[0].resource[20].searchParam[5].type = #token
* rest[0].resource[20].searchParam[5].documentation = "Search by observation status"

// -------------------- Device Resource --------------------
* rest[0].resource[21].type = #Device
* rest[0].resource[21].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-device"
* rest[0].resource[21].documentation = """
Device resource for medical devices (wearables, lab equipment).
Supports Medical Devices track (Track 5).
"""
* rest[0].resource[21].interaction[0].code = #read
* rest[0].resource[21].interaction[1].code = #create
* rest[0].resource[21].interaction[2].code = #update
* rest[0].resource[21].interaction[3].code = #search-type
* rest[0].resource[21].versioning = #versioned
* rest[0].resource[21].updateCreate = true
* rest[0].resource[21].searchParam[0].name = "patient"
* rest[0].resource[21].searchParam[0].type = #reference
* rest[0].resource[21].searchParam[0].documentation = "Search by patient reference (device owner)"
* rest[0].resource[21].searchParam[1].name = "type"
* rest[0].resource[21].searchParam[1].type = #token
* rest[0].resource[21].searchParam[1].documentation = "Search by device type"
* rest[0].resource[21].searchParam[2].name = "manufacturer"
* rest[0].resource[21].searchParam[2].type = #string
* rest[0].resource[21].searchParam[2].documentation = "Search by manufacturer"
* rest[0].resource[21].searchParam[3].name = "model"
* rest[0].resource[21].searchParam[3].type = #string
* rest[0].resource[21].searchParam[3].documentation = "Search by model number"
* rest[0].resource[21].searchParam[4].name = "status"
* rest[0].resource[21].searchParam[4].type = #token
* rest[0].resource[21].searchParam[4].documentation = "Search by device status"

// -------------------- Consent Resource --------------------
* rest[0].resource[22].type = #Consent
* rest[0].resource[22].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-consent"
* rest[0].resource[22].documentation = """
Consent resource for data sharing and research consent (ISO/TR 17975).
Supports Standards Adoption and Privacy tracks (Track 8 & 9).
"""
* rest[0].resource[22].interaction[0].code = #read
* rest[0].resource[22].interaction[1].code = #create
* rest[0].resource[22].interaction[2].code = #update
* rest[0].resource[22].interaction[3].code = #search-type
* rest[0].resource[22].versioning = #versioned
* rest[0].resource[22].updateCreate = true
* rest[0].resource[22].searchParam[0].name = "patient"
* rest[0].resource[22].searchParam[0].type = #reference
* rest[0].resource[22].searchParam[0].documentation = "Search by patient reference"
* rest[0].resource[22].searchParam[1].name = "status"
* rest[0].resource[22].searchParam[1].type = #token
* rest[0].resource[22].searchParam[1].documentation = "Search by consent status"
* rest[0].resource[22].searchParam[2].name = "scope"
* rest[0].resource[22].searchParam[2].type = #token
* rest[0].resource[22].searchParam[2].documentation = "Search by consent scope"
* rest[0].resource[22].searchParam[3].name = "date"
* rest[0].resource[22].searchParam[3].type = #date
* rest[0].resource[22].searchParam[3].documentation = "Search by consent date"

// -------------------- RelatedPerson Resource --------------------
* rest[0].resource[23].type = #RelatedPerson
* rest[0].resource[23].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-related-person"
* rest[0].resource[23].documentation = """
RelatedPerson resource for family members and caregivers.
Supports Privacy use case (Track 9) with pseudonymization.
"""
* rest[0].resource[23].interaction[0].code = #read
* rest[0].resource[23].interaction[1].code = #create
* rest[0].resource[23].interaction[2].code = #update
* rest[0].resource[23].interaction[3].code = #search-type
* rest[0].resource[23].versioning = #versioned
* rest[0].resource[23].updateCreate = true
* rest[0].resource[23].searchParam[0].name = "patient"
* rest[0].resource[23].searchParam[0].type = #reference
* rest[0].resource[23].searchParam[0].documentation = "Search by patient reference"
* rest[0].resource[23].searchParam[1].name = "name"
* rest[0].resource[23].searchParam[1].type = #string
* rest[0].resource[23].searchParam[1].documentation = "Search by related person name"
* rest[0].resource[23].searchParam[2].name = "relationship"
* rest[0].resource[23].searchParam[2].type = #token
* rest[0].resource[23].searchParam[2].documentation = "Search by relationship type"

// -------------------- Encounter Resource --------------------
* rest[0].resource[24].type = #Encounter
* rest[0].resource[24].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-encounter"
* rest[0].resource[24].documentation = """
Encounter resource for clinical visits and episodes of care.
Supports multiple tracks requiring visit context.
"""
* rest[0].resource[24].interaction[0].code = #read
* rest[0].resource[24].interaction[1].code = #create
* rest[0].resource[24].interaction[2].code = #update
* rest[0].resource[24].interaction[3].code = #search-type
* rest[0].resource[24].versioning = #versioned
* rest[0].resource[24].updateCreate = true
* rest[0].resource[24].searchParam[0].name = "patient"
* rest[0].resource[24].searchParam[0].type = #reference
* rest[0].resource[24].searchParam[0].documentation = "Search by patient reference"
* rest[0].resource[24].searchParam[1].name = "date"
* rest[0].resource[24].searchParam[1].type = #date
* rest[0].resource[24].searchParam[1].documentation = "Search by encounter date"
* rest[0].resource[24].searchParam[2].name = "type"
* rest[0].resource[24].searchParam[2].type = #token
* rest[0].resource[24].searchParam[2].documentation = "Search by encounter type"
* rest[0].resource[24].searchParam[3].name = "status"
* rest[0].resource[24].searchParam[3].type = #token
* rest[0].resource[24].searchParam[3].documentation = "Search by encounter status"

// -------------------- Provenance Resource --------------------
* rest[0].resource[25].type = #Provenance
* rest[0].resource[25].profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-provenance"
* rest[0].resource[25].documentation = """
Provenance resource for audit trails and data origin tracking.
Supports Privacy and device data tracks (Track 5, 8, 9).
"""
* rest[0].resource[25].interaction[0].code = #read
* rest[0].resource[25].interaction[1].code = #create
* rest[0].resource[25].interaction[2].code = #search-type
* rest[0].resource[25].versioning = #versioned
* rest[0].resource[25].searchParam[0].name = "target"
* rest[0].resource[25].searchParam[0].type = #reference
* rest[0].resource[25].searchParam[0].documentation = "Search by target resource"
* rest[0].resource[25].searchParam[1].name = "recorded"
* rest[0].resource[25].searchParam[1].type = #date
* rest[0].resource[25].searchParam[1].documentation = "Search by recorded timestamp"
* rest[0].resource[25].searchParam[2].name = "agent"
* rest[0].resource[25].searchParam[2].type = #reference
* rest[0].resource[25].searchParam[2].documentation = "Search by agent (who/what performed the activity)"

// -------------------- Bundle Resource --------------------
* rest[0].resource[26].type = #Bundle
* rest[0].resource[26].supportedProfile[0] = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-eligibility-check-bundle"
* rest[0].resource[26].supportedProfile[1] = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-preauthorization-bundle"
* rest[0].resource[26].supportedProfile[2] = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-claim-submission-bundle"
* rest[0].resource[26].supportedProfile[3] = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-prescription-bundle"
* rest[0].resource[26].supportedProfile[4] = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-medication-dispense-bundle"
* rest[0].resource[26].supportedProfile[5] = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-mnch-referral-bundle"
* rest[0].resource[26].supportedProfile[6] = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-aefi-report-bundle"
* rest[0].resource[26].supportedProfile[7] = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-imm-smart-scheduler-bundle"
* rest[0].resource[26].supportedProfile[8] = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-device-data-bundle"
* rest[0].resource[26].documentation = """
Bundle resource for transaction and collection bundles across all tracks.
Supports batch operations and structured data exchange.
"""
* rest[0].resource[26].interaction[0].code = #read
* rest[0].resource[26].interaction[1].code = #create
* rest[0].resource[26].interaction[2].code = #search-type
* rest[0].resource[26].versioning = #versioned
* rest[0].resource[26].searchParam[0].name = "type"
* rest[0].resource[26].searchParam[0].type = #token
* rest[0].resource[26].searchParam[0].documentation = "Search by bundle type (transaction, collection)"
* rest[0].resource[26].searchParam[1].name = "timestamp"
* rest[0].resource[26].searchParam[1].type = #date
* rest[0].resource[26].searchParam[1].documentation = "Search by bundle timestamp"

// -------------------- System-Level Interactions --------------------
* rest[0].interaction[0].code = #transaction
* rest[0].interaction[0].documentation = "Support for transaction bundles (batch create/update)"
* rest[0].interaction[1].code = #batch
* rest[0].interaction[1].documentation = "Support for batch bundles (independent operations)"
* rest[0].interaction[2].code = #search-system
* rest[0].interaction[2].documentation = "Support for system-wide searches"
* rest[0].interaction[3].code = #history-system
* rest[0].interaction[3].documentation = "Support for system-wide history"

// -------------------- System-Level Search Parameters --------------------
* rest[0].searchParam[0].name = "_id"
* rest[0].searchParam[0].type = #token
* rest[0].searchParam[0].documentation = "Search by resource ID"
* rest[0].searchParam[1].name = "_lastUpdated"
* rest[0].searchParam[1].type = #date
* rest[0].searchParam[1].documentation = "Search by last updated timestamp"
* rest[0].searchParam[2].name = "_profile"
* rest[0].searchParam[2].type = #uri
* rest[0].searchParam[2].documentation = "Search by profile conformance"
* rest[0].searchParam[3].name = "_tag"
* rest[0].searchParam[3].type = #token
* rest[0].searchParam[3].documentation = "Search by resource tags"
* rest[0].searchParam[4].name = "_security"
* rest[0].searchParam[4].type = #token
* rest[0].searchParam[4].documentation = "Search by security labels"

// -------------------- Operations --------------------
* rest[0].operation[0].name = "validate"
* rest[0].operation[0].definition = "http://hl7.org/fhir/OperationDefinition/Resource-validate"
* rest[0].operation[0].documentation = "Validate a resource against its profile"
* rest[0].operation[1].name = "meta"
* rest[0].operation[1].definition = "http://hl7.org/fhir/OperationDefinition/Resource-meta"
* rest[0].operation[1].documentation = "Access resource metadata"
* rest[0].operation[2].name = "patient-everything"
* rest[0].operation[2].definition = "http://hl7.org/fhir/OperationDefinition/Patient-everything"
* rest[0].operation[2].documentation = "Retrieve all resources for a patient"
//* rest[0].operation[3].name = "export"
//* rest[0].operation[3].definition = "http://hl7.org/fhir/uv/bulkdata/OperationDefinition/export"
//* rest[0].operation[3].documentation = "Bulk data export (system-level)"
