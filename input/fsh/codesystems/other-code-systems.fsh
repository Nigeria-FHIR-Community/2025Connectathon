
CodeSystem: NGRelationshipsCS
Id: nigeria-relationship
Title: "NG Relationships CS"
Description: "This CodeSystem defines list of persons related to a patient, but who is not a direct target of care"
* ^url = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-relationship"
* ^status = #active
* ^content = #complete
* ^caseSensitive = true
//* ^hierarchyMeaning = #is-a
* ^experimental = false
* ^publisher = "DHIN"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"

// The different relationships used in the IG

* #BROTHER	"Brother"
* #SISTER	"Sister"
* #SON	"Son"
* #DAUGHTER	"Daughter"
* #MOTHER	"Mother"
* #FATHER	"Father"
* #AUNT	"Aunt"
* #COUSIN	"Cousin"
* #GRDSON	"Grand Son"
* #GRDDAU "Grand Daughter"
* #INLAW "Inlaw"
* #NEPHEW "Nephew"
* #NIECE "Niece"
* #UNCLE "Uncle"
* #FRND "Friend"



CodeSystem: NGSiblingHealthStatusCS
Id: nigeria-sibling-health-status
Title: "NG Health Status CS"
Description: "This CodeSystem IMMZ.C.DE30 defines the health of the client's sibling"
* ^url = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-sibling-health-status"
* ^status = #active
* ^content = #complete
* ^caseSensitive = true
* ^experimental = false
//* ^hierarchyMeaning = #is-a
* ^publisher = "DHIN"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
// The CodeSystem for Sibling Health Status
* #ALIVE	"Alive" "Sibling referenced is still alive"
* #DEAD	"Dead" "Sibling referenced is dead"
* #WELL	"well" "Sibling reference is alive and well"
* #ILL "underlying disease" "Referenced Sibling has an underlying disease"




CodeSystem: NGFacilityTypeCS
Id: nigeria-facility-type
Title: "NG Facility Type CS"
Description: "A standardized classification system used to describe the type or level of health facility within a healthcare delivery system, based on the scope of services provided, staffing, infrastructure, and administrative role."
* ^url = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* ^status = #active
//* ^hierarchyMeaning = #is-a
* ^caseSensitive = true
* ^experimental = false
* ^publisher = "DHIN"
* ^content = #complete
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
// The CodeSystem for Grouping different Facility types
* #outreach "Outreach Post" "A temporary or mobile health service site established to deliver essential healthcare to underserved or remote populations."
* #phc-center-l1 "PHC Center Level 1" "A basic primary healthcare facility providing preventive and promotive services, often staffed by community health workers."
* #phc-center-l2 "PHC Center Level 2" "A primary healthcare facility with limited diagnostic and treatment services, typically staffed by nurses, CHEWs, or junior medical personnel."
* #phc-center-l3 "PHC Center Level 3" "An advanced primary healthcare facility offering comprehensive outpatient care, minor/light procedures, and referral support, often with a resident medical officer."
* #hospital "Secondary Hospital" "A referral facility providing specialized care, inpatient services, and emergency response, staffed by medical officers and specialists."
* #tertiary "Tertiary Facility" "A highly specialized hospital offering advanced diagnostic, therapeutic, and surgical care, often affiliated with teaching or research institutions."


CodeSystem: NGOrganizationOwnerCS
Id: nigeria-location-owner-cs
Title: "NG Location Owner CS"
Description: "This CodeSystem defines Immunization Location Owner."
* ^url = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-location-owner-cs"
* ^publisher = "NPHCDA"
* ^caseSensitive = false
* ^content = #complete
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
* ^experimental = false

// Location Owner types and their codes
* #public "Public Health Institution Location"
* #private "Private Health Institution Location"
* #faith-based "Faith-based Institution Locations such as churches, musques, and traditional homes"




