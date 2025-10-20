CodeSystem: NgAgeComponentCodesCS
Id: age-component-codes
Title: "NG Age Component Codes"
Description: "Local CodeSystem for age components: units, comparison operators, and common MNCH/EPI age bands for use in measures, decision logic, and stratification."
* ^url = "https://sandbox.dhin-hie.org/ig/CodeSystem/age-component-codes"
* ^status = #active
* ^version = "0.1.0"
* ^caseSensitive = true
* ^content = #complete
* ^experimental = false
* ^publisher = "FMoHSW / DHIN 2025 Connectathon"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"

// -------------------- Units --------------------
* #yr "Years (y)" "Age measured in years."
* #mn "Months (mo)" "Age measured in months."
* #wk "Weeks (wk)" "Age measured in weeks."
* #da "Days (d)" "Age measured in days."
* #hr "Hours (h)" "Age measured in hours (e.g., immediate neonatal)."

// -------------------- Comparison operators --------------------
* #op-lt "< (less than)" "Comparator for age threshold: less than."
* #op-le "≤ (less than or equal)" "Comparator for age threshold: less than or equal."
* #op-eq "= (equal)" "Comparator for age equality checks."
* #op-ge "≥ (greater than or equal)" "Comparator for age threshold: greater than or equal."
* #op-gt "> (greater than)" "Comparator for age threshold: greater than."

// -------------------- Programmatic age bands (MNCH / EPI) --------------------
// Neonatal/Infant
* #band-neonate "Neonate (0–28 days)" "0–28 days inclusive."
* #band-early-neonate "Early neonate (0–6 days)" "0–6 days inclusive."
* #band-late-neonate "Late neonate (7–28 days)" "7–28 days inclusive."
* #band-under1 "Under 1 year (0–11 months)" "0–11 months inclusive."
* #band-infant "Infant (1–11 months)" "1–11 months inclusive."

// Under-5 / child / adolescent
* #band-u5 "Under 5 years (0–59 months)" "0–59 months inclusive."
* #band-1to4y "1–4 years" "1 year up to 4 years 11 months."
* #band-5to9y "5–9 years" "5 years up to 9 years 11 months."
* #band-10to14y "10–14 years" "10 years up to 14 years 11 months."
* #band-15to19y "Adolescent (15–19 years)" "15 years up to 19 years 11 months."

// Adults
* #band-20to24y "Young adult (20–24 years)" "20 years up to 24 years 11 months."
* #band-25to49y "Adult (25–49 years)" "25 years up to 49 years 11 months."
* #band-50to64y "Older adult (50–64 years)" "50 years up to 64 years 11 months."
* #band-65plus "Senior (≥65 years)" "65 years and above."

// -------------------- Useful EPI schedule points (labels) --------------------
* #epi-birth "At birth" "EPI schedule label for birth dose."
* #epi-6w "6 weeks" "EPI schedule label for doses due at 6 weeks."
* #epi-10w "10 weeks" "EPI schedule label for doses due at 10 weeks."
* #epi-14w "14 weeks" "EPI schedule label for doses due at 14 weeks."
* #epi-9m "9 months" "EPI schedule label for doses due at 9 months."
* #epi-15m "15 months" "EPI schedule label for doses due at 15 months."
