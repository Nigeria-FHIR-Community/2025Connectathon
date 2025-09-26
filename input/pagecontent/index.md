<img src="input/images/dhin-favicon.ico" alt="DHIN logo" width="15"/>

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
    </tbody>
</table>


# DHIN 2025 Connectathon FHIR Implementation Guide

### Purpose

The DHIN 2025 Connectathon Implementation Guide (IG) brings together multiple tracks under a single standards-based framework to demonstrate, test, and advance healthcare interoperability in Nigeria and across Africa.  

This IG is rooted in the **WHO SMART Guidelines** approach (Standards-based, Machine-readable, Adaptable, Requirements-based, Testable). Each track leverages Digital Adaptation Kits (DAKs) and HL7 FHIR R4-based artifacts to ensure that systems can exchange health information seamlessly, securely, and in alignment with national and international best practices.

---

### Background

Nigeria’s health information ecosystem is characterized by **fragmented, siloed systems** that limit continuity of care, decision-making, and efficiency. The **Digital Health Interoperability Network (DHIN)** convenes stakeholders—including regulators, providers, developers, insurers, and innovators—to design and test practical interoperability solutions through structured connectathons.  

This IG documents the machine-readable artifacts, profiles, and value sets required to implement the **2025 DHIN Connectathon tracks**:  

1. **Health Insurance & Claims**  
2. **MNCH Referral**  
3. **ePharmacy (ePrescription & eDispensing)**  
4. **Immunization**  
5. **Medical Devices Communication**  

Each track builds on existing DAKs, regulatory frameworks, and stakeholder-driven priorities, providing reference implementations for future production systems.

---

### Scope of the FHIR Implementation Guide

This IG addresses the following cross-cutting goals:  

- Standardize **profiles, value sets, and extensions** for each track.  
- Enable **secure interoperable data exchange** across health facilities, pharmacies, insurers, referral networks, immunization registries, and medical device platforms.  
- Support **decision-support, regulatory compliance, and real-time data exchange** through SMART-on-FHIR and open APIs.  
- Provide artifacts for **testing and conformance validation** during and beyond the Connectathon.  

---

### Track-Specific Overviews

#### 1. Health Insurance & Claims  
- **Purpose:** To digitize and streamline claim submission, adjudication, and reimbursement across HMOs, NHIS, and health providers.  
- **Key FHIR Artifacts:** `Claim`, `ClaimResponse`, `Coverage`, `ExplanationOfBenefit`.  
- **Value:** Reduces fraud, accelerates payments, increases transparency, and supports regulatory oversight. 
- **Bundles:** bundle-hmo-hospital, bundle-hmo-insurer, bundle-patient-hospital, bundle-patient-insurer.

#### 2. MNCH Referral  
- **Purpose:** To enable structured, traceable referrals for Maternal, Newborn, and Child Health services.  
- **Key FHIR Artifacts:** `ServiceRequest`, `Task`, `CarePlan`, `Communication`.  
- **Value:** Improves care continuity, ensures timely follow-up, and reduces maternal and child mortality.
- **Bundles:** bundle-referral-communication, bundle-referral-initiation, bundle-referral-response, bundle-referral-tracking.  

#### 3. ePharmacy (ePrescription & eDispensing)  
- **Purpose:** To standardize electronic prescribing and dispensing workflows.  
- **Key FHIR Artifacts:** `MedicationRequest`, `MedicationDispense`, `Organization`, `PractitionerRole`.  
- **Value:** Prevents medication errors, improves drug availability, ensures accountability, and integrates insurance claims.  
- **Bundles:** bundle-coverage-enquiry, bundle-prescription, and bundle-dispense-notification.

#### 4. Immunization  
- **Purpose:** To digitize vaccine administration, reporting, and defaulter tracing in alignment with SMART Guidelines.  
- **Key FHIR Artifacts:** `Immunization`, `Patient`, `Encounter`, `Observation`, `List`.  
- **Value:** Strengthens vaccine traceability, supports AEFI (Adverse Events Following Immunization) monitoring, and improves coverage reporting. 
- **Bundles:** bundle-client-registration, bundle-report-aefi, bundle-register-facility, bundle-update-client.

#### 5. Medical Devices Communication  
- **Purpose:** To enable integration of connected medical devices (vital signs monitors, infusion pumps, diagnostic devices) with health records.  
- **Key FHIR Artifacts:** `Device`, `DeviceMetric`, `Observation`, `DeviceRequest`.  
- **Value:** Facilitates remote monitoring, supports clinical decision-making, and aligns with ISO/IEEE 11073 device communication standards.  
- **Bundles:** bundle-device-audit, bundle-device-observation, bundle-device-provenance, bundle-device-registration, bundle-device-task-execution

---

### Interactions Between Priority Systems

- **Clinical Systems (EMRs/EHRs):** Exchange data with referral, immunization, and prescription services.  
- **Pharmacy Systems:** Receive, dispense, and reconcile ePrescriptions and link with insurance systems.  
- **Insurance Systems:** Verify coverage, adjudicate claims, and support financial protection mechanisms.  
- **Medical Devices:** Send observations to clinical records for real-time monitoring and analytics.  
- **Regulatory Systems:** Collect data for policy oversight, audits, and compliance monitoring.  
- **Patients & Communities:** Engage through mobile applications, feedback loops, and consent-enabled access.  

All exchanges are defined through **FHIR R4 profiles and conformance statements** in this IG.

---

### Acronyms

| Acronym | Meaning |
|--------|---------|
| AEFI | Adverse Event Following Immunization |
| DAK | Digital Adaptation Kit |
| DHIN | Digital Health Interoperability Network |
| SMART | Standards-based, Machine-readable, Adaptable, Requirements-based, Testable |

---
