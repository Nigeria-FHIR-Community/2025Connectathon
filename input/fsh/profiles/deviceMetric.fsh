// -----------------------------
// Profile: NgDeviceMetric
// -----------------------------
Profile: NgDeviceMetric
Parent: DeviceMetric
Title: "NG DeviceMetric"
Description: "Minimal DeviceMetric profile for the 2025 Connectathon (medical device observations)."

// Core elements
* type 1..1 MS
* unit 0..1 MS
* category 1..1 MS
* measurementPeriod 0..1

// Bindings
* category from http://terminology.hl7.org/CodeSystem/metric-category (required) // built-in ValueSet
* type from http://loinc.org (preferred) // placeholder binding to LOINC


// -----------------------------
// Example Instance
// -----------------------------
Instance: NgDeviceMetric-001
InstanceOf: NgDeviceMetric
Usage: #example
Title: "Example NG DeviceMetric"
Description: "A minimal DeviceMetric example."
* type.text = "Oxygen saturation"
* unit.text = "%"
* category = #measurement
* measurementPeriod.repeat.frequency = 1
* measurementPeriod.repeat.period = 1
* measurementPeriod.repeat.periodUnit = #s
