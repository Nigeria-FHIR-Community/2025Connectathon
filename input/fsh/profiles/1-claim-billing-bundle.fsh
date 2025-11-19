// ======================================================================
// Profile: NgClaimSubmissionBundle
// ======================================================================
Profile: NgClaimSubmissionBundle
Parent: Bundle
Id: ng-claim-submission-bundle
Title: "1-NGClaim 3 Submission and Billing Bundle (Request/Response)"
Description: """
Single Bundle profile that supports BOTH:
- Claim Submission Request (type=transaction): Patient, Practitioner, Provider Org, 
  Insurer Org, Coverage, and a Claim (use=claim) for services rendered
- Claim Response/Billing (type=collection): Patient (echo), Insurer Org, Coverage (echo), 
  ClaimResponse with adjudication and payment details, and optional ExplanationOfBenefit
"""
* ^status = #active

// Core
* type 1..1 MS
* entry 2..* MS
* entry.fullUrl 1..1 MS
* entry.resource 1..1 MS
* entry.request 0..1 MS
* entry.request.method 1..1
* entry.request.url 1..1

// Slice by resource profile
* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #open

// Named slices
* entry contains
    patient 1..1 MS and
//    practitioner 0..1 MS and
    providerOrg 0..1 MS and
    insurerOrg 0..1 MS and
    coverage 0..1 MS and
    claim 0..1 MS and
    claimResponse 0..1 MS and
    explanationOfBenefit 0..1 MS

* entry[patient].resource only NgPatient
//* entry[practitioner].resource only NgPractitioner
* entry[providerOrg].resource only NgProviderOrganization
* entry[insurerOrg].resource only NgInsurerOrganization
* entry[coverage].resource only NgCoverage
* entry[claim].resource only NgClaim
* entry[claimResponse].resource only NgClaimResponse
* entry[explanationOfBenefit].resource only NgExplanationOfBenefit

* entry.fullUrl ^short = "Prefer URN UUID (urn:uuid:...) for intra-bundle references."




// ===============================================================
// REQUEST BUNDLE (transaction) - Claim Submission
// ===============================================================
Instance: ClaimSubmission-Request
InstanceOf: NgClaimSubmissionBundle
Usage: #example
Title: "Claim Submission - Request (Transaction)"
Description: "Hospital submits claim to HMO for services already rendered to patient."
* type = #transaction

// Patient
* entry[0].fullUrl = "urn:uuid:aaabbbc2-e5f6-4789-a123-456789abcdef"
* entry[0].resource = NgPatient-Claim-001
* entry[0].request.method = #POST
* entry[0].request.url = "Patient"

// Practitioner
// * entry[+].fullUrl = "urn:uuid:bbb22233-e5f6-4789-a123-456789abcdef"
// * entry[=].resource = NgPractitioner-Claim-001
// * entry[=].request.method = #POST
// * entry[=].request.url = "Practitioner"

// Provider Organization (Hospital)
* entry[+].fullUrl = "urn:uuid:ccc33344-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgOrganization-Provider-Claim-001
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

// Insurer Organization (HMO)
* entry[+].fullUrl = "urn:uuid:ddd44455-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgOrganization-Insurer-Claim-001
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

// Coverage
* entry[+].fullUrl = "urn:uuid:eee55566-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgCoverage-Claim-001
* entry[=].request.method = #POST
* entry[=].request.url = "Coverage"

// Claim (use = claim)
* entry[+].fullUrl = "urn:uuid:fff66677-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgClaim-Claim-001
* entry[=].request.method = #POST
* entry[=].request.url = "Claim"


// ===============================================================
// RESPONSE BUNDLE (collection) - Adjudication & Billing
// ===============================================================
Instance: ClaimSubmission-Response
InstanceOf: NgClaimSubmissionBundle
Usage: #example
Title: "Claim Submission - Response (Collection)"
Description: "HMO response with adjudication, approved amounts, and payment details."
* type = #transaction

// Patient (echo)
* entry[0].fullUrl = "urn:uuid:aaabbbc2-e5f6-4789-a123-456789abcdef"
* entry[0].resource = NgPatient-Claim-001
* entry[0].request.method = #POST
* entry[0].request.url = "Patient"

// Provider Organization (Hospital)
* entry[+].fullUrl = "urn:uuid:ccc33344-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgOrganization-Provider-Claim-001
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

// Insurer (payer)
* entry[+].fullUrl = "urn:uuid:ddd44455-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgOrganization-Insurer-Claim-001
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

// Coverage (echo)
* entry[+].fullUrl = "urn:uuid:eee55566-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgCoverage-Claim-001
* entry[=].request.method = #POST
* entry[=].request.url = "Coverage"

// ClaimResponse (adjudication)
* entry[+].fullUrl = "urn:uuid:aaa77788-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgClaimResponse-Claim-001
* entry[=].request.method = #POST
* entry[=].request.url = "ClaimResponse"

