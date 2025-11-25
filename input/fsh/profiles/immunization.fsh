Profile: NgImmunization
Parent: Immunization
Title: "NG Immunization"
Description: "Nigerian Profile for Immunization resource."
Id: ng-immunization
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-immunization"

* identifier 0..1
* vaccineCode 1..1 MS
* vaccineCode from NGVaccineLocalVS 
* vaccineCode ^short = "Vaccine Product Administered"
* statusReason from http://hl7.org/fhir/ValueSet/immunization-status-reason (extensible)
* statusReason ^short = "Reason immunization was not done (or was missed)"
* status 1..1 MS
* status from http://hl7.org/fhir/ValueSet/immunization-status (required)
* status ^short = "Status of Immunization e.g. completed| entered-in-error | not-done"
* manufacturer only Reference(NgOrganization)
* manufacturer ^short = "Manufacturer description and identity"
* patient 1..1 MS
* patient only Reference(NgPatient)
* protocolApplied 0..* MS
* protocolApplied.targetDisease from http://hl7.org/fhir/ValueSet/immunization-target-disease (example)
* protocolApplied.targetDisease ^short = "Vaccine preventable disease being targeted" 
* lotNumber 0..1 MS
* lotNumber ^short = "Vaccine batch number"
* expirationDate 0..1 MS
* expirationDate ^short = "Vaccine expiration date"
* doseQuantity 1..1 MS
* doseQuantity ^short = "Amount of vaccine administered"
* site from http://hl7.org/fhir/ValueSet/immunization-site (preferred)
* site ^short = "Body site vaccine was administered"
* route from http://hl7.org/fhir/ValueSet/immunization-route (preferred)
* route ^short = "How vaccine entered body"
* performer 0..* MS //Who performed event
* performer.function from http://hl7.org/fhir/ValueSet/immunization-function (extensible)
* performer.function ^short = "Designation of reporting officer" //What type of performance was done
* performer.actor only Reference (NgPractitioner)
* performer.actor ^short = "Information of reporting officer" //Individual or organization who was performing
* occurrence[x] 1..1 MS
* occurrence[x] only dateTime
* reaction 0..5 MS
* reaction.date 0..1 
* reaction.reported 0..1
* reaction.detail only Reference(NgObservation)
* location only Reference(NgLocation)



// Immunization Extensions
 
/* * extension contains NGPrimaryVaccineStatus named primaryVaccineStatus 0..1 MS */

* extension contains NGContraindications named contraindications 0..* MS
* extension contains NGContraindicated named contraindicated 0..* MS
* extension contains NextDoseDate named nextDoseDate 0..1 MS
 


 // EXAMPLES

 // ==============================================
// NgImmunization-001 — Pentavalent 1 for child (Gwagwalada PHC)
// ==============================================
Instance: NgImmunization-001
InstanceOf: NgImmunization
Usage: #example
Title: "Example Ng Immunization (Pentavalent 1)"
Description: "Pentavalent 1 administered to NgPatient-003 at Gwagwalada PHC."
* id = "00128455-e5f6-4789-a123-456789abcdef"
* status = #completed
* vaccineCode = NGVaccineLocalCS#IMMZ.Z.DE4 "Pentavalent 1"
* patient = Reference(NgPatient-003)
* occurrenceDateTime = 2025-09-10T10:00:00+01:00
* lotNumber = "PENTA25-0001"
* expirationDate = 2026-06-30
* doseQuantity.value = 0.5
* doseQuantity.system = "http://unitsofmeasure.org"
* doseQuantity.code = #mL
* doseQuantity.unit = "mL"
* manufacturer = Reference(NgOrganization-001)
* performer[0].actor = Reference(NgPractitioner-003)
// Optional, text-only to avoid code mismatches
* site.text = "Left thigh"
* route.text = "Intramuscular"
// Show use of NextDoseDate extension (via protocolApplied)
* extension[nextDoseDate].valueDate = 2024-09-10
* extension[nextDoseDate].url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/next-dose-date"
* protocolApplied[0].doseNumberPositiveInt = 4


