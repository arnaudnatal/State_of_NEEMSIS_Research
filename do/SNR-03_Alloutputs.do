*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@ifpindia.org
*September 22, 2025
*-----
*Figures
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
* Global
****************************************

global authors Nordman Guérin Venkat Michiels Natal Mouchel DiSantolo Lanos Hilger Kumar Girollet DEspallier Goedecke Reboul Kar Seetahul Roesch
global data R N1 N2
global topics Debt Employment Personality Networks Agriculture Gender Income Wealth Inequality Demonetisation Covid Mobility Marriage Trust Caste Migration Education Discrimination Consumption Saving Decisionmaking
global journaltopics j_Economics j_PoliticalScience j_Sociology j_Development j_Geography j_Demography j_Management

****************************************
* END








****************************************
* All papers
****************************************
use"Papers_v1", clear

********** Type
*
set graph on
count
catplot, over(type, lab(angle(90) labsize(small))) percent vertical ///
ylabel(0(10)50,labsize(small)) ///
ytitle("Percentage",size(small)) ///
title("Type of outputs (N=`r(N)')") ///
note("{it:Source:} A. Natal. Updated in September 2025.", size(vsmall)) name(type, replace) 
graph export "Beamer/INPUT/A_type.pdf", as(pdf) replace

****************************************
* END










****************************************
* Selection PP for wordcloud
****************************************
use"Papers_v1", clear


********** All PP
preserve
keep if status==3
drop if type==6
drop if type==7
keep if Abstract!=""
keep Abstract
outfile using "WCloud/all.txt", noquote replace
restore


********** RUME PP
preserve
keep if status==3
drop if type==6
drop if type==7
keep if R==1
keep if Abstract!=""
keep Abstract
outfile using "WCloud/rume.txt", noquote replace
restore


********** NEEMSIS-1 PP
preserve
keep if status==3
drop if type==6
drop if type==7
keep if N1==1
keep if Abstract!=""
keep Abstract
outfile using "WCloud/neemsis1.txt", noquote replace
restore


********** NEEMSIS-2 PP
preserve
keep if status==3
drop if type==6
drop if type==7
keep if N2==1
keep if Abstract!=""
keep Abstract
outfile using "WCloud/neemsis2.txt", noquote replace
restore


********** NEEMSIS PP
preserve
keep if status==3
drop if type==6
drop if type==7
keep if N1==1 | N2==1
keep if Abstract!=""
keep Abstract
outfile using "WCloud/neemsis.txt", noquote replace
restore


********** Dissertation PP
preserve
keep if type==5
keep if Abstract!=""
keep Abstract
outfile using "WCloud/dissertations.txt", noquote replace
restore

****************************************
* END



