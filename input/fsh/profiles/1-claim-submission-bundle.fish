// ===============================================================
// Example 1: Outpatient Consultation & Labs Claim (Transaction)
// ===============================================================
Instance: ClaimSubmit-OPD-Request
InstanceOf: Bundle
Usage: #example
Title: "Claim Submission – Outpatient Consult & Labs"
Description: "Provider submits an outpatient claim to the payer."
* type = #transaction

// Patient -------------------------------------------------------
* entry[0].fullUrl = "urn:uuid:pat-claim-001"
* entry[0].resource = NgPatient-Claim-001
* entry[0].request.method = #POST
* entry[0].request.url = "Patient"

// Practitioner (attending) -------------------------------------
* entry[+].fullUrl = "urn:uuid:prac-claim-001"
* entry[=].resource = NgPractitioner-Claim-001
* entry[=].request.method = #POST
* entry[=].request.url = "Practitioner"

// Provider Organization (Hospital/Clinic) ----------------------
* entry[+].fullUrl = "urn:uuid:org-provider-001"
* entry[=].resource = NgOrganization-Provider-OPD-001
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

// Insurer Organization (Payer) ---------------------------------
* entry[+].fullUrl = "urn:uuid:org-insurer-003"
* entry[=].resource = NgOrganization-Insurer-003
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

// Coverage (policy) --------------------------------------------
* entry[+].fullUrl = "urn:uuid:cov-claim-001"
* entry[=].resource = NgCoverage-Claim-001
* entry[=].request.method = #POST
* entry[=].request.url = "Coverage"

// Claim (use = claim) ------------------------------------------
* entry[+].fullUrl = "urn:uuid:claim-001"
* entry[=].resource = NgClaim-OPD-001
* entry[=].request.method = #POST
* entry[=].request.url = "Claim"


// ===============================================================
// Example 2: Inpatient Procedure Claim (Transaction)
// ===============================================================
Instance: ClaimSubmit-IP-Request
InstanceOf: Bundle
Usage: #example
Title: "Claim Submission – Inpatient Procedure"
Description: "Provider submits an inpatient/procedure claim to the payer."
* type = #transaction

// Patient -------------------------------------------------------
* entry[0].fullUrl = "urn:uuid:pat-claim-002"
* entry[0].resource = NgPatient-Claim-002
* entry[0].request.method = #POST
* entry[0].request.url = "Patient"

// Practitioner (surgeon/attending) -----------------------------
* entry[+].fullUrl = "urn:uuid:prac-claim-002"
* entry[=].resource = NgPractitioner-Claim-002
* entry[=].request.method = #POST
* entry[=].request.url = "Practitioner"

// Provider Organization (Hospital) -----------------------------
* entry[+].fullUrl = "urn:uuid:org-provider-002"
* entry[=].resource = NgOrganization-Provider-IP-001
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

// Insurer Organization (Payer) ---------------------------------
* entry[+].fullUrl = "urn:uuid:org-insurer-003"
* entry[=].resource = NgOrganization-Insurer-003
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

// Coverage (policy) --------------------------------------------
* entry[+].fullUrl = "urn:uuid:cov-claim-002"
* entry[=].resource = NgCoverage-Claim-002
* entry[=].request.method = #POST
* entry[=].request.url = "Coverage"

// Claim (use = claim) ------------------------------------------
* entry[+].fullUrl = "urn:uuid:claim-002"
* entry[=].resource = NgClaim-IP-001
* entry[=].request.method = #POST
* entry[=].request.url = "Claim"



// ==================================================================
// Inline Resources (kept minimal; aligned to your Ng* profile rules)
// ==================================================================

