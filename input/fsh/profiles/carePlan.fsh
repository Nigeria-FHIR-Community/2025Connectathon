Profile: NgCarePlan
Parent: CarePlan
Title: "NG CarePlan"
Description: "A simple CarePlan profile for the 2025 Connectathon."

// Core elements
* status 1..1 MS
* intent 1..1 MS
* subject 1..1 MS
* subject only Reference(NgPatient)
* category 0..* MS
* period 0..1 MS
* goal 0..* MS
* goal only Reference(NgGoal)


// Bindings
* intent = #plan (exactly)
* status from http://hl7.org/fhir/ValueSet/request-status (required) // built-in value set
* activity.detail.status from CarePlanActivityStatus (required) // built-in value set

// Apply local VS bindings
* category from NgCarePlanCategoryVS (extensible)
* activity.detail.code from NgCarePlanActivityVS (preferred)

// -----------------------------
// Example Instance
// -----------------------------
Instance: NgCarePlan-001
InstanceOf: NgCarePlan
Usage: #example
Title: "Example NG CarePlan"
Description: "Minimal example of a CarePlan using NgCarePlan."
* status = #active
* intent = #plan
* subject = Reference(NgPatient/NgPatient-001)
* category[+] = NgCarePlanCategoryCS#mnch "MNCH"
* period.start = 2025-11-11
* period.end = 2025-12-31
* goal = Reference(NgGoal/NgGoal-001)

