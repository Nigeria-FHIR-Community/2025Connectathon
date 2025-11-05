// ======================================================================
// Profile: NgPreAuthorizationBundle  (fixed)
// ======================================================================
Profile: NgPreAuthorizationBundle
Parent: Bundle
Id: ng-preauthorization-bundle
Title: "2-NG Pre-Authorization Bundle (Request or Response)"
Description: """
One bundle profile that supports both:
- Pre-Authorization Request (type=transaction): Patient, Practitioner, Provider Org, Insurer Org, Coverage, and a Claim (use=preauthorization)
- Pre-Authorization Response (type=collection): Patient (echo), Insurer Org, Coverage (echo), and a ClaimResponse (decision)
"""
* ^status = #active

// Core
* type 1..1 MS
* entry 2..* MS
* entry.fullUrl 1..1 MS
* entry.resource 1..1 MS
* entry.request 0..1
* entry.request.method 1..1
* entry.request.url 1..1

// Slice by resource profile
* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #open

// Named slices
* entry contains
    patient 1..1 MS and
    practitioner 0..1 MS and
    providerOrg 0..1 MS and
    insurerOrg 0..1 MS and
    coverage 0..1 MS and
    claim 0..1 MS and
    claimResponse 0..1 MS

* entry[patient].resource only NgPatient
* entry[practitioner].resource only NgPractitioner
* entry[providerOrg].resource only NgOrganization
* entry[insurerOrg].resource only NgOrganization
* entry[coverage].resource only NgCoverage
* entry[claim].resource only NgClaim
* entry[claimResponse].resource only NgClaimResponse

* entry.fullUrl ^short = "Prefer URN UUID (urn:uuid:...) for intra-bundle references."

// Invariants
Invariant: ngpra-transaction-shape
Description: "If Bundle.type = 'transaction', include ≥1 Claim, ≥2 Organizations, and every entry has request.method & request.url."
Severity: #error
Expression: "(type = 'transaction') implies (entry.resource.ofType(Claim).count() >= 1 and entry.resource.ofType(Organization).count() >= 2 and entry.request.all(method.exists() and url.exists()))"

Invariant: ngpra-claim-use-preauth
Description: "When a Claim is present, it SHOULD be for preauthorization."
Severity: #warning
Expression: "entry.resource.ofType(Claim).all(use = 'preauthorization')"

Invariant: ngpra-collection-shape
Description: "If Bundle.type = 'collection', include ≥1 ClaimResponse and ≥1 Organization."
Severity: #error
Expression: "(type = 'collection') implies (entry.resource.ofType(ClaimResponse).count() >= 1 and entry.resource.ofType(Organization).count() >= 1)"


// ===============================================================
// REQUEST BUNDLE (transaction) — fixed
// ===============================================================
Instance: PreAuth-Request
InstanceOf: NgPreAuthorizationBundle
Usage: #example
Title: "Pre-Authorization - Request (Transaction)"
Description: "Hospital requests payer authorization before delivering a service."
* type = #transaction

// Patient
* entry[0].fullUrl = "urn:uuid:pat-preauth-001"
* entry[0].resource = NgPatient-PreAuth-001
* entry[0].request.method = #POST
* entry[0].request.url = "Patient"

// Practitioner
* entry[+].fullUrl = "urn:uuid:prac-preauth-001"
* entry[=].resource = NgPractitioner-PreAuth-001
* entry[=].request.method = #POST
* entry[=].request.url = "Practitioner"

// Provider Organization (Hospital)
* entry[+].fullUrl = "urn:uuid:org-provider-001"
* entry[=].resource = NgOrganization-Provider-001
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

// Insurer Organization (Payer)  -- use *ONE* insurer (-001)
* entry[+].fullUrl = "urn:uuid:org-insurer-001"
* entry[=].resource = NgOrganization-Insurer-001
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

// Coverage (policy)
* entry[+].fullUrl = "urn:uuid:cov-preauth-001"
* entry[=].resource = NgCoverage-PreAuth-001
* entry[=].request.method = #POST
* entry[=].request.url = "Coverage"

// Claim (use = preauthorization)
* entry[+].fullUrl = "urn:uuid:claim-preauth-001"
* entry[=].resource = NgClaim-PreAuth-001
* entry[=].request.method = #POST
* entry[=].request.url = "Claim"


// ===============================================================
// RESPONSE BUNDLE (collection) — fixed
// ===============================================================
Instance: PreAuth-Response
InstanceOf: NgPreAuthorizationBundle
Usage: #example
Title: "Pre-Authorization - Response (Collection)"
Description: "Payer response to pre-authorization request."
* type = #collection

// Patient (echo)
* entry[0].fullUrl = "urn:uuid:pat-preauth-001"
* entry[0].resource = NgPatient-PreAuth-001

// Insurer (payer)  -- same org and same URN as in request
* entry[+].fullUrl = "urn:uuid:org-insurer-002"
* entry[=].resource = NgOrganization-Insurer-002

// Coverage (echo)
* entry[+].fullUrl = "urn:uuid:cov-preauth-001"
* entry[=].resource = NgCoverage-PreAuth-001

// ClaimResponse (decision)
* entry[+].fullUrl = "urn:uuid:claimresp-preauth-001"
* entry[=].resource = NgClaimResponse-PreAuth-001