CodeSystem: NGClinicalStatusCS
Id: nigeria-clinical-status 
Title: "NG Adverse Event CS"
Description: "A classification system that represents the current clinical status of an individual who experienced an Adverse Event Following Immunization (AEFI), based on medical observation, investigation, or follow-up assessment."
* ^url = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-clinical-status"
* ^status = #active
* ^content = #complete
* ^caseSensitive = false
* ^experimental = false
* #active "Active" "The clinical condition is currently present, ongoing, or requires active management or monitoring."
* #inactive "Inactive" "The clinical condition is no longer present but is not considered resolved; it may recur or requires no current treatment."
* #resolved "Resolved" "The clinical condition has completely resolved and is no longer impacting the patient's health or requiring further management."
* #recovered "Recovered" "The individual has recovered fully from the adverse event without any long-term effects or sequelae."
* #recovered-with-sequelae "Recovered with sequelae" "The individual has recovered from the adverse event but with lasting effects, complications, or disabilities."
* #death "Death" "The adverse event resulted in the death of the individual."


CodeSystem: NGSessionTypeCS
Id: nigeria-immunization-session-type
Title: "NG Immunization Session types CS"
Description: "Type of session for immunization Could be in a fixed facility, outreach or mobile."
* ^url = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-immunization-session-type"
* ^status = #active
//* ^hierarchyMeaning = #is-a
* ^caseSensitive = false
* ^publisher = "DHIN"
* ^experimental = false
* ^content = #complete
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
// The CodeSystem for Immunization session types
* #fixed	"Fixed session" "An immunization session conducted at a static health facility or designated fixed site where routine immunization services are regularly available."
* #outreach	"Outreach session" "An immunization session conducted outside of fixed sites, typically within a 5-10 km radius of a health facility, aimed at increasing access for underserved populations."
* #mobile	"Mobile session" "An immunization session delivered by a mobile team traveling to hard-to-reach or remote areas beyond the normal outreach distance, often using vehicles or other transport."


CodeSystem: NGImmContraindicationCS
Id: nigeria-immunization-contraindication
Title: "NG Vaccine contraindications CS"
Description: "A set of standardized codes used to represent clinical conditions, diagnoses, or circumstances that serve as contraindications to the administration of one or more vaccines."
* ^url = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-immunization-contraindication"
* ^status = #active
//* ^hierarchyMeaning = #is-a
* ^experimental = false
* ^caseSensitive = false
* ^content = #complete
* ^publisher = "DHIN"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
// The CodeSystem for Immunization Contraindications
* #immuno	"Immunocompromised" "The individual has a weakened immune system due to a medical condition (e.g., cancer, organ transplant, or immunosuppressive therapy), which contraindicates certain live vaccines."
* #severe-aefi	"severe AEFI" "The individual is currently experiencing a severe febrile or respiratory illness (REFI), which may necessitate deferral of immunization until recovery."
* #anaphylactic	"Anaphylactic reactions" "The individual has a documented history of a severe allergic (anaphylactic) reaction to a previous dose of a vaccine or any of its components, making re-administration contraindicated."
* #hiv "HIV positive" "The individual has symptomatic HIV infection, which may contraindicate live vaccines or require specific vaccine schedules based on immunological status."



CodeSystem: NGPregnancyStatusCS
Id: nigeria-pregnancy-status
Title: "NG Client Pregnancy Status CS"
Description: "This CodeSystem defines list of options for Pregnancy status of a Client"
* ^url = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-pregnancy-status"
* ^status = #active
* ^content = #complete
* ^caseSensitive = false
* ^experimental = false
//* ^hierarchyMeaning = #is-a
* ^publisher = "DHIN"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
// The CodeSystem for Pregnancy Status
* #pregnant	"Pregnant" "The Client's pregnancy status is positive"
* #notpregnant	"Not Pregnant" "The Client's pregnancy status is negative"
* #unknown	"Not known" "The Client does not know their Pregnancy status"






CodeSystem: NGIdentifierCS
Id: patient-identifier-cs
Title: "NG Client Identifier CS"
Description: "This CodeSystem defines list of options for uniquely Identifting a Client"
* ^url = "https://sandbox.dhin-hie.org/ig/CodeSystem/patient-identifier-cs"
* ^status = #active
* ^content = #complete
* ^caseSensitive = false
* ^experimental = false
* ^hierarchyMeaning = #is-a
* ^publisher = "DHIN"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"

