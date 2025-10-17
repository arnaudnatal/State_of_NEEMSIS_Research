*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@ifpindia.org
*September 22, 2025
*-----
*All in one
*-----
cd"C:\Users\Arnaud\Documents\GitHub\State_of_NEEMSIS_Research"
*----- Routines
*ssc install fre
*ssc install catplot
*ssc install git
*
*----- Schemes
set scheme plottig, permanently
*-------------------------

set graph off

do"Stata_cmd\SNR-01_Journals.do"
do"Stata_cmd\SNR-02_Papers.do"
do"Stata_cmd\SNR-03_Alloutputs.do"
do"Stata_cmd\SNR-04_Researchpapers.do"
do"Stata_cmd\SNR-05_Publishedpapers.do"
do"Stata_cmd\SNR-06_Journalarticles.do"
do"Stata_cmd\SNR-07_Dissertations.do"
do"Stata_cmd\SNR-08_Blogposts.do"
do"Stata_cmd\SNR-09_OngoingProjects.do"

erase"Stata_cmd\_temp.dta"
erase"Stata_cmd\journals.dta"
erase"Stata_cmd\Papers_v0.dta"
erase"Stata_cmd\Papers_v1.dta"
erase"Stata_cmd\Projects_v1.dta"

set graph on
