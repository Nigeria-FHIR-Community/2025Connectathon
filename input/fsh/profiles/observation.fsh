Profile: NgObservation
Parent: Observation
Id: NgObservation
Title: "NG Observations"
Description: "A composite Observation profile capturing state of health, underlying conditions, HIV status, ages in weeks/months/years during client registration."

* status 1..1
* status = #final
* category 1..1
* category = http://terminology.hl7.org/CodeSystem/observation-category#social-history
* code 1..1
* code = $loinc#30525-0 "Age"        // Use LOINC Age as the main analyte
* subject 1..1
* subject only Reference(NgPatient)
* effective[x] 1..1

// Force age to be expressed via components (not Observation.value[x])
* value[x] 0..0

// Slice components by the component.code
* component 1..* MS
* component ^slicing.discriminator[0].type = #pattern
* component ^slicing.discriminator[0].path = "code"
* component ^slicing.rules = #closed
* component contains
    ageInWeeks 0..1 MS and
    ageInMonths 0..1 MS and
    ageInYears 0..1 MS


// Component: Pregnancy Status
* component contains pregnancyStatus 0..1
* component[pregnancyStatus].code = $loinc#82810-3 "Pregnancy status"
* component[pregnancyStatus].valueCodeableConcept 1..1 MS
* component[pregnancyStatus].valueCodeableConcept from NGPregnancyStatusVS (extensible)

// Component: HIV Status
* component contains hivStatus 0..1
* component[hivStatus].code = $sct#278977008 "HIV status"
* component[hivStatus].valueCodeableConcept 1..1 MS
* component[hivStatus].valueCodeableConcept from NGHivStatusVS (extensible)


// Weight at Birth
* component contains birthWeight 0..1
* component[birthWeight].code = $loinc#8339-4 "Birth weight Measured"
* component[birthWeight].valueQuantity 1..1
* component[birthWeight].valueQuantity.unit = "g"
* component[birthWeight].valueQuantity.system = "http://unitsofmeasure.org"
//* component[birthWeight].valueQuantity.code = #g


// ---- ageInWeeks ----
* component[ageInWeeks].code = $ngAgeComp#wk "Age in weeks"
* component[ageInWeeks].value[x] only Quantity
* component[ageInWeeks].valueQuantity.unit = "week"

// ---- ageInMonths ----
* component[ageInMonths].code = $ngAgeComp#mn "Months (mo)"
* component[ageInMonths].value[x] only Quantity
* component[ageInMonths].valueQuantity.unit = "month"

// ---- ageInYears ----
* component[ageInYears].code = $ngAgeComp#yr "Years (y)"
* component[ageInYears].value[x] only Quantity
* component[ageInYears].valueQuantity.unit = "year"


// EXAMPLES 

// ==============================================
// NgObservation-001 — MNCH Referral (Pregnant)
// ==============================================
Instance: NgObservation-001
InstanceOf: NgObservation
Usage: #example
Title: "Example Observation (MNCH Referral)"
Description: "Pregnancy & HIV status with age in years for NgPatient-001."
* status = #final
* category = http://terminology.hl7.org/CodeSystem/observation-category#social-history
* code = http://loinc.org#30525-0 "Age"
* subject = Reference(NgPatient-001)
* effectiveDateTime = 2025-11-04T10:00:00Z
* performer = Reference(NgPractitioner-001)

// Components (use named slices only)
* component[ageInYears].valueQuantity.value = 30
* component[ageInYears].valueQuantity.system = "http://unitsofmeasure.org"
* component[ageInYears].valueQuantity.unit = "year"

* component[pregnancyStatus].valueCodeableConcept.coding[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-pregnancy-status"
* component[pregnancyStatus].valueCodeableConcept.coding[0].code = #pregnant
* component[pregnancyStatus].valueCodeableConcept.coding[0].display = "Pregnant"

* component[hivStatus].valueCodeableConcept.coding[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-hiv-status"
* component[hivStatus].valueCodeableConcept.coding[0].code = #unknown
* component[hivStatus].valueCodeableConcept.coding[0].display = "Unknown"


// ==============================================
// NgObservation-002 — ePharmacy & Claims (Adult Male)
// ==============================================
Instance: NgObservation-002
InstanceOf: NgObservation
Usage: #example
Title: "Example Ng Observation (ePharmacy & Claims)"
Description: "HIV status with age in years for NgPatient-002."
* status = #final
* category = http://terminology.hl7.org/CodeSystem/observation-category#social-history
* code = http://loinc.org#30525-0 "Age"
* subject = Reference(NgPatient-002)
* effectiveDateTime = 2025-11-04T10:05:00Z
* performer = Reference(NgPractitioner-002)

* component[ageInYears].valueQuantity.value = 38
* component[ageInYears].valueQuantity.system = "http://unitsofmeasure.org"
//* component[ageInYears].valueQuantity.code = #yr
* component[ageInYears].valueQuantity.unit = "year"

* component[hivStatus].valueCodeableConcept.coding[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-hiv-status"
* component[hivStatus].valueCodeableConcept.coding[0].code = #negative
* component[hivStatus].valueCodeableConcept.coding[0].display = "Negative"


// ==============================================
// NgObservation-003 — Childhood Immunization (Child)
// ==============================================
Instance: NgObservation-003
InstanceOf: NgObservation
Usage: #example
Title: "Example Ng Observation (Childhood Immunization)"
Description: "Age in months and birth weight for NgPatient-003."
* status = #final
* category = http://terminology.hl7.org/CodeSystem/observation-category#social-history
* code = http://loinc.org#30525-0 "Age"
* subject = Reference(NgPatient-003)
* effectiveDateTime = 2025-11-04T10:10:00Z
* performer = Reference(NgPractitioner-001)

* component[ageInMonths].valueQuantity.value = 74
* component[ageInMonths].valueQuantity.system = "http://unitsofmeasure.org"
//* component[ageInMonths].valueQuantity.code = #mo
* component[ageInMonths].valueQuantity.unit = "month"

* component[birthWeight].valueQuantity.value = 3200
* component[birthWeight].valueQuantity.system = "http://unitsofmeasure.org"
* component[birthWeight].valueQuantity.unit = "g"
