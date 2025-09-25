Profile: NgClaimCoverage
Parent: Coverage
Id: ng-claim-coverage
Title: "NG-Claim Coverage"
Description: "A profile capturing a patient's insurance coverage details."

* status 1..1 MS
* type 1..1 MS
* subscriber 0..1 MS
* beneficiary 1..1 MS
* payor 1..1 MS
* period 0..1