Profile: NgMeasureReport
Parent: MeasureReport
Id: measure-report-profile 
Title: "NG MeasureReport"
Description: "Nigeria Measure Report Profile"


* identifier.value 1..1 MS
* identifier.value ^short = "A unique identifier for the instance of the report that has been generated"
* status 1..1 MS
* status ^short = "The status of the report (e.g, initial, complete, etc)"
* type 1..1 MS
* type ^short = "The type of report which has been generated (i.e. is the report a list of individuals, a summary, etc)"
//* measure 1..1 MS
//* measure ^short = "The indicator or measure definition which is being reported on (for example: Dropout rate, defaulters, etc)"
* date 1..1 MS
* date ^short = "The date and time on which the report was generated"
* reporter only Reference(NgPractitioner)
* reporter ^short = "Indicates the organization, or location which is generating or producing the report"
* period 1..1 MS
* period.start 1..1 
* period.start ^short = "The start date of the reporting period for which data in the report has been included"
* period.end 1..1 
* period.end ^short = "The end date of the reporting period for which data in the report has been included"
* measure only Canonical(NgMeasure)
* measure ^short = "The measure that was calculated"

* group.measureScore 0..1 MS
* group.measureScore.value 0..1 
* group.measureScore.value ^short = "The calculated score of the measure / indicator which is being reported on"
* group.measureScore.unit  0..1 
* group.measureScore.unit ^short = "The unit of  calculated score of the measure / indicator which is being reported on"
* group.population 0..1
* group.population ^short = "The population "


 // EXAMPLES
 // ==============================================
// 1) MeasureReport for NgMeasure-001 (eRx Dispense within 48h) — September 2025
// ==============================================
Instance: NgMeasureReport-001
InstanceOf: NgMeasureReport
Usage: #example
Title: "Example Ng MeasureReport (DispenseWithin48h)"
Description: "Summary report of ePrescriptions dispensed within 48 hours."
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier.value  = #HCF-12345
* status = #complete
* type = #summary
* date = "2025-10-05T08:00:00+01:00"
* reporter = Reference(NgPractitioner-002)
* period.start = 2025-09-01
* period.end   = 2025-09-30
* measure = Canonical(NgMeasure-001)
// Minimal score
* group[0].measureScore.value = 0.78
* group[0].measureScore.system = "http://unitsofmeasure.org"
* group[0].measureScore.code  = #numerator
* group[0].population[0].code = http://terminology.hl7.org/CodeSystem/measure-population#initial-population
* group[0].population[0].count = 23433


// ==============================================
// 2) MeasureReport for NgMeasure-002 (Counseling Documented) — October 2025
// ==============================================
Instance: NgMeasureReport-002
InstanceOf: NgMeasureReport
Usage: #example
Title: "Example Ng MeasureReport (CounselingDocumented)"
Description: "Summary report of dispensing events with counseling documented."
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier.value  = #HCF-12343
* status = #complete
* type = #summary
* date = "2025-11-02T09:15:00+01:00"
* reporter = Reference(NgPractitioner-001)
* period.start = 2025-10-01
* period.end   = 2025-10-31
* measure = Canonical(NgMeasure-002)
// Minimal score
* group[0].measureScore.value = 0.64
* group[0].measureScore.system = "http://unitsofmeasure.org"
* group[0].measureScore.code  = #%


// ==============================================
// 3) MeasureReport for NgMeasure-003 (Claim Approval Rate) — Q3 2025
// ==============================================
Instance: NgMeasureReport-003
InstanceOf: NgMeasureReport
Usage: #example
Title: "Example Ng MeasureReport (ClaimApprovalRate)"
Description: "Summary report of approved claims over all submitted claims."
* identifier.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* identifier.value  = #HCF-12344
* status = #complete
* type = #summary
* date = "2025-10-07T11:00:00+01:00"
* reporter = Reference(NgPractitioner-003)
* period.start = 2025-07-01
* period.end   = 2025-09-30
* measure = Canonical(NgMeasure-003)
// Minimal score
* group[0].measureScore.value = 0.82
* group[0].measureScore.system = "http://unitsofmeasure.org"
* group[0].measureScore.code  = #%
