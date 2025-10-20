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
Instance: bundle-hmo-hospital-claim-001
InstanceOf: NgTransactionBundle
Usage: #example
Title: "HMO Hospital Claim Transaction Bundle"
Description: "Example of a complete HMO-to-Hospital claim submission with Coverage, Claim, and supporting resources"

* meta.profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-transaction-bundle"

// Bundle identification and timestamp
* identifier.system = "https://hmo.example.ng/bundle-id"
* identifier.value = "CLM-TXN-2025-001"
* timestamp = "2025-01-15T14:30:00+01:00"
* type = #transaction

// Entry: Coverage (Required)
* entry[coverage].resource = NgCoverage-001
* entry[coverage].request.method = #POST
* entry[coverage].request.url = "https://sandbox.dhin-hie.org/ig/resources/NgCoverage"

// Entry: Claim (Required)
* entry[claim].resource = NgClaim-001
* entry[claim].request.method = #POST
* entry[claim].request.url = "https://sandbox.dhin-hie.org/ig/resources/NgClaim"

