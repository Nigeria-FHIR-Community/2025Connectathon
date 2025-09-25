
CodeSystem: NGWardsCS
Id: nigeria-wards
Title: "IMMZ.C.DE14 Administrative Wards CS"
Description: "This CodeSystem IMMZ.C.DE14 defines ward codes and names mapped to their respective Local Government Areas (LGAs) in Nigeria."
* ^url = "https://www.dhin-hie.org/ig/immunization/CodeSystem/nigeria-wards"
* ^status = #active
* ^content = #complete
* ^caseSensitive = true
//* ^hierarchyMeaning = #grouped-by
* ^publisher = "DHIN"
* ^experimental = false
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"

// Abaji area councle wards in FCT
* #fc-amac-abajic "Abaji central" "Abaji central"
* #fc-amac-abajine "Abaji North East" "Abaji North East"
* #fc-amac-abajise "Abaji South East" "Abaji South East"
* #fc-amac-agyana "Agyana/Pandagi" "Agyana/Pandagi"
* #fc-amac-rimba "Rimba Ebagi" "Rimba Ebagi"
* #fc-amac-nuku "Nuku" "Nuku"
* #fc-amac-alu "Alu Mamagi" "Alu Mamagi"
* #fc-amac-yaba "Yaba" "Yaba"
* #fc-amac-gurdi "Gurdi" "Gurdi"
* #fc-amac-gawu "Gawu" "Gawu"

//.... to be completed
* #en-agwu "Agwu" "Agwu"





CodeSystem: NGRelationshipsCS
Id: nigeria-relationship
Title: "Relationships CS"
Description: "This CodeSystem defines list of persons related to a patient, but who is not a direct target of care"
* ^url = "https://www.dhin-hie.org/ig/CodeSystem/nigeria-relationship"
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
Title: "IMMZ.C.DE30 Sibling Health Status CS"
Description: "This CodeSystem IMMZ.C.DE30 defines the health of the client's sibling"
* ^url = "https://www.dhin-hie.org/ig/CodeSystem/nigeria-sibling-health-status"
* ^status = #active
* ^content = #complete
* ^caseSensitive = true
* ^experimental = false
//* ^hierarchyMeaning = #is-a
* ^publisher = "DHIN"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
// The CodeSystem for Sibling Health Status
* #DE40	"Alive" "Sibling referenced is still alive"
* #DE41	"Dead" "Sibling referenced is dead"
* #DE42	"well" "Sibling reference is alive and well"
* #DE43 "underlying disease" "Referenced Sibling has an underlying disease"




CodeSystem: NGFacilityTypeCS
Id: nigeria-facility-type
Title: "Facility Type CS"
Description: "A standardized classification system used to describe the type or level of health facility within a healthcare delivery system, based on the scope of services provided, staffing, infrastructure, and administrative role."
* ^url = "https://www.dhin-hie.org/ig/CodeSystem/nigeria-facility-type"
* ^status = #active
//* ^hierarchyMeaning = #is-a
* ^caseSensitive = true
* ^experimental = false
* ^publisher = "DHIN"
* ^content = #complete
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"
// The CodeSystem for Grouping different Facility types
* #outreach	"Outreach Post" "A temporary or mobile health service site established to deliver essential healthcare to underserved or remote populations."
* #phc-center-l1	"PHC Center Level 1" "A basic primary healthcare facility providing preventive and promotive services, often staffed by community health workers."
* #phc-center-l2    "PHC Center Level 2" "A primary healthcare facility with limited diagnostic and treatment services, typically staffed by nurses, CHEWs, or junior medical personnel."
* #phc-center-l3    "PHC Center Level 3" "An advanced primary healthcare facility offering comprehensive outpatient care, minor/light procedures, and referral support, often with a resident medical officer."
* #hospital	"Secondary Hospital" "A referral facility providing specialized care, inpatient services, and emergency response, staffed by medical officers and specialists."
* #tertiary	"Tertiary Facility" "A highly specialized hospital offering advanced diagnostic, therapeutic, and surgical care, often affiliated with teaching or research institutions."


CodeSystem: NGOrganizationOwnerCS
Id: nigeria-location-owner-cs
Title: "Location Owner CS"
Description: "This CodeSystem defines Immunization Location Owner."
* ^url = "https://www.dhin-hie.org/ig/immunization/CodeSystem/nigeria-location-owner-cs"
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
Title: "Adverse Event Clinical Status CS"
Description: "A classification system that represents the current clinical status of an individual who experienced an Adverse Event Following Immunization (AEFI), based on medical observation, investigation, or follow-up assessment."
* ^url = "https://www.dhin-hie.org/ig/immunization/CodeSystem/nigeria-clinical-status"
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
Title: "Immunization Session types CS"
Description: "Type of session for immunization Could be in a fixed facility, outreach or mobile."
* ^url = "https://www.dhin-hie.org/ig/immunization/CodeSystem/nigeria-immunization-session-type"
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
Title: "IMMZ.D.DE6 Vaccine contraindications CS"
Description: "A set of standardized codes used to represent clinical conditions, diagnoses, or circumstances that serve as contraindications to the administration of one or more vaccines."
* ^url = "https://www.dhin-hie.org/ig/immunization/CodeSystem/nigeria-immunization-contraindication"
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
Title: "Client Pregnancy status CS"
Description: "This CodeSystem defines list of options for Pregnancy status of a Client"
* ^url = "https://www.dhin-hie.org/ig/immunization/CodeSystem/nigeria-pregnancy-status"
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
Title: "Client Identifier CS"
Description: "This CodeSystem defines list of options for uniquely Identifting a Client"
* ^url = "https://www.dhin-hie.org/ig/immunization/CodeSystem/patient-identifier-cs"
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
Title: "Practitioner Identifier CS"
Description: "This CodeSystem IMMZ.C.DE14 defines placeholder codes to manage physician identifiers in Nigeria."
* ^url = "https://www.dhin-hie.org/ig/immunization/CodeSystem/nigeria-mdcn"
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
* #MDCN-12347  "4"
* #CHEW-12346 "3"
* #CHEW-12347  "4"

//.... to be completed




CodeSystem: NGFacilityIdentifierCS
Id: nigeria-facility-registry
Title: "IMMZ.A.DE1 Facility Identifier CS"
Description: "This CodeSystem IMMZ.A.DE1 defines placeholder codes to manage Facility identifiers in Nigeria."
* ^url = "https://www.dhin-hie.org/ig/immunization/CodeSystem/nigeria-facility-registry"
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
* #HCF-12344  "4"
* #HCF-12345 "3"
* #HCF-12346  "4"
* #HCF-12347  "5"
//.... to be completed


