#### Revision History

<table class="table table-hover table-bordered table-striped">
  <thead>
    <tr>
      <th>Name</th>
      <th>Date</th>
      <th>Reason for Changes</th>
      <th>Version</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Digital Health Interoperability Network (DHIN)</td>
      <td>25th September 2025</td>
      <td>First Draft for Connectathon IG</td>
      <td>0.1.0</td>
    </tr>
    <tr>
      <td>Digital Health Interoperability Network (DHIN)</td>
      <td>10th November 2025</td>
      <td>Added nine TestScripts (stories, steps, outcomes) for all tracks</td>
      <td>0.2.0</td>
    </tr>
  </tbody>
</table>

# DHIN 2025 Connectathon FHIR Implementation Guide

## Purpose
The DHIN 2025 Connectathon Implementation Guide (IG) brings together multiple tracks under a single standards-based framework to demonstrate, test, and advance healthcare interoperability in Nigeria and across Africa.  
This IG follows the **WHO SMART Guidelines** approach (Standards-based, Machine-readable, Adaptable, Requirements-based, Testable), leveraging DAKs and HL7 FHIR R4 artifacts so systems can exchange health information seamlessly, securely, and in line with national and international best practices.

---

## Background
Nigeria’s health information ecosystem is often **fragmented and siloed**. The **Digital Health Interoperability Network (DHIN)** in collaboration with many government and development stakeholders convenes regulators, providers, developers, insurers, and innovators to design and test practical interoperability solutions through structured connectathons.  
This IG documents the machine-readable artifacts, profiles, and value sets for the **2025 DHIN Connectathon tracks**:

1. Health Insurance & Claims  
2. MNCH Referral  
3. ePharmacy (ePrescription & eDispensing)  
4. Immunization  
5. Medical Devices Communication
6. SON Standards and NDPC Regulation
7. Registries (MDCN and PCN provider and Facility registries)

Each track builds on DAKs, regulatory frameworks, and stakeholder priorities—providing reference implementations for production systems.

---

## Scope of the FHIR Implementation Guide
- Standardize **profiles, value sets, and extensions** for each track  
- Enable **secure interoperable data exchange** across facilities, pharmacies, insurers, referral networks, immunization registries, and device platforms  
- Support **decision-support, regulatory compliance, and real-time data exchange** through open APIs  
- Provide artifacts for **testing and conformance validation** during and beyond the Connectathon

---

## Track Overviews

### 1) Health Insurance & Claims
- **Purpose:** Digitize and streamline eligibility, pre-auth, billing, and reimbursement  
- **Key FHIR Artifacts:** `Coverage`, `CoverageEligibilityRequest/Response`, `Claim`, `ClaimResponse`, `Invoice`, `ExplanationOfBenefit`  
- **Sample Bundles:** Eligibility Check, Pre-Auth, Claim Submission

### 2) MNCH Referral
- **Purpose:** Structured, traceable referrals for MNCH services  
- **Key Artifacts:** `ServiceRequest`, `Task`, `Communication`, `CarePlan`  
- **Sample Bundles:** Referral Initiation, Referral Response, Referral Tracking

### 3) ePharmacy (ePrescription & eDispensing)
- **Purpose:** Standardize prescribing, dispensing, and pharmacy confirmations  
- **Key Artifacts:** `Medication`, `MedicationRequest`, `MedicationDispense`, `Invoice`  
- **Sample Bundles:** Prescription, Dispense Confirmation

### 4) Immunization
- **Purpose:** Digitize vaccine scheduling, administration, AEFI reporting  
- **Key Artifacts:** `Immunization`, `ImmunizationRecommendation`, `Appointment`, `Encounter`, `Observation`  
- **Sample Bundles:** Client Registration, SMART Scheduler, AEFI Report

### 5) Medical Devices Communication
- **Purpose:** Integrate connected devices (e.g., analyzers, wearables) with records  
- **Key Artifacts:** `Device`, `DeviceMetric`, `Observation`, `Task`, `Provenance`  
- **Sample Bundles:** Device Result Submission, Wearable Data Upload

---

## Interactions Between Priority Systems
- **Clinical Systems (EMRs/EHRs):** referrals, immunization, eRx  
- **Pharmacy Systems:** ePrescription receive/dispense and billing  
- **Insurance Systems:** coverage checks, adjudication, payment  
- **Medical Devices:** observations to clinical records  
- **Regulators:** provider registries, audits, compliance  
- **Patients:** mobile access, consent, feedback

