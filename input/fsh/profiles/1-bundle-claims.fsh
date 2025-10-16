Profile: NgTransactionBundle
Parent: Bundle
Id: ng-transaction-bundle
Title: "1-NG HMO-Hospital Transaction Bundle"
Description: """
Transaction bundle for Nigerian HMO-Hospital claims submissions. This bundle MUST contain 
a Coverage and a Claim entry, representing the minimum dataset required for claims processing.
Designed for supporting cross-organizational healthcare claims processing in Nigeria's DHIN ecosystem.
"""

* ^version = "1.0.0"
* ^date = "2025-10-15"
* ^publisher = "DHIN 2025 Connectathon"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
* ^purpose = "A claims transaction bundle designed for Nigerian HMO-to-Hospital submissions, containing essential coverage and claim information. The bundle is minimal and non-exhaustive but clinically and administratively relevant for claims processing."

* obeys ngbun-uuid-fullurl and ngbun-claim-cov-localref and ngbun-minimum-slices

* type 1..1 MS
* type = #transaction (exactly)

* identifier 1..1 MS
* identifier ^short = "Persistent identifier for this transaction bundle"
* identifier ^definition = "A unique identifier assigned to this claims transaction bundle for tracking and auditing purposes."

* timestamp 1..1 MS
* timestamp ^short = "When the bundle was assembled"
* timestamp ^definition = "The date/time when this claims transaction bundle was assembled by the HMO or submitting system."

* entry 2..* MS
* entry ^short = "Entry resource in the claims transaction bundle"
* entry ^definition = "An entry resource included in the claims transaction bundle. Must contain at least one Coverage and one Claim."
* entry ^comment = "Must contain at least one Coverage resource and one Claim resource. Additional supporting resources (Patient, Practitioner, Organization, etc.) may be included as needed."

* entry.fullUrl 1..1 MS
* entry.fullUrl ^short = "URN UUID for the entry"
* entry.fullUrl ^definition = "A URN UUID that identifies this entry within the bundle and allows for internal references."
* entry.resource 1..1 MS
* entry.request 1..1 MS
* entry.request.method 1..1 MS
* entry.request.url 1..1 MS
* entry.search ..0
* entry.response ..0

* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.discriminator[+].type = #type
* entry ^slicing.discriminator[=].path = "resource"
* entry ^slicing.rules = #open
* entry ^slicing.description = "Slicing based on the profile and type of the entry resource"

* entry contains
    coverage 1..1 MS and
    claim 1..1 MS and
    patient 0..* and
    practitioner 0..* and
    practitionerrole 0..* and
    organization 0..* and
    location 0..* and
    procedure 0..* and
    condition 0..* and
    medicationrequest 0..* and
    medication 0..* and
    device 0..* and
    observation 0..*

* entry[coverage].resource 1..1
* entry[coverage].resource only NgCoverage
* entry[coverage].request.method = #POST
* entry[coverage].request.url = "Coverage"

* entry[claim].resource 1..1
* entry[claim].resource only NgClaim
* entry[claim].request.method = #POST
* entry[claim].request.url = "Claim"

* entry[patient].resource 1..1
* entry[patient].resource only Patient
* entry[patient].request.method = #POST
* entry[patient].request.url = "Patient"

* entry[practitioner].resource 1..1
* entry[practitioner].resource only Practitioner
* entry[practitioner].request.method = #POST
* entry[practitioner].request.url = "Practitioner"

* entry[practitionerrole].resource 1..1
* entry[practitionerrole].resource only PractitionerRole
* entry[practitionerrole].request.method = #POST
* entry[practitionerrole].request.url = "PractitionerRole"

* entry[organization].resource 1..1
* entry[organization].resource only Organization
* entry[organization].request.method = #POST
* entry[organization].request.url = "Organization"

* entry[location].resource 1..1
* entry[location].resource only Location
* entry[location].request.method = #POST
* entry[location].request.url = "Location"

* entry[procedure].resource 1..1
* entry[procedure].resource only Procedure
* entry[procedure].request.method = #POST
* entry[procedure].request.url = "Procedure"

* entry[condition].resource 1..1
* entry[condition].resource only Condition
* entry[condition].request.method = #POST
* entry[condition].request.url = "Condition"

* entry[medicationrequest].resource 1..1
* entry[medicationrequest].resource only MedicationRequest
* entry[medicationrequest].request.method = #POST
* entry[medicationrequest].request.url = "MedicationRequest"

* entry[medication].resource 1..1
* entry[medication].resource only Medication
* entry[medication].request.method = #POST
* entry[medication].request.url = "Medication"

