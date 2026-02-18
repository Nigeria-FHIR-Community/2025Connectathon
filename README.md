# 🇳🇬 DHIN 2025 Connectathon

**Maintained by:**  Digital Health Interoperability Network (DHIN)  
**Project Type:** HL7® FHIR® Implementation Guide  
**Language:** FHIR Shorthand (FSH)  
**Build Tool:** SUSHI (ShortHand Unshortens Syntax Iteratively)  
**License:** MIT

## Overview

This repository contains the **2025 Connectathon FHIR Implementation Guide (IG)** published by the **DHIN**.  Showcasing end-to-end, standards-based interoperability across **five tracks**:
- **Immunization**
- **MNCH Referral**
- **ePharamacy**
- **Insurance & Claims**
- **Medical-Devices Communications**

The IG defines how HL7 FHIR standards are applied to immunization use cases in Nigeria, aligning with the **WHO SMART Guidelines**, **Digital Adaptation Kits (DAKs)**, and global best practices in digital health interoperability.

## Repository Structure

- `input/`: Main working folder containing:
  - `fsh/`: FHIR Shorthand (FSH) files (profiles, extensions, value sets, etc.)
  - `images/`: Contains static images used in the guide.
  - `includes/`: Custom content like narrative markdown, guidance pages
  - `pagecontent/`: Markdown files for IG narrative contents
- `sushi-config.yaml`: Main config for IG metadata (title, canonical URL, etc.)
- `ig.ini`: IG Publisher initialization file
- ~~`output/`: (To be auto-generated) IG publisher output including HTML, and assets, etc. Generated when ./_genonce is run.~~


### Tracks & Key Artifacts
Below is a **practical cheat-sheet** of the main profiles and sample instances you’ll use during the Connectathon.
(Names shown reflect example instances already provided in this repository.)

1) **Immunization**
- Core Profiles: NgPatient, NgImmunization, NgObservation (age/pregnancy/HIV),
NgPractitioner, NgPractitionerRole, NgOrganization, NgLocation
- Terminology / Extensions: NGGenderVS, NGWardsVS, NGLGAsVS, NGStatesVS,
NGContraindicated, NGContraindications, NextDoseDate
- Example Instances: NgPatient-001/002/003, NgImmunization-001/002/003

**Sample Flow**: Register patient → capture age/pregnancy/HIV etc. via NgObservation → record vaccine administration in NgImmunization with protocolApplied and scheduling extension NextDoseDate.

2) **MNCH Referral**
- Core Profiles: NgServiceRequest (referrals/orders), NgCondition, NgEncounter,
NgOrganization, NgLocation, NgPractitionerRole
- Example Instances: NgServiceRequest-001/002 (minimal referral requests)

**Sample Flow**: ANC/PNC visit triggers referral via NgServiceRequest (reason as NgCondition/NgObservation), routed to receiving facility (NgOrganization/NgLocation).

3) **ePharmacy**
- Core Profiles: NgMedication, NgMedicationRequest, NgMedicationDispense, NgPatient
Example Instances:
- NgMedication-Paracetamol, NgMedication-Amoxicillin, NgMedication-HPV,
NgMedicationRequest-001/002/003, NgMedicationDispense-001/002/003

**Sample Flow**: Prescriber issues NgMedicationRequest → pharmacy validates and records NgMedicationDispense → optionally feeds into Claims track.

4) **Insurance & Claims**
- Core Profiles: NgClaim, NgClaimResponse, NgCoverage, NgExplanationOfBenefit
- Transaction: NgTransactionBundle (HMO–hospital submission)
- Example Instances:
NgClaim-001, NgClaim-002, NgClaimResponse-Approved-001, NgClaimResponse-Partial-002,
NgCoverage-001/002, NgExplanationOfBenefit-001/002,
NgTransactionBundle-Example-01/02

**Sample Flow**: Provider submits a NgTransactionBundle with inline NgCoverage + NgClaim. The payer replies with NgClaimResponse and later NgExplanationOfBenefit.

5) **Medical-Devices Communications**
- Core Profiles: NgDevice, NgDeviceMetric, NgDeviceRequest (and related NgObservation if needed)
- Terminology: NgDeviceMetricCategoryVS (and THO metric-category for parity)
- Example Instances: Minimal Device/Metric/Request samples included

**Sample Flow**: Device registered via NgDevice; metrics defined using NgDeviceMetric categories; orders/configuration via NgDeviceRequest; optional observations for measured values.

## Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/) (v18.20.7)
- [SUSHI](https://fshschool.org/docs/sushi/) (v3.16.3)
- [Java JDK](https://adoptopenjdk.net/) (v20 and above)
- VS - Code (with HL7 fsh extension)


### Testing Scenarios (Quick Pointers)
- **Immunization**: Post NgPatient-00x, create NgImmunization-00x with protocolApplied and NextDoseDate.
- **MNCH Referral**: Create NgServiceRequest-Referral-00x referencing NgPatient-00x, NgCondition, and target NgOrganization.
- **ePharmacy**: Link NgMedicationRequest-00x → NgMedicationDispense-00x (same patient).
- **Claims**: Submit NgTransactionBundle-Example-01/02 (two entries: Coverage + Claim, URN UUID fullUrls). Expect payer to return NgClaimResponse-*.
- **Devices**: Register NgDevice, define NgDeviceMetric (category via NgDeviceMetricCategoryVS), issue NgDeviceRequest to configure.

Ensure example references resolve (e.g., Patient/NgPatient-001, Organization/NgOrganization-001) and that value set bindings are satisfied.


### Contributing
1. Create a feature branch (feat/<topic> or fix/<issue>).
2. Edit FSH under input/fsh/... and narratives under input/pagecontent/....
3. Run sushi . and build the IG; review QA results.
4. Keep canonical URLs and instance references consistent.
5. Open a PR with a concise summary and impacted track(s).


### Contact
- **DHIN IG Mainatiners: info@dhin-hie.org

### License
This project is released under the MIT License. See LICENSE for details.

_Built for the DHIN 2025 Connectathon to accelerate safe, standards-based interoperability across immunization, MNCH, ePharmacy, claims, and device ecosystems in Nigeria. _
```bash



