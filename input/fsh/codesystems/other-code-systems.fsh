

CodeSystem: NGFacilityTypeCS
Id: nigeria-facility-type
Title: "NG-eP Facility Type CS"
Description: "A standardized classification system used to describe the type or level of health facility within a healthcare delivery system, based on the scope of services provided, staffing, infrastructure, and administrative role."
//* ^url = "http://nphcda.gov.ng/ig/fhir/CodeSystem/ng-facility-typeCS"
* ^status = #active
* ^hierarchyMeaning = #is-a
* ^publisher = "NPHCDA"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
// The CodeSystem for Grouping different Facility types
* #clinic	"Clinic" "The Health facility is a primary health facility"
* #hospital	"Hospital" "The Health facility is a Secondary health facilities and General Hospitals"
* #health-post	"Health Post" "The Health facility is a primary health facility in category of dispensories"
* #chc	"Comprehensive Health Centers" "The Health facility is a comprehensive primary health center owned by the government"
* #tertiary	"Tertiary facility" "These are Higher level facilities and referal centers)"

CodeSystem: NGGenderCS
Id: nigeria-gender
Title: "NG-eP Gender CS"
Description: "The administrative gender of a person."
//* ^url = "http://nphcda.gov.ng/ig/fhir/CodeSystem/ng-genderCS"
* ^status = #active
* ^hierarchyMeaning = #is-a
* ^publisher = "NPHCDA"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
// The CodeSystem for Gender/sex of a client
* #male "male" "Client is of the male gender"
* #female "female" "Client is of the female gender"