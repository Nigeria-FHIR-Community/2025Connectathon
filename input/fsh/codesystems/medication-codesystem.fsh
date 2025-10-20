CodeSystem: NgATCLocalMedicationCS
Id: ng-atc-medication-cs
Title: "NG Local ATC Medication Codes"
Description: "Local, ATC-inspired medication codes for MNCH referral, claims, prescription, and immunization use cases at the DHIN 2025 Connectathon. Codes are placeholders aligned to common maternal, newborn, and child health needs, plus EPI vaccines."
* ^url = "https://sandbox.dhin-hie.org/ig/CodeSystem/ng-atc-medication-cs"
* ^status = #active
* ^version = "0.1.0"
* ^caseSensitive = true
* ^content = #complete
* ^experimental = false
* ^publisher = "FMoHSW / DHIN 2025 Connectathon"
* ^jurisdiction = urn:iso:std:iso:3166#NG "Nigeria"

// ---------- Maternal supplements / antianemics (A, B) ----------
* #A11-IFA "Iron–Folic Acid tablets (30/0.4 mg)" "Daily antenatal iron–folate for anemia prevention."
* #A11-FA-5 "Folic acid 5 mg tablet" "High-dose folate per protocol."
* #A12-CALC "Calcium carbonate 500 mg tablet" "Calcium supplementation to reduce pre-eclampsia risk."
* #B03-FE-SULF "Ferrous sulfate 200 mg (65 mg elemental) tablet" "Treatment of iron-deficiency anemia."
* #A11-MV-PREN "Prenatal multivitamin" "Combined antenatal vitamin/mineral tablet."
* #A11-VITA-100 "Vitamin A 100,000 IU capsule" "For post-partum/child dosing per guideline."
* #A11-VITA-200 "Vitamin A 200,000 IU capsule" "For post-partum/child dosing per guideline."

// ---------- Obstetric / labor & pre-eclampsia (G, A) ----------
* #G02-OXY "Oxytocin 10 IU/mL injection" "Active management of third stage, PPH prevention/treatment."
* #G02-MISO "Misoprostol 200 mcg tablet" "PPH prevention/treatment where oxytocin unavailable."
* #A12-MGSO4 "Magnesium sulfate injection" "Severe pre-eclampsia/eclampsia management (loading/maintenance)."
* #C02-METHYLDOPA "Methyldopa 250 mg tablet" "Antihypertensive in pregnancy per protocol."
* #C08-NIFEDIPINE "Nifedipine 10 mg capsule" "Acute BP control in severe hypertension (per protocol)."

// ---------- Anti-infectives / neonatal sepsis (J) ----------
* #J01-AMX-DT "Amoxicillin 250 mg dispersible tablet" "Child pneumonia/OTIT treatment; community case mgmt."
* #J01-AMOX-CAP "Amoxicillin 500 mg capsule" "Adult/maternal infections per protocol."
* #J01-AMP "Ampicillin injection" "Neonatal sepsis first-line (with gentamicin)."
* #J01-GENTA "Gentamicin injection" "Neonatal sepsis first-line (with ampicillin)."
* #J01-CEFTRI "Ceftriaxone injection" "Severe infections; inpatient use per protocol."
* #J01-CLX "Cloxacillin 500 mg capsule" "Skin/soft tissue and mastitis per protocol."
* #J01-METRO "Metronidazole 400 mg tablet" "Anaerobic/obstetric infections per protocol."
* #J06-ANTI-D-IG "Anti-D immunoglobulin" "Rh-D negative prophylaxis for sensitizing events."
* #J01-ERYTHRO "Erythromycin 250 mg tablet" "Alternative macrolide; PPROM/GBS contexts per protocol."

// ---------- Diarrhea / child health (A, N, R) ----------
* #A07-ORS "Oral rehydration salts (sachet)" "Acute diarrhea rehydration."
* #A07-ZINC20 "Zinc sulfate 20 mg tablet" "Adjunct for pediatric diarrhea (10–14 days)."
* #N02-PARA-SYR "Paracetamol 125 mg/5 mL syrup" "Fever/pain management in children."
* #R03-SALB-INH "Salbutamol 100 mcg inhaler" "Wheeze/asthma relief in MNCH contexts."

// ---------- Malaria in pregnancy / childhood (P) ----------
* #P01-ACT-AL "ACT: Artemether–Lumefantrine" "First-line uncomplicated malaria (weight-based)."
* #P01-ACT-DHA-PPQ "ACT: Dihydroartemisinin–Piperaquine" "Alternative ACT per national guideline."
* #P01-SP "Sulfadoxine–Pyrimethamine (SP)" "IPTp in pregnancy per schedule."
* #P02-ALB "Albendazole 400 mg tablet" "Antenatal deworming per protocol."

// ---------- Family planning / reproductive health (G03) ----------
* #G03-LNG-EC "Levonorgestrel 1.5 mg (EC)" "Emergency contraception (single dose)."
* #G03-DMPA-IM "DMPA 150 mg/mL IM injection" "3-monthly injectable contraceptive."
* #G03-DMPA-SC "DMPA 104 mg/0.65 mL SC" "3-monthly SC contraceptive (sayana-type)."
* #G03-ETON-IMP "Etonogestrel implant" "Long-acting reversible contraception."
* #G03-COC "Combined oral contraceptive (LNG/EE)" "Daily combined pill per protocol."

// ---------- Newborn care / cord & supportive ----------
* #D08-CHX-7 "Chlorhexidine 7.1% digluconate gel" "Umbilical cord care (4% free CHX equivalent)."

// ---------- Immunization (EPI) — Vaccines (J07) ----------
* #J07-BCG "BCG vaccine" "At birth — TB prevention."
* #J07-OPV "OPV vaccine" "Oral polio per schedule."
* #J07-IPV "IPV vaccine" "Inactivated polio per schedule."
* #J07-PENTA "Pentavalent DTP-HepB-Hib vaccine" "Primary series per schedule."
* #J07-PCV "Pneumococcal conjugate vaccine" "PCV10/13 per national schedule."
* #J07-ROTA "Rotavirus vaccine" "Rotavirus per schedule."
* #J07-MR "Measles-Rubella vaccine" "MR at 9/15 months per schedule."
* #J07-YF "Yellow fever vaccine" "Yellow fever per schedule."
* #J07-HPV "HPV vaccine" "Girls/boys per national program."
* #J07-TD "Tetanus-diphtheria (Td) vaccine" "Adolescent/maternal protection."

// ---------- Kits / combined claims lines (local placeholders) ----------
* #R01-ORS-ZINC-KIT "ORS + Zinc kit" "Community diarrhea pack for claims/prescription."
* #J01-AMP-GEN-COMB "Ampicillin + Gentamicin regimen (neonatal)" "Combined line item for neonatal sepsis claims."

// ---------- Metabolic in pregnancy (A10) ----------
* #A10-INSULIN-NPH "Insulin NPH" "Gestational diabetes—basal insulin per protocol."
* #A10-METFORMIN "Metformin 500 mg tablet" "GDM/T2DM per national guideline and obstetric advice."
