Profile: NgTransactionBundle
Parent: Bundle
Id: ng-transaction-bundle
Title: "1-NG HMO-Hospital Transaction Bundle"
Description: """
Transaction bundle for Nigerian HMO-Hospital claims submissions. This bundle MUST contain 
a Coverage and a Claim entry, representing the minimum dataset required for claims processing.
Designed for supporting cross-organizational healthcare claims processing in Nigeria's DHIN ecosystem.
"""
* ^version = "1.0.0"
* ^date = "2025-10-15"
* ^publisher = "DHIN 2025 Connectathon"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
* ^purpose = "A claims transaction bundle designed for Nigerian HMO-to-Hospital submissions, containing essential coverage and claim information. The bundle is minimal and non-exhaustive but clinically and administratively relevant for claims processing."
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-transaction-bundle"
* ^status = #active
* type = #transaction (exactly)
* identifier 1..1 MS
* identifier ^short = "Persistent identifier for this transaction bundle"
* identifier ^definition = "A unique identifier assigned to this claims transaction bundle for tracking and auditing purposes."
* timestamp 1..1 MS
* timestamp ^short = "When the bundle was assembled"
* timestamp ^definition = "The date/time when this claims transaction bundle was assembled by the HMO or submitting system."
* entry.fullUrl 1.. 
* entry.search 0..1
* entry.request 0..1
* entry.response 0..1


// ------- Slicing on entry by resource.type and profile -------
* entry ^slicing.discriminator[0].type = #type
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.discriminator[1].type = #profile
* entry ^slicing.discriminator[1].path = "resource"
* entry ^slicing.rules = #open
* entry ^comment = "Must contain exactly one Coverage (NgCoverage) and one Claim (NgClaim). Others are allowed."



// Entries
* entry 2..* MS
* entry ^short = "Entry resource in the claims transaction bundle"
* entry ^definition = "An entry resource included in the claims transaction bundle. Must contain at least one Coverage and one Claim."
* entry ^comment = "Must contain at least one Coverage resource and one Claim resource. Additional supporting resources (Patient, Practitioner, Organization, etc.) may be included as needed."

* entry contains
    coverage 1..1 MS and
    claim 1..1 MS

* entry[coverage].resource only NgCoverage
* entry[coverage].request.method = #POST
* entry[coverage].request.url = "https://sandbox.dhin-hie.org/ig/resources/NgCoverage"

* entry[claim].resource only NgClaim
* entry[claim].request.method = #POST
* entry[claim].request.url = "https://sandbox.dhin-hie.org/ig/resources/NgClaim"


// ============================================================================
// BUNDLE INSTANCE - HMO to Hospital Claims Submission
// ============================================================================
Instance: NgTransactionBundle-Example-Linked
InstanceOf: NgTransactionBundle
Title: "Example — Claims Transaction (links NgCoverage-001 & NgClaim-001)"
Usage: #example

// Required transaction metadata
* type = #transaction
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-bundle-identifier-cs"
* identifier.value = "BND-0003" // Claims Transaction Bundle (from your local CodeSystem/VS if bound)
* timestamp = "2025-10-15T09:30:00+01:00"

// ---------------- Coverage slice ----------------
* entry[coverage].fullUrl = "urn:uuid:7e6d5f40-2d3b-4a0e-9d2a-1e3e3f6a8b9c"
* entry[coverage].resource = NgCoverage-001
// (Optional, but common for transaction bundles)
* entry[coverage].request.method = #POST

// ---------------- Claim slice ----------------
* entry[claim].fullUrl = "urn:uuid:5f4a6c21-3b9a-4c82-9a55-2b1d5e7f0c12"
* entry[claim].resource = NgClaim-001
// Ensure the claim’s insurance.coverage points to the Coverage entry in THIS bundle
* entry[claim].resource.insurance[0].coverage = Reference(urn:uuid:7e6d5f40-2d3b-4a0e-9d2a-1e3e3f6a8b9c)
// (Optional request block for transaction processing)
* entry[claim].request.method = #POST