* entry[device].resource 1..1
* entry[device].resource only Device
* entry[device].request.method = #POST
* entry[device].request.url = "Device"

* entry[observation].resource 1..1
* entry[observation].resource only Observation
* entry[observation].request.method = #POST
* entry[observation].request.url = "Observation"

Invariant: ngbun-uuid-fullurl
Description: "Transaction entries SHOULD use URN UUID fullUrls for local intra-bundle references."
Severity: #warning
Expression: "entry.fullUrl.all(matches('^urn:uuid:[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'))"

Invariant: ngbun-claim-cov-localref
Description: "Claim.insurance.coverage references SHOULD be local URN UUIDs when the Coverage is in the same transaction."
Severity: #warning
Expression: "entry.resource.ofType(Claim).insurance.coverage.reference.all(matches('^urn:uuid:[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'))"

Invariant: ngbun-minimum-slices
Description: "Bundle must contain at least one coverage and one claim entry."
Severity: #error
Expression: "entry.where(resource is Coverage).exists() and entry.where(resource is Claim).exists()"

// ============================================================================
// BUNDLE INSTANCE - HMO to Hospital Claims Submission
// ============================================================================
Instance: bundle-hmo-hospital-claim-001
InstanceOf: NgTransactionBundle
Usage: #example
Title: "HMO Hospital Claim Transaction Bundle"
Description: "Example of a complete HMO-to-Hospital claim submission with Coverage, Claim, and supporting resources"

* meta.profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-transaction-bundle"

// Bundle identification and timestamp
* identifier.system = "https://hmo.example.ng/bundle-id"
* identifier.value = "CLM-TXN-2025-001"
* timestamp = "2025-01-15T14:30:00+01:00"
* type = #transaction

// Entry: Coverage (Required)
* entry[coverage].fullUrl = "urn:uuid:61ade759-8a1c-4a29-b4b2-234f4c3d9a1e"
* entry[coverage].resource = NgCoverage-HMO-001
* entry[coverage].request.method = #POST
* entry[coverage].request.url = "Coverage"

// Entry: Claim (Required)
* entry[claim].fullUrl = "urn:uuid:71ade759-8a1c-4a29-b4b2-234f4c3d9a2f"
* entry[claim].resource = NgClaim-Hospital-001
* entry[claim].request.method = #POST
* entry[claim].request.url = "Claim"

// Entry: Patient (Optional)
* entry[patient].fullUrl = "urn:uuid:81ade759-8a1c-4a29-b4b2-234f4c3d9a3g"
* entry[patient].resource = NgPatient-Claim-001
* entry[patient].request.method = #POST
* entry[patient].request.url = "Patient"

// Entry: Organization - Hospital (Optional)
* entry[organization].fullUrl = "urn:uuid:91ade759-8a1c-4a29-b4b2-234f4c3d9a4h"
* entry[organization].resource = NgOrganization-Hospital-001
* entry[organization].request.method = #POST
* entry[organization].request.url = "Organization"

// Entry: Organization - HMO (Optional)
* entry[organization].fullUrl = "urn:uuid:a1ade759-8a1c-4a29-b4b2-234f4c3d9a5i"
* entry[organization].resource = NgOrganization-HMO-001
* entry[organization].request.method = #POST
* entry[organization].request.url = "Organization"

// Entry: Practitioner (Optional)
* entry[practitioner].fullUrl = "urn:uuid:b1ade759-8a1c-4a29-b4b2-234f4c3d9a6j"
* entry[practitioner].resource = NgPractitioner-Claim-001
* entry[practitioner].request.method = #POST
* entry[practitioner].request.url = "Practitioner"

// Entry: Condition - Diagnosis (Optional)
* entry[condition].fullUrl = "urn:uuid:c1ade759-8a1c-4a29-b4b2-234f4c3d9a7k"
* entry[condition].resource = NgCondition-Claim-001
* entry[condition].request.method = #POST
* entry[condition].request.url = "Condition"

// Entry: Procedure (Optional)
* entry[procedure].fullUrl = "urn:uuid:d1ade759-8a1c-4a29-b4b2-234f4c3d9a8l"
* entry[procedure].resource = NgProcedure-Claim-001
* entry[procedure].request.method = #POST
* entry[procedure].request.url = "Procedure"


// ============================================================================
// COVERAGE RESOURCE (Entry coverage)
// ============================================================================
Instance: NgCoverage-HMO-001
InstanceOf: NgCoverage
Usage: #inline
Title: "HMO Coverage Example"

* meta.profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-claim-coverage"

* identifier[0].system = "https://hmo.example.ng/member-id"
* identifier[0].value = "HMO-2025-123456"

