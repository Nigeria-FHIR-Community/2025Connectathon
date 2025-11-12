// ======================================================================
// Profile: NgCommunication
// ======================================================================
Profile: NgCommunication
Parent: Communication
Id: ng-communication
Title: "NG Communication"

Description: """
Lightweight communication artifact for clinical messaging across DHIN tracks
(e.g., MNCH referral updates, pharmacy notifications, insurer clarifications).
Optimized to minimize QA noise while keeping key elements Must Support.
"""
* ^url = "https://sandbox.dhin-hie.org/ig/StructureDefinition/ng-communication"
* ^status = #active

// ---- Core Must-Supports ----
* status 1..1 MS
* subject 1..1 MS
* subject only Reference(NgPatient)
* sent 0..1 MS
* received 0..1 MS
* category 0..1 MS
* medium 0..1 MS
* sender 0..1 MS
* sender only Reference(NgPractitioner or NgOrganization)
* recipient 0..* MS
* recipient only Reference(NgPractitioner or NgOrganization)
* basedOn 0..* MS
* basedOn only Reference(NgServiceRequest)
* partOf 0..* MS
* partOf only Reference(NgTask)
* payload 0..* MS
* payload.content[x] 1..1 MS
* payload.content[x] only string or Attachment

// ---- Helpful (soft) invariants ----
Invariant: ngcomm-sent-or-received
Description: "A Communication SHOULD have either sent or received populated."
Severity: #warning
Expression: "sent.exists() or received.exists()"

// ---- Example binding hints (kept weak to avoid QA noise) ----
//* category from http://terminology.hl7.org/ValueSet/communication-category (extensible)
//* medium from http://terminology.hl7.org/ValueSet/v3-ParticipationMode (extensible)


// ======================================================================
// Example: NgCommunication — MNCH referral update
// ======================================================================
Instance: NgCommunication-MNCH-001
InstanceOf: NgCommunication
Usage: #example
Title: "MNCH Referral Update Message"
Description: "Referring midwife notifies receiving facility about patient en route."

* status = #completed
// * category.coding.system = "http://terminology.hl7.org/CodeSystem/communication-category"
// * category.coding.code = #notification
// * category.coding.display = "Notification"

// Patient (subject) — prefer URN UUID for intra-bundle references
* subject = Reference(NgPatient-001)

// Sender & recipient (Practitioner/Organization)
* sender = Reference(NgPractitioner-001)
* recipient[0] = Reference(NgOrganization-001)
* recipient[+] = Reference(NgPractitioner-002)

// Context links (optional but useful)
//* basedOn[0] = Reference(urn:uuid:sr-referral-request)
//* partOf[0]  = Reference(urn:uuid:task-referral-tracking)

// Timing
* sent = 2025-11-12T09:05:00+01:00

// Content (keep simple for testing)
* payload[0].contentString = "Patient is stable; EDD ~ 4 weeks. Please prepare ANC slot this morning."
// * medium[0].coding.system = "http://terminology.hl7.org/CodeSystem/v3-ParticipationMode"
// * medium[0].coding.code = #WRITTEN
// * medium[0].coding.display = "written"
