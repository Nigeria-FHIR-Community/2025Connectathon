
ValueSet: NGGenderVS
Id: ng-gender-vs
Title: "NG Gender or Sex VS"
Description: "A subset of the administrative gender codes including only 'male' and 'female'"
* ^status = #active
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/ng-gender-vs"
* ^experimental = false
* include codes from system http://hl7.org/fhir/administrative-gender where code = "male"
* include codes from system http://hl7.org/fhir/administrative-gender where code = "female"


ValueSet: NGWardsVS
Id: nigeria-wards
Title: "NG Wards VS"
Description: "The administrative Ward (within an LGA) where a person or a facility is."
* ^status = #active
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/nigeria-wards"
* ^experimental = false
* include codes from system NGWardsCS

ValueSet: NGLGAsVS
Id: nigeria-lgas
Title: "NG LGAs VS"
Description: "The administrative Local Government Areas where a person or a facility is."
* ^status = #active
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/nigeria-lgas"
* ^experimental = false
* include codes from system NGLGAsCS

ValueSet: NGStatesVS
Id: nigeria-states
Title: "NG States VS"
Description: "The state where a person or a facility is."
* ^status = #active
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/nigeria-states"
* ^experimental = false
* include codes from system NGStatesCS



ValueSet: NGRelationshipsVS
Id: nigeria-relationship
Title: "NG Relationships VS"
Description: "list of persons related to a patient, but who is not a direct target of care."
* ^status = #active
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/nigeria-relationship"
* ^experimental = false
* include codes from system NGRelationshipsCS


ValueSet: NGSiblingRelationshipsVS
Id: nigeria-sibling-relationship
Title: "NG Sibling Relationships VS"
Description: "A sub list from relationship list with only two options brother and sister."
* ^status = #active
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/nigeria-sibling-relationship"
* ^experimental = false
* include codes from system NGRelationshipsCS where code = "BROTHER"
* include codes from system NGRelationshipsCS where code = "SISTER"



ValueSet: NGHivStatusVS
Id: nigeria-hiv-status
Title: "NG Client HIV Status VS"
Description: "Client HIV Status"
* ^status = #active
* ^experimental = false
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/nigeria-hiv-status"
* include codes from system NGHivStatusCS

//Pregnancy Status ValueSet
ValueSet: NGPregnancyStatusVS
Id: nigeria-pregnancy-status
Title: "NG Clinical Status VS"
Description: "The outcome of the reaction"
* ^status = #active
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/nigeria-pregnancy-status"
* ^experimental = false
* include codes from system NGPregnancyStatusCS



// //Related Person Valueset
ValueSet: NGSiblingHealthStatusVS
Id: nigeria-sibling-health-status
Title: "NG Sibling Health Status VS"
Description: "This CodeSystem defines the health of the client's sibling"
* ^status = #active
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/nigeria-sibling-health-status"
* ^experimental = false
* include codes from system NGSiblingHealthStatusCS



//Identifier VS

// ValueSet: NGIdentifierVS
// Id: patient-identifier-vs
// Title: "NG Client Identifier VS"
// Description: "This ValueSet defines list of options for uniquely Identifting a Client"
// * ^status = #active
// * ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/patient-identifier-vs"
// * ^experimental = false
// * include codes from system NGPatientIdentifierTypeCS


//Immunization Valuesets
ValueSet: NGSessionTypeVS
Id: nigeria-session-type 
Title: "NG Session Type VS"
Description: "Type of session for immunization. Could be in a fixed facility, outreach or mobile."
* ^status = #active
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/nigeria-session-type"
* ^experimental = false
* include codes from system NGSessionTypeCS

ValueSet: NGContraindicationVS
Id: nigeria-vaccine-contraindication
Title: "NG Vaccine Contraindication VS"
Description: "A set of standardized codes used to represent clinical conditions, diagnoses, or circumstances that serve as contraindications to the administration of one or more vaccines."
* ^status = #active
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/nigeria-vaccine-contraindication"
* ^experimental = false
* include codes from system NGImmContraindicationCS


//Location & Organisation VS

ValueSet: NGFacilityTypeVS
Id: nigeria-facility-types
Title: "NG HealthFacility Type VS"
Description: "Classification of Nigerian health facilities"
* ^status = #active
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/nigeria-facility-types"
* ^experimental = false
* include codes from system NGFacilityTypeCS


ValueSet: NGOrganizationOwnerVS
Id: nigeria-location-owner
Title: "NG Location Owner"
Description: "The owner of an Health Facility location"
* ^status = #active
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/nigeria-location-owner"
* ^experimental = false
* include codes from system NGOrganizationOwnerCS

// //Allergy Intolerance Valuesets
ValueSet: NGClinicalStatusVS
Id: nigeria-clinical-status
Title: "NG Clinical Status VS"
Description: "The outcome of the reaction"
* ^status = #active
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/nigeria-clinical-status"
* ^experimental = false
* include codes from system NGClinicalStatusCS



