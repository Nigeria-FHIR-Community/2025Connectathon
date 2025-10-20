// ====================================================================
// Profile: HL7R4BundleEquivalent
// Mirrors the core HL7 FHIR R4 Bundle definition in FSH form,
// including cardinalities, bindings, and key invariants from the spec.
// Source: https://www.hl7.org/fhir/R4/bundle.html  (R4 v4.0.1)
// ====================================================================

Alias: $BundleType = http://hl7.org/fhir/ValueSet/bundle-type
Alias: $HTTPVerb = http://hl7.org/fhir/ValueSet/http-verb
Alias: $SearchEntryMode = http://hl7.org/fhir/ValueSet/search-entry-mode

Profile: HL7R4BundleEquivalent
Parent: Bundle
Id: hl7-r4-bundle-equivalent
Title: "HL7 R4 Bundle (Equivalent Mirror)"
Description: "FSH mirror of HL7 FHIR R4 Bundle: cardinalities, bindings, and normative rules expressed as invariants to emulate the base spec."

// ---- Top-level elements (restate key cardinalities/types/bindings) ----
* identifier 0..1
* type 1..1
* type from $BundleType (required)
* timestamp 0..1
* total 0..1
* link 0..*
* entry 0..*
* signature 0..1

// ---- link backbone ----
* link.relation 1..1
* link.relation ^short = "IANA link relation"
* link.url 1..1

// ---- entry backbone ----
* entry.link 0..*
* entry.fullUrl 0..1
* entry.resource 0..1
* entry.search 0..1
* entry.request 0..1
* entry.response 0..1

// entry.link
* entry.link.relation 1..1
* entry.link.url 1..1

// entry.search
* entry.search.mode 0..1
* entry.search.mode from $SearchEntryMode (required)
* entry.search.score 0..1

// entry.request
* entry.request.method 1..1
* entry.request.method from $HTTPVerb (required)
* entry.request.url 1..1
* entry.request.ifNoneMatch 0..1
* entry.request.ifModifiedSince 0..1
* entry.request.ifMatch 0..1
* entry.request.ifNoneExist 0..1

// entry.response
* entry.response.status 1..1
* entry.response.location 0..1
* entry.response.etag 0..1
* entry.response.lastModified 0..1
* entry.response.outcome 0..1

// ---- Invariants (FHIRPath) reflecting normative rules in the spec) ----
// total only when a search or history bundle
Invariant: bdl-total-only-search-or-history
Description: "total is present only for type=searchset or type=history"
Severity: #error
Expression: "total.exists() implies (type = 'searchset' or type = 'history')"

// entry.search only when search bundle
Invariant: bdl-search-only-on-searchset
Description: "entry.search is present only for type=searchset"
Severity: #error
Expression: "entry.search.exists() implies type = 'searchset'"

// entry.request required for batch/transaction/history; otherwise prohibited
Invariant: bdl-request-required-certain-types
Description: "entry.request must exist for batch, transaction, or history; otherwise must be absent"
Severity: #error
Expression: "(type in {'batch','transaction','history'}) implies entry.request.exists() and (not (type in {'batch','transaction','history'}) implies entry.request.empty())"

// entry.response required for batch-response/transaction-response/history; otherwise prohibited
Invariant: bdl-response-required-certain-types
Description: "entry.response must exist for batch-response, transaction-response, or history; otherwise must be absent"
Severity: #error
Expression: "(type in {'batch-response','transaction-response','history'}) implies entry.response.exists() and (not (type in {'batch-response','transaction-response','history'}) implies entry.response.empty())"

// fullUrl cannot be a version-specific reference
Invariant: bdl-fullurl-not-version-specific
Description: "entry.fullUrl SHALL NOT be a version-specific reference"
Severity: #error
Expression: "entry.fullUrl.all(matches('^((?!/_history/).)*$'))"

// Document bundle requirements: identifier (system+value), timestamp (date), first entry is Composition
Invariant: bdl-document-first-composition
Description: "For type=document: identifier present (system+value), timestamp present, and first entry.resource is Composition"
Severity: #error
Expression: "type != 'document' or (identifier.exists() and identifier.system.exists() and identifier.value.exists() and timestamp.exists() and entry.first().resource.exists() and entry.first().resource.is(Composition))"

