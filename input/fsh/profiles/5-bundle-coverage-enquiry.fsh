// ============================================================================
// PROFILE: Coverage Enquiry Transaction Bundle
// ============================================================================
Profile: NgCoverageEnquiryBundle
Parent: Bundle
Id: ng-coverage-enquiry-bundle
Title: "NG Coverage Enquiry Transaction Bundle"
Description: """
Transaction bundle for member coverage/benefit enquiries between submitters (HMO/hospital/patient apps) and the insurer.
The bundle MUST contain a Patient and a CoverageEligibilityRequest.
An optional CoverageEligibilityResponse may be included for synchronous responses.
"""
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-coverage-enquiry-bundle"
* ^version = "1.0.0"
* ^status = #active
* ^date = "2025-10-15"
* ^publisher = "DHIN 2025 Connectathon"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
* ^purpose = "Supports coverage eligibility checks for MNCH and general claims workflows."

// Bundle metadata
* type 1..1 MS
* type = #transaction (exactly)
* identifier 1..1 MS
* identifier ^short = "Identifier for this coverage enquiry transaction bundle"
* timestamp 1..1 MS

// Entries + slicing
* entry 2..* MS
* entry.fullUrl 1..
* entry.search ..0
* entry.response ..0
* entry.request 0..1

* entry ^slicing.discriminator[0].type = #type
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.discriminator[1].type = #profile
* entry ^slicing.discriminator[1].path = "resource"
* entry ^slicing.rules = #open
* entry ^comment = "Must contain one Patient and one CoverageEligibilityRequest; response is optional (synchronous)."

// Named slices
* entry contains
    patient 1..1 MS and
    // eligreq 0..1 MS and
    // eligresp 0..1 MS and
    supporting 0..* MS

// Required slices
* entry[patient].resource only NgPatient
* entry[patient].request.method = #POST
* entry[patient].request.url = "https://sandbox.dhin-hie.org/ig/resources/NgPatient"

// * entry[eligreq].resource only NgCoverageEligibilityRequest
// * entry[eligreq].request.method = #POST
// * entry[eligreq].request.url = "https://sandbox.dhin-hie.org/ig/resources/NgCoverageEligibilityRequest"

// // Optional response slice (for synchronous replies)
// * entry[eligresp].resource only NgCoverageEligibilityResponse
// * entry[eligresp].request.method = #POST
// * entry[eligresp].request.url = "https://sandbox.dhin-hie.org/ig/resources/NgCoverageEligibilityResponse"

// Optional supporting entries (Coverage/Organization/Practitioner/etc.)
* entry[supporting].request.method = #POST
* entry[supporting].request.url = "https://sandbox.dhin-hie.org/ig/resources/NgPractitioner"


// ============================================================================
// EXAMPLE 1: Coverage Enquiry Transaction Bundle
// ============================================================================


Instance: bundle-coverage-enquiry-initiation
InstanceOf: NgCoverageEnquiryBundle
Title: "Coverage Enquiry — Initiation"
Usage: #example

* type = #transaction
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-bundle-identifier-cs"
* identifier.value = "BND-0031"
* timestamp = "2025-10-16T08:10:00+01:00"

// Patient
* entry[patient].fullUrl = "urn:uuid:6e8b1c2d-1a23-4bcd-95ef-0a1b2c3d4e21"
* entry[patient].resource = NgPatient-001
* entry[patient].request.method = #POST
* entry[patient].request.url = "https://sandbox.dhin-hie.org/ig/resources/NgPatient"

// Optional supporting (Organization / Practitioner)
// * entry[supporting][+].fullUrl = "urn:uuid:org-submitter-0001"
// * entry[supporting][=].resource = NgOrganization-001
// * entry[supporting][=].request.method = #POST
// * entry[supporting][=].request.url = "https://sandbox.dhin-hie.org/ig/resources/NgOrganization-001"

* entry[supporting][+].fullUrl = "urn:uuid:prac-submitter-0001"
* entry[supporting][=].resource = NgPractitioner-001
* entry[supporting][=].request.method = #POST
* entry[supporting][=].request.url = "https://sandbox.dhin-hie.org/ig/resources/NgPractitioner"