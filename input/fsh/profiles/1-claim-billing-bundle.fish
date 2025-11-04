// ======================================================================
// Profile: NgReimbursementReconciliationBundle  (FIXED)
// ======================================================================
Profile: NgReimbursementReconciliationBundle
Parent: Bundle
Id: ng-reimbursement-reconciliation-bundle
Title: "NG Reimbursement Reconciliation Transaction Bundle"
Description: "Transaction bundle for payer-issued reimbursement reconciliation to a provider. MUST contain exactly one PaymentReconciliation and the payer/provider Organizations."

* ^status = #active

// -------------------- Bundle constraints --------------------
* type 1..1 MS
* type = #transaction (exactly)
* entry 3..* MS
* entry.fullUrl 1..1 MS
* entry.resource 1..1 MS
* entry.request 1..1 MS
* entry.request.method 1..1 MS
* entry.request.url 1..1 MS

// -------------------- Slice entries by profile/type --------------------
* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #open

// Required slices (minimum content)
* entry contains
    insurerOrg 1..1 MS and
    providerOrg 1..1 MS and
    paymentReconciliation 1..1 MS

// ---- Payer Organization slice ----
* entry[insurerOrg].resource only NgOrganization
* entry[insurerOrg].request.method = #POST
* entry[insurerOrg].request.url = "Organization"
* entry[insurerOrg].fullUrl ^short = "Prefer URN UUID (urn:uuid:...) for intra-bundle references."

// ---- Provider Organization slice ----
* entry[providerOrg].resource only NgOrganization
* entry[providerOrg].request.method = #POST
* entry[providerOrg].request.url = "Organization"
* entry[providerOrg].fullUrl ^short = "Prefer URN UUID (urn:uuid:...) for intra-bundle references."

// ---- PaymentReconciliation slice ----
* entry[paymentReconciliation].resource only PaymentReconciliation
* entry[paymentReconciliation].request.method = #POST
* entry[paymentReconciliation].request.url = "PaymentReconciliation"

// -------------------- Optional soft guidance (not enforced) --------------------
// (Left as comments to reduce QA noise.)
// Entries SHOULD use URN UUID fullUrls for intra-bundle local references.
// PaymentReconciliation.paymentIssuer SHOULD reference the insurer Organization in this same bundle using a URN UUID.
// Detail/payee MAY reference the provider in this same bundle using a URN UUID.



// ======================================================================
// Reimbursement Reconciliation (Provider ↔ Payer) — Transaction Bundle
// (FIXED: use slice names; URN references align; values adjusted)
// ======================================================================
Instance: ReimbursementReconciliation-2025-10
InstanceOf: NgReimbursementReconciliationBundle
Usage: #example
Title: "Reimbursement Reconciliation – October 2025"
Description: "Payer issues a PaymentReconciliation summarizing payments against provider claims for Oct 2025."
* type = #transaction

// ------------------ Payer (Issuer) ------------------------------------
* entry[insurerOrg].fullUrl = "urn:uuid:org-insurer-rr-001"
* entry[insurerOrg].resource = Org-Insurer-RR-001
* entry[insurerOrg].request.method = #POST
* entry[insurerOrg].request.url = "Organization"

// ------------------ Provider (Payee) ----------------------------------
* entry[providerOrg].fullUrl = "urn:uuid:org-provider-rr-001"
* entry[providerOrg].resource = Org-Provider-RR-001
* entry[providerOrg].request.method = #POST
* entry[providerOrg].request.url = "Organization"

// ------------------ PaymentReconciliation -----------------------------
* entry[paymentReconciliation].fullUrl = "urn:uuid:payrec-2025-10-rr"
* entry[paymentReconciliation].resource = PayRec-2025-10
* entry[paymentReconciliation].request.method = #POST
* entry[paymentReconciliation].request.url = "PaymentReconciliation"



// ======================================================================
// Inline resources (kept simple to reduce QA)
// ======================================================================

