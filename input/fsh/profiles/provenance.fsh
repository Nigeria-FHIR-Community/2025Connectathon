// ==============================================
// Profile: NgProvenance (lightweight)
// ==============================================
Profile: NgProvenance
Parent: Provenance
Id: ng-provenance
Title: "NG Lightweight Provenance"
Description: "Minimal provenance profile for DHIN 2025 Connectathon. Captures who created/updated a resource, when, and (optionally) which activity was performed."

// Core constraints
* target 1..* MS
* target ^short = "The resource(s) for which this provenance record provides information"

* recorded 1..1 MS
* recorded ^short = "When the activity was recorded"

* activity 0..1 MS
* activity ^short = "High-level activity (e.g., create/update/delete)"
* activity from https://sandbox.dhin-hie.org/ig/ValueSet/ng-provenance-activity-vs (extensible)

* agent 1..* MS
* agent ^short = "Actor(s) responsible for the activity"
* agent.type 0..1
* agent.type from http://hl7.org/fhir/ValueSet/provenance-agent-type (extensible)
* agent.who 1..1
* agent.who only Reference(NgPractitioner or NgPractitionerRole or NgOrganization)
* agent.onBehalfOf 0..1
* agent.onBehalfOf only Reference(NgOrganization)

// Keep it lightweight: no signature/entity requirements
* entity 0..0
* reason 0..*


// ==============================================
// Example: NgProvenance-ReferralCreate-001
// Notes:
// - Targets a ServiceRequest example created earlier
// - Agent is a Practitioner example created earlier
// ==============================================
Instance: NgProvenance-001
InstanceOf: NgProvenance
Usage: #example
Title: "Provenance for MNCH Referral Creation"
Description: "Provenance indicating that a practitioner authored the MNCH referral request."
* target[0] = Reference(NgServiceRequest-001)
* recorded = "2025-10-02T09:35:00+01:00"
* activity.coding[0].system = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-provenance-activity-cs"
* activity.coding[0].code = #CREATE
* activity.coding[0].display = "create"
* agent[0].type = http://terminology.hl7.org/CodeSystem/provenance-participant-type#author "Author"
* agent[0].who = Reference(NgPractitioner-002)