//. Facility Registry
ValueSet: NGFacilityIdentifierVS
Id: ng-facility-identifier-vs
Title: "NG Clinical Status VS"
Description: "The outcome of the reaction"
* ^status = #active
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/ng-facility-identifier-vs"
* ^experimental = false
* include codes from system NGFacilityIdentifierCS


// Local-only ValueSet
ValueSet: NGVaccineLocalVS
Id: ng-vaccine-local-vs
Title: "NG Vaccine Local ValueSet"
Description: "All local vaccine codes (DE1–DE29)."
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/ng-vaccine-local-vs"
* ^experimental = false
* ^status = #active
* include codes from system NGVaccineLocalCS



// ICD11 ValueSet
ValueSet: NGVaccineICDVS
Id: ng-vaccine-icd-vs
Title: "NG Vaccine ICD ValueSet"
Description: "All ICD11 vaccine codes (DE1–DE29)."
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/ng-vaccine-icd-vs"
* ^experimental = false
* ^status = #active
* include codes from system NGVaccineLibraryICD11CS


// SNOMED ValueSet
ValueSet: NGVaccineSCTVS
Id: ng-vaccine-sct-vs
Title: "NG Vaccine SNOMED ValueSet"
Description: "All SNOMED vaccine codes (DE1–DE29)."
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/ng-vaccine-sct-vs"
* ^experimental = false
* ^status = #active
* include codes from system NGVaccineLibrarySNOMEDCS



ValueSet: NgCarePlanCategoryVS
Id: ng-careplan-category-vs
Title: "NG CarePlan Category VS"
Description: "ValueSet for CarePlan.category (demo)."
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/ng-careplan-category-vs"
* ^experimental = false
* ^status = #active
* include codes from system NgCarePlanCategoryCS


ValueSet: NgCarePlanActivityVS
Id: ng-careplan-activity-vs
Title: "NG CarePlan Activity VS"
Description: "ValueSet for CarePlan.activity.detail.code (demo)."
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/ng-careplan-activity-vs"
* ^experimental = false
* ^status = #active
* include codes from system NgCarePlanActivityCS

/* ValueSet: NgDeviceMetricCategoryVS
Id: ng-device-metric-category-vs
Title: "NG DeviceMetric Category VS"
Description: "ValueSet for DeviceMetric.category."
* ^status = #active
* ^version = "0.1.0"
* ^experimental = false
// Prefer the official THO CS; include local CS for flexibility
* include codes from system http://terminology.hl7.org/CodeSystem/metric-category
* include codes from system NgDeviceMetricCategoryCS */


ValueSet: NGDeviceIdentifierVS
Id: nigeria-device-identifier-vs
Title: "NG Electromechanical Medical Device Identifier VS"
Description: "ValueSet selecting the 50 hypothetical electromechanical medical device identifiers (leaf concepts only) from NGDeviceIdentifierCS. Excludes category/group nodes."
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/nigeria-device-identifier-vs"
* ^status = #active
* ^version = "1.0.0"
* ^publisher = "FMoHSW / DHIN 2025 Connectathon"
* ^experimental = false
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
* include codes from system NGDeviceIdentifierCS


ValueSet: NgProvenanceActivityVS
Id: ng-provenance-activity-vs
Title: "NG Provenance Activity Codes"
Description: "ValueSet including local provenance activity codes (anonymize, de-identify, mask, label, pseudonymize, create, delete, append, nullify, legally authenticated) for DHIN 2025 Connectathon."
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/ng-provenance-activity-vs"
* ^status = #active
* ^version = "0.1.0"
* ^experimental = false
* ^publisher = "FMoHSW / DHIN 2025 Connectathon"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
//Pull all codes from the CodeSystem
* include codes from system NgProvenanceActivityCS



ValueSet: NgBundleIdentifierVS
Id: ng-bundle-identifier-vs
Title: "NG Bundle Identifier Codes"
Description: "ValueSet including all local bundle identifier codes for DHIN 2025 Connectathon use cases (immunization, MNCH referral, claims, device data, etc.)."
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/ng-bundle-identifier-vs"
* ^status = #active
* ^version = "0.1.0"
* ^experimental = false
* ^publisher = "FMoHSW / DHIN 2025 Connectathon"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
// Pull all codes from the CodeSystem
* include codes from  system NgBundleIdentifierCS






// ===========================================================
// 1) All medications (full CodeSystem passthrough)
// ===========================================================
ValueSet: NgATCAllMedicationsVS
Id: ng-atc-all-medications-vs
Title: "NG Local ATC — All Medications"
Description: "All local ATC-style medication codes used across MNCH referral, claims, prescription, and immunization."
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/ng-atc-all-medications-vs"
* ^status = #active
* ^version = "0.1.0"
* ^experimental = false
* ^publisher = "FMoHSW / DHIN 2025 Connectathon"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
* include codes from system NgATCLocalMedicationCS




ValueSet: NgProviderOrgTypeVS
Id: ng-provider-org-type-vs
Title: "NG Provider Organization Types"
Description: "Organization types for healthcare providers"
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/ng-provider-org-type-vs"
* ^experimental = false
* ^status = #active
* include codes from system http://terminology.hl7.org/CodeSystem/organization-type where code = "prov"


