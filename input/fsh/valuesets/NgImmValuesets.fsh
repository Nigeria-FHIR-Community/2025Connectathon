//Patient Valuesets
ValueSet: NGGenderVS
Id: nigeria-gender
Title: "NG-eP Gender or Sex VS"
//Description: "The administrative gender of a person."
Description: "Subset of HL7 administrative-gender limited to 'male' and 'female'."
//* ^url = "http://nphcda.gov.ng/ig/fhir/ValueSet/ng-gender"
* include codes from system NGGenderCS 

ValueSet: NGWardsVS
Id: nigeria-wards
Title: "NG-eP Wards VS"
Description: "The administrative Ward (within an LGA) where a person or a facility is."
* ^status = #active
//* ^url = "http://nphcda.gov.ng/ig/fhir/ValueSet/ng-wards"
* include codes from system NGWardsCS

ValueSet: NGLGAsVS
Id: nigeria-lgas
Title: "NG-eP LGAs VS"
Description: "The administrative Local Government Areas where a person or a facility is."
* ^status = #active
//* ^url = "http://nphcda.gov.ng/ig/fhir/ValueSet/ng-lgas"
* include codes from system NGLGAsCS

ValueSet: NGStatesVS
Id: nigeria-states
Title: "NG-eP States VS"
Description: "The state where a person or a facility is."
* ^status = #active
//* ^url = "http://nphcda.gov.ng/ig/fhir/ValueSet/ng-states"
* include codes from system NGStatesCS

ValueSet: NGLanguagesVS
Id: nigeria-languages
Title: "NG-eP Languages VS"
Description: "The Patient's preferred language for communication."
* ^status = #active
//* ^url = "http://nphcda.gov.ng/ig/fhir/ValueSet/ng-languages"
* include codes from system NGLanguagesCS


ValueSet: NGRelationshipsVS
Id: nigeria-relationship
Title: "NG-eP Relationships VS"
Description: "list of persons related to a patient, but who is not a direct target of care."
* ^status = #active
//* ^url = "http://nphcda.gov.ng/ig/fhir/ValueSet/ng-relationship"
* include codes from system NGRelationshipsCS

ValueSet: NGFacilityTypeVS
Id: nigeria-facility-types
Title: "NG-eP HealthFacility Type VS"
Description: "Classification of Nigerian health facilities"
* ^status = #active
//* ^url = "http://nphcda.gov.ng/ig/fhir/ValueSet/ng-health-facility-types"
* include codes from system NGFacilityTypeCS


//Allergy Intolerance Valuesets
ValueSet: NGOrganizationOwnerVS
Id: nigeria-location-owner
Title: "NG-eP Location Owner"
Description: "The owner of an Immunization location"
* ^status = #active
//* ^url = "http://nphcda.gov.ng/ig/fhir/ValueSet/ng-clinical-status"
* include codes from system NGOrganizationOwnerCS
