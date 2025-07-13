Instance: NgePCapabilityStatementClient
InstanceOf: CapabilityStatement
Usage: #definition
Title: "NG-eP Client CapabilityStatement"
Description: "Describes expected behavior of clients consuming immunization services using the Nigerian profiles."
* status = #active
* date = "2025-06-22"
* kind = #requirements
* fhirVersion = #4.0.1
* format = #json
* format = #xml
* rest[+]
  * mode = #client
  * documentation = "Client that searches, retrieves and submits immunization records using Nigerian profiles."

  * resource[+]
    * type = #Patient
    * profile = Canonical(NgePPatient)
    * interaction[+].code = #read
    * interaction[+].code = #search-type
    * interaction[+].code = #create
    * interaction[+].code = #update
    * interaction[+].code = #patch

  * resource[+]
    * type = #Immunization
    * profile = Canonical(Immunization)
    * interaction[+].code = #read
    * interaction[+].code = #search-type
    * interaction[+].code = #create
    * interaction[+].code = #update
    * interaction[+].code = #patch
