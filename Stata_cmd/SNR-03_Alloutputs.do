*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@ifpindia.org
*September 22, 2025
*-----
*Figures for all outputs
*
do"Stata_cmd\_lists.do"
*-------------------------





/*
****************************************
* Global
****************************************

global authors Nordman Guérin Venkat Michiels Natal Mouchel DiSantolo Lanos Hilger Kumar Girollet DEspallier Goedecke Reboul Kar Seetahul Roesch
global data R N1 N2
global topics Debt Employment Personality Networks Agriculture Gender Income Wealth Inequality Demonetisation Covid Mobility Marriage Trust Caste Migration Education Discrimination Consumption Saving Decisionmaking
global journaltopics j_Economics j_PoliticalScience j_Sociology j_Development j_Geography j_Demography j_Management

****************************************
* END
*/







****************************************
* All papers
****************************************
use"Stata_cmd\Papers_v1", clear

********** Type
*
count
catplot, over(type, lab(angle(90) labsize(small))) percent vertical ///
ylabel(0(10)50,labsize(small)) ///
ytitle("Percentage",size(small)) ///
title("Type of outputs (N=`r(N)')") ///
note("{it:Source:} $authordate", size(vsmall)) name(type, replace) 
graph export "Stata_cmd\Stata_fig\A_type.svg", as(svg) replace

****************************************
* END










****************************************
* Selection PP for wordcloud
****************************************
use"Stata_cmd\Papers_v1", clear


********** All PP
preserve
keep if status==3
drop if type==6
drop if type==7
keep if Abstract!=""
keep Abstract
outfile using "R_cmd\R_fig\all.txt", noquote replace
restore


********** RUME PP
preserve
keep if status==3
drop if type==6
drop if type==7
keep if R==1
keep if Abstract!=""
keep Abstract
outfile using "R_cmd\R_fig\rume.txt", noquote replace
restore


********** NEEMSIS-1 PP
preserve
keep if status==3
drop if type==6
drop if type==7
keep if N1==1
keep if Abstract!=""
keep Abstract
outfile using "R_cmd\R_fig\neemsis1.txt", noquote replace
restore


********** NEEMSIS-2 PP
preserve
keep if status==3
drop if type==6
drop if type==7
keep if N2==1
keep if Abstract!=""
keep Abstract
outfile using "R_cmd\R_fig\neemsis2.txt", noquote replace
restore


********** NEEMSIS PP
preserve
keep if status==3
drop if type==6
drop if type==7
keep if N1==1 | N2==1
keep if Abstract!=""
keep Abstract
outfile using "R_cmd\R_fig\neemsis.txt", noquote replace
restore


********** Dissertation PP
preserve
keep if type==5
keep if Abstract!=""
keep Abstract
outfile using "R_cmd\R_fig\dissertations.txt", noquote replace
restore

****************************************
* END



