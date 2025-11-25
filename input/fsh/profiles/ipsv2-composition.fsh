// ============================================================================
// PROFILE: NG IPS Composition (based on IPS v2 Composition)
// ============================================================================
Profile: NgIPSComposition
Parent: Composition
Id: ng-ips-composition
Title: "NG IPS Composition"
Description: """
International Patient Summary (IPS) Composition adapted for Nigeria/DHIN 2025 Connectathon.
Conforms to IPS v2 Composition and narrows key references to local NG profiles where available.
Includes common IPS sections: Problems, Allergies, Medications, Immunizations, Procedures, Results, Devices, and Plan of Care. 
"""
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-ips-composition"
* ^version = "1.0.0"
* ^status = #active
* ^publisher = "DHIN 2025 Connectathon"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
* ^experimental = false

// ---- Helpful narrative (kept short to avoid QA noise)
* ^text.status = #generated
* ^text.div = """
<div xmlns="http://www.w3.org/1999/xhtml">
  <h2>NG IPS Composition</h2>
  <p>IPS v2-compliant patient summary for cross-facility sharing in Nigeria (DHIN 2025 Connectathon).
  Sections follow IPS structure and reference NG profiles for Patient, Conditions, Meds, Immunizations, etc.</p>
</div>
"""

// ---- Core IPS elements
* status 1..1 MS
* status = #final (exactly)
* type 1..1 MS
* type.coding 1..1
* type.coding.system = "http://loinc.org"
* type.coding.code = #60591-5   // "Patient summary Document" (IPS)
* title 1..1 MS
* date 1..1 MS

// ---- Key references bound to local profiles (replace with your canonical NG profiles as desired)
* subject 1..1 MS
* subject only Reference(NgPatient)        // local patient profile
* author 1..* MS
* author only Reference(NgPractitioner or NgOrganization)

// ---- Section slicing by code (LOINC section codes commonly used in IPS)
* section 0..* MS
* section ^slicing.discriminator[0].type = #value
* section ^slicing.discriminator[0].path = "code"
* section ^slicing.rules = #open

* section contains
    problems 0..1 MS and
    allergies 0..1 MS and
    medications 0..1 MS and
    immunizations 0..1 MS and
    procedures 0..1 MS and
    results 0..1 MS and
    devices 0..1 MS and
    planOfCare 0..1 MS

// ---- Section codes (LOINC)
* section[problems].code = http://loinc.org#11450-4 "Problem list - Reported"
* section[allergies].code = http://loinc.org#48765-2 "Allergies and adverse reactions Document"
* section[medications].code = http://loinc.org#10160-0 "Hx of Medication use"
* section[immunizations].code = http://loinc.org#11369-6 "History of Immunization note"
* section[procedures].code = http://loinc.org#47519-4 "History of Procedures Document"
* section[results].code = http://loinc.org#30954-2 "Relevant diagnostic tests/laboratory data note"
* section[devices].code = http://loinc.org#46264-8 "History of medical device use"
* section[planOfCare].code = http://loinc.org#18776-5 "Plan of care note"

// ---- Mild guidance on entries (do not hard-require to keep QA low)
* section[problems].entry 0..*
* section[allergies].entry 0..*
* section[medications].entry 0..*
* section[immunizations].entry 0..*
* section[procedures].entry 0..*
* section[results].entry 0..*
* section[devices].entry 0..*
* section[planOfCare].entry 0..*







// ============================================================================
// EXAMPLE: NG IPS Composition 
// ============================================================================
Instance: NgIPSComposition-001
InstanceOf: NgIPSComposition
Title: "IPS — Nigeria Example (Connectathon)"
Usage: #example

* status = #final
* type.coding.system = "http://loinc.org"
* type.coding.code = #60591-5
* title = "International Patient Summary (Nigeria)"
* date = "2025-10-25T10:00:00+01:00"

// Subject & author
* subject = Reference(NgPatient-001)            // assume this exists
* author[0] = Reference(NgPractitioner-001)         // prescriber/author
* author[+] = Reference(NgOrganization-001)         // facility

// Sections (use entries if available; otherwise text/emptyReason is acceptable)
* section[problems].title = "Problems"
* section[problems].text.status = #generated
* section[problems].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Hypertension; Gestational diabetes (history)</div>"
* section[problems].entry[0] = Reference(NgCondition-001)

* section[allergies].title = "Allergies"
* section[allergies].text.status = #generated
* section[allergies].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">No known drug allergies</div>"
* section[allergies].emptyReason = http://terminology.hl7.org/CodeSystem/list-empty-reason#nilknown

* section[medications].title = "Medications"
* section[medications].text.status = #generated
* section[medications].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Amlodipine 5 mg OD; Metformin 500 mg BD</div>"
* section[medications].entry[0] = Reference(NgMedicationRequest-001)
* section[medications].entry[+] = Reference(NgMedicationDispense-001)

* section[immunizations].title = "Immunizations"
* section[immunizations].text.status = #generated
* section[immunizations].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Childhood schedule complete; COVID-19 series complete</div>"
* section[immunizations].entry[0] = Reference(NgImmunization-001)
* section[immunizations].entry[+] = Reference(NgImmunization-002)

* section[procedures].title = "Procedures"
* section[procedures].text.status = #generated
* section[procedures].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">C-section in 2022</div>"
* section[procedures].entry[0] = Reference(NgProcedure-001)

* section[results].title = "Results"
* section[results].text.status = #generated
* section[results].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Fake data 6.8% (2025-09-30); Creatinine 0.9 mg/dL</div>"
* section[results].entry[0] = Reference(NgObservation-001)


* section[devices].title = "Devices"
* section[devices].text.status = #generated
* section[devices].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Home BP monitor in use</div>"
* section[devices].entry[0] = Reference(NgDevice-001)

* section[planOfCare].title = "Plan of Care"
* section[planOfCare].text.status = #generated
* section[planOfCare].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Lifestyle modification; medication review in 8 weeks</div>"
* section[planOfCare].entry[0] = Reference(NgCarePlan-001)
