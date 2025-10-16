*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@ifpindia.org
*September 22, 2025
*-----
*Prepa Journals
*-----
cd"C:\Users\Arnaud\Documents\MEGA\ODRIIS materials\NEEMSIS papers"
*----- Schemes
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid
* OR
*set scheme s1mono, perm
*-------------------------




****************************************
* Import + Global
****************************************

********** Import
import excel "NEEMSIS_papers.xlsx", sheet("Journals") firstrow clear

********** Global
global topics Economics PoliticalScience Sociology Development Geography Demography Management

*
save"_temp", replace
****************************************
* END








****************************************
* Cleaning
****************************************
use"_temp", clear

********** Topics
label define yesno 0"No" 1"Yes"
foreach x in $topics {
gen `x'=0
}
foreach x in $topics {
forvalues i=1/4 {
replace `x'=1 if strpos(Topic`i',"`x'")
label values `x' yesno
}
}
order $topics, after(Topic1)
drop Topic1 Topic2 Topic3 Topic4
foreach x in $topics {
rename `x' j_`x'
}


********** Category
gen q_SJR2024=.
replace q_SJR2024=1 if QSJR2024=="Q1"
replace q_SJR2024=2 if QSJR2024=="Q2"
replace q_SJR2024=3 if QSJR2024=="Q3"
replace q_SJR2024=4 if QSJR2024=="Q4"
label define q_SJR 1"Q1" 2"Q2" 3"Q3" 4"Q4"
label values q_SJR2024 q_SJR
order q_SJR2024, after(QSJR2024)
drop QSJR2024

********** Rename
foreach x in Country Publisher SJR2024 q_SJR2024 hindex {
rename `x' j_`x'
}

*
save"journals", replace
****************************************
* END