* status = #active

* type.coding[0].system = "http://terminology.hl7.org/CodeSystem/v3-ActCode"
* type.coding[0].code = #HMO
* type.coding[0].display = "health maintenance organization policy"

* subscriberId = "SUB-2025-789"

* beneficiary = Reference(urn:uuid:81ade759-8a1c-4a29-b4b2-234f4c3d9a3g)

* relationship.coding[0].system = "http://terminology.hl7.org/CodeSystem/subscriber-relationship"
* relationship.coding[0].code = #self

* period.start = "2025-01-01"
* period.end = "2025-12-31"

* payor[0] = Reference(urn:uuid:a1ade759-8a1c-4a29-b4b2-234f4c3d9a5i)


// ============================================================================
// CLAIM RESOURCE (Entry claim)
// ============================================================================
Instance: NgClaim-Hospital-001
InstanceOf: NgClaim
Usage: #inline
Title: "Hospital Claim Example"

* meta.profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-claim"

* identifier[0].system = "https://hospital.example.ng/claim-id"
* identifier[0].value = "CLM-2025-001"

* status = #active

* type.coding[0].system = "http://terminology.hl7.org/CodeSystem/claim-type"
* type.coding[0].code = #institutional
* type.coding[0].display = "Institutional"

* use = #claim

* patient = Reference(urn:uuid:81ade759-8a1c-4a29-b4b2-234f4c3d9a3g)

* created = "2025-01-15T14:30:00+01:00"

* provider = Reference(urn:uuid:91ade759-8a1c-4a29-b4b2-234f4c3d9a4h)

* priority.coding[0].system = "http://terminology.hl7.org/CodeSystem/processpriority"
* priority.coding[0].code = #normal

// Link to Coverage using URN:UUID (satisfies ngbun-claim-cov-localref invariant)
* insurance[0].sequence = 1
* insurance[0].focal = true
* insurance[0].coverage = Reference(urn:uuid:61ade759-8a1c-4a29-b4b2-234f4c3d9a1e)

// Diagnosis
* diagnosis[0].sequence = 1
* diagnosis[0].diagnosisReference = Reference(urn:uuid:c1ade759-8a1c-4a29-b4b2-234f4c3d9a7k)

// Procedure
* procedure[0].sequence = 1
* procedure[0].procedureReference = Reference(urn:uuid:d1ade759-8a1c-4a29-b4b2-234f4c3d9a8l)

// Claim items (services/procedures)
* item[0].sequence = 1
* item[0].careTeamSequence[0] = 1
* item[0].diagnosisSequence[0] = 1
* item[0].procedureSequence[0] = 1
* item[0].productOrService.coding[0].system = "http://terminology.hl7.org/CodeSystem/ex-USCLS"
* item[0].productOrService.coding[0].code = #1205
* item[0].productOrService.coding[0].display = "General Exam"
* item[0].servicedDate = "2025-01-15"
* item[0].unitPrice.value = 50000
* item[0].unitPrice.currency = #NGN
* item[0].net.value = 50000
* item[0].net.currency = #NGN

* item[1].sequence = 2
* item[1].careTeamSequence[0] = 1
* item[1].diagnosisSequence[0] = 1
* item[1].procedureSequence[0] = 1
* item[1].productOrService.coding[0].system = "http://terminology.hl7.org/CodeSystem/ex-USCLS"
* item[1].productOrService.coding[0].code = #21211
* item[1].productOrService.coding[0].display = "Amalgam - one surface"
* item[1].servicedDate = "2025-01-15"
* item[1].unitPrice.value = 120000
* item[1].unitPrice.currency = #NGN
* item[1].net.value = 120000
* item[1].net.currency = #NGN

// Care team
* careTeam[0].sequence = 1
* careTeam[0].provider = Reference(urn:uuid:b1ade759-8a1c-4a29-b4b2-234f4c3d9a6j)
* careTeam[0].role.coding[0].system = "http://terminology.hl7.org/CodeSystem/claimcareteamrole"
* careTeam[0].role.coding[0].code = #primary

* total.value = 170000
* total.currency = #NGN


// ============================================================================
// PATIENT RESOURCE (Entry patient)
// ============================================================================
Instance: NgPatient-Claim-001
InstanceOf: NgPatient
Usage: #inline
Title: "Patient for Claims Example"

* meta.profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/NgPatient"
* meta.lastUpdated = 2025-11-04T11:45:00Z