// -------------------- PATIENTS (NgPatient requires meta.lastUpdated)
Instance: NgPatient-Claim-001
InstanceOf: NgPatient
Usage: #inline
Title: "Patient – OPD Claim"
* meta.lastUpdated = "2025-10-05T09:30:00+01:00"
* identifier[PhoneNumber].value = "08031234567"
* identifier[PhoneNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.code = #MOBILE
* identifier[PhoneNumber].type.coding.display = "Primary Mobile Phone Number of the Client or CareGiver"
* name.given[0] = "Adaeze"
* name.family = "Nwosu"
* gender = #female
* birthDate = "1992-07-18"
* active = true
* address.line[0] = "3 PHC Crescent"
* address.city = "Garki"
* address.district = "abuja-municipal"
* address.state = "FC"

Instance: NgPatient-Claim-002
InstanceOf: NgPatient
Usage: #inline
Title: "Patient – IP Claim"
* meta.lastUpdated = "2025-10-10T11:05:00+01:00"
* identifier[PhoneNumber].value = "08095550011"
* identifier[PhoneNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.code = #MOBILE
* identifier[PhoneNumber].type.coding.display = "Primary Mobile Phone Number of the Client or CareGiver"
* name.given[0] = "Salisu"
* name.family = "Bello"
* gender = #male
* birthDate = "1985-03-21"
* active = true
* address.line[0] = "22 Ward Road"
* address.city = "Ikeja"
* address.district = "ikeja"
* address.state = "LA"

// -------------------- PRACTITIONERS
Instance: NgPractitioner-Claim-001
InstanceOf: NgPractitioner
Usage: #inline
Title: "Attending – OPD"
* identifier[0].system = "https://mdcn.gov.ng/practitioner-id"
* identifier[0].value = "MDCN-230045"
* active = true
* name.given = "Nkiru"
* name.family = "Okafor"
* telecom[0].system = #phone
* telecom[0].value = "08092000001"
* birthDate = "1984-12-02"

Instance: NgPractitioner-Claim-002
InstanceOf: NgPractitioner
Usage: #inline
Title: "Attending – IP"
* identifier[0].system = "https://mdcn.gov.ng/practitioner-id"
* identifier[0].value = "MDCN-117733"
* active = true
* name.given = "Tunde"
* name.family = "Adebayo"
* telecom[0].system = #phone
* telecom[0].value = "08093000002"
* birthDate = "1979-06-14"

// -------------------- ORGANIZATIONS (Provider & Payer)
Instance: NgOrganization-Provider-OPD-001
InstanceOf: NgOrganization
Usage: #inline
Title: "Garki Family Clinic"
* identifier.system = "https://hfr.health.gov.ng/facility-id"
* identifier.value = "HCF-10011"
* active = true
* name = "Garki Family Clinic"
* type.coding.system = "https://www.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type.coding.code = #clinic
* type.coding.display = "Primary Care Clinic"
* telecom[0].system = #phone
* telecom[0].value = "09-445-1200"
* address.line[0] = "8 Clinic Close"
* address.city = "Garki"
* address.district = "abuja-municipal"
* address.state = "FC"
* extension[NGOrganizationOwner].valueCodeableConcept.text = "Private"

Instance: NgOrganization-Provider-IP-001
InstanceOf: NgOrganization
Usage: #inline
Title: "Unity District Hospital"
* identifier.system = "https://hfr.health.gov.ng/facility-id"
* identifier.value = "HCF-11223"
* active = true
* name = "Unity District Hospital"
* type.coding.system = "https://www.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type.coding.code = #hospital
* type.coding.display = "Secondary Hospital"
* telecom[0].system = #phone
* telecom[0].value = "09-445-7788"
* address.line[0] = "45 Hospital Avenue"
* address.city = "Garki"
* address.district = "abuja-municipal"
* address.state = "FC"
* extension[NGOrganizationOwner].valueCodeableConcept.text = "State Government"

Instance: NgOrganization-Insurer-003
InstanceOf: NgOrganization
Usage: #inline
Title: "PrimeCare HMO"
* identifier.system = "https://nhia.gov.ng/hmo-code"
* identifier.value = "NHIA-HMO-0042"
* active = true
* name = "PrimeCare HMO"
* type.coding.system = "https://www.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type.coding.code = #payer
* type.coding.display = "Health Maintenance Organization"
* telecom[0].system = #phone
* telecom[0].value = "0700-PRIMECARE"
* address.line[0] = "12 Insurance Close"
* address.city = "Victoria Island"
* address.district = "eti-osa"
* address.state = "LA"

// -------------------- COVERAGES
Instance: NgCoverage-Claim-001
InstanceOf: NgCoverage
Usage: #inline
Title: "Coverage – Adaeze (PrimeCare)"
* status = #active
* type.coding.system = "http://terminology.hl7.org/CodeSystem/v3-ActCode"
* type.coding.code = #EHCPOL
* type.coding.display = "extended healthcare"
* beneficiary = Reference(urn:uuid:pat-claim-001)
* payor[0] = Reference(urn:uuid:org-insurer-001)
* period.start = "2025-01-01"
* period.end = "2025-12-31"

Instance: NgCoverage-Claim-002
InstanceOf: NgCoverage
Usage: #inline
Title: "Coverage – Salisu (PrimeCare)"
* status = #active
* type.coding.system = "http://terminology.hl7.org/CodeSystem/v3-ActCode"
* type.coding.code = #EHCPOL
* type.coding.display = "extended healthcare"
* beneficiary = Reference(urn:uuid:pat-claim-002)
* payor[0] = Reference(urn:uuid:org-insurer-001)
* period.start = "2025-01-01"
* period.end = "2025-12-31"

// -------------------- CLAIMS (NgClaim)
// NOTE: Satisfy required fields per your NgClaim profile:
// status, type, use, patient, created, provider, payee.type(1..1)+party, priority(1..1),
// item(1..* with sequence), insurance(1..* with focal+coverage)
Instance: NgClaim-OPD-001
InstanceOf: NgClaim
Usage: #inline
Title: "Claim – Outpatient Consultation & Labs"
* status = #active
* type.coding.system = "http://terminology.hl7.org/CodeSystem/claim-type"
* type.coding.code = #professional
* type.coding.display = "Professional"
* use = #claim
* patient = Reference(urn:uuid:pat-claim-001)
* created = "2025-10-05T10:00:00+01:00"
* provider = Reference(urn:uuid:org-provider-001)
* payee.type.coding.system = "http://terminology.hl7.org/CodeSystem/payeetype"
* payee.type.coding.code = #provider
* payee.party = Reference(urn:uuid:prac-claim-001)
* priority.coding.system = "http://terminology.hl7.org/CodeSystem/processpriority"
* priority.coding.code = #normal
// Items
* item[0].sequence = 1
* item[0].productOrService.coding[0].system = "http://hl7.org/fhir/sid/cvx"
* item[0].productOrService.coding[0].code = #123
* item[0].productOrService.coding[0].display = "Outpatient consultation"
* item[0].quantity.value = 1
* item[0].unitPrice.value = 15000
* item[0].unitPrice.currency = #NGN
* item[1].sequence = 2
* item[1].productOrService.coding[0].system = "http://loinc.org"
* item[1].productOrService.coding[0].code = #1751-7
* item[1].productOrService.coding[0].display = "Glucose [Moles/volume] in Serum or Plasma"
* item[1].quantity.value = 1
* item[1].unitPrice.value = 5000
* item[1].unitPrice.currency = #NGN
// Insurance
* insurance[0].focal = true
* insurance[0].coverage = Reference(urn:uuid:cov-claim-001)
* insurance[0].sequence = 419

// Inpatient claim
Instance: NgClaim-IP-001
InstanceOf: NgClaim
Usage: #inline
Title: "Claim – Inpatient Appendectomy"
* status = #active
* type.coding.system = "http://terminology.hl7.org/CodeSystem/claim-type"
* type.coding.code = #institutional
* type.coding.display = "Institutional"
* use = #claim
* patient = Reference(urn:uuid:pat-claim-002)
* created = "2025-10-10T14:30:00+01:00"
* provider = Reference(urn:uuid:org-provider-002)
* payee.type.coding.system = "http://terminology.hl7.org/CodeSystem/payeetype"
* payee.type.coding.code = #provider
* payee.party = Reference(urn:uuid:prac-claim-002)
* priority.coding.system = "http://terminology.hl7.org/CodeSystem/processpriority"
* priority.coding.code = #normal
// Items (DRG/procedure + bed days)
* item[0].sequence = 1
* item[0].productOrService.coding[0].system = "http://snomed.info/sct"
* item[0].productOrService.coding[0].code = #80146002
* item[0].productOrService.coding[0].display = "Appendectomy (procedure)"
* item[0].quantity.value = 1
* item[0].unitPrice.value = 250000
* item[0].unitPrice.currency = #NGN
* item[1].sequence = 2
* item[1].productOrService.coding[0].system = "http://terminology.hl7.org/CodeSystem/ex-benefitcategory"
* item[1].productOrService.coding[0].code = #room
* item[1].productOrService.coding[0].display = "Room and board"
* item[1].quantity.value = 3
* item[1].unitPrice.value = 40000
* item[1].unitPrice.currency = #NGN
// Insurance
* insurance[0].focal = true
* insurance[0].coverage = Reference(urn:uuid:cov-claim-002)
* insurance[0].sequence = 999
