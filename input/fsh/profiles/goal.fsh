Profile: NgGoal
Parent: Goal
Title: "NG Goal"
Description: "Minimal Goal profile for the 2025 Connectathon."

// Core constraints
* lifecycleStatus 1..1 MS
* lifecycleStatus from GoalLifecycleStatus (required)
* achievementStatus 0..1
* achievementStatus from GoalAchievementStatus (preferred)

* description 1..1 MS // CodeableConcept
* subject 1..1 MS
* subject only Reference(NgPatient)

* start[x] 0..1
* priority 0..1
* priority from GoalPriority (preferred)
* category 0..* MS
* category from GoalCategory (preferred)

* target 0..* MS
* target.measure 0..1
* target.measure from http://loinc.org (example)
* target.detail[x] 0..1
* target.due[x] 0..1

* statusDate 0..1
* addresses 0..*
* addresses only Reference(NgCondition or NgObservation or NgServiceRequest)


// -----------------------------
// Example Instance
// -----------------------------
Instance: NgGoal-001
InstanceOf: NgGoal
Usage: #example
Title: "Example NG Goal"
Description: "Patient goal to control systolic BP within 6 weeks."
* lifecycleStatus = #active
* achievementStatus.coding[0].system = "http://terminology.hl7.org/CodeSystem/goal-achievement"
* achievementStatus.coding[0].code = #improving
* description.text = "Control systolic blood pressure"
* subject = Reference(NgPatient/NgPatient-001)
* startDate = 2025-11-11
* priority.coding[0].system = "http://terminology.hl7.org/CodeSystem/goal-priority"
* priority.coding[0].code = #high-priority
* category[0].text = "Chronic disease management"
* target[0].measure.coding[0].system = "http://loinc.org"
* target[0].measure.coding[0].code = #8480-6
* target[0].measure.coding[0].display = "Systolic blood pressure"
* target[0].detailQuantity.value = 120
* target[0].detailQuantity.unit = "mmHg"
* target[0].dueDate = 2025-12-23
