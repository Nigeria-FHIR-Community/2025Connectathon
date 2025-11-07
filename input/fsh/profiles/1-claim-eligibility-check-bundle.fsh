
// ======================================================================
// Profile: NgEligibilityCheckBundle
// ======================================================================
Profile: NgEligibilityCheckBundle
Parent: Bundle
Id: ng-eligibility-check-bundle
Title: "1-NGClaim 1 Eligibility Check Bundle (Request/Response)"
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
* entry[providerOrg].resource only NgProviderOrganization


// ---- CoverageEligibilityRequest (REQUEST bundle) ----
* entry[cerRequest].resource only NgCoverageEligibilityRequest
* entry[cerRequest].request.method ^short = "POST for transaction requests"
* entry[cerRequest].request.url ^short    = "NgCoverageEligibilityRequest"

// ---- Insurer Organization (RESPONSE bundle) ----
* entry[insurerOrg].resource only NgInsurerOrganization


// ---- Coverage (returned by insurer) ----
* entry[coverage].resource only NgCoverage

// ---- CoverageEligibilityResponse (RESPONSE bundle) ----
* entry[cerResponse].resource only NgCoverageEligibilityResponse

// -------------------- Helpful soft invariants (warnings) --------------------
// Limit bundle.type to the two intended codes
Invariant: ngelig-type
Description: "Bundle.type SHOULD be either 'transaction' (request) or 'collection' (response)."
Severity: #warning
Expression: "type in ('transaction'|'collection')"

// If it's a transaction request, suggest presence of CER and HTTP requests
Invariant: ngelig-request-shape
Description: "If type = 'transaction', bundle SHOULD include a NgCoverageEligibilityRequest and each entry SHOULD carry a request.method/url."
Severity: #warning
Expression: "(type != 'transaction') or (entry.resource.ofType(NgCoverageEligibilityRequest).exists() and entry.request.exists())"

// If it's a collection response, suggest presence of CER response and Coverage
Invariant: ngelig-response-shape
Description: "If type = 'collection', bundle SHOULD include a NgCoverageEligibilityResponse and a NgCoverage resource."
Severity: #warning
Expression: "(type != 'collection') or (entry.resource.ofType(NgCoverageEligibilityResponse).exists() and entry.resource.ofType(NgCoverage).exists())"

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
Instance: NgEligibilityCheck-Request
InstanceOf: NgEligibilityCheckBundle //modified to fix linkages
Usage: #example
Title: "Eligibility Check - Request (Transaction)"
Description: "Hospital requests HMO eligibility for a patient."
* type = #transaction

// Patient -------------------------------------------------------
* entry[0].fullUrl = "urn:uuid:aaabbbcc-e5f6-4789-a123-456789abcdef"
* entry[0].resource = NgPatient-Elig-001

// Practitioner (ordering/attending) ----------------------------
* entry[+].fullUrl = "urn:uuid:bbbcccdd-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgPractitioner-Elig-001

// Hospital Organization (provider) -----------------------------
* entry[+].fullUrl = "urn:uuid:cccdddee-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgOrganization-Hospital-001

// Eligibility Request ------------------------------------------
* entry[+].fullUrl = "urn:uuid:dddeeeff-e5f6-4789-a123-456789abcdef"
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
Instance: NgEligibilityCheck-Response
InstanceOf: NgEligibilityCheckBundle
Usage: #example
Title: "Eligibility Check - Response (Collection)"
Description: "Insurer's response indicating coverage and eligibility outcome."
* type = #collection

// Patient echo (optional but helpful for correlation) ----------
* entry[0].fullUrl = "urn:uuid:aaabbbcc-e5f6-4789-a123-456789abcdef"
* entry[0].resource = NgPatient-Elig-001

// Insurer Organization -----------------------------------------
* entry[+].fullUrl = "urn:uuid:cccdddee-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgOrganization-Insurer-001

// Coverage (the 'converge' -> Coverage) ------------------------
* entry[+].fullUrl = "urn:uuid:fffaaabb-e5f6-4789-a123-456789abcdef"
* entry[=].resource = NgCoverage-Elig-001

// Eligibility Response -----------------------------------------
* entry[+].fullUrl = "urn:uuid:abababab-e5f6-4789-a123-456789abcdef"
* entry[=].resource = CER-Response-001



// ===============================================================
// Inline Resources
// ===============================================================

// -------------------- NgPatient (requires meta.lastUpdated) ----
Instance: NgPatient-Elig-001
InstanceOf: NgPatient
Usage: #example
Title: "Eligibility Patient"
Description: "A Patient whose service eligibility is being sorth."
* meta.lastUpdated = "2025-10-15T09:00:00+01:00"
* identifier[PhoneNumber].value = "08031112222"
* identifier[PhoneNumber].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* identifier[PhoneNumber].type.coding.code = #MOBILE
* identifier[PhoneNumber].type.coding.display = "mobile"
* name.given[0] = "Aisha"
* name.family = "Bello"
* gender = #female
* active = true
* birthDate = "1990-04-21"
* address.line[0] = "12 PHC Road"
* address.city = "Garki"
* address.district = "fc-municipal"
* address.state = "FC"

