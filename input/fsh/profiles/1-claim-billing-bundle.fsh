Profile: NgBillingBundle
Parent: Bundle
Id: ng-billing-bundle
Title: "NG Billing Transaction Bundle"
Description: """
Transaction bundle representing the billing workflow for healthcare service claims between a facility and an HMO in Nigeria.
This bundle includes all resources necessary to submit and process a claim for payment after services have been rendered.
"""
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-billing-bundle"
* ^version = "1.0.0"
* ^status = #active
* ^date = "2025-10-28"
* ^publisher = "DHIN 2025 Connectathon"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
* ^purpose = "Defines the structure of a billing transaction bundle for claim submission between facility and HMO in the DHIN ecosystem."
* type = #transaction (exactly)
* identifier 1..1 MS
* timestamp 1..1 MS

// --------------------- Slicing ---------------------
* entry ^slicing.discriminator[0].type = #type
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #open
* entry ^comment = "Must contain a Patient, Facility Organization, HMO Organization, Coverage, Claim, and ClaimResponse."

// --------------------- Entries ---------------------
* entry contains
    patient 1..1 MS and
    facilityOrganization 1..1 MS and
    hmoOrganization 1..1 MS and
    coverage 1..1 MS and
    claim 1..1 MS and
    claimResponse 0..1

* entry[patient].resource only Patient
* entry[facilityOrganization].resource only Organization
* entry[hmoOrganization].resource only Organization
* entry[coverage].resource only Coverage
* entry[claim].resource only Claim
* entry[claimResponse].resource only ClaimResponse

// --------------------- Constraints ---------------------
* entry[claim].resource.use = #claim
* entry[claim].resource.patient = Reference(entry[patient].resource)
* entry[claim].resource.insurer = Reference(entry[hmoOrganization].resource)
* entry[claim].resource.provider = Reference(entry[facilityOrganization].resource)
* entry[claim].resource.insurance.coverage = Reference(entry[coverage].resource)

* entry[claimResponse].resource.request = Reference(entry[claim].resource)
* entry[claimResponse].resource.insurer = Reference(entry[hmoOrganization].resource)
* entry[claimResponse].resource.patient = Reference(entry[patient].resource)

// --------------------- Notes ---------------------
* entry[claimResponse] ^short = "Optional. Returned by HMO after processing the submitted billing claim."
* entry[claim].request.method = #POST
* entry[claim].request.url = "Claim"
