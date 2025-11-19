Profile: NgExplanationOfBenefit
Parent: ExplanationOfBenefit
Id: ng-explanation-of-benefit
Title: "NG ExplanationOfBenefit"
Description: "A profile detailing adjudicated claim results."
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-explanation-of-benefit"

* status 1..1 MS
* type 1..1 MS
* patient 1..1 MS
* created 1..1 MS
* provider 1..1 MS
* provider only Reference(NgProviderOrganization)
* insurer 1..1 MS
* insurer only Reference(NgInsurerOrganization)
* insurance 1..1 MS
* benefitPeriod 0..1
* use 1..1
* outcome 1..1



// EXAMPLES
// ==============================================
// EOB-001 — Approved in full (maps to NgClaimResponse-001)
// ==============================================
Instance: NgExplanationOfBenefit-001
InstanceOf: NgExplanationOfBenefit
Usage: #example
Title: "Example Ng EOB (Approved)"
Description: "EOB for fully approved pharmacy claim."
* status = #active
* type.coding[0].system = "http://terminology.hl7.org/CodeSystem/claim-type"
* type.coding[0].code = #pharmacy
* use = #claim
* outcome = #complete
* created = 2025-11-04T12:46:00Z

* patient = Reference(NgPatient-002)
* insurer = Reference(Organization-Truth-HMO)
* provider = Reference(Organization-PortHarcourt-Hospital)
* claim = Reference(NgClaim-001)
* claimResponse = Reference(NgClaimResponse-001)

* insurance[0].focal = true
* insurance[0].coverage = Reference(Coverage-Chika-TruthHMO)
* insurance[0].preAuthRef[0] = "PA-2025-8847"


// Optional benefit period (plan year)
* benefitPeriod.start = 2025-01-01
* benefitPeriod.end   = 2025-12-31





// ==============================================
// EOB-002 — Partial approval with copay (maps to NgClaimResponse-002)
// ==============================================
Instance: NgExplanationOfBenefit-002
InstanceOf: NgExplanationOfBenefit
Usage: #example
Title: "Example Ng EOB (Partial with Copay)"
Description: "EOB documenting partial approval and member copay."
* status = #active
* type.coding[0].system = "http://terminology.hl7.org/CodeSystem/claim-type"
* type.coding[0].code = #pharmacy
* use = #claim
* outcome = #partial
* created = 2025-11-04T12:51:00Z

* patient = Reference(NgPatient-002)
* insurer = Reference(Organization-Truth-HMO)
* provider = Reference(Organization-PortHarcourt-Hospital)
* claim = Reference(NgClaim-001)
* claimResponse = Reference(NgClaimResponse-002)

// Optional benefit period (plan year)
* benefitPeriod.start = 2025-01-01
* benefitPeriod.end   = 2025-12-31

* insurance[0].focal = true
* insurance[0].coverage = Reference(Coverage-Chika-TruthHMO)
* insurance[0].preAuthRef[0] = "PA-2025-8847"

