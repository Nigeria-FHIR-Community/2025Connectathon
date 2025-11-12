
Profile: NgMeasure
Parent: Measure
Id: ng-measure
Title: "NG Measure"
Description: "A profile on the Measure resource used to define indicators within prescription program."
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-measure"

* identifier 1..1 MS
* identifier.value 1..1
* identifier.value ^short = "A unique identifier for the indicator definition (e.g. dropout-rate, bcg-coverage)."
* status 1..1 MS
* status ^short = "Indicates the status of the measure (e.g., draft, active, retired)."
* name 1..1 MS
* name ^short = "A machine-friendly name for the measure (e.g., DropoutRate)."
* title 1..1 MS
* title ^short = "A human-readable title for the measure (e.g., 'Penta1 to Measles Dropout Rate')."
* description 1..1 MS
* description ^short = "Detailed description of what this measure represents."
* purpose 0..1 MS
* purpose ^short = "Explains the reason this measure exists and what it is intended to support."
* topic 0..* MS
* topic ^short = "A code or text indicating the domain/topic of the measure (e.g., Immunization Coverage)."
* scoring 1..1 MS
* scoring ^short = "How the measure is scored (e.g., proportion, ratio, continuous-variable)."
* improvementNotation 0..1 MS
* improvementNotation ^short = "Indicates whether an increase or decrease in the score is desirable."
* date 1..1 MS
* date ^short = "The date this measure profile or version was published."
* publisher 0..1 MS
* publisher ^short = "The organization or person responsible for publishing the measure."
* group 0..* MS
* group.population 0..* MS
* group.population.code 0..1
* group.population.code ^short = "The type of population for the measure (e.g., numerator, denominator, initial-population)."
* group.population.description 0..1 MS
* group.population.description ^short = "Description of the population involved in the indicator."

* library 0..1 MS
* library ^short = "Reference to the logic library (e.g., CQL or ELM) defining computation rules for the measure."


// EXAMPLES

// ==============================================
// 1) ePharmacy — Dispense within 48h (proportion)
// ==============================================
Instance: NgMeasure-001
InstanceOf: NgMeasure
Usage: #example
Title: "Example Ng Measure (Dispense within 48h)"
Description: "Proportion of ePrescriptions dispensed within 48 hours of prescription."
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier.value  = #HCF-12341
* status = #active
* experimental = false
* name = "DispenseWithin48h"
* title = "eRx Dispense within 48 Hours"
* description = "Measures the proportion of electronic prescriptions dispensed within 48 hours."
* purpose = "Monitor timeliness of dispensing and reduce delays to therapy."
* topic[0].text = "ePharmacy"
* scoring.coding[0].system = "http://terminology.hl7.org/CodeSystem/measure-scoring"
* scoring.coding[0].code = #proportion
* improvementNotation.coding[0].system = "http://terminology.hl7.org/CodeSystem/measure-improvement-notation"
* improvementNotation.coding[0].code = #increase
* date = "2025-09-15"

// Populations (denominator & numerator)
* group[0].population[0].code.coding[0].system = "http://terminology.hl7.org/CodeSystem/measure-population"
* group[0].population[0].code.coding[0].code = #denominator
* group[0].population[0].description = "All valid ePrescriptions in the measurement period."
// NgMeasure-001 (Dispense within 48h) — Denominator: all ePrescriptions in period
* group[0].population[0].criteria.language = #text/cql-identifier
* group[0].population[0].criteria.expression = "AllRxInPeriod"
* group[0].population[0].criteria.description = "All valid ePrescriptions (MedicationRequest) authored within the Measurement Period."
* group[0].population[1].code.coding[0].system = "http://terminology.hl7.org/CodeSystem/measure-population"
* group[0].population[1].code.coding[0].code = #numerator
* group[0].population[1].description = "ePrescriptions dispensed within 48 hours of prescription."
* group[0].population[1].criteria.language = #text/cql-identifier
* group[0].population[1].criteria.expression = "AllRxInPeriod"
* group[0].population[1].criteria.description = "All valid ePrescriptions (MedicationRequest) authored within the Measurement Period."



