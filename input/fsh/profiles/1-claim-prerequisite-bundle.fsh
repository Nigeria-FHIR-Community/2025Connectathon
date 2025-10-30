Profile: DHINClaimPrerequisiteBundle
Parent: Bundle
Id: dhin-claim-prerequisite-bundle
Title: "DHIN Claims Prerequisite Bundle"
Description: """
A transaction bundle that defines the prerequisite setup for all DHIN Claims workflows.
It contains foundational resources required before eligibility, preauthorization, or billing interactions.
These include Patient, Coverage, Organization (Facility + HMO), Practitioner, and PractitionerRole.
"""
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/dhin-claim-prerequisite-bundle"
* ^version = "1.0.0"
* ^status = #active
* ^date = "2025-10-28"
* ^publisher = "DHIN 2025 Connectathon"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
* ^purpose = "Defines the baseline resource setup for all DHIN Claims workflows under FHIR R4."

// ------------------------------------------------------------
// BUNDLE METADATA
// ------------------------------------------------------------
* type 1..1 MS
* type = #transaction (exactly)

* identifier 1..1 MS
* identifier ^short = "Unique ID for this prerequisite setup transaction"
* identifier ^definition = "Used for tracking and auditing setup bundles during Connectathon."

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
* entry ^comment = "Must contain one Patient, one Coverage, Facility and HMO Organizations, and optional Practitioner + PractitionerRole."

* entry contains
    patient 1..1 MS and
    facilityOrganization 1..1 MS and
    hmoOrganization 1..1 MS and
    coverage 1..1 MS and
    practitioner 0..1 and
    practitionerRole 0..1

// ------------------------------------------------------------
// RESOURCE BINDINGS
// ------------------------------------------------------------
* entry[patient].resource only Patient
* entry[facilityOrganization].resource only Organization
* entry[hmoOrganization].resource only Organization
* entry[coverage].resource only Coverage
* entry[practitioner].resource only Practitioner
* entry[practitionerRole].resource only PractitionerRole

/* // ------------------------------------------------------------
// EXAMPLE INSTANCE
// ------------------------------------------------------------
Instance: ExampleClaimsPrerequisiteBundle
InstanceOf: DHINClaimPrerequisiteBundle
Usage: #example
Description: "Example DHIN prerequisite bundle defining foundational setup before claims workflows."

* type = #transaction
* timestamp = "2025-10-28T09:00:00Z"
* identifier.system = "https://sandbox.dhin-hie.org/ids/bundles"
* identifier.value = "claims-prerequisite-001"

// PATIENT
* entry[patient].fullUrl = "urn:uuid:patient-001"
* entry[patient].resource = ExamplePatient

// FACILITY ORGANIZATION
* entry[facilityOrganization].fullUrl = "urn:uuid:facility-org"
* entry[facilityOrganization].resource = ExampleFacilityOrganization

// HMO ORGANIZATION
* entry[hmoOrganization].fullUrl = "urn:uuid:hmo-org"
* entry[hmoOrganization].resource = ExampleHMOOrganization

// COVERAGE
* entry[coverage].fullUrl = "urn:uuid:coverage-001"
* entry[coverage].resource = ExampleCoverage

// PRACTITIONER
* entry[practitioner].fullUrl = "urn:uuid:practitioner-001"
* entry[practitioner].resource = ExamplePractitioner

// PRACTITIONER ROLE
* entry[practitionerRole].fullUrl = "urn:uuid:practitionerrole-001"
* entry[practitionerRole].resource = ExamplePractitionerRole
 */