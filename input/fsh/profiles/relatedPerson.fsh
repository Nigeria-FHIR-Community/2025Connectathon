Profile: NgRelatedPerson
Parent: RelatedPerson
Title: "NG RelatedPerson"
Id: related-person
Description: "Sibling or parent of the sick person."

* patient 1..1 MS
* patient only Reference(NgPatient)
* patient ^short = "The client this person is related to"
* name 1..* MS
* name.given 1..* 
* name.given ^short = "The first name and other names of Client's related person"
* name.family 0..1
* name.family ^short = "The surname of Client's related person"
* birthDate 0..1 MS
* gender from NGGenderVS (required)
* gender ^short = "The sex of the Immunization client's related person"
* relationship.text from NGSiblingRelationshipsVS (extensible)
* relationship.text ^short = "The relationship of the sibling with the Client e.g. brother| sister"

// Hide extra items
* name.use 0..0 
* implicitRules 0..0
* modifierExtension 0..0
* active 0..0


// EXAMPLE

// ==============================================
// 1) Brother of NgPatient-003
// ==============================================
Instance: NgRelatedPerson-001
InstanceOf: NgRelatedPerson
Usage: #example
Title: "Example Ng RelatedPerson (Brother)"
Description: "Older brother of NgPatient-003."
* patient = Reference(NgPatient/NgPatient-003)
* name[0].given[0] = "Ibrahim"
* name[0].family = "Abdullahi"
* gender = #male
* birthDate = 2015-07-12
* relationship[0].coding[0].system = "https://www.dhin-hie.org/ig/CodeSystem/nigeria-relationship"
* relationship[0].coding[0].code = #BROTHER
* relationship[0].coding[0].display = "Brother"
* relationship[0].text = "Brother"


// ==============================================
// 2) Sister of NgPatient-003
// ==============================================
Instance: NgRelatedPerson-002
InstanceOf: NgRelatedPerson
Usage: #example
Title: "Example Ng RelatedPerson (Sister)"
Description: "Younger sister of NgPatient-003."
* patient = Reference(NgPatient/NgPatient-003)
* name[0].given[0] = "Maryam"
* name[0].family = "Abdullahi"
* gender = #female
* birthDate = 2018-03-02
* relationship[0].coding[0].system = "https://www.dhin-hie.org/ig/CodeSystem/nigeria-relationship"
* relationship[0].coding[0].code = #SISTER
* relationship[0].coding[0].display = "Sister"
* relationship[0].text = "Sister"


// ==============================================
// 3) Brother of NgPatient-001
// ==============================================
Instance: NgRelatedPerson-003
InstanceOf: NgRelatedPerson
Usage: #example
Title: "Example Ng RelatedPerson (Brother)"
Description: "Brother of NgPatient-001."
* patient = Reference(NgPatient/NgPatient-001)
* name[0].given[0] = "Chinedu"
* name[0].family = "Okafor"
* gender = #male
* birthDate = 1990-01-20
* relationship[0].coding[0].system = "https://www.dhin-hie.org/ig/CodeSystem/nigeria-relationship"
* relationship[0].coding[0].code = #BROTHER
* relationship[0].coding[0].display = "Brother"
* relationship[0].text = "Brother"