// ==============================================
// 2) ePharmacy — Counseling documented (proportion)
// ==============================================
Instance: NgMeasure-002
InstanceOf: NgMeasure
Usage: #example
Title: "Example Ng Measure (Counseling Documented)"
Description: "Proportion of dispensations with counseling documented."
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier.value  = #HCF-12343
* status = #active
* experimental = false
* name = "CounselingDocumented"
* title = "Medication Counseling Documented"
* description = "Measures documentation of patient counseling during dispensing events."
* purpose = "Improve adherence and patient safety through counseling."
* topic[0].text = "ePharmacy Quality"
* scoring.coding[0].system = "http://terminology.hl7.org/CodeSystem/measure-scoring"
* scoring.coding[0].code = #proportion
* improvementNotation.coding[0].system = "http://terminology.hl7.org/CodeSystem/measure-improvement-notation"
* improvementNotation.coding[0].code = #increase
* date = "2025-09-15"

// Populations
* group[0].population[0].code.coding[0].system = "http://terminology.hl7.org/CodeSystem/measure-population"
* group[0].population[0].code.coding[0].code = #denominator
* group[0].population[0].description = "All medication dispensing events in the measurement period."
* group[0].population[0].criteria.language = #text/cql-identifier
* group[0].population[0].criteria.expression = "AllDispenseEventsInPeriod"
* group[0].population[0].criteria.description = "All MedicationDispense events occurring within the Measurement Period."

* group[0].population[1].code.coding[0].system = "http://terminology.hl7.org/CodeSystem/measure-population"
* group[0].population[1].code.coding[0].code = #numerator
* group[0].population[1].description = "Dispensing events with counseling recorded."
* group[0].population[1].criteria.language = #text/cql-identifier
* group[0].population[1].criteria.expression = "AllDispenseEventsInPeriod"
* group[0].population[1].criteria.description = "All MedicationDispense events occurring within the Measurement Period."

// ==============================================
// 3) Claims — Claim approval rate (proportion)
// ==============================================
Instance: NgMeasure-003
InstanceOf: NgMeasure
Usage: #example
Title: "Example Ng Measure (Claim Approval Rate)"
Description: "Proportion of submitted claims that are approved."
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier.value  = #HCF-12345
* status = #active
* experimental = false
* name = "ClaimApprovalRate"
* title = "Claim Approval Rate"
* description = "Measures the proportion of claims adjudicated as approved out of all submitted claims."
* purpose = "Track payer performance and provider claim quality."
* topic[0].text = "Claims & Insurance"
* scoring.coding[0].system = "http://terminology.hl7.org/CodeSystem/measure-scoring"
* scoring.coding[0].code = #proportion
* improvementNotation.coding[0].system = "http://terminology.hl7.org/CodeSystem/measure-improvement-notation"
* improvementNotation.coding[0].code = #increase
* date = "2025-09-15"

// Populations
* group[0].population[0].code.coding[0].system = "http://terminology.hl7.org/CodeSystem/measure-population"
* group[0].population[0].code.coding[0].code = #denominator
* group[0].population[0].description = "All claims submitted during the measurement period."
* group[0].population[0].criteria.language = #text/cql-identifier
* group[0].population[0].criteria.expression = "AllClaimsSubmittedInPeriod"
* group[0].population[0].criteria.description = "All submitted Claim resources within the Measurement Period."

* group[0].population[1].code.coding[0].system = "http://terminology.hl7.org/CodeSystem/measure-population"
* group[0].population[1].code.coding[0].code = #numerator
* group[0].population[1].description = "Claims with adjudication outcome 'approved'."
* group[0].population[1].criteria.language = #text/cql-identifier
* group[0].population[1].criteria.expression = "AllClaimsSubmittedInPeriod"
* group[0].population[1].criteria.description = "All submitted Claim resources within the Measurement Period."