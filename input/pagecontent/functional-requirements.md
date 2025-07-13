
This section defines the core functional requirements for the ePrescription and eDispensing (PD) system. These are actions that the system must perform to meet user needs and support workflows such as registration, prescription, dispensing, billing, and follow-up. Each requirement is described using a user story format ("As a... I want... So that...") for clarity.

### Business Process A: Registration

| **Requirement ID** | **Activity**                    | **As a...**             | **I want...**                                                                 | **So that...**                                                       |
|--------------------|----------------------------------|--------------------------|--------------------------------------------------------------------------------|----------------------------------------------------------------------|
| PD.FXNREQ.002       | Search for client record        | Health worker or clerk   | To search using at least 2 identifiers                                         | I can check whether this is a new or existing client                |
| PD.FXNREQ.003       | Search for client record        | Health worker or clerk   | The system to display sufficient data to identify the client                   | I can confirm that it is the correct client                         |
| PD.FXNREQ.004       | Search before entry             | Health worker or clerk   | System to require a search before creating a new entry                         | I can avoid duplication and confirm the client                      |
| PD.FXNREQ.005       | Client identification           | Health worker or clerk   | To use QR/barcode/fingerprint to pull client record                            | I can confirm identity and update record                            |
| PD.FXNREQ.006       | Avoid duplicates                | Health worker or clerk   | System to help rule out duplicates                                              | I can avoid creating duplicate client records                       |
| PD.FXNREQ.007       | Create client record            | Health worker or clerk   | To enter identification information                                            | I can register new clients or update existing ones                  |
| PD.FXNREQ.008       | Mandatory fields                | Health worker or clerk   | The system to indicate required fields                                          | I can ensure valid and complete registrations                       |
| PD.FXNREQ.009       | Encounter number generation     | Health worker or clerk   | To generate an encounter number                                                | I can track patient visits                                          |
| PD.FXNREQ.010       | Medical record number           | Health worker or clerk   | To generate or associate with a facility medical record number                 | I can check and confirm medical records                             |
| PD.FXNREQ.011       | Edit before save                | Health worker or clerk   | To edit fields before saving data                                              | I can ensure accuracy before submission                             |
| PD.FXNREQ.012       | Temporary ID for emergencies    | Health worker or clerk   | To enter temporary ID if full identity is unknown                              | I can proceed with emergency registration                           |
| PD.FXNREQ.013       | Display for validation          | Health worker or clerk   | To display and edit client information before submission                       | I can validate and correct data                                     |
| PD.FXNREQ.014       | Update demographic info         | Health worker or clerk   | To update client demographics                                                  | I can record current and accurate client data                       |
| PD.FXNREQ.015       | Retain history                  | Health worker or clerk   | To view history of updated information                                         | I can review previous data changes                                 |
| PD.FXNREQ.016       | Add biometric/photo ID          | Health worker or clerk   | To attach a QR code/barcode/photo with consent                                 | I have more ways of verifying identity                              |
| PD.FXNREQ.017       | Confirm identity                | Health worker or clerk   | To confirm client identity                                                     | I can ensure services go to the right person                        |
| PD.FXNREQ.018       | Link returning contact          | Health worker or clerk   | To link information to previous contact                                        | I can maintain continuity of care                                  |
| PD.FXNREQ.019       | Record timestamp of visit       | Health worker or clerk   | To record time and date of new contact                                         | I can track when the client was seen                                |

---

### Additional Requirements (Other Processes)

*Further functional requirements for prescription generation, dispensing, billing, patient counseling, and follow-up are included in the business process tables and artifacts.*

---

> Note: Each of these requirements is aligned with business workflows and mapped to system functionalities that will be developed or configured in the ePrescription FHIR Implementation Guide and related software.

