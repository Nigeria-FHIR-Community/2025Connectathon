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
* type 1..1 MS
* type = #transaction (exactly)

* identifier 1..1 MS
* identifier ^short = "Persistent identifier for this transaction bundle"
* identifier ^definition = "A unique identifier assigned to this claims transaction bundle for tracking and auditing purposes."

* timestamp 1..1 MS
* timestamp ^short = "When the bundle was assembled"
* timestamp ^definition = "The date/time when this claims transaction bundle was assembled by the HMO or submitting system."

* entry 2..* MS
* entry ^short = "Entry resource in the claims transaction bundle"
* entry ^definition = "An entry resource included in the claims transaction bundle. Must contain at least one Coverage and one Claim."
* entry ^comment = "Must contain at least one Coverage resource and one Claim resource. Additional supporting resources (Patient, Practitioner, Organization, etc.) may be included as needed."

* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[=].path = "resource"
* entry ^slicing.discriminator[+].type = #profile
* entry ^slicing.discriminator[=].path = "resource"
* entry ^slicing.rules = #open
* entry ^short = "Entry resource in the bundle"
* entry ^definition = "An entry resource included in the bundle resource."
* entry ^comment = "Must contain the Claims and Coverage resource."
* entry.fullUrl 1.. 
* entry.search ..0


* entry contains
    coverage 1..1 MS and
    claim 1..1 MS

* entry[coverage].resource 1..1
* entry[coverage].resource only NgCoverage

* entry[claim].resource 1..1
* entry[claim].resource only NgClaim




// ============================================================================
// BUNDLE INSTANCE - HMO to Hospital Claims Submission
// ============================================================================

Instance: NgTransactionBundle-Example-01
InstanceOf: NgTransactionBundle
Title: "Example — HMO→Hospital Claims Transaction"
Usage: #example
* type = #transaction
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:54c6f2b7-1b7e-4d6c-ae17-3e8b5e7a9012"
* timestamp = "2025-10-15T09:30:00+01:00"

/* --- Coverage entry (POST /Coverage) --- */
* entry[coverage].fullUrl = "urn:uuid:7e6d5f40-2d3b-4a0e-9d2a-1e3e3f6a8b9c"

* entry[coverage].resource.resourceType = "Coverage"
* entry[coverage].resource.status = #active
* entry[coverage].resource.type.coding[0].system = "http://terminology.hl7.org/CodeSystem/coverage-copay-type"
* entry[coverage].resource.type.coding[0].code = #televisit
* entry[coverage].resource.beneficiary = Reference(NgPatient-001)
* entry[coverage].resource.payor[0] = Reference(NgOrganization-001)
* entry[coverage].resource.period.start = "2025-01-01"
* entry[coverage].resource.period.end = "2025-12-31"
* entry[coverage].resource.class[0].type = http://terminology.hl7.org/CodeSystem/coverage-class#plan
* entry[coverage].resource.class[0].value = "Silver"
* entry[coverage].resource.subscriberId = "HMO-1234567890"

/* --- Claim entry (POST /Claim) --- */
* entry[claim].fullUrl = "urn:uuid:5f4a6c21-3b9a-4c82-9a55-2b1d5e7f0c12"
* entry[claim].resource.resourceType = "Claim"
* entry[claim].resource.status = #active
* entry[claim].resource.type = http://terminology.hl7.org/CodeSystem/claim-type#professional
* entry[claim].resource.use = #claim
* entry[claim].resource.created = "2025-10-15T09:25:00+01:00"
* entry[claim].resource.patient = Reference(NgPatient-001)
* entry[claim].resource.insurer = Reference(NgOrganization-002)
* entry[claim].resource.provider = Reference(NgOrganization-001)
* entry[claim].resource.priority = #urgent

/* Insurance link to the Coverage entry via local (UUID) reference */
* entry[claim].resource.insurance[0].sequence = 1
* entry[claim].resource.insurance[0].focal = true
* entry[claim].resource.insurance[0].coverage = Reference(urn:uuid:7e6d5f40-2d3b-4a0e-9d2a-1e3e3f6a8b9c)

/* Minimal billable item */
* entry[claim].resource.item[0].sequence = 1
* entry[claim].resource.item[0].productOrService.coding[0].system = "http://hl7.org/fhir/sid/cvx" // placeholder system; swap to your local code system if needed
* entry[claim].resource.item[0].productOrService.coding[0].code = #000
* entry[claim].resource.item[0].quantity.value = 1
* entry[claim].resource.item[0].unitPrice.value = 15000
* entry[claim].resource.item[0].unitPrice.currency = #NGN
* entry[claim].resource.total.value = 15000
* entry[claim].resource.total.currency = #NGN