// ===============================================================
// Inline Resources (aligned to Ng* profiles)
// ===============================================================

// -------------------- NgPatient (PhoneNumber slice aligned) ----
Instance: NgPatient-PreAuth-001
InstanceOf: NgPatient
Usage: #inline
Title: "PreAuth Patient"
* meta.lastUpdated = "2025-10-20T10:15:00+01:00"
* identifier[PhoneNumber].value = "08034561234"
* identifier[PhoneNumber].system = "http://mtnonline.com/phone-no"
* identifier[PhoneNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.code = #MOBILE
* identifier[PhoneNumber].type.coding.display = "mobile"
* name.given[0] = "Chinedu"
* name.family = "Okeke"
* gender = #male
* birthDate = "1988-09-12"
* active = true
* address.line[0] = "10 PHC Lane"
* address.city = "Garki"
* address.district = "abuja-municipal"
* address.state = "FC"

// -------------------- NgPractitioner ---------------------------
Instance: NgPractitioner-PreAuth-001
InstanceOf: NgPractitioner
Usage: #inline
Title: "Requesting Clinician"
* identifier[0].system = "https://mdcn.gov.ng/practitioner-id"
* identifier[0].value = "MDCN-012345"
* active = true
* name.given = "Hadiza"
* name.family = "Ibrahim"
* telecom[0].system = #phone
* telecom[0].value = "08090002222"
* birthDate = "1983-05-04"

// -------------------- NgOrganization (Provider/Hospital) -------
Instance: NgOrganization-Provider-001
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

// -------------------- NgOrganization (Insurer/Payer) -----------

Instance: NgOrganization-Insurer-001
InstanceOf: NgOrganization
Usage: #inline
Title: "Harmony HMO"
* identifier.system = "https://nhia.gov.ng/hmo-code"
* identifier.value = "NHIA-HMO-0021"
* active = true
* name = "Harmony HMO"
* type.coding.system = "https://www.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type.coding.code = #payer
* type.coding.display = "Health Maintenance Organization"
* telecom[0].system = #phone
* telecom[0].value = "0700-HARMONY"
* address.line[0] = "7 Insurance Crescent"
* address.city = "Victoria Island"
* address.district = "eti-osa"
* address.state = "LA"

Instance: NgOrganization-Insurer-002
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

// -------------------- NgCoverage (Policy) ----------------------
Instance: NgCoverage-PreAuth-001
InstanceOf: NgCoverage
Usage: #inline
Title: "Coverage - PrimeCare HMO (Active)"
* status = #active
* type.coding.system = "http://terminology.hl7.org/CodeSystem/v3-ActCode"
* type.coding.code = #EHCPOL
* type.coding.display = "extended healthcare"
* beneficiary = Reference(urn:uuid:pat-preauth-001)
* payor[0] = Reference(urn:uuid:org-insurer-001)
* period.start = "2025-01-01"
* period.end = "2025-12-31"

// -------------------- NgClaim (use=preauthorization) -----------
Instance: NgClaim-PreAuth-001
InstanceOf: NgClaim
Usage: #inline
Title: "2-Pre-Authorization Claim"
* status = #active
* type.coding.system = "http://terminology.hl7.org/CodeSystem/claim-type"
* type.coding.code = #institutional
* type.coding.display = "Institutional"
* use = #preauthorization
* patient = Reference(urn:uuid:pat-preauth-001)
* created = "2025-10-20T10:20:00+01:00"
* provider = Reference(urn:uuid:org-provider-001)
// At least one item
* item[0].sequence = 1
* item[0].productOrService.coding[0].system = "http://snomed.info/sct"
* item[0].productOrService.coding[0].code = #16310003
* item[0].productOrService.coding[0].display = "Ultrasonography of abdomen (procedure)"
* item[0].quantity.value = 1
* item[0].unitPrice.value = 25000
* item[0].unitPrice.currency = #NGN
// Insurance (required; focal + coverage)
* insurance[0].focal = true
* insurance[0].coverage = Reference(urn:uuid:cov-preauth-001)
* insurance[0].sequence = 1
// Priority
* priority.coding[0].system = "http://terminology.hl7.org/CodeSystem/processpriority"
* priority.coding[0].code = #normal

// -------------------- NgClaimResponse (decision) ---------------
Instance: NgClaimResponse-PreAuth-001
InstanceOf: NgClaimResponse
Usage: #inline
Title: "Pre-Authorization Decision"
* status = #active
* type.coding.system = "http://terminology.hl7.org/CodeSystem/claim-type"
* type.coding.code = #institutional
* type.coding.display = "Institutional"
* use = #preauthorization
* patient = Reference(urn:uuid:pat-preauth-001)
* created = "2025-10-20T10:45:00+01:00"
* insurer = Reference(urn:uuid:org-insurer-001)
* outcome = #complete
* item[0].itemSequence = 1
* item[0].adjudication[0].category.coding[0].system = "http://terminology.hl7.org/CodeSystem/adjudication"
* item[0].adjudication[0].category.coding[0].code = #eligible
* item[0].adjudication[0].amount.value = 25000
* item[0].adjudication[0].amount.currency = #NGN