All exchanges are defined via **FHIR R4 profiles and conformance statements** in this IG.

---

## Acronyms

| Acronym | Meaning |
|---|---|
| AEFI | Adverse Event Following Immunization |
| DAK | Digital Adaptation Kit |
| DHIN | Digital Health Interoperability Network |
| SMART | Standards-based, Machine-readable, Adaptable, Requirements-based, Testable |

---

## Connectathon TestScripts (Nine Tracks)

> **Conventions**
> - Prefer **URN UUIDs** for intra-bundle references (e.g., `urn:uuid:...`)  
> - Use IG profiles: `NgPatient`, `NgPractitioner`, `NgProviderOrganization`, `NgPharmacyOrganization`, `NgInsurerOrganization`, etc.  
> - **Transaction** bundles must include `entry.request.method` + `entry.request.url` per entry  
> - Keep examples minimal; warnings are acceptable, **errors are not**

---

### TestScript 1 — CLAIMS & INSURANCE
**Scenarios:** (i) Eligibility Check, (ii) Pre-Authorization, (iii) Submission & Billing

**Story (summary):**  
“Did you know your hospital bill can travel faster than you can say *‘where is my receipt?’*” In Port Harcourt, night-shift injury becomes a same-day greenlight as the ER nurse runs a digital eligibility check, the clinician requests pre-auth on a tablet, and the cashier submits billing with clean links. A duplicate X-ray is auto-flagged; context is supplied, and approval follows—no phone-tag, no wahala.

**Prerequisites**  
- Profiles installed; shared identifier namespaces  
- Minimal examples prepared for: `NgPatient`, `NgPractitioner`, `NgProviderOrganization`, `NgInsurerOrganization`, `NgCoverage`, `NgCoverageEligibilityRequest/Response`, `NgClaim`, `NgClaimResponse`, `NgInvoice`, `ExplanationOfBenefit`

**Steps**  
A) **Eligibility Check**  
1. POST `NgEligibilityCheck-Request` (transaction): Patient, Provider Practitioner, Provider Org, `CoverageEligibilityRequest`  
2. Expect `NgEligibilityCheck-Response` (collection): `Coverage`, `CoverageEligibilityResponse`

B) **Pre-Authorization**  
3. POST `NgPreAuthorizationBundle` (transaction): Patient, Provider & Insurer Orgs, Coverage, `Claim(use=preauthorization)`  
4. Expect `NgPreAuthorizationBundle` (collection): `ClaimResponse` decision

C) **Submission & Billing**  
5. POST `NgClaim(use=claim)` + optional `NgInvoice`  
6. Expect `ExplanationOfBenefit` (payer result)

**Expected Outcomes**  
- Eligibility outcome present (`inforce=true`)  
- Pre-auth decision returned (`ClaimResponse`) linked to originating `Claim`  
- EOB references submitted `Claim`; totals reconcile with Invoice (if present)

**Validation**  
- Bundle.type correct; all references resolve  
- `Claim.use` values correct across phases  
- `entry.request.*` present for transactions

**Evidence**  
- Request/Response JSON + validator output (0 errors)

**Pitfalls**  
- Missing `entry.request.url` in transactions  
- `Invoice.lineItem.chargeItem[x]` absent (must include `chargeItemReference` or `chargeItemCodeableConcept`)

---

### TestScript 2 — ePHARMACY (ePrescription & eDispensing)

**Story (summary):**  
“In Kano, a patient fills chronic meds without drama.” The pharmacy receives three medication requests, dispenses exact quantities, attaches counseling notes, and issues a simple invoice; payer or patient can later verify line items by dispense references.

**Prerequisites**  
- `NgPatient`, `NgPractitioner` (prescriber & dispenser), `NgPharmacyOrganization`  
- `NgMedication` ×3, `NgMedicationRequest` ×3  
- Response examples: `NgMedicationDispense` ×3, `NgInvoice` (optional)

**Steps**  
1. POST **Prescription Bundle** (transaction): Patient, Prescriber, Pharmacy, Medications, MedicationRequests  
2. POST **Dispense Bundle** (collection): Patient, Pharmacy, Medications, MedicationDispense ×N, optional `NgInvoice`

**Expected Outcomes**  
- `MedicationDispense.authorizingPrescription` links to the right `MedicationRequest`  
- Invoice `lineItem` references dispenses (or uses codeable concepts)

