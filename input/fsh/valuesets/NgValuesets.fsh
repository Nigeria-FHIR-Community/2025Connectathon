
ValueSet: NGGenderVS
Id: ng-gender-vs
Title: "NG Gender or Sex VS"
Description: "A subset of the administrative gender codes including only 'male' and 'female'"
* ^status = #active
* ^url = "https://www.dhin-hie.org/ig/ValueSet/ng-gender-vs"
* ^experimental = true
* include codes from system http://hl7.org/fhir/administrative-gender where code = "male"
* include codes from system http://hl7.org/fhir/administrative-gender where code = "female"


ValueSet: NGWardsVS
Id: nigeria-wards
Title: "NG Wards VS"
Description: "The administrative Ward (within an LGA) where a person or a facility is."
* ^status = #active
* ^url = "https://www.dhin-hie.org/ig/ValueSet/nigeria-wards"
* ^experimental = false
* include codes from system NGWardsCS

ValueSet: NGLGAsVS
Id: nigeria-lgas
Title: "NG LGAs VS"
Description: "The administrative Local Government Areas where a person or a facility is."
* ^status = #active
* ^url = "https://www.dhin-hie.org/ig/ValueSet/nigeria-lgas"
* ^experimental = false
* include codes from system NGLGAsCS

ValueSet: NGStatesVS
Id: nigeria-states
Title: "NG States VS"
Description: "The state where a person or a facility is."
* ^status = #active
* ^url = "https://www.dhin-hie.org/ig/ValueSet/nigeria-states"
* ^experimental = false
* include codes from system NGStatesCS



ValueSet: NGRelationshipsVS
Id: nigeria-relationship
Title: "NG Relationships VS"
Description: "list of persons related to a patient, but who is not a direct target of care."
* ^status = #active
* ^url = "https://www.dhin-hie.org/ig/ValueSet/nigeria-relationship"
* ^experimental = false
* include codes from system NGRelationshipsCS


ValueSet: NGSiblingRelationshipsVS
Id: nigeria-sibling-relationship
Title: "NG Sibling Relationships VS"
Description: "A sub list from relationship list with only two options brother and sister."
* ^status = #active
* ^url = "https://www.dhin-hie.org/ig/ValueSet/nigeria-sibling-relationship"
* ^experimental = false
* include codes from system NGRelationshipsCS where code = "BROTHER"
* include codes from system NGRelationshipsCS where code = "SISTER"



ValueSet: NGHivStatusVS
Id: nigeria-hiv-status
Title: "NG Client HIV Status VS"
Description: "Client HIV Status"
* ^status = #active
* ^url = "https://www.dhin-hie.org/ig/ValueSet/nigeria-hiv-status"
* include codes from system NGHivStatusCS

//Pregnancy Status ValueSet
ValueSet: NGPregnancyStatusVS
Id: nigeria-pregnancy-status
Title: "NG Clinical Status VS"
Description: "The outcome of the reaction"
* ^status = #active
* ^url = "https://www.dhin-hie.org/ig/ValueSet/nigeria-pregnancy-status"
* ^experimental = false
* include codes from system NGPregnancyStatusCS



// //Related Person Valueset
ValueSet: NGSiblingHealthStatusVS
Id: nigeria-sibling-health-status
Title: "NG Sibling Health Status VS"
Description: "This CodeSystem defines the health of the client's sibling"
* ^status = #active
* ^url = "https://www.dhin-hie.org/ig/ValueSet/nigeria-sibling-health-status"
* ^experimental = false
* include codes from system NGSiblingHealthStatusCS



//Identifier VS

ValueSet: NGIdentifierVS
Id: patient-identifier-vs
Title: "NG Client Identifier VS"
Description: "This ValueSet defines list of options for uniquely Identifting a Client"
* ^status = #active
* ^url = "https://www.dhin-hie.org/ig/ValueSet/patient-identifier-vs"
* ^experimental = false
* include codes from system NGIdentifierCS


//Immunization Valuesets
ValueSet: NGSessionTypeVS
Id: nigeria-session-type 
Title: "NG Session Type VS"
Description: "Type of session for immunization. Could be in a fixed facility, outreach or mobile."
* ^status = #active
* ^url = "https://www.dhin-hie.org/ig/ValueSet/nigeria-session-type"
* ^experimental = false
* include codes from system NGSessionTypeCS

