// ====================================================================
// Profile: NgTaskExecutionBundle
// ====================================================================
Profile: NgTaskExecutionBundle
Parent: Bundle
Id: ng-task-execution-bundle
Title: "4-NG Device Task Execution Bundle (Chemistry Analyzer)"
Description: "Collection bundle for chemistry analyzer task execution. Includes Patient, performing Organization, Device, optional DeviceMetric/DeviceRequest, one Task, and ≥1 Observation (lab results). Kept lightweight to reduce QA."
* ^status = #active

// Bundle basics
* type 1..1 MS
* type = #collection (exactly)
* entry 5..* MS
* entry.fullUrl 1..1 MS
* entry.resource 1..1 MS

// Slice entries by resource/profile
* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #open

* entry contains
    patient 1..1 MS and
    performerOrg 1..1 MS and
    device 1..1 MS and
    deviceMetric 0..* and
    deviceRequest 0..1 and
    task 1..1 MS and
    observation 1..* MS and
    location 0..1

// Patient slice
* entry[patient].resource only NgPatient
* entry[patient].fullUrl ^short = "Prefer URN UUID for intra-bundle references"

// Performing Organization slice
* entry[performerOrg].resource only NgOrganization
* entry[performerOrg].fullUrl ^short = "Prefer URN UUID for intra-bundle references"

// Device slice
* entry[device].resource only NgDevice
* entry[device].fullUrl ^short = "Prefer URN UUID for intra-bundle references"

// DeviceMetric slice (optional)
* entry[deviceMetric].resource only NgDeviceMetric

// DeviceRequest slice (optional)
* entry[deviceRequest].resource only NgDeviceRequest

// Task slice (execution record)
* entry[task].resource only NgTask

// Observation slice (lab results)
// Allow either base Observation or your NgObservation to avoid profile mismatch
* entry[observation].resource only Observation or NgObservation

// Location slice (optional: analyzer room/bench)
* entry[location].resource only NgLocation

// --------------------
// Invariants (soft; reduce QA noise)
// --------------------
Invariant: ngtx-uuid-fullurl
Description: "Entries SHOULD use URN UUID fullUrls for local intra-bundle references."
Severity: #warning
Expression: "entry.fullUrl.all(matches('^urn:uuid:'))"

Invariant: ngtx-obs-links
Description: "Observation.subject and Observation.device SHOULD be local URN references within the same bundle."
Severity: #warning
Expression: "entry.resource.ofType(Observation).subject.reference.all(matches('^urn:uuid:')) and entry.resource.ofType(Observation).device.reference.all(matches('^urn:uuid:'))"

Invariant: ngtx-task-links
Description: "Task.for (patient) and Task.owner (organization) SHOULD be local URN references; if Task.focus exists it SHOULD resolve to a DeviceRequest in this bundle."
Severity: #warning
Expression: "entry.resource.ofType(Task).for.reference.all(matches('^urn:uuid:')) and entry.resource.ofType(Task).owner.reference.all(matches('^urn:uuid:')) and (entry.resource.ofType(Task).focus.exists() implies entry.resource.ofType(Task).focus.reference.all(matches('^urn:uuid:')))"