* identifier[0].type.coding[0].system = "http://terminology.hl7.org/CodeSystem/v2-0203"
* identifier[0].type.coding[0].code = #MR
* identifier[0].type.coding[0].display = "Medical Record Number"
* identifier[0].system = "https://hospital.example.ng/patient-id"
* identifier[0].value = "PAT-2025-001"

* name[0].family = "Adebayo"
* name[0].given[0] = "Oluwaseun"

* gender = #male
* birthDate = "1985-03-20"

* address[0].line[0] = "45 Victoria Island"
* address[0].city = "Lagos"
* address[0].state = "Lagos"
* address[0].country = "NG"

* telecom[0].system = #phone
* telecom[0].value = "+234-803-123-4567"


// ============================================================================
// ORGANIZATION - HOSPITAL (Entry organization)
// ============================================================================
Instance: NgOrganization-Hospital-001
InstanceOf: NgOrganization
Usage: #inline
Title: "Hospital Organization Example"

* meta.profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-organization"

* identifier[0].system = "https://hfr.health.gov.ng/facility-id"
* identifier[0].value = "HFR-LG-H-001"

* active = true

* type[0].coding[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* type[0].coding[0].code = #secondary
* type[0].coding[0].display = "Secondary Hospital"

* name = "Lagos General Hospital"

* telecom[0].system = #phone
* telecom[0].value = "+234-1-234-5678"

* address[0].line[0] = "1 Hospital Road"
* address[0].city = "Lagos"
* address[0].state = "Lagos"
* address[0].country = "NG"


// ============================================================================
// ORGANIZATION - HMO (Entry orgainzation)
// ============================================================================
Instance: NgOrganization-HMO-001
InstanceOf: NgOrganization
Usage: #inline
Title: "HMO Organization Example"

* meta.profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-organization"

* identifier[0].system = "https://nhia.gov.ng/hmo-id"
* identifier[0].value = "HMO-NG-001"

* active = true

* type[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/organization-type"
* type[0].coding[0].code = #pay
* type[0].coding[0].display = "Payer"

* name = "Nigerian Health Maintenance Organization"

* telecom[0].system = #phone
* telecom[0].value = "+234-1-345-6789"

* address[0].line[0] = "10 Insurance Plaza"
* address[0].city = "Abuja"
* address[0].state = "FCT"
* address[0].country = "NG"


// ============================================================================
// PRACTITIONER (Entry practitioner)
// ============================================================================
Instance: NgPractitioner-Claim-001
InstanceOf: NgPractitioner
Usage: #inline
Title: "Practitioner for Claims Example"

* meta.profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/NgPractitioner"

* identifier[0].system = "https://mdcn.gov.ng/practitioner-id"
* identifier[0].value = "MDCN-2025-001"

* name[0].family = "Okonkwo"
* name[0].given[0] = "Chukwuemeka"
* name[0].prefix[0] = "Dr."

* telecom[0].system = #phone
* telecom[0].value = "+234-802-987-6543"

* gender = #male


// ============================================================================
// CONDITION - DIAGNOSIS (Entry diagnosis)
// ============================================================================
Instance: NgCondition-Claim-001
InstanceOf: NgCondition
Usage: #inline
Title: "Condition for Claims Example"

* meta.profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/NgCondition"

* clinicalStatus.coding[0].system = "http://terminology.hl7.org/CodeSystem/condition-clinical"
* clinicalStatus.coding[0].code = #active

* verificationStatus.coding[0].system = "http://terminology.hl7.org/CodeSystem/condition-ver-status"
* verificationStatus.coding[0].code = #confirmed

* category[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/condition-category"
* category[0].coding[0].code = #encounter-diagnosis

* code.coding[0].system = "http://snomed.info/sct"
* code.coding[0].code = #38341003
* code.coding[0].display = "Hypertension"

* subject = Reference(urn:uuid:81ade759-8a1c-4a29-b4b2-234f4c3d9a3g)

* onsetDateTime = "2024-12-01"


// ============================================================================
// PROCEDURE (Entry procedure)
// ============================================================================
Instance: NgProcedure-Claim-001
InstanceOf: NgProcedure
Usage: #inline
Title: "Procedure for Claims Example"

* meta.profile = "https://sandbox.dhin-hie.org/ig/StructureDefinition/NgProcedure"

* status = #completed

* code.coding[0].system = "http://snomed.info/sct"
* code.coding[0].code = #410006001
* code.coding[0].display = "Consultation"

* subject = Reference(urn:uuid:81ade759-8a1c-4a29-b4b2-234f4c3d9a3g)

* performedDateTime = "2025-01-15"

* performer[0].actor = Reference(urn:uuid:b1ade759-8a1c-4a29-b4b2-234f4c3d9a6j)