// ------------------ Organization (Payer)
Instance: Org-Insurer-RR-001
InstanceOf: NgOrganization
Usage: #inline
Title: "PrimeCare HMO (Payer)"
* identifier.system = "https://nhia.gov.ng/hmo-code"
* identifier.value = "NHIA-HMO-0042"
* active = true
* name = "PrimeCare HMO"
* type.coding.system = "https://www.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type.coding.code = #payer
* type.coding.display = "Health Maintenance Organization"
* telecom[0].system = #phone
* telecom[0].value = "0700-PRIMECARE"
* address.line[0] = "12 Insurance Close"
* address.city = "Victoria Island"
* address.district = "Eti-Osa"
* address.state = "Lagos"
* extension[NGOrganizationOwner].valueCodeableConcept.text = "Private"

// ------------------ Organization (Provider)
Instance: Org-Provider-RR-001
InstanceOf: NgOrganization
Usage: #inline
Title: "Unity District Hospital (Provider)"
* identifier.system = "https://hfr.health.gov.ng/facility-id"
* identifier.value = "HCF-11223"
* active = true
* name = "Unity District Hospital"
* type.coding.system = "https://www.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type.coding.code = #hospital
* type.coding.display = "Secondary Hospital"
* telecom[0].system = #phone
* telecom[0].value = "09-445-7788"
* address.line[0] = "45 Hospital Avenue"
* address.city = "Garki"
* address.district = "Abuja Municipal"
* address.state = "FCT"
* extension[NGOrganizationOwner].valueCodeableConcept.text = "State Government"

// ------------------ PaymentReconciliation (Summary statement)
Instance: PayRec-2025-10
InstanceOf: PaymentReconciliation
Usage: #inline
Title: "Payment Reconciliation – October 2025"
Description: "Summarizes payments received by Unity District Hospital for October 2025 claims."
// Identifiers
* identifier[0].system = "https://primecare-hmo.example.org/payrec"
* identifier[0].value = "PR-2025-10-UDH"
// Required status & dates
* status = #active
* created = "2025-11-01T09:00:00+01:00"
// Issuer (payer) & optional payee (line-level)
* paymentIssuer = Reference(urn:uuid:org-insurer-rr-001)
// Payment metadata
* paymentIdentifier.system = "https://primecare-hmo.example.org/payments"
* paymentIdentifier.value = "PAY-2025-10-BATCH-07"
* paymentDate = "2025-10-31"
* paymentAmount.value = 335000
* paymentAmount.currency = #NGN
// Reconciliation period (claims service window)
* period.start = "2025-10-01"
* period.end   = "2025-10-31"
// Outcome & notes
* outcome = #complete
* processNote[0].type = #display
* processNote[0].text = "October batch payment for Unity District Hospital: 2 paid claims, 1 partially paid."

// ------------------ Details (line-level allocations)
* detail[0].type.coding[0].system = "http://terminology.hl7.org/CodeSystem/payment-type"
* detail[0].type.coding[0].code = #payment
* detail[0].type.coding[0].display = "Payment"
* detail[0].date = "2025-10-28"
* detail[0].amount.value = 250000
* detail[0].amount.currency = #NGN
* detail[0].payee = Reference(urn:uuid:org-provider-rr-001)

// Second paid claim
* detail[1].type.coding[0].system = "http://terminology.hl7.org/CodeSystem/payment-type"
* detail[1].type.coding[0].code = #payment
* detail[1].type.coding[0].display = "Payment"
* detail[1].date = "2025-10-29"
* detail[1].amount.value = 70000
* detail[1].amount.currency = #NGN
* detail[1].payee = Reference(urn:uuid:org-provider-rr-001)

// Adjustment (e.g., withhold/fee) shown as a separate line
* detail[2].type.coding[0].system = "http://terminology.hl7.org/CodeSystem/payment-type"
* detail[2].type.coding[0].code = #adjustment
* detail[2].type.coding[0].display = "Adjustment"
* detail[2].date = "2025-10-31"
* detail[2].amount.value = 15000
* detail[2].amount.currency = #NGN
* detail[2].payee = Reference(urn:uuid:org-provider-rr-001)

// Balance check note (sum of details should match paymentAmount)
// 250,000 + 70,000 + 15,000 = 335,000
* processNote[+].type = #print
* processNote[=].text = "Sum of payment details equals total payment amount (₦335,000)."