ValueSet: NgInsurerOrgTypeVS
Id: ng-insurer-org-type-vs
Title: "NG Insurer Organization Types"
Description: "Organization types for insurance payers/HMOs"
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/ng-insurer-org-type-vs"
* ^experimental = false
* ^status = #active
* include codes from system http://terminology.hl7.org/CodeSystem/organization-type where code = "ins"


ValueSet: NgPharmacyOrganizationVS
Id: ng-pharmacy-org-type-vs
Title: "NG Pharmacy Organization Types"
Description: "Organization types for Pharmacies"
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/ng-pharmacy-org-type-vs"
* ^experimental = false
* ^status = #active
* include codes from system http://terminology.hl7.org/CodeSystem/organization-type where code = "cg"









// ValueSet: NgOrganizationTypeVS
// Id: ng-org-type-vs
// Title: "NG Organization Type"
// Description: "A general organization type grouping"
// * ^status = #active
// * ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/ng-org-type-vs"
// * ^experimental = false
// * include codes from system http://terminology.hl7.org/CodeSystem/organization-type where code = "prov"
// * include codes from system http://terminology.hl7.org/CodeSystem/organization-type where code = "ins"
// * include codes from system http://terminology.hl7.org/CodeSystem/organization-type where code = "pay"
// * include codes from system http://terminology.hl7.org/CodeSystem/organization-type where code = "govt"
// * include codes from system http://terminology.hl7.org/CodeSystem/organization-type where code = "crs"
// * include codes from system http://terminology.hl7.org/CodeSystem/organization-type where code = "edu"













/* // ===========================================================
// 2) Immunization (EPI) — Vaccines (J07-*)
// ===========================================================
ValueSet: NgATCVaccinesVS
Id: ng-atc-vaccines-vs
Title: "NG Local ATC — Vaccines (EPI)"
Description: "Subset of local ATC codes for routine immunization vaccines (EPI)."
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/ng-atc-vaccines-vs"
* ^status = #active
* ^version = "0.1.0"
* ^experimental = false
* ^publisher = "FMoHSW / DHIN 2025 Connectathon"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
* compose.include.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-atc-medication-cs"
* compose.include.filter.property = "code"
* compose.include.filter.op = #regex
* compose.include.filter.value = "^J07-"

// ===========================================================
// 3) Core MNCH Rx/Dispense set (common outpatient therapeutics)
//    J01- (antibiotics), A07- (diarrhea), N02- (analgesic), R03- (airways),
//    P01-/P02- (malaria/deworming), G03- (FP), A10- (diabetes in pregnancy)
// ===========================================================
ValueSet: NgATCMNCHCoreRxVS
Id: ng-atc-mnch-core-rx-vs
Title: "NG Local ATC — MNCH Core Prescription/Dispense"
Description: "Common MNCH outpatient therapeutics for prescription/dispense and claims."
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/ng-atc-mnch-core-rx-vs"
* ^status = #active
* ^version = "0.1.0"
* ^experimental = false
* ^publisher = "FMoHSW / DHIN 2025 Connectathon"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
* compose.include.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-atc-medication-cs"
* compose.include.filter[0].property = "code"
* compose.include.filter[0].op = #regex
* compose.include.filter[0].value = "^(J01-|A07-|N02-|R03-|P01-|P02-|G03-|A10-)"

// ===========================================================
// 4) Antenatal supplements & antianemics (A11-, A12-, B03-)
// ===========================================================
ValueSet: NgATCAntenatalSupplementsVS
Id: ng-atc-antenatal-supplements-vs
Title: "NG Local ATC — Antenatal Supplements & Antianemics"
Description: "Antenatal vitamins, iron/folate, calcium, and antianemics for MNCH referral/prescription."
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/ng-atc-antenatal-supplements-vs"
* ^status = #active
* ^version = "0.1.0"
* ^experimental = false
* ^publisher = "FMoHSW / DHIN 2025 Connectathon"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
* compose.include.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-atc-medication-cs"
* compose.include.filter.property = "code"
* compose.include.filter.op = #regex
* compose.include.filter.value = "^(A11-|A12-|B03-)"

// ===========================================================
// 5) Claims bundles / kits (combined line items)
//    Match local bundle codes ending with -KIT or -COMB
// ===========================================================
ValueSet: NgATCClaimsBundlesVS
Id: ng-atc-claims-bundles-vs
Title: "NG Local ATC — Claims Bundles/Kits"
Description: "Local bundle/kit concepts for claims (e.g., ORS+Zinc, Ampicillin+Gentamicin regimen)."
* ^url = "https://sandbox.dhin-hie.org/ig/ValueSet/ng-atc-claims-bundles-vs"
* ^status = #active
* ^version = "0.1.0"
* ^experimental = false
* ^publisher = "FMoHSW / DHIN 2025 Connectathon"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
* compose.include.system = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-atc-medication-cs"
* compose.include.filter.property = "code"
* compose.include.filter.op = #regex
* compose.include.filter.value = "(-KIT$|-COMB$)"

 */