// Message bundle requirements: first entry is MessageHeader
Invariant: bdl-message-first-messageheader
Description: "For type=message: first entry.resource is MessageHeader"
Severity: #error
Expression: "type != 'message' or (entry.first().resource.exists() and entry.first().resource.is(MessageHeader))"

// FullUrl uniqueness within bundle (approximate check)
// Note: Strict uniqueness across meta.versionId variants is complex; this checks simple duplicates.
Invariant: bdl-fullurl-unique
Description: "fullUrl values must be unique within the bundle (simple check)"
Severity: #warning
Expression: "entry.fullUrl.where($this != '').isDistinct()"

// ---- Short definitions mirroring the spec text (concise) ----
* identifier ^short = "Persistent identifier for the bundle"
* type ^short = "Indicates the purpose of this bundle"
* timestamp ^short = "When the bundle was assembled"
* total ^short = "If search, the total number of matches"
* signature ^short = "Digital Signature (XML-DSig or JWT)"

// Notes on entry ordering for document/message (first resource significance)
* entry ^comment = "For document bundles, first resource = Composition; for message bundles, first resource = MessageHeader. For others, order semantics vary by type."




// ============================================================================
// BUNDLE INSTANCE - 1 bundle-example — search response (searchset)
// ============================================================================

Instance: bundle-example
InstanceOf: Bundle
Usage: #example
* meta.lastUpdated = "2014-08-18T01:43:30Z"
* type = #searchset
* total = 3
* link[0].relation = "self"
* link[=].url = "https://example.com/base/MedicationRequest?patient=347&_include=MedicationRequest.medication&_count=2"
* link[+].relation = "next"
* link[=].url = "https://example.com/base/MedicationRequest?patient=347&searchId=ff15fd40-ff71-4b48-b366-09c706bed9d0&page=2"

// match — MedicationRequest
* entry[0].fullUrl = "https://example.com/base/MedicationRequest/3123"
* entry[=].resource = MedicationRequest
* entry[=].resource.id = "3123"
* entry[=].resource.status = #unknown
* entry[=].resource.intent = #order
* entry[=].resource.medicationReference = Reference(Medication/example)
* entry[=].resource.subject = Reference(Patient/f001)
* entry[=].search.mode = #match
* entry[=].search.score = 1

// include — Medication
* entry[+].fullUrl = "https://example.com/base/Medication/example"
* entry[=].resource = Medication
* entry[=].resource.id = "example"
* entry[=].search.mode = #include


//==================================================
//EXAMPLE2-bundle-transaction-transaction-request
//==================================================

Instance: bundle-transaction
InstanceOf: Bundle
Usage: #example
* meta.lastUpdated = "2014-08-18T01:43:30Z"
* type = #transaction

// POST a new Patient (client-assigned UUID)
* entry[0].fullUrl = "urn:uuid:61ebe359-bfdc-4613-8bf2-c5e300945f0a"
* entry[=].resource = Patient
* entry[=].resource.active = true
* entry[=].resource.name[0].use = #official
* entry[=].resource.name[=].family = "Chalmers"
* entry[=].resource.name[=].given = "Peter James"
* entry[=].resource.gender = #male
* entry[=].resource.birthDate = "1974-12-25"
* entry[=].request.method = #POST
* entry[=].request.url = "Patient"

// POST with ifNoneExist (conditional create)
* entry[+].fullUrl = "urn:uuid:88f151c0-a954-468a-88bd-5ae15c08e059"
* entry[=].resource = Patient
* entry[=].resource.identifier[0].system = "http:/example.org/fhir/ids"
* entry[=].resource.identifier[=].value = "234234"
* entry[=].resource.active = true
* entry[=].resource.name[0].family = "Chalmers"
* entry[=].resource.name[=].given = "Peter James"
* entry[=].resource.gender = #male
* entry[=].resource.birthDate = "1974-12-25"
* entry[=].request.method = #POST
* entry[=].request.url = "Patient"
* entry[=].request.ifNoneExist = "identifier=http:/example.org/fhir/ids|234234"

// PUT update existing Patient
* entry[+].fullUrl = "http://example.org/fhir/Patient/123"
* entry[=].resource = Patient
* entry[=].resource.id = "123"
* entry[=].resource.active = true
* entry[=].resource.name[0].family = "Chalmers"
* entry[=].resource.name[=].given = "Peter James"
* entry[=].resource.gender = #male
* entry[=].resource.birthDate = "1974-12-25"
* entry[=].request.method = #PUT
* entry[=].request.url = "Patient/123"