// -------------------- NgPractitioner ---------------------------
Instance: NgPractitioner-Elig-001
InstanceOf: NgPractitioner
Usage: #example
Title: "Attending Practitioner"
Description: "A Healthcare provider checking for a given Patient's eligibility for service."
* identifier[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-mdcn"
* identifier[0].value = "MDCN-45231"
* active = true
* name.given = "Nkiru"
* name.family = "Okafor"
* telecom[0].system = #phone
* telecom[0].value = "08090001111"
* birthDate = "1985-03-05"

// -------------------- NgOrganization (Hospital) ----------------
Instance: NgOrganization-Hospital-001
InstanceOf: NgProviderOrganization
Usage: #example
Title: "City General Hospital"
Description: "A Hospital organization where a Patient has gone for service."
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier.value = "CLM-2025-0001"
* active = true
* name = "City General Hospital"
* type.coding.system = "http://terminology.hl7.org/CodeSystem/organization-type"
* type.coding.code = #prov
* type.coding.display = "Healthcare Provider"
* telecom[0].system = #phone
* telecom[0].value = "01-445-7788"
* address.line[0] = "25 Hospital Way"
* address.city = "Garki"
* address.district = "fc-municipal"
* address.state = "FC"

// -------------------- CoverageEligibilityRequest (base) --------
Instance: CER-Request-001
InstanceOf: NgCoverageEligibilityRequest
Usage: #example
Title: "Eligibility Request - HMO Benefits"
Description: "The request sent to a HMO from a Hospital."
* status = #active
* purpose[0] = #benefits
* patient = Reference(urn:uuid:aaabbbcc-e5f6-4789-a123-456789abcdef)
* created = "2025-10-15T09:05:00+01:00"
// Provider can be Practitioner or Organization; include both contextually
* provider = Reference(urn:uuid:bbbcccdd-e5f6-4789-a123-456789abcdef)
* insurer = Reference(urn:uuid:cccdddee-e5f6-4789-a123-456789abcdef)
// Optional facility context (requestor organization)
* facility = Reference(NgLocation-001)
* item.category.coding.system = "http://terminology.hl7.org/CodeSystem/ex-benefitcategory"
* item.category.coding.code = #1


// -------------------- NgCoverage (returned by insurer) ---------
Instance: NgCoverage-Elig-001
InstanceOf: NgCoverage
Usage: #example
Title: "Coverage - Harmony HMO (Active)"
Description: "The Coverage of a Patient."
* status = #active
* type.coding.system = "http://terminology.hl7.org/CodeSystem/v3-ActCode"
* type.coding.code = #EHCPOL     // health insurance policy
* type.coding.display = "extended healthcare"
* beneficiary = Reference(urn:uuid:aaabbbcc-e5f6-4789-a123-456789abcdef)
* payor[0] = Reference(urn:uuid:cccdddee-e5f6-4789-a123-456789abcdef)
* period.start = "2025-01-01"
* period.end = "2025-12-31"

// -------------------- CoverageEligibilityResponse (base) --------
Instance: CER-Response-001
InstanceOf: NgCoverageEligibilityResponse
Usage: #example
Title: "Eligibility Response - Approved"
Description: "The response sent from HMO to Hospital to confirm eligibility or not."
* status = #active
* purpose[0] = #benefits
* patient = Reference(urn:uuid:aaabbbcc-e5f6-4789-a123-456789abcdef)
* created = "2025-10-15T09:06:30+01:00"
* insurer = Reference(urn:uuid:cccdddee-e5f6-4789-a123-456789abcdef)
* outcome = #complete
* request = Reference(urn:uuid:dddeeeff-e5f6-4789-a123-456789abcdef)
* disposition = "Eligible for covered services per active policy."
* insurance[0].coverage = Reference(urn:uuid:fffaaabb-e5f6-4789-a123-456789abcdef)
* insurance[0].inforce = true
// Optional: add a simple item/category note for clarity
* insurance[0].item[0].category.text = "Outpatient"
* insurance[0].item[0].category.coding = http://terminology.hl7.org/CodeSystem/ex-benefitcategory#1
* insurance[0].item[0].benefit[0].type.text = "vision-exam"
* insurance[0].item[0].benefit[0].type.coding = http://terminology.hl7.org/CodeSystem/benefit-type#copay
* insurance[0].item[0].benefit[0].allowedUnsignedInt = 1
