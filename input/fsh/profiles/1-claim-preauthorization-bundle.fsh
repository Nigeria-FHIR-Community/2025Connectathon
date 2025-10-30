Profile: NGClaimPreauthorizationBundle
Parent: Bundle
Id: ng-claim-preauthorization-bundle
Title: "NG Preauthorization Transaction Bundle"
Description: """
Transaction bundle representing the preauthorization workflow for medical services between facility and HMO.
Includes a Claim (use=preauthorization) and its corresponding ClaimResponse.
"""
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-preauthorization-bundle"
* ^version = "1.0.0"
* ^status = #active
* ^date = "2025-10-28"
* ^publisher = "DHIN 2025 Connectathon"
* type = #transaction (exactly)
* identifier 1..1 MS
* timestamp 1..1 MS

// Slicing
* entry ^slicing.discriminator[0].type = #type
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #open

// Entries
* entry contains
    patient 1..1 MS and
    facilityOrganization 1..1 MS and
    hmoOrganization 1..1 MS and
    coverage 1..1 MS and
    claim 1..1 MS and
    claimResponse 1..1 MS

* entry[patient].resource only Patient
* entry[Organization].resource only Organization
* entry[coverage].resource only Coverage
* entry[claim].resource only Claim
* entry[claimResponse].resource only ClaimResponse

// Constraints
* entry[claim].resource.use = #preauthorization
* entry[claim].resource.patient = Reference(entry[patient].resource)
* entry[claim].resource.insurer = Reference(entry[hmoOrganization].resource)
* entry[claim].resource.provider = Reference(entry[facilityOrganization].resource)
* entry[claim].resource.insurance.coverage = Reference(entry[coverage].resource)

* entry[claimResponse].resource.request = Reference(entry[claim].resource)
* entry[claimResponse].resource.insurer = Reference(entry[hmoOrganization].resource)
* entry[claimResponse].resource.patient = Reference(entry[patient].resource)


/* Instance: NgClaimPreauthorizationBundle-Example
InstanceOf: NGClaimPreauthorizationBundle
Title: "Example — Preauthorization Transaction"
Usage: #example

* type = #transaction
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-bundle-identifier-cs"
* identifier.value = "PREAUTH-BND-0001"
* timestamp = "2025-10-28T10:15:00+01:00"

// --- Patient ---
* entry[patient].fullUrl = "urn:uuid:pat-001"
* entry[patient].resource = NgPatient-001

// --- Facility Organization ---
* entry[Organization].fullUrl = "urn:uuid:org-fac-001"
* entry[Organization].resource = NgFacilityOrg-001

// --- HMO Organization ---
* entry[Organization].fullUrl = "urn:uuid:org-hmo-001"
* entry[Organization].resource = NgHmoOrg-001

// --- Coverage ---
* entry[coverage].fullUrl = "urn:uuid:cov-001"
* entry[coverage].resource = NgCoverage-001

// --- Claim (preauthorization) ---
* entry[claim].fullUrl = "urn:uuid:claim-001"
* entry[claim].resource = NgClaim-Preauth-001

// --- ClaimResponse (authorization decision) ---
* entry[claimResponse].fullUrl = "urn:uuid:claimresp-001"
* entry[claimResponse].resource = NgClaimResponse-Preauth-001
 */