**Validation**  
- Dose/timing present; route present  
- For invoice: at least one `lineItem.chargeItemReference` **or** `chargeItemCodeableConcept`

**Evidence**  
- Request/Response JSON + validator results

**Pitfalls**  
- Missing dispense linkage to medicationRequest  
- Invoice line items lacking a charge item

---

### TestScript 3 — MNCH REFERRAL

**Story (summary):**  
“In Lafia, a PHC midwife escalates an ANC case with blood-pressure red flags.” A `ServiceRequest` and initial `Task` notify a secondary hospital; response updates `Task.status`, and tracking confirms arrival and completion—no missed calls, no lost papers.

**Prerequisites**  
- `NgPatient`, `NgPractitioner`, `NgProviderOrganization` (PHC & hospital)  
- `NgServiceRequest`, `NgTask`, optional `Communication`

**Steps**  
1. POST **Referral Initiation** (transaction): Patient, ServiceRequest, Practitioner, Task (`ready`)  
2. Expect **Referral Response** (collection): Task accepted/assigned  
3. POST **Referral Tracking** updates (collection): Task `in-progress` → `completed`

**Expected Outcomes**  
- `Task.for` → Patient; `Task.owner` → receiving facility  
- `Task.basedOn` → ServiceRequest

**Validation**  
- Status transitions valid (`requested/ready` → `accepted` → `in-progress/completed`)  
- All references resolve

**Evidence**  
- Bundle JSONs + Task state changes

**Pitfalls**  
- Missing `Task.basedOn` link to ServiceRequest

---

### TestScript 4 — IMMUNIZATION (SMART Scheduler & AEFI)

**Story (summary):**  
“In Aba, a caregiver books a measles shot and later flags a mild fever.” A minimal scheduler suggests dates via `ImmunizationRecommendation` and `Appointment`; a separate AEFI report captures `Immunization` context and an `Observation` for symptoms.

**Prerequisites**  
- Scheduler: `NgPatient`, `NgImmunizationRecommendation`, `NgAppointment`, `NgLocation`  
- AEFI: `NgPatient`, `NgPractitioner`, `NgOrganization`, `Encounter`, `Immunization`, `Observation`

**Steps**  
A) **Scheduler**  
1. POST Scheduler bundle (collection): Recommendation + Appointment + Location  
B) **AEFI Report**  
2. POST AEFI bundle (collection): Encounter, Immunization, Observation (adverse event)

**Expected Outcomes**  
- Appointment date/time matches recommended window  
- AEFI `Observation.effective[x]` and linkage to `Immunization` present

**Validation**  
- Reason codes present where applicable  
- Subject and performer references resolve

**Evidence**  
- Bundle JSON + validator logs

**Pitfalls**  
- Missing link from AEFI Observation to Immunization

---

### TestScript 5 — MEDICAL DEVICES (Analyzer Result & Wearable Upload)

**Story (summary):**  
“In Jos, a chemistry analyzer posts serum glucose; in Lagos, a student’s Apple Watch streams heart rate.” Two simple device flows push `Observation` to a FHIR endpoint with device attribution.

**Prerequisites**  
- `NgPatient`, `NgOrganization` (performer), `NgDevice` (analyzer / watch)  
- Analyzer: optional `DeviceMetric`, `Task`; Wearable: mobile app as data source

**Steps**  
A) **Chemistry Analyzer**  
1. POST bundle (collection): Patient, Organization, Device, Observation (glucose)  
B) **Apple Watch**  
2. POST bundle (collection): Patient, Organization (app vendor/clinic), Device, Observation (heart rate)

**Expected Outcomes**  
- `Observation.device` → Device; `Observation.subject` → Patient  
- Units present (e.g., mmol/L, bpm)

**Validation**  
- UCUM codes for units where possible  
- Effective times present and recent

**Evidence**  
- Observation JSONs + validator results

**Pitfalls**  
- Missing units or using free text

---

### TestScript 6 — MDCN USE CASE (Practitioner Registry)

**Story (summary):**  
“In Enugu, a hospital HR verifies a locum doctor before shift.” A practitioner is created/queried against MDCN ID to prevent impersonation and ensure licensure validity.

**Prerequisites**  
- `NgPractitioner` profile; MDCN identifier system agreed

**Steps**  
1. POST `NgPractitioner` with MDCN ID  
2. GET `/Practitioner?identifier=<system>|<value>`

