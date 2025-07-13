Instance: SearchParameter-ngep-identifier
InstanceOf: SearchParameter
Title: "NG-eP Search Patient by Identifier"
Usage: #definition
* name = "identifier"
* status = #active
* code = #identifier
* base = #Patient
* type = #token
* expression = "Patient.identifier"
* description = "Search by patient identifier"


Instance: SearchParameter-ngep-firstname
InstanceOf: SearchParameter
Title: "NG-eP Search Patient by firstname"
Usage: #definition
* name = "firstname"
* status = #active
* code = #firstname
* base = #Patient
* type = #token
* expression = "Patient.firstname"
* description = "Search by patient firstname"

Instance: SearchParameter-ngep-lastname
InstanceOf: SearchParameter
Title: "NG-eP Search Patient by lastname"
Usage: #definition
* name = "lastname"
* status = #active
* code = #lastname
* base = #Patient
* type = #token
* expression = "Patient.lastname"
* description = "Search by patient lastname"

Instance: SearchParameter-ngep-birthdate
InstanceOf: SearchParameter
Title: "NG-eP Search Patient by birth date"
Usage: #definition
* name = "birthDate"
* status = #active
* code = #birthdate
* base = #Patient
* type = #token
* expression = "Patient.birthdate"
* description = "Search by patient birth date"

Instance: SearchParameter-ngimm-gender
InstanceOf: SearchParameter
Title: "NG-eP Search Patient by gender"
Usage: #definition
* name = "gender"
* status = #active
* code = #gender
* base = #Patient
* type = #token
* expression = "Patient.gender"
* description = "Search by patient gender"

Instance: SearchParameter-ngep-telecom
InstanceOf: SearchParameter
Title: "NG-eP Search patient record by phone number or email address"
Usage: #definition
* name = "telecom"
* status = #active
* code = #telecom
* base = #Patient
* type = #token
* expression = "Patient.telecom"
* description = "Search patient record by phone number or email address"


Instance: SearchParameter-ngep-state
InstanceOf: SearchParameter
Title: "NG-eP Search Patient by state"
Usage: #definition
* name = "state"
* status = #active
* code = #state
* base = #Patient
* type = #token
* expression = "Patient.state"
* description = "Search by patient's State of residence"

Instance: SearchParameter-ngeP-lga
InstanceOf: SearchParameter
Title: "NG-eP Search by Patient lga of residence"
Usage: #definition
* name = "lga"
* status = #active
* code = #lga
* base = #Patient
* type = #token
* expression = "Patient.lga"
* description = "Search by patient LGA of residence"

Instance: SearchParameter-ngep-city
InstanceOf: SearchParameter
Title: "NG-eP Search patient record by city, town or settlement"
Usage: #definition
* name = "city"
* status = #active
* code = #city
* base = #Patient
* type = #token
* expression = "Patient.city"
* description = "Search patient records by city, town or settlement"

Instance: SearchParameter-ngep-patient
InstanceOf: SearchParameter
Title: "NG-eP Search Immunization by patient"
Usage: #definition
* name = "immpatient"
* status = #active
* code = #immpatient
* base = #Immunization
* type = #token
* expression = "Immunization.patient"
* description = "Search Immunization records by patient"





Instance: NgePBundleSearchByBirthDate
InstanceOf: SearchParameter
Title: "NG-eP Search Bundle by Patient BirthDate"
Description: "Retrieve bundles where the Patient has a specific birth date"
Usage: #definition
* name = "searchBundleByPatientBirthDate"
* status = #active
* description = "Search for a bundle based on Patient.birthDate"
* code = #patient-birthdate
* base = #Bundle
* type = #date
* expression = "Bundle.entry.resource.ofType(Patient).birthDate"

Instance: NgePBundleSearchByPatientIdentifier
InstanceOf: SearchParameter
Title: "NG-eP Search Bundle by Patient Identifier"
Description: "Allows search of NgImmBundle resources where the embedded Patient has a specific identifier (e.g., NIN)"
Usage: #definition
* name = "searchBundleByPatientIdentifier"
* status = #active
* description = "Search for a bundle containing a patient with a specific identifier"
* code = #patient.identifier
* base = #Bundle
* type = #token
* expression = "Bundle.entry.resource.ofType(Patient).identifier"
* xpathUsage = #normal

Instance: NgePBundleSearchByState
InstanceOf: SearchParameter
Title: "NG-eP Search Bundle by Patient State"
Description: "Retrieve bundles where the Patient resides in a specific Nigerian State"
Usage: #definition
* name = "searchBundleByPatientState"
* status = #active
* description = "Search for a bundle based on Patient address.state"
* code = #patient-address-state
* base = #Bundle
* type = #token
* expression = "Bundle.entry.resource.ofType(Patient).address.state"

Instance: NgePBundleSearchByFacilityIdentifier
InstanceOf: SearchParameter
Title: "NG-eP Search Bundle by Organization Identifier"
Description: "Retrieve bundles that reference a specific healthcare organization/facility"
Usage: #definition
* name = "searchBundleByOrganizationIdentifier"
* status = #active
* description = "Search for a bundle based on Organization.identifier"
* code = #organization-identifier
* base = #Bundle
* type = #token
* expression = "Bundle.entry.resource.ofType(Organization).identifier"


Instance: NgePBundleSearchByLastUpdated
InstanceOf: SearchParameter
Title: "NG-eP Search Bundle by Last Updated Date"
Description: "Retrieve bundles based on last updated timestamp"
Usage: #definition
* name = "searchBundleByLastUpdated"
* status = #active
* description = "Search for bundles that were last updated on or after a given date"
* code = #_lastUpdated
* base = #Bundle
* type = #date
* expression = "Bundle.meta.lastUpdated"
