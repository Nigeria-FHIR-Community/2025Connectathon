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
            <td>5th July 2025</td>
            <td>First Draft</td>
            <td>0.1.0</td>
        </tr>
    </tbody>
</table>


# DHIN ePrescription FHIR Implementation Guide

### Purpose

The ePrescription Implementation Guide (IG) aims to standardize how electronic prescriptions and dispensing (ePD) processes are digitized in Nigeria. The primary purpose is to overcome existing challenges such as medication errors, poor access to essential drugs, inefficient workflows, stockouts, and fragmented data systems—all of which compromise patient safety and quality of care.

The IG is rooted in the Standards-based, Machine-readable, Adaptable, Requirements-based, and Testable (SMART) guidelines approach. Developed through the DHIN mentorship program, this IG leverages the ePrescription Digital Adaptation Kit (DAK), ensuring that any compliant system faithfully represents the core guidelines, policies, and data content required for a robust, patient-centered, and interoperable digital PD (Prescription and Dispensing) system.

---

### Background

Nigeria’s current prescription and dispensing ecosystem is largely paper-based. This has led to inefficiencies in prescriber-dispenser communication, accountability lapses, data fragmentation, and safety concerns for patients. Recognizing the potential of digital transformation, the World Health Organization introduced SMART guidelines to accelerate adoption of clinical recommendations in digital tools.

In alignment with this vision, the Digital Health Interoperability Network (DHIN), supported by multidisciplinary stakeholders, developed a comprehensive Digital Adaptation Kit (DAK) for ePrescription. The DAK defines operational, software-agnostic requirements mapped directly from existing national guidelines and is designed to support software developers, clinicians, and health administrators.

---

### Scope of the FHIR Implementation Guide

This FHIR Implementation Guide addresses the following:

- Modeling machine-readable artifacts that represent Nigeria's ePrescription DAK components.
- Enabling interoperable exchange of ePrescription data across healthcare facilities, pharmacies, and health insurance systems.
- Defining profiles, value sets, and extensions to support:
  - Prescription generation,
  - Medication dispensing,
  - Billing and payment processes,
  - Regulatory reporting,
  - Decision-support logic,
  - Patient counseling and follow-up.

It draws from WHO and Nigeria’s regulatory guidance and applies HL7 FHIR R4 standards, enabling both intra- and inter-facility digital health communication.

---

### Interactions Between Priority Systems

The implementation of this guide supports key interactions among various systems and stakeholders:

- **Prescriber Systems** generate and send prescriptions electronically to Pharmacy Information Systems.
- **Pharmacy Information Systems** receive and validate ePrescriptions, process medications, and document dispensing actions.
- **Health Insurance Systems** verify patient coverage and process reimbursement claims for dispensed medications.
- **Regulatory Platforms** such as those managed by NAFDAC, PCN, and FMoHSW collect compliance data, monitor controlled substances, and perform digital audits.
- **Logistics Systems** integrate inventory management and real-time stock monitoring.
- **Patients** interact with the system through registration, counseling, and medication tracking, enabled by digital feedback loops and follow-up mechanisms.

All these systems rely on the underlying FHIR-based data structures and profiles defined in this guide to communicate seamlessly and securely.

---

### Acronyms

| Acronym | Meaning |
|--------|---------|
| DAK | Digital Adaptation Kit |
| DHI | Digital Health Interventions |
| DHIN | Digital Health Interoperability Network |
| ePD | Electronic Prescription and Dispensing |
| FHIR | Fast Healthcare Interoperability Resources |
| HMO | Health Maintenance Organization |
| IG | Implementation Guide |
| IT | Information Technology |
| NHIS | National Health Insurance Scheme |
| NIN | National Identification Number |
| PCN | Pharmacy Council of Nigeria |
| PD | Prescription and Dispensing |
| PHC | Primary Healthcare Centre |
| SMART | Standards-based, Machine-readable, Adaptable, Requirements-based, Testable |

---

> For more details, refer to the Nigeria ePrescription DAK and the national prescription and pharmacy policies available through [PCN.gov.ng](https://pcn.gov.ng) and [NAFDAC.gov.ng](https://nafdac.gov.ng).
