*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@ifpindia.org
*September 22, 2025
*-----
*All in one
*-----
cd"C:\Users\Arnaud\Documents\MEGA\ODRIIS materials\NEEMSIS papers"
*----- Schemes
set scheme plotplain_v2
grstyle init
grstyle set plain, box nogrid
* OR
*set scheme s1mono, perm
*-------------------------

do"Monitor-01_prepa_journals.do"
do"Monitor-02_prepa_papers.do"
do"Monitor-03_all.do"
do"Monitor-04_researchpapers.do"
do"Monitor-05_publishedpapers.do"
do"Monitor-06_journals.do"
do"Monitor-07_dissertations.do"
do"Monitor-08_blogposts.do"
do"Monitor-09_ongoing_projects.do"

erase"_temp.dta"
erase"journals.dta"
erase"Papers_v0.dta"
*erase"Papers_v1.dta"