* #MRN	"mrn" "Medical Record Number"
* #NIN	"nin" "National Identity Number"
* #MOBILE	"mobile" "Phone Number"
* #INSUR "insurance no" "Insurance or HMO number"
* #BIRTHCERT "birthcert" "Birth certificate number"
* #IMMNO "immunizationo" "Immunization Number"


CodeSystem: NGMDCNCS
Id: nigeria-mdcn
Title: "NG Practitioner Identifier CS"
Description: "This CodeSystem IMMZ.C.DE14 defines placeholder codes to manage physician identifiers in Nigeria."
* ^url = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-mdcn"
* ^status = #active
* ^content = #complete
* ^caseSensitive = true
* ^hierarchyMeaning = #grouped-by
* ^experimental = false
* ^publisher = "DHIN"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"

// Sample Codes for testing
* #MDCN-45231 "1"
* #MDCN-12345 "2"
* #MDCN-12346 "3"
* #MDCN-12347 "4"
* #CHEW-12346 "5"
* #CHEW-12347 "6"

//.... to be completed




CodeSystem: NGPCNCS
Id: nigeria-pcn
Title: "NG Practitioner Identifier CS"
Description: "This CodeSystem defines placeholder codes to manage Pharmcists' identifiers in Nigeria validated at  https://pcn.gov.ng/practice-number."
* ^url = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-pcn"
* ^status = #active
* ^content = #complete
* ^caseSensitive = true
* ^hierarchyMeaning = #grouped-by
* ^experimental = false
* ^publisher = "DHIN"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
// Sample Codes for testing
* #PCN-45231 "1"
* #PCN-12345 "2"








CodeSystem: NGFacilityIdentifierCS
Id: nigeria-facility-registry
Title: "NG Facility Identifier CS"
Description: "This CodeSystem IMMZ.A.DE1 defines placeholder codes to manage Facility identifiers in Nigeria."
* ^url = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-facility-registry"
* ^status = #active
* ^content = #complete
* ^caseSensitive = true
* ^hierarchyMeaning = #grouped-by
* ^publisher = "FMoHSW"
* ^experimental = false
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"

// Sample Codes for testing
* #HCF-45231 "1"
* #HCF-12342 "2"
* #HCF-12343 "3"
* #HCF-12344 "4"
* #HCF-12345 "5"
* #HCF-12346 "6"
* #HCF-12347 "7"
* #CLM-2025-0001 "Claims Institution"
* #NHIA-0011223344 "Insurance Organization"
* #HOSPITAL1234 "Hospital ID example"
//.... to be completed







CodeSystem: NgCarePlanCategoryCS
Id: ng-careplan-category-cs
Title: "NG CarePlan Category Codes"
Description: "Categories for CarePlan.category aligned to DHIN 2025 Connectathon tracks."
* ^url = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-careplan-category-cs"
* ^status = #active
* ^content = #complete
* ^caseSensitive = false
* ^hierarchyMeaning = #grouped-by
* ^publisher = "FMoHSW"
* ^version = "0.1.0"
* ^experimental = false
* #general "General care plan" "Cross-cutting plan not tied to a single track."
* #mnch "MNCH" "Maternal, newborn & child health plan."
* #immunization "Immunization" "Vaccination and defaulter-tracing plan."
* #pharmacy "Pharmacy/ePharmacy" "Medication adherence/dispense plan."
* #claims "Insurance & Claims" "Financial protection and claims-related plan."
* #devices "Medical Devices" "Connected/home-monitoring device plan."
* #chronic "Chronic disease" "Hypertension, diabetes, etc."




