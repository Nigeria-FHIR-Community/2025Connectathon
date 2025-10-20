Profile: NgPractitionerRole
Parent: PractitionerRole
Id: ng-practitionerrole
Title: "NG PractitionerRole"
Description: """
Defines the role(s) of a Nigerian healthcare practitioner context.
Links a Practitioner to an Organization, specifies their role.
"""

* practitioner 1..1 MS
* practitioner only Reference(NgPractitioner)
* practitioner ^short = "Practitioner linked to this role"
* practitioner ^definition = "Reference to the Nigerian healthcare practitioner holding this role."

* organization 1..1 MS
* organization only Reference(NgOrganization)
* organization ^short = "Organization the practitioner is associated with"
* organization ^definition = "The health facility, agency, or organization in which the practitioner works."

* code 1..* MS
* code ^short = "Roles of the practitioner"
* code ^definition = "Describes the functional roles (e.g., Routine Immunization Officer, AEFI Surveillance Officer)."
* code.text 1..1
* code.text ^short = "Plain text description of role"
* code.text ^definition = "The common-language label for the role."


* period 0..1 MS
* period ^short = "Period during which the practitioner is performing this role"
* period ^definition = "The time interval this practitioner has or had this role."

* location 0..* MS
* location only Reference(NgLocation)
* location ^short = "Locations where the practitioner role is performed"
* location ^definition = "Physical or service delivery locations where this role is carried out."

* healthcareService 0..* MS
* healthcareService ^short = "Services provided"
* healthcareService ^definition = "Types of related health services delivered in this role."


// Hide data elements not needed
* availableTime 0..0
* notAvailable 0..0

// EXAMPLES 
// ==============================================
// NgPractitionerRole-001 — MNCH Referral
// ==============================================
Instance: NgPractitionerRole-001
InstanceOf: NgPractitionerRole
Usage: #example
Title: "Example Ng PractitionerRole (MNCH Referral)"
Description: "Obstetrician role for ANC referrals."
* practitioner = Reference(NgPractitioner-001)
* organization = Reference(NgOrganization-001)
* code[0].text = "Obstetrician / ANC Clinician"
* period.start = 2024-01-01

// ==============================================
// NgPractitionerRole-002 — ePharmacy & Claims
// ==============================================
Instance: NgPractitionerRole-002
InstanceOf: NgPractitionerRole
Usage: #example
Title: "Example Ng PractitionerRole (ePharmacy & Claims)"
Description: "Pharmacist dispensing medications and processing claims."
* practitioner = Reference(NgPractitioner-002)
* organization = Reference(NgOrganization-001)
* code[0].text = "Pharmacist"
* code[1].text = "Claims Submission Officer"
* period.start = 2022-06-01

// ==============================================
// NgPractitionerRole-003 — Medical Devices Comms
// ==============================================
Instance: NgPractitionerRole-003
InstanceOf: NgPractitionerRole
Usage: #example
Title: "Example Ng PractitionerRole (Medical Devices)"
Description: "CHEW operating connected vitals devices."
* practitioner = Reference(NgPractitioner-003)
* organization = Reference(NgOrganization-001)
* code[0].text = "Device Operator (CHEW)"
* code[1].text = "Community Health Extension Worker"
* period.start = 2023-03-15
