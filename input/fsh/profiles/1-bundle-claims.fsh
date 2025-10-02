// ==============================================
// Profile: NgTransactionBundle
// ==============================================
Profile: NgTransactionBundle
Parent: Bundle
Id: ng-transaction-bundle
Title: "NG HMO-Hospital Transaction Bundle"
Description: "Transaction bundle that MUST contains a Coverage and a Claim entry for HMO submissions."

// Bundle basics
* type 1..1 MS
* type = #transaction (exactly)
* entry 2..* MS
* entry.fullUrl 1..1
* entry.resource 1..1
* entry.request 1..1
* entry.request.method 1..1
* entry.request.url 1..1

// Slice entries by the profile of the inlined resource
* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #open

// Required slices: one Coverage (NgCoverage) and one Claim (NgClaim)
* entry contains
    coverage 1..1 MS and
    claim 1..1 MS

// Coverage slice
* entry[coverage].resource only NgCoverage
* entry[coverage].request.method = #POST
* entry[coverage].request.url = "Coverage"

// Claim slice
* entry[claim].resource only NgClaim
* entry[claim].request.method = #POST
* entry[claim].request.url = "Claim"

// --------------------
// Invariants (soft)
// --------------------
Invariant: ngbun-uuid-fullurl
Description: "Transaction entries SHOULD use URN UUID fullUrls for local intra-bundle references."
Severity: #warning
Expression: "entry.fullUrl.all(matches('^urn:uuid:'))"

Invariant: ngbun-claim-cov-localref
Description: "Claim.insurance.coverage references SHOULD be local URN UUIDs when the Coverage is in the same transaction."
Severity: #warning
Expression: "entry.resource.ofType(Claim).insurance.coverage.reference.all(matches('^urn:uuid:'))"