CodeSystem: NgCarePlanActivityCS
Id: ng-careplan-activity-cs
Title: "NG CarePlan Activity Codes"
Description: "Activities for CarePlan.activity.detail.code aligned to DHIN 2025 Connectathon tracks."
* ^url = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-careplan-activity-cs"
* ^status = #active
* ^version = "0.1.0"
* ^caseSensitive = true
* ^content = #complete
* ^experimental = false
* #anc-counsel "ANC Counseling" "Antenatal education/counseling."
* #bp-monitor "BP Monitoring" "Blood pressure monitoring at home."
* #immunize "Immunization Administration" "Administer scheduled vaccine."
* #defaulter-trace "Defaulter Tracing" "Outreach to missed immunization clients."
* #rx-counsel "Medication Counseling" "Explain regimen and side effects."
* #med-dispense "Medication Dispense" "Dispense prescribed medication."
* #referral-followup "Referral Follow-up" "Confirm referral attended."
* #device-setup "Device Setup" "Configure device and train patient."
* #device-check "Device Check/Calibration" "Validate device performance."
* #claim-submit "Claim Submission" "Submit claim to payer."
* #claim-reconcile "Claim Reconciliation" "Match payments to claims."


CodeSystem: NgDeviceMetricCategoryCS
Id: ng-device-metric-category-cs
Title: "NG DeviceMetric Category Codes"
Description: "Local mirror of DeviceMetric.category. Consider using 'http://terminology.hl7.org/CodeSystem/metric-category' in production."
* ^status = #active
* ^version = "0.1.0"
* ^caseSensitive = true
* ^content = #complete
* ^experimental = false
* #measurement "Measurement" "Metric represents a measured value from a device."
* #setting "Setting" "Metric represents a device setting that affects behavior."
* #calculation "Calculation" "Metric represents a calculated/derived value."
* #unspecified "Unspecified" "Metric category is not specified."




CodeSystem: NGHivStatusCS
Id: nigeria-hiv-status
Title: "NG Client HIV status CS"
Description: "This CodeSystem IMMZ.C.DE31 defines list of options for HIV status of a Client"
* ^url = "https://sandbox.dhin-hie.org/ig/CodeSystem/nigeria-hiv-status"

* ^status = #active
* ^content = #complete
* ^caseSensitive = true
* ^experimental = false
//* ^hierarchyMeaning = #is-a
* ^publisher = "NPHCDA"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
// The CodeSystem for Client's HIV Status
* #positive	"Positive" "The Client is HIV positive"
* #negative 	"Negative" "The Client is HIV Negative"
* #unknown	"Unknown" "The Client does not know their HIV status"



CodeSystem: NgProvenanceActivityCS
Id: ng-provenance-activity-cs
Title: "NG Provenance Activity Codes"
Description: "Local CodeSystem defining provenance activity codes for data lifecycle operations such as anonymization, de-identification, labeling, creation, and deletion, aligned to DHIN 2025 Connectathon artifacts."
* ^url = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-provenance-activity-cs"
* ^status = #active
* ^content = #complete
* ^caseSensitive = false
* ^hierarchyMeaning = #grouped-by
* ^publisher = "FMoHSW / DHIN 2025 Connectathon"
* ^version = "0.1.0"
* ^experimental = false
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"

// -------------------- Provenance Activity Codes --------------------
* #ANONY "Anonymize" "Activity that removes all personally identifiable information (PII) to prevent re-identification."
* #DEID "De-identify" "Activity that removes or obfuscates personal identifiers while retaining data usability."
* #MASK "Mask" "Activity that hides or replaces specific data elements with placeholder values."
* #LABEL "Assign Security Label" "Activity that applies confidentiality, sensitivity, or purpose-of-use labels to data."
* #PSEUD "Pseudonymize" "Activity that replaces direct identifiers with pseudonyms that can be re-linked under controlled conditions."
* #CREATE "Create" "Activity representing the creation of new data or resource instance."
* #DELETE "Delete" "Activity representing deletion or removal of a data record."
* #APPEND "Append" "Activity representing addition of new information to an existing resource or record."
* #NULLIFY "Nullify" "Activity that invalidates or renders data non-usable without deleting the record."
* #LA "Legally Authenticated" "Activity confirming legal authentication of a record (e.g., signed or witnessed by authorized person)."

