// ======================================================================
// Profile: NgInvoice
// ======================================================================
Profile: NgInvoice
Parent: Invoice
Id: ng-invoice
Title: "NG Invoice"
Description: "Lightweight Invoice profile for pharmacy dispensing and payment in DHIN 2025 Connectathon."

// Keep it simple to minimize QA
* status 1..1 MS
* type 0..1 MS
* subject 0..1 MS
* date 0..1 MS
* participant 0..* MS
* issuer 0..1 MS
* lineItem 0..* MS
* lineItem.sequence 0..1
* lineItem.chargeItem[x] 1..1
* lineItem.priceComponent 0..*
* lineItem.priceComponent.type 1..1
* lineItem.priceComponent.amount 0..1
* totalPriceComponent 0..*
* totalGross 0..1
* totalNet 0..1
* paymentTerms 0..1
* note 0..*

// References (kept broad enough to work with your bundle)
* subject only Reference(NgPatient)
* participant.actor only Reference(NgPractitioner or NgOrganization)
* issuer only Reference(NgOrganization)

// Nice-to-haves (shorts)
* status ^short = "draft | issued | balanced | cancelled | entered-in-error"
* type ^short = "Invoice category (e.g., Rx invoice)"
* subject ^short = "The patient this invoice is about"
* participant.role ^short = "Role (e.g., performer, payee)"
* issuer ^short = "Organization issuing the invoice (e.g., pharmacy)"
* lineItem.sequence ^short = "Line order"
* lineItem.chargeItem[x] ^short = "What is being billed (code or reference)"
* lineItem.priceComponent.type ^short = "base | surcharge | deduction | discount | tax | informational"
* totalPriceComponent ^short = "Invoice-level price components (e.g., subtotal, VAT)"
* totalGross ^short = "Total before adjustments"
* totalNet ^short = "Total after adjustments"
* paymentTerms ^short = "Payment instructions/terms"
* note.text ^short = "Free text note (e.g., co-pay, coverage info)"

// ----------------------------------------------------------------------
// OPTIONAL: Soft guidance (warnings) to keep bundles tidy
// ----------------------------------------------------------------------
Invariant: nginv-has-amounts
Description: "If totalGross or totalNet is present, at least one lineItem or totalPriceComponent SHOULD be present."
Severity: #warning
Expression: "(totalGross.exists() or totalNet.exists()) implies (lineItem.exists() or totalPriceComponent.exists())"

Invariant: nginv-patient
Description: "Invoices SHOULD identify a patient."
Severity: #warning
Expression: "subject.exists()"
