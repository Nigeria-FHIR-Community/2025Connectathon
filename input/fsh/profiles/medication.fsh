Profile: NgMedication
Parent: Medication
Id: ng-medication
Title: "NG Medication"
Description: "A Medication profile with some core elements for demonstration purposes."

* identifier MS
* form MS
* ingredient MS
* code MS
* batch MS


//EXAMPLES
// ==============================================
// NgMedication-001 — Amoxicillin 500 mg Capsule
// ==============================================
Instance: NgMedication-001
InstanceOf: NgMedication
Usage: #example
Title: "Example Ng Medication (Amoxicillin 500 mg Capsule)"
Description: "Amoxicillin hard gelatin capsule, 500 mg."
* identifier.system = $ngVacCS
* identifier.value  = #IMMZ.Z.DE5  "Oral Polio Vaccine (OPV 1)"
* code.text = "Amoxicillin 500 mg capsule"
* form.text = "Capsule"
// Ingredient strength: 500 mg per 1 (unitless)
* ingredient[0].itemCodeableConcept.text = "Amoxicillin"
* ingredient[0].strength.numerator.value = 500
* ingredient[0].strength.numerator.unit = "mg"
* ingredient[0].strength.numerator.system = "http://unitsofmeasure.org"
* ingredient[0].strength.numerator.code = #mg
* ingredient[0].strength.denominator.value = 1
* ingredient[0].strength.denominator.unit = "1"
* ingredient[0].strength.denominator.system = "http://unitsofmeasure.org"
* ingredient[0].strength.denominator.code = #1
* batch.lotNumber = "AMX-2025-001"
* batch.expirationDate = 2027-12-31


// ==============================================
// NgMedication-002 — Paracetamol 250 mg/5 mL Oral Suspension
// ==============================================
Instance: NgMedication-002
InstanceOf: NgMedication
Usage: #example
Title: "Example Ng Medication (Paracetamol Oral Suspension 250 mg/5 mL)"
Description: "Paracetamol (Acetaminophen) oral suspension, pediatric."
* identifier.system = $ngVacCS
* identifier.value  = #IMMZ.Z.DE5  "Oral Polio Vaccine (OPV 1)"
* code.text = "Paracetamol oral suspension 250 mg/5 mL"
* form.text = "Oral Suspension"
// Ingredient strength: 250 mg per 5 mL
* ingredient[0].itemCodeableConcept.text = "Paracetamol (Acetaminophen)"
* ingredient[0].strength.numerator.value = 250
* ingredient[0].strength.numerator.unit = "mg"
* ingredient[0].strength.numerator.system = "http://unitsofmeasure.org"
* ingredient[0].strength.numerator.code = #mg
* ingredient[0].strength.denominator.value = 5
* ingredient[0].strength.denominator.unit = "mL"
* ingredient[0].strength.denominator.system = "http://unitsofmeasure.org"
* ingredient[0].strength.denominator.code = #mL
* batch.lotNumber = "PCM-25-091"
* batch.expirationDate = 2026-06-30

// ==============================================
// NgMedication-003 — Insulin 100 IU/mL Injection
// ==============================================
Instance: NgMedication-003
InstanceOf: NgMedication
Usage: #example
Title: "Example Ng Medication (Insulin 100 IU/mL Injection)"
Description: "Short-acting insulin solution for injection."
* identifier.system = $ngVacCS
* identifier.value  = #IMMZ.Z.DE5  "Oral Polio Vaccine (OPV 1)"
* code.text = "Insulin (short-acting) 100 IU/mL"
* form.text = "Injection Solution"
// Ingredient strength: 100 International Units per 1 mL
* ingredient[0].itemCodeableConcept.text = "Insulin (short-acting)"
* ingredient[0].strength.numerator.value = 100
* ingredient[0].strength.numerator.unit = "IU"
* ingredient[0].strength.numerator.system = "http://unitsofmeasure.org"
* ingredient[0].strength.numerator.code = #"[iU]"
* ingredient[0].strength.denominator.value = 1
* ingredient[0].strength.denominator.unit = "mL"
* ingredient[0].strength.denominator.system = "http://unitsofmeasure.org"
* ingredient[0].strength.denominator.code = #mL
* batch.lotNumber = "INS-100-2025A"
* batch.expirationDate = 2027-03-31