**Expected Outcomes**  
- 201 on create; search returns exact match with correct status

**Validation**  
- Identifier system/code correct; `active = true`

**Evidence**  
- POST/GET payloads + logs

**Pitfalls**  
- Wrong identifier namespace; inactive practitioner used in tests

---

### TestScript 7 — PCN USE CASE (Pharmacy Registry)

**Story (summary):**  
“In Abeokuta, a neon sign is not a license.” A community pharmacy publishes `NgPharmacyOrganization` with PCN number; citizens and HMOs verify registration by identifier. Unlicensed “chemist” shops are filtered out.

**Prerequisites**  
- `NgPharmacyOrganization` profile; PCN identifier system agreed

**Steps**  
1. POST `NgPharmacyOrganization` (active = true; type = pharmacy; PCN identifier)  
2. GET `/Organization?identifier=<system>|<value>`

**Expected Outcomes**  
- Organization retrievable by identifier; type coding present

**Validation**  
- Address/telecom present; canonical org-type used

**Evidence**  
- POST/GET JSON + logs

**Pitfalls**  
- Non-canonical org-type; missing identifier

---

### TestScript 8 — SON USE CASE (Standards & Consent/Pseudonymization)

**Story (summary):**  
“In Kaduna, a facility implements consent and pseudonymization to share data safely.” A simple consent is recorded; separately, a patient/practitioner/related-person example is pseudonymized for a privacy-preserving flow.

**Prerequisites**  
- `NgConsent` profile + example  
- Pseudonymized `NgPatient`, `NgPractitioner`, `NgRelatedPerson` (consistent tokenization domain)

**Steps**  
1. POST `NgConsent` (opt-in/opt-out per scenario)  
2. POST pseudonymized Patient/Practitioner/RelatedPerson resources

**Expected Outcomes**  
- Consent discoverable and linked to subject  
- Pseudonymized identifiers consistent across resources

**Validation**  
- `Consent.provision.type` set appropriately  
- No direct identifiers in pseudonymized resources

**Evidence**  
- JSON resources + validator logs

**Pitfalls**  
- Mixing real PHI into pseudonymized examples; inconsistent pseudonyms

---

### TestScript 9 — PRIVACY USE CASE (Applied Pseudonymization)

**Story (summary):**  
“In Uyo, a research extract replaces direct identifiers with tokens while preserving clinical utility.” The dataset keeps dates within policy (e.g., month/year only) and retains linkability across encounters with a stable pseudonym.

**Prerequisites**  
- Clear policy for tokenization, date handling, and quasi-identifiers  
- Pseudonymization function documented (salted/HMAC or equivalent)

**Steps**  
1. Transform Patient/Practitioner/RelatedPerson to pseudonymized variants  
2. POST transformed resources  
3. Run sample query chains to confirm linkability (same pseudonym across resources)

**Expected Outcomes**  
- No direct identifiers present  
- Queries still correlate patient across resources

**Validation**  
- Pseudonym fields consistent; addresses generalized where required

**Evidence**  
- Before/after examples; pseudonymization method note

**Pitfalls**  
- Reversible tokens without controls; leaking rare combinations (re-identification risk)

---

## General Validation & Logistics

- **Transport:** Use HTTPS endpoints; include `Content-Type: application/fhir+json`  
- **Bundle Hygiene:**  
  - `transaction` ⇒ each entry has `request.method` + `request.url`  
  - `collection` ⇒ omit `entry.request`  
  - Prefer `urn:uuid:` in `fullUrl` and internal references  
- **Coding:** Use official code systems (THO/HL7, UCUM). Keep custom code systems under your canonical  
- **Evidence Pack:** Submit request/response JSON, validator reports, and brief screenshots as needed  
- **Passing Criteria:** No **errors** in validation; warnings acceptable if justified in notes

---

## Appendix — Quick Tips

- **Invoices:** Each `Invoice.lineItem` must carry **either** `chargeItemReference` (e.g., a `MedicationDispense`/`Procedure`) **or** `chargeItemCodeableConcept`.  
- **Claims:** Keep `Claim.use` appropriate to phase (`preauthorization` vs `claim`).  
- **Devices:** Always include measurement units (UCUM).  
- **Privacy:** When in doubt, **pseudonymize** and briefly document how.  
- **Troubleshooting:** If references don’t resolve, check `fullUrl` vs local `Reference(target-id)` and slice constraints in your bundle profile.
