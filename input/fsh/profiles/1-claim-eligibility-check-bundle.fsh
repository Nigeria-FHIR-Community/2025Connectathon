

Profile: NGClaimEligibilityCheckBundle
Parent: Bundle
Id: NG-claim-eligibility-check-bundle
Title: "NG Claims Eligibility Check Transaction Bundle"
Description: """Transaction bundle for validating patient insurance eligibility between a facility and HMO.
The bundle MUST contain Patient, Coverage,  CoverageEligibilityRequestand CoverageEligibilityResponse resources.
Optional entries (Organization, Practitioner) may be included to support
the request, response, and tracking between both parties.
"""
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/dhin-claim-eligibility-check-bundle"
* ^version = "1.0.0"
* ^status = #active
* ^date = "2025-10-28"
* ^publisher = "DHIN 2025 Connectathon"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
* ^purpose = "Defines a transaction bundle pattern for eligibility verification between healthcare facilities and HMOs."

// ------------------------------------------------------------
// BUNDLE METADATA
// ------------------------------------------------------------
* type 1..1 MS
* type = #transaction (exactly)

* identifier 1..1 MS
* identifier ^short = "Unique ID for this eligibility transaction"
* identifier ^definition = "Used for tracking and auditing the eligibility verification event."

* timestamp 1..1 MS
* timestamp ^short = "Time when the bundle was assembled"

// ------------------------------------------------------------
// ENTRY SLICING
// ------------------------------------------------------------
* entry 1..* MS
* entry.fullUrl 1..
* entry.search ..0
* entry.response ..0

* entry ^slicing.discriminator[0].type = #type
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.discriminator[1].type = #profile
* entry ^slicing.discriminator[1].path = "resource"
* entry ^slicing.rules = #open
* entry ^comment = "Must contain one Patient, one Coverage, one CoverageEligibilityRequest and one CoverageEligibilityResponse resource. Others optional."

* entry contains
    patient 1..1 MS and
    coverage 1..1 MS and
    coverageEligibilityRequest 1..1 MS and
    coverageEligibilityResponse 1..1 MS and
    organization 0..1 and
    practitioner 0..1 
    

// ------------------------------------------------------------
// RESOURCE BINDINGS
// ------------------------------------------------------------
* entry[patient].resource only Patient
* entry[coverage].resource only Coverage
* entry[coverageEligibilityRequest].resource only CoverageEligibilityRequest
* entry[coverageEligibilityResponse].resource only CoverageEligibilityResponse
* entry[practitioner].resource only Practitioner
* entry[organization].resource only Organization

// ------------------------------------------------------------
// EXAMPLE INSTANCE (OPTIONAL)
// ------------------------------------------------------------

Instance: ExampleEligibilityTransaction
InstanceOf: NGClaimEligibilityCheckBundle
Usage: #example
Description: "Example bundle simulating an eligibility check request from a facility to an HMO."

* type = #transaction
* timestamp = "2025-10-28T12:00:00Z"
* identifier.system = "https://sandbox.dhin-hie.org/ids/bundles"
* identifier.value = "eligibility-check-001"

* entry[patient].fullUrl = "urn:uuid:patient-001"
* entry[patient].resource = ExamplePatient

* entry[coverage].fullUrl = "urn:uuid:coverage-001"
* entry[coverage].resource = ExampleCoverage

* entry[coverageEligibilityRequest].fullUrl = "urn:uuid:eligibility-req-001"
* entry[coverageEligibilityRequest].resource = ExampleCoverageEligibilityRequest

* entry[coverageEligibilityResponse].fullUrl = "urn:uuid:eligibility-resp-001"
* entry[coverageEligibilityResponse].resource = ExampleCoverageEligibilityResponse

* entry[organization][0].fullUrl = "urn:uuid:facility-org"
* entry[organization][0].resource = ExampleFacilityOrganization

* entry[organization][+].fullUrl = "urn:uuid:hmo-org"
* entry[organization][+].resource = ExampleHMOOrganization
