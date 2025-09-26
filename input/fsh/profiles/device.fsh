Profile: NgDevice
Parent: Device
Title: "NG Device"
Description: "Minimal Device profile for the 2025 Connectathon (medical devices communications)."

// Core elements (minimal & useful)
* status 1..1 MS
* type 1..1 MS
* identifier 0..* MS
* serialNumber 0..1 MS
* manufacturer 0..1
* deviceName 0..* MS
* deviceName.name 1..1
* deviceName.type MS
* deviceName.type 1..1
* patient 0..1
* owner 0..1
* location 0..1

// Reference targets
* patient only Reference(NgPatient)
* owner only Reference(NgOrganization)
* location only Reference(NgLocation)

// Value set bindings (use built-ins)
* status from FHIRDeviceStatus (required)


// -----------------------------
// Example Instance
// -----------------------------
Instance: NgDevice-001
InstanceOf: NgDevice
Usage: #example
Title: "Example NG Device"
Description: "A minimal example Device."
* status = #active
* type.text = "Pulse oximeter"
* identifier[0].system = "http://dhin.org.ng/devices"
* identifier[0].value = "POX-001"
* serialNumber = "SN-12345"
* manufacturer = "Acme Medtech"
* deviceName[0].name = "Acme Oxi-100"
* deviceName[0].type = #model-name
* owner = Reference(NgOrganization/NgOrganization-001)
* patient = Reference(NgPatient/NgOrganization-001)
* location = Reference(NgLocation/NgOrganization-001)