// ExplanationOfBenefit (optional, detailed breakdown)
* entry[+].fullUrl = "urn:uuid:bbb88899-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgEOB-Claim-001
* entry[=].request.method = #POST
* entry[=].request.url = "ExplanationOfBenefit"


// ===============================================================
// Inline Resources
// ===============================================================

// -------------------- NgPatient --------------------------------
Instance: NgPatient-Claim-001
InstanceOf: NgPatient
Usage: #inline
Title: "Claim Patient - Amaka Nwosu"
* meta.lastUpdated = "2025-10-25T14:30:00+01:00"
* identifier[PhoneNumber].value = "08045678901"
* identifier[PhoneNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.code = #MOBILE
* identifier[PhoneNumber].type.coding.display = "mobile"
* name.given[0] = "Amaka"
* name.family = "Nwosu"
* gender = #female
* birthDate = "1992-07-15"
* active = true
* address.line[0] = "22 River Road"
* address.city = "Port Harcourt"
* address.district = "ri-oyigbo"
* address.state = "RI"

// -------------------- NgPractitioner ---------------------------
Instance: NgPractitioner-Claim-001
InstanceOf: NgPractitioner
Usage: #inline
Title: "Attending Physician - Dr. Emeka Obi"
* identifier[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-mdcn"
* identifier[0].value = "MDCN-67890"
* active = true
* name.given = "Emeka"
* name.family = "Obi"
* telecom[0].system = #phone
* telecom[0].value = "08098887777"
* birthDate = "1980-11-20"

// -------------------- NgOrganization (Provider) ----------------
Instance: NgOrganization-Provider-Claim-001
InstanceOf: NgProviderOrganization
Usage: #inline
Title: "Rivers State Teaching Hospital"
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier.value = "HCF-RS-5678"
* active = true
* name = "Rivers State Teaching Hospital"
* type.coding.system = "http://terminology.hl7.org/CodeSystem/organization-type"
* type.coding.code = #prov
* type.coding.display = "Healthcare Provider"
* telecom[0].system = #phone
* telecom[0].value = "084-234-5678"
* address.line[0] = "100 Hospital Boulevard"
* address.city = "Port Harcourt"
* address.district = "ri-oyigbo"
* address.state = "RI"
* extension[NGOrganizationOwner].valueCodeableConcept.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-location-owner-cs"
* extension[NGOrganizationOwner].valueCodeableConcept.coding.code = #public

// -------------------- NgOrganization (Insurer) -----------------
Instance: NgOrganization-Insurer-Claim-001
InstanceOf: NgInsurerOrganization
Usage: #inline
Title: "MediCare Plus HMO"
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier.value = "HMO-MC-9988"
* active = true
* name = "MediCare Plus HMO"
* type.coding.system = "http://terminology.hl7.org/CodeSystem/organization-type"
* type.coding.code = #ins
* type.coding.display = "Insurance Company"
* telecom[0].system = #phone
* telecom[0].value = "0700-MEDICARE"
* address.line[0] = "15 Insurance Plaza"
* address.city = "Port Harcourt"
* address.district = "ri-oyigbo"
* address.state = "RI"

// -------------------- NgCoverage -------------------------------
Instance: NgCoverage-Claim-001
InstanceOf: NgCoverage
Usage: #inline
Title: "Coverage - MediCare Plus (Active)"
* status = #active
* type.coding.system = "http://terminology.hl7.org/CodeSystem/v3-ActCode"
* type.coding.code = #EHCPOL
* type.coding.display = "extended healthcare"
* beneficiary = Reference(urn:uuid:aaabbbc2-e5f6-4789-a123-456789abcdef)
* payor[0] = Reference(urn:uuid:ddd44455-e5f6-4789-a123-456789abcdef)
* period.start = "2025-01-01"
* period.end = "2025-12-31"

// -------------------- NgClaim (use=claim) ----------------------
Instance: NgClaim-Claim-001
InstanceOf: NgClaim
Usage: #inline
Title: "Claim - Emergency Surgery & Hospitalization"
* status = #active
* type.coding.system = "http://terminology.hl7.org/CodeSystem/claim-type"
* type.coding.code = #institutional
* type.coding.display = "Institutional"
* use = #claim
* patient = Reference(urn:uuid:aaabbbc2-e5f6-4789-a123-456789abcdef)
* created = "2025-10-25T14:35:00+01:00"
* provider = Reference(urn:uuid:ccc33344-e5f6-4789-a123-456789abcdef)
* priority.coding[0].system = "http://terminology.hl7.org/CodeSystem/processpriority"
* priority.coding[0].code = #normal

// Insurance
* insurance[0].focal = true
* insurance[0].coverage = Reference(urn:uuid:eee55566-e5f6-4789-a123-456789abcdef)
* insurance[0].sequence = 1

// Item 1: Surgery
* item[0].sequence = 1
* item[0].productOrService = http://terminology.hl7.org/CodeSystem/ex-USCLS#1205
* item[0].productOrService.text = "Appendectomy"
* item[0].servicedDate = "2025-10-22"
* item[0].quantity.value = 1
* item[0].unitPrice.value = 150000
* item[0].unitPrice.currency = #NGN
* item[0].net.value = 150000
* item[0].net.currency = #NGN

// Item 2: Hospitalization (3 days)
* item[+].sequence = 2
* item[=].productOrService = http://terminology.hl7.org/CodeSystem/ex-USCLS#1201
* item[=].productOrService.text = "Exam, recall"
* item[=].servicedPeriod.start = "2025-10-22"
* item[=].servicedPeriod.end = "2025-10-25"
* item[=].quantity.value = 3
* item[=].unitPrice.value = 20000
* item[=].unitPrice.currency = #NGN
* item[=].net.value = 60000
* item[=].net.currency = #NGN

// Item 3: Laboratory tests
* item[+].sequence = 3
* item[=].productOrService = http://terminology.hl7.org/CodeSystem/ex-USCLS#1101
* item[=].productOrService.text = "Laboratory Tests"
* item[=].servicedDate = "2025-10-22"
* item[=].quantity.value = 1
* item[=].unitPrice.value = 15000
* item[=].unitPrice.currency = #NGN
* item[=].net.value = 15000
* item[=].net.currency = #NGN

// Item 4: Medications
* item[+].sequence = 4
* item[=].productOrService = http://terminology.hl7.org/CodeSystem/ex-USCLS#1102
* item[=].productOrService.text = "Medications"
* item[=].servicedDate = "2025-10-22"
* item[=].quantity.value = 1
* item[=].unitPrice.value = 25000
* item[=].unitPrice.currency = #NGN
* item[=].net.value = 25000
* item[=].net.currency = #NGN

// Total
* total.value = 250000
* total.currency = #NGN

// -------------------- NgClaimResponse --------------------------
Instance: NgClaimResponse-Claim-001
InstanceOf: NgClaimResponse
Usage: #inline
Title: "Claim Response - Partial Approval"
* status = #active
* type.coding.system = "http://terminology.hl7.org/CodeSystem/claim-type"
* type.coding.code = #institutional
* type.coding.display = "Institutional"
* use = #claim
* patient = Reference(urn:uuid:aaabbbc2-e5f6-4789-a123-456789abcdef)
* created = "2025-10-26T09:15:00+01:00"
* insurer = Reference(urn:uuid:ddd44455-e5f6-4789-a123-456789abcdef)
* outcome = #partial
* disposition = "Claim partially approved. Patient responsible for co-pay and non-covered items."

// Item 1: Surgery - Approved
* item[0].itemSequence = 1
* item[0].adjudication[0].category = http://terminology.hl7.org/CodeSystem/adjudication#eligible
* item[0].adjudication[0].amount.value = 5000
* item[0].adjudication[0].amount.currency = #NGN
* item[0].adjudication[+].category = http://terminology.hl7.org/CodeSystem/adjudication#benefit
* item[0].adjudication[=].amount.value = 4500
* item[0].adjudication[=].amount.currency = #NGN
* item[0].adjudication[+].category = http://terminology.hl7.org/CodeSystem/adjudication#copay
* item[0].adjudication[=].amount.value = 500
* item[0].adjudication[=].amount.currency = #NGN

// Item 2: Hospitalization - Approved
* item[+].itemSequence = 2
* item[=].adjudication[0].category = http://terminology.hl7.org/CodeSystem/adjudication#eligible
* item[=].adjudication[0].amount.value = 3000
* item[=].adjudication[0].amount.currency = #NGN
* item[=].adjudication[+].category = http://terminology.hl7.org/CodeSystem/adjudication#benefit
* item[=].adjudication[=].amount.value = 3000
* item[=].adjudication[=].amount.currency = #NGN

// Item 3: Laboratory - Approved
* item[+].itemSequence = 3
* item[=].adjudication[0].category.coding = http://terminology.hl7.org/CodeSystem/adjudication#eligible
* item[=].adjudication[0].amount.value = 15000
* item[=].adjudication[0].amount.currency = #NGN
* item[=].adjudication[+].category.coding = http://terminology.hl7.org/CodeSystem/adjudication#benefit
* item[=].adjudication[=].amount.value = 1500
* item[=].adjudication[=].amount.currency = #NGN
* item[=].adjudication[+].category = http://terminology.hl7.org/CodeSystem/adjudication#copay
* item[=].adjudication[=].amount.value = 0
* item[=].adjudication[=].amount.currency = #NGN

// Item 4: Medications - Partially covered
* item[+].itemSequence = 4
* item[=].adjudication[0].category = http://terminology.hl7.org/CodeSystem/adjudication#eligible
* item[=].adjudication[0].amount.value = 2000
* item[=].adjudication[0].amount.currency = #NGN
* item[=].adjudication[+].category = http://terminology.hl7.org/CodeSystem/adjudication#benefit
* item[=].adjudication[=].amount.value = 2000
* item[=].adjudication[=].amount.currency = #NGN
* item[=].adjudication[+].category = http://terminology.hl7.org/CodeSystem/adjudication#copay
* item[=].adjudication[=].amount.value = 0
* item[=].adjudication[=].amount.currency = #NGN

// Total adjudication
* total[0].category.coding = http://terminology.hl7.org/CodeSystem/adjudication#submitted
* total[0].amount.value = 25000
* total[0].amount.currency = #NGN

* total[+].category.coding = http://terminology.hl7.org/CodeSystem/adjudication#benefit
* total[=].amount.value = 23000
* total[=].amount.currency = #NGN

* total[+].category = http://terminology.hl7.org/CodeSystem/adjudication#copay
* total[=].amount.value = 2000
* total[=].amount.currency = #NGN

// Payment
* payment.type = http://terminology.hl7.org/CodeSystem/ex-paymenttype#complete
* payment.amount.value = 25000
* payment.amount.currency = #NGN
* payment.date = "2025-10-30"

// -------------------- NgExplanationOfBenefit -------------------
Instance: NgEOB-Claim-001
InstanceOf: NgExplanationOfBenefit
Usage: #inline
Title: "EOB - Detailed Benefit Explanation"
* status = #active
* type = http://terminology.hl7.org/CodeSystem/claim-type#institutional
* use = #claim
* patient = Reference(urn:uuid:aaabbbc2-e5f6-4789-a123-456789abcdef)
* created = "2025-10-26T09:15:00+01:00"
* insurer = Reference(urn:uuid:ddd44455-e5f6-4789-a123-456789abcdef)
* provider = Reference(urn:uuid:ccc33344-e5f6-4789-a123-456789abcdef)
* outcome = #partial
* insurance[0].focal = true
* insurance[0].coverage = Reference(urn:uuid:eee55566-e5f6-4789-a123-456789abcdef)

// Item details matching claim
* item[0].sequence = 1
* item[0].productOrService.coding = http://terminology.hl7.org/CodeSystem/ex-USCLS#1205
* item[0].servicedDate = "2025-10-22"
* item[0].adjudication[0].category.coding = http://terminology.hl7.org/CodeSystem/adjudication#eligible
* item[0].adjudication[0].amount.value = 15000
* item[0].adjudication[0].amount.currency = #NGN
* item[0].adjudication[+].category.coding = http://terminology.hl7.org/CodeSystem/adjudication#benefit
* item[0].adjudication[=].amount.value = 13000
* item[0].adjudication[=].amount.currency = #NGN

* item[+].sequence = 2
* item[=].productOrService.coding = http://terminology.hl7.org/CodeSystem/ex-USCLS#1201
* item[=].servicedPeriod.start = "2025-10-22"
* item[=].servicedPeriod.end = "2025-10-25"
* item[=].adjudication[0].category.coding = http://terminology.hl7.org/CodeSystem/adjudication#benefit
* item[=].adjudication[0].amount.value = 6000
* item[=].adjudication[0].amount.currency = #NGN

* item[+].sequence = 3
* item[=].productOrService.coding = http://terminology.hl7.org/CodeSystem/ex-USCLS#1101
* item[=].servicedDate = "2025-10-22"
* item[=].adjudication[0].category.coding = http://terminology.hl7.org/CodeSystem/adjudication#benefit
* item[=].adjudication[0].amount.value = 1500
* item[=].adjudication[0].amount.currency = #NGN

* item[+].sequence = 4
* item[=].productOrService.coding = http://terminology.hl7.org/CodeSystem/ex-USCLS#1102
* item[=].servicedDate = "2025-10-22"
* item[=].adjudication[0].category.coding = http://terminology.hl7.org/CodeSystem/adjudication#benefit
* item[=].adjudication[0].amount.value = 1500
* item[=].adjudication[0].amount.currency = #NGN

// Totals
* total[0].category.coding = http://terminology.hl7.org/CodeSystem/adjudication#submitted
* total[0].amount.value = 2500
* total[0].amount.currency = #NGN

* total[+].category.coding = http://terminology.hl7.org/CodeSystem/adjudication#benefit
* total[=].amount.value = 22000
* total[=].amount.currency = #NGN

// Payment info
* payment.type = http://terminology.hl7.org/CodeSystem/ex-paymenttype#complete
* payment.amount.value = 2200
* payment.amount.currency = #NGN
* payment.date = "2025-10-30"