// ==============================================
// NgImmunization-002 — Rotavirus 1 (oral) for child (Gwagwalada PHC)
// ==============================================
Instance: NgImmunization-002
InstanceOf: NgImmunization
Usage: #example
Title: "Example Ng Immunization (Rotavirus 1)"
Description: "Rotavirus 1 administered orally to NgPatient-003."
* id = "00234455-e5f6-4789-a123-456789abcdef"
* status = #completed
* vaccineCode = NGVaccineLocalCS#IMMZ.Z.DE7 "Rotavirus 1"
* patient = Reference(NgPatient-003)
* occurrenceDateTime = 2025-09-10T10:05:00+01:00
* lotNumber = "ROTA25-0045"
* expirationDate = 2026-04-30
* doseQuantity.value = 2
* doseQuantity.system = "http://unitsofmeasure.org"
* doseQuantity.code = #mL
* doseQuantity.unit = "mL"
* manufacturer = Reference(NgOrganization-003)
* performer[0].actor = Reference(NgPractitioner-003)
* route.text = "Oral"



// ==============================================
// NgImmunization-003 — Tetanus-Diphtheria for adult (Asokoro Hospital)
// ==============================================
Instance: NgImmunization-003
InstanceOf: NgImmunization
Usage: #example
Title: "Example Ng Immunization (Tetanus Diphtheria)"
Description: "Td dose administered to NgPatient-001 at Asokoro District Hospital."
* status = #completed
* vaccineCode = NGVaccineLocalCS#IMMZ.Z.DE28 "Tetanus Diphtheria"
* patient = Reference(NgPatient-001)
* occurrenceDateTime = 2025-11-04T09:10:00+01:00
* lotNumber = "TD25-0300"
* expirationDate = 2027-12-31
* doseQuantity.value = 0.5
* doseQuantity.system = "http://unitsofmeasure.org"
* doseQuantity.code = #mL
* doseQuantity.unit = "mL"
* manufacturer = Reference(NgOrganization-001)
* performer[0].actor = Reference(NgPractitioner-001)
* site.text = "Left deltoid"
* route.text = "Intramuscular"





// ========== Extension 1: NGContraindications (0..*) ==========
// List of contraindications identified but immunization proceeded anyway
// (e.g., mild contraindications that were assessed and deemed acceptable)

* extension[contraindications][0].valueCodeableConcept.coding.system = "http://snomed.info/sct"
* extension[contraindications][0].valueCodeableConcept.coding.code = #419076005
* extension[contraindications][0].valueCodeableConcept.coding.display = "Allergic reaction (disorder)"
* extension[contraindications][0].valueCodeableConcept.text = "Mild seasonal allergies - assessed, not a contraindication to vaccination"

* extension[contraindications][1].valueCodeableConcept.coding.system = "http://snomed.info/sct"
* extension[contraindications][1].valueCodeableConcept.coding.code = #386661006
* extension[contraindications][1].valueCodeableConcept.coding.display = "Fever"
* extension[contraindications][1].valueCodeableConcept.text = "Low-grade fever (37.8°C) - assessed by clinician, vaccination approved"


// ========== Extension 2: NGContraindicated (0..1) ==========
// Boolean flag: Was this vaccine contraindicated? (false = proceeded despite concerns)
* extension[contraindicated].valueBoolean = false

// ========== Extension 3: NextDoseDate (0..1) under protocolApplied ==========
// When is the next dose due?

* protocolApplied[0].series = "Hepatitis B Primary Series"
* protocolApplied[0].doseNumberPositiveInt = 2
* protocolApplied[0].seriesDosesPositiveInt = 3

* protocolApplied[0].targetDisease[0].coding.system = "http://snomed.info/sct"
* protocolApplied[0].targetDisease[0].coding.code = #66071002
* protocolApplied[0].targetDisease[0].coding.display = "Viral hepatitis type B"

* extension[nextDoseDate].valueDate = "2026-05-18"
* extension[nextDoseDate].url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/next-dose-date"