ValueSet: NGContraindicationVS
Id: nigeria-vaccine-contraindication
Title: "NG Vaccine Contraindication VS"
Description: "A set of standardized codes used to represent clinical conditions, diagnoses, or circumstances that serve as contraindications to the administration of one or more vaccines."
* ^status = #active
* ^url = "https://www.dhin-hie.org/ig/ValueSet/nigeria-vaccine-contraindication"
* ^experimental = false
* include codes from system NGImmContraindicationCS


//Location & Organisation VS

ValueSet: NGFacilityTypeVS
Id: nigeria-facility-types
Title: "NG HealthFacility Type VS"
Description: "Classification of Nigerian health facilities"
* ^status = #active
* ^url = "https://www.dhin-hie.org/ig/ValueSet/nigeria-facility-types"
* ^experimental = false
* include codes from system NGFacilityTypeCS

ValueSet: NGOrganizationOwnerVS
Id: nigeria-location-owner
Title: "NG Location Owner"
Description: "The owner of an Health Facility location"
* ^status = #active
* ^url = "https://www.dhin-hie.org/ig/ValueSet/nigeria-location-owner"
* ^experimental = false
* include codes from system NGOrganizationOwnerCS

// //Allergy Intolerance Valuesets
ValueSet: NGClinicalStatusVS
Id: nigeria-clinical-status
Title: "NG Clinical Status VS"
Description: "The outcome of the reaction"
* ^status = #active
* ^url = "https://www.dhin-hie.org/ig/ValueSet/nigeria-clinical-status"
* ^experimental = false
* include codes from system NGClinicalStatusCS



//. Facility Registry
ValueSet: NGFacilityIdentifierVS
Id: ng-facility-identifier-cs
Title: "NG Clinical Status VS"
Description: "The outcome of the reaction"
* ^status = #active
* ^url = "https://www.dhin-hie.org/ig/ValueSet/ng-facility-identifier-cs"
* ^experimental = false
* include codes from system NGFacilityIdentifierCS


// Local-only ValueSet
ValueSet: NGVaccineLocalVS
Id: ng-vaccine-local-vs
Title: "NG Vaccine Local ValueSet"
Description: "All local vaccine codes (DE1–DE29)."
* ^url = "https://www.dhin-hie.org/ig/ValueSet/ng-vaccine-local-vs"
* ^experimental = false
* ^status = #active
* include codes from system NGVaccineLocalCS



// ICD11 ValueSet
ValueSet: NGVaccineICDVS
Id: ng-vaccine-icd11-vs
Title: "NG Vaccine ICD ValueSet"
Description: "All ICD11 vaccine codes (DE1–DE29)."
* ^url = "https://www.dhin-hie.org/ig/ValueSet/ng-vaccine-icd11-vs"
* ^experimental = false
* ^status = #active
* include codes from system $icd11


// SNOMED ValueSet
ValueSet: NGVaccineSCTVS
Id: ng-vaccine-sct-vs
Title: "NG Vaccine SNOMED ValueSet"
Description: "All SNOMED vaccine codes (DE1–DE29)."
* ^url = "https://www.dhin-hie.org/ig/ValueSet/ng-vaccine-sct-vs"
* ^experimental = false
* ^status = #active
* include codes from system $sct



ValueSet: NgCarePlanCategoryVS
Id: ng-careplan-category-vs
Title: "NG CarePlan Category VS"
Description: "ValueSet for CarePlan.category (demo)."
* ^url = "https://www.dhin-hie.org/ig/ValueSet/ng-careplan-category-vs"
* ^experimental = false
* ^status = #active
* include codes from system NgCarePlanCategoryCS


ValueSet: NgCarePlanActivityVS
Id: ng-careplan-activity-vs
Title: "NG CarePlan Activity VS"
Description: "ValueSet for CarePlan.activity.detail.code (demo)."
* ^url = "https://www.dhin-hie.org/ig/ValueSet/ng-careplan-activity-vs"
* ^experimental = false
* ^status = #active
* include codes from system NgCarePlanActivityCS

ValueSet: NgDeviceMetricCategoryVS
Id: ng-device-metric-category-vs
Title: "NG DeviceMetric Category VS"
Description: "ValueSet for DeviceMetric.category."
* ^status = #active
* ^version = "0.1.0"
// Prefer the official THO CS; include local CS for flexibility
* include codes from system http://terminology.hl7.org/CodeSystem/metric-category
* include codes from system NgDeviceMetricCategoryCS
