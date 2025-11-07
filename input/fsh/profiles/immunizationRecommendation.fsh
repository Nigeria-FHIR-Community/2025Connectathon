// ======================================================================
// Profile: NgImmunizationRecommendation
// ======================================================================
Profile: NgImmunizationRecommendation
Parent: ImmunizationRecommendation
Id: ng-immunization-recommendation
Title: "NG ImmunizationRecommendation"
Description: "Simple profile to convey due/overdue vaccine recommendations for a Nigerian client."

* ^status = #active

// Core must-supports
* patient 1..1 MS
* patient only Reference(NgPatient)
* recommendation 1..* MS

// Keep the inner recommendation simple & practical
* date 1..1 MS
* recommendation.vaccineCode 0..* MS
* recommendation.vaccineCode.text 0..1
* recommendation.targetDisease 0..1 
* recommendation.forecastStatus 1..1 MS
* recommendation.forecastStatus.coding 0..1
* recommendation.forecastStatus.coding.system 0..1
* recommendation.forecastStatus.coding.code 0..1
* recommendation.series 0..1
* recommendation.doseNumber[x] 0..1
* recommendation.doseNumber[x] only positiveInt or string

// Helpful hint
* patient ^short = "Reference to the client (NgPatient)"
* recommendation.forecastStatus ^short = "due | overdue | complete | contraindicated | not-due"

// ----------------------------------------------------------------------
// Minimal Example
// ----------------------------------------------------------------------
Instance: NgImmunizationRecommendation-001
InstanceOf: NgImmunizationRecommendation
Usage: #example
Title: "Immunization Recommendation – Measles (due)"
Description: "Recommends Measles dose for a child; due now."

// Patient (inline minimal NgPatient for a self-contained example)
* patient = Reference(NgPatient-001)
* date = "2025-11-06T09:00:00+01:00"
* recommendation[0].vaccineCode[0].text = "Measles-containing vaccine (MCV1)"
* recommendation[0].forecastStatus.coding.system = "http://terminology.hl7.org/CodeSystem/immunization-recommendation-status"
* recommendation[0].forecastStatus.coding.code = #due
* recommendation[0].series = "RI Schedule – Measles"
* recommendation[0].doseNumberPositiveInt = 1
