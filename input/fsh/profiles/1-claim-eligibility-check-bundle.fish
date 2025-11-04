
// ======================================================================
// Profile: NgEligibilityCheckBundle
// ======================================================================
Profile: NgEligibilityCheckBundle
Parent: Bundle
Id: ng-eligibility-check-bundle
Title: "NG Eligibility Check Bundle (Request/Response)"
Description: """
Single Bundle profile that supports BOTH:
  • Transaction request from a hospital to an HMO (type = transaction)
  • Collection response from an insurer/HMO (type = collection)
It allows Patient, Practitioner, Organizations, Coverage, and
CoverageEligibilityRequest/Response with minimal constraints to reduce QA noise.
"""

* ^status = #active

// -------------------- Bundle core --------------------
* type 1..1 MS
* entry 1..* MS
* entry.fullUrl 1..1 MS
* entry.resource 1..1 MS

// For request bundles (transaction), HTTP requests are present;
// for response bundles (collection), they are not. Keep optional.
* entry.request 0..1
* entry.request.method 1..1
* entry.request.url 1..1

// -------------------- Slice entries by resource/profile --------------------
* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #open

// Named slices used across REQUEST and RESPONSE flows
* entry contains
    patient            0..1 MS and
    practitioner       0..1 MS and
    providerOrg        0..1 MS and
    cerRequest         0..1 MS and
    insurerOrg         0..1 MS and
    coverage           0..1 MS and
    cerResponse        0..1 MS

// ---- Patient ----
* entry[patient].resource only NgPatient
* entry[patient].fullUrl ^short = "Prefer URN UUID (urn:uuid:...) for intra-bundle refs."

// ---- Practitioner (ordering/attending) ----
* entry[practitioner].resource only NgPractitioner

// ---- Hospital/Provider Organization ----
* entry[providerOrg].resource only NgOrganization

// ---- CoverageEligibilityRequest (REQUEST bundle) ----
* entry[cerRequest].resource only CoverageEligibilityRequest
// When present in a transaction request, typical REST directives:
* entry[cerRequest].request.method ^short = "POST for transaction requests"
* entry[cerRequest].request.url ^short    = "CoverageEligibilityRequest"

// ---- Insurer Organization (RESPONSE bundle) ----
* entry[insurerOrg].resource only NgOrganization

// ---- Coverage (returned by insurer) ----
* entry[coverage].resource only NgCoverage

// ---- CoverageEligibilityResponse (RESPONSE bundle) ----
* entry[cerResponse].resource only CoverageEligibilityResponse

// -------------------- Helpful soft invariants (warnings) --------------------
// Limit bundle.type to the two intended codes
Invariant: ngelig-type
Description: "Bundle.type SHOULD be either 'transaction' (request) or 'collection' (response)."
Severity: #warning
Expression: "type in ('transaction'|'collection')"

// If it's a transaction request, suggest presence of CER and HTTP requests
Invariant: ngelig-request-shape
Description: "If type = 'transaction', bundle SHOULD include a CoverageEligibilityRequest and each entry SHOULD carry a request.method/url."
Severity: #warning
Expression: "(type != 'transaction') or (entry.resource.ofType(CoverageEligibilityRequest).exists() and entry.request.exists())"

// If it's a collection response, suggest presence of CER response and Coverage
Invariant: ngelig-response-shape
Description: "If type = 'collection', bundle SHOULD include a CoverageEligibilityResponse and a Coverage resource."
Severity: #warning
Expression: "(type != 'collection') or (entry.resource.ofType(CoverageEligibilityResponse).exists() and entry.resource.ofType(Coverage).exists())"

// Encourage URN UUIDs for intra-bundle references
Invariant: ngelig-urn-uuids
Description: "Entries SHOULD use URN UUID fullUrls for local intra-bundle references."
Severity: #warning
Expression: "entry.fullUrl.all(matches('^urn:uuid:'))"




// ===============================================================
// HMO Eligibility Check Bundles (Request + Response)
// ===============================================================

// ---------------------------------------------------------------
// REQUEST BUNDLE (transaction)
// ---------------------------------------------------------------
Instance: EligibilityCheck-Request
InstanceOf: Bundle
Usage: #example
Title: "Eligibility Check - Request (Transaction)"
Description: "Hospital requests HMO eligibility for a patient."
* type = #transaction

// Patient -------------------------------------------------------
* entry[0].fullUrl = "urn:uuid:pat-elig-001"
* entry[0].resource = NgPatient-Elig-001

// Practitioner (ordering/attending) ----------------------------
* entry[+].fullUrl = "urn:uuid:prac-elig-001"
* entry[=].resource = NgPractitioner-Elig-001

// Hospital Organization (provider) -----------------------------
* entry[+].fullUrl = "urn:uuid:org-hospital-001"
* entry[=].resource = NgOrganization-Hospital-001

// Eligibility Request ------------------------------------------
* entry[+].fullUrl = "urn:uuid:cer-req-001"
* entry[=].resource = CER-Request-001

// Transaction methods/urls -------------------------------------
* entry[0].request.method = #POST
* entry[0].request.url = "Patient"
* entry[1].request.method = #POST
* entry[1].request.url = "Practitioner"
* entry[2].request.method = #POST
* entry[2].request.url = "Organization"
* entry[3].request.method = #POST
* entry[3].request.url = "CoverageEligibilityRequest"


// ---------------------------------------------------------------
// RESPONSE BUNDLE (collection)
// ---------------------------------------------------------------
Instance: EligibilityCheck-Response
InstanceOf: Bundle
Usage: #example
Title: "Eligibility Check - Response (Collection)"
Description: "Insurer's response indicating coverage and eligibility outcome."
* type = #collection

// Patient echo (optional but helpful for correlation) ----------
* entry[0].fullUrl = "urn:uuid:pat-elig-001"
* entry[0].resource = NgPatient-Elig-001

// Insurer Organization -----------------------------------------
* entry[+].fullUrl = "urn:uuid:org-insurer-001"
* entry[=].resource = NgOrganization-Insurer-001

// Coverage (the 'converge' -> Coverage) ------------------------
* entry[+].fullUrl = "urn:uuid:cov-elig-001"
* entry[=].resource = NgCoverage-Elig-001

// Eligibility Response -----------------------------------------
* entry[+].fullUrl = "urn:uuid:cer-resp-001"
* entry[=].resource = CER-Response-001



// ===============================================================
// Inline Resources (kept minimal & aligned to your profiles)
// ===============================================================

// -------------------- NgPatient (requires meta.lastUpdated) ----
Instance: NgPatient-Elig-001
InstanceOf: NgPatient
Usage: #inline
Title: "Eligibility Patient"
* meta.lastUpdated = "2025-10-15T09:00:00+01:00"
* identifier[PhoneNumber].value = "08031112222"
* identifier[PhoneNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.code = #MOBILE
* identifier[PhoneNumber].type.coding.display = "Primary Mobile Phone Number of the Client or CareGiver"
* name.given[0] = "Aisha"
* name.family = "Bello"
* gender = #female
* active = true
* birthDate = "1990-04-21"
* address.line[0] = "12 PHC Road"
* address.city = "Garki"
* address.district = "abuja-municipal"
* address.state = "FC"

// -------------------- NgPractitioner ---------------------------
Instance: NgPractitioner-Elig-001
InstanceOf: NgPractitioner
Usage: #inline
Title: "Attending Practitioner"
* identifier[0].system = "https://mdcn.gov.ng/practitioner-id"
* identifier[0].value = "MDCN-009988"
* active = true
* name.given = "Nkiru"
* name.family = "Okafor"
* telecom[0].system = #phone
* telecom[0].value = "08090001111"
* birthDate = "1985-03-05"

// -------------------- NgOrganization (Hospital) ----------------
Instance: NgOrganization-Hospital-001
InstanceOf: NgOrganization
Usage: #inline
Title: "City General Hospital"
* identifier.system = "https://hfr.health.gov.ng/facility-id"
* identifier.value = "HCF-56789"
* active = true
* name = "City General Hospital"
* type.coding.system = "https://www.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type.coding.code = #hospital
* type.coding.display = "Secondary Hospital"
* telecom[0].system = #phone
* telecom[0].value = "01-445-7788"
* address.line[0] = "25 Hospital Way"
* address.city = "Garki"
* address.district = "abuja-municipal"
* address.state = "FC"

// -------------------- CoverageEligibilityRequest (base) --------
Instance: CER-Request-001
InstanceOf: CoverageEligibilityRequest
Usage: #inline
Title: "Eligibility Request - HMO Benefits"
* status = #active
* purpose[0] = #benefits
* patient = Reference(urn:uuid:pat-elig-001)
* created = "2025-10-15T09:05:00+01:00"
// Provider can be Practitioner or Organization; include both contextually
* provider = Reference(urn:uuid:prac-elig-001)
* insurer = Reference(urn:uuid:org-insurer-001)
// Optional facility context (requestor organization)
* facility = Reference(urn:uuid:org-hospital-001)


// -------------------- NgCoverage (returned by insurer) ---------
Instance: NgCoverage-Elig-001
InstanceOf: NgCoverage
Usage: #inline
Title: "Coverage - Harmony HMO (Active)"
* status = #active
* type.coding.system = "http://terminology.hl7.org/CodeSystem/v3-ActCode"
* type.coding.code = #EHCPOL     // health insurance policy
* type.coding.display = "extended healthcare"
* beneficiary = Reference(urn:uuid:pat-elig-001)
* payor[0] = Reference(urn:uuid:org-insurer-001)
* period.start = "2025-01-01"
* period.end = "2025-12-31"

// -------------------- CoverageEligibilityResponse (base) --------
Instance: CER-Response-001
InstanceOf: CoverageEligibilityResponse
Usage: #inline
Title: "Eligibility Response - Approved"
* status = #active
* purpose[0] = #benefits
* patient = Reference(urn:uuid:pat-elig-001)
* created = "2025-10-15T09:06:30+01:00"
* insurer = Reference(urn:uuid:org-insurer-001)
* outcome = #complete
* request = Reference(urn:uuid:cer-req-001)
* disposition = "Eligible for covered services per active policy."
* insurance[0].coverage = Reference(urn:uuid:cov-elig-001)
* insurance[0].inforce = true
// Optional: add a simple item/category note for clarity
* insurance[0].item[0].category.text = "Outpatient"
* insurance[0].item[0].benefit[0].type.text = "Consultation"
* insurance[0].item[0].benefit[0].allowedUnsignedInt = 1
