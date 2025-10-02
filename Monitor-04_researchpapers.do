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
* Research papers
****************************************
use"Papers_v1", clear
set graph off

*
fre type
drop if type>4

********** Type
catplot, over(type, lab(angle(90) labsize(small))) percent vertical ///
ylabel(0(10)80,labsize(small)) ///
ytitle("Percentage",size(small)) ///
title("Type") ///
name(type, replace)


********** Status
catplot, over(status, lab(angle(90) labsize(small))) percent vertical ///
ylabel(0(10)70,labsize(small)) ///
ytitle("Percentage",size(small)) ///
title("Status") ///
name(status, replace)


********** Panel
catplot, over(panel, lab(angle(90) labsize(small))) percent vertical ///
ylabel(0(20)60, labsize(small)) ///
ytitle("Percentage", size(small)) ///
title("Analysis") ///
name(panel, replace)


********** Data used
preserve
keep Title $data
rename ($data) (data#), addnumber(1)
gen id=_n
reshape long data, i(id) j(which)
lab define which 1 "RUME" 2 "NEEMSIS-1" 3 "NEEMSIS-2"
lab values which which
replace data=data*100
*
graph bar data, over(which, lab(angle(90) labsize(small))) ///
ylabel(0(20)80, labsize(small)) ytitle("Percentage",size(small)) ///
title("Data used") ///
name(dataused, replace)
restore


********** Topics
preserve
keep Title $topics
gen id=_n
rename ($topics) topic=
reshape long topic, i(id) j(which) string
replace topic=topic*100
bys which: egen x=sum(topic)
drop if x==0
drop x
myaxis order=which, sort(sum topic) descending
*
graph bar topic, over(order, lab(angle(90) labsize(small)))  ///
ylabel(0(20)60,labsize(small)) ytitle("Percentage",size(small)) ///
title("Topics")  ///
name(topics, replace)
restore


********** Authors
preserve
keep Title $authors
gen id=_n
rename ($authors) author=
reshape long author, i(id) j(which) string
replace author=author*100
bys which: egen x=sum(author)
drop if x==0
drop x
myaxis order=which, sort(sum author) descending
*
graph bar author, over(order, lab(angle(90) labsize(small)))  ///
ylabel(0(20)60,labsize(small)) ytitle("Percentage",size(small)) ///
title("Authors")  ///
name(authors, replace)
restore


********** Team 1
catplot, over(team1, lab(angle(90) labsize(small))) percent vertical ///
ylabel(0(20)60, labsize(small)) ///
ytitle("Percentage", size(small)) ///
title("Team 1") ///
name(team1, replace)


********** Team 2
catplot, over(team2, lab(angle(90) labsize(small))) percent vertical ///
ylabel(0(20)60, labsize(small)) ///
ytitle("Percentage", size(small)) ///
title("Team 2") ///
name(team2, replace)


********** Team 3
catplot, over(team3, lab(angle(90) labsize(small))) percent vertical ///
ylabel(0(20)80, labsize(small)) ///
ytitle("Percentage", size(small)) ///
title("Team 3") ///
name(team3, replace)


********** Combine 1
graph combine status type team1 team2 team3 panel, col(6) name(top, replace)
graph combine dataused topics authors, col(3) name(bot, replace)
set graph on

********** Combine 2
count
graph combine top bot, col(1) title("Research papers (N=`r(N)')", size(medium)) note("{it:Source:} A. Natal. Updated in September 2025.", size(vsmall)) name(all, replace)
graph export "Beamer/INPUT/RP_global.pdf", as(pdf) replace

****************************************
* END





















****************************************
* Authors per wave for research papers
****************************************
use"Papers_v1", clear
set graph off

*
fre type
drop if type>4

********** RUME
preserve
keep if R==1
count
local n=`r(N)'
keep Title $authors
gen id=_n
rename ($authors) author=
reshape long author, i(id) j(which) string
replace author=author*100
bys which: egen x=sum(author)
drop if x==0
drop x
myaxis order=which, sort(sum author) descending
*
graph bar author, over(order, lab(angle(90) labsize(small)))  ///
ylabel(0(20)100,labsize(small)) ytitle("Percentage",size(small)) ///
title("RUME (N=`n')", size(medsmall))  ///
name(rume, replace)
restore


********** NEEMSIS
forvalues i=1/2 {
preserve
keep if N`i'==1
count
local n=`r(N)'
keep Title $authors
gen id=_n
rename ($authors) author=
reshape long author, i(id) j(which) string
replace author=author*100
bys which: egen x=sum(author)
drop if x==0
drop x
myaxis order=which, sort(sum author) descending
*
graph bar author, over(order, lab(angle(90) labsize(small)))  ///
ylabel(0(20)100,labsize(small)) ytitle("Percentage",size(small)) ///
title("NEEMSIS-`i' (N=`n')", size(medsmall))  ///
name(neemsis`i', replace)
restore
}


********** Combine
set graph on
graph combine rume neemsis1 neemsis2, col(3) title("Authors by wave for research papers", size(medium)) note("{it:Source:} A. Natal. Updated in September 2025.", size(vsmall)) name(authors, replace)
graph export "Beamer/INPUT/RP_authorswave.pdf", as(pdf) replace

****************************************
* END












****************************************
* Topics per wave for research papers
****************************************
use"Papers_v1", clear
set graph off

*
fre type
drop if type>4

********** RUME
preserve
keep if R==1
count
local n=`r(N)'
keep Title $topics
gen id=_n
rename ($topics) topic=
reshape long topic, i(id) j(which) string
replace topic=topic*100
bys which: egen x=sum(topic)
drop if x==0
drop x
myaxis order=which, sort(sum topic) descending
*
graph bar topic, over(order, lab(angle(90) labsize(small)))  ///
ylabel(0(20)80,labsize(small)) ytitle("Percentage",size(small)) ///
title("RUME (N=`n')", size(medsmall))  ///
name(rume, replace)
restore

********** NEEMSIS
forvalues i=1/2 {
preserve
keep if N`i'==1
count
local n=`r(N)'
keep Title $topics
gen id=_n
rename ($topics) topic=
reshape long topic, i(id) j(which) string
replace topic=topic*100
bys which: egen x=sum(topic)
drop if x==0
drop x
myaxis order=which, sort(sum topic) descending
*
graph bar topic, over(order, lab(angle(90) labsize(small)))  ///
ylabel(0(20)80,labsize(small)) ytitle("Percentage",size(small)) ///
title("NEEMSIS-`i' (N=`n')", size(medsmall))  ///
name(neemsis`i', replace)
restore
}

********** Combine
set graph on
graph combine rume neemsis1 neemsis2, col(3) title("Topics by wave for research papers", size(medium)) note("{it:Source:} A. Natal. Updated in September 2025.", size(vsmall)) name(authors, replace)
graph export "Beamer/INPUT/RP_topicswave.pdf", as(pdf) replace

****************************************
* END















****************************************
* Authors and main authors for research papers
****************************************
use"Papers_v1", clear
set graph off

*
fre type
drop if type>4
count
local N=`r(N)'


********** Stat
foreach x in $authors {
ta Mainauthor `x' if `x'==1
}
sort Mainauthor
list Title Mainauthor, noobs clean


********** Prepa data
keep Title Mainauthor $authors
foreach x in $authors {
egen n_`x'=sum(`x')
drop `x'
}
bys Mainauthor: egen ma=sum(1)
drop Title
duplicates drop
order Mainauthor ma
reshape long n_, i(Mainauthor) j(which) string
split Mainauthor, p(". ")
drop Mainauthor Mainauthor1
replace Mainauthor3=Mainauthor2 if Mainauthor3==""
drop Mainauthor2
replace Mainauthor3="DiSantolo" if Mainauthor3=="Di Santolo"
keep if Mainauthor3==which
drop Mainauthor3
rename which name
rename ma nbmain
rename n_ nbpapers

********** Scatter
bys nbmain nbpapers: gen n=_n
gen pos=3
replace pos=6 if n==2
drop n
*
set graph on
twoway ///
(scatter nbpapers nbmain, mlab(name) mlabv(pos)) ///
, xtitle("Paper as lead author") ytitle("Paper as author") ///
xlabel(0(1)10) ylabel(0(2)20) ///
title("Lead author and papers (N=`N')") note("{it:Source:} A. Natal. Updated in September 2025.", size(vsmall)) name(lead, replace)
graph export "Beamer/INPUT/RP_leadauthor.pdf", as(pdf) replace

****************************************
* END














****************************************
* Research papers from?
****************************************
use"Papers_v1", clear
set graph off

*
fre type
drop if type>4


********** From?
catplot, over(Fromdissertation, lab(angle(90) labsize(small))) percent vertical ///
ylabel(0(10)80,labsize(small)) ///
ytitle("Percentage",size(small)) ///
title("From?", size(medsmall)) ///
name(type, replace)


********** Authors for original
preserve
keep if Fromdissertation==0
count
local n=`r(N)'
keep Title $authors
gen id=_n
rename ($authors) author=
reshape long author, i(id) j(which) string
replace author=author*100
bys which: egen x=sum(author)
drop if x==0
drop x
myaxis order=which, sort(sum author) descending
*
graph bar author, over(order, lab(angle(90) labsize(small)))  ///
ylabel(0(20)100,labsize(small)) ytitle("Percentage",size(small)) ///
title("Original papers (N=`n')", size(medsmall))  ///
name(original, replace)
restore


********** Authors for thesis
preserve
keep if Fromdissertation==1
count
local n=`r(N)'
keep Title $authors
gen id=_n
rename ($authors) author=
reshape long author, i(id) j(which) string
replace author=author*100
bys which: egen x=sum(author)
drop if x==0
drop x
myaxis order=which, sort(sum author) descending
*
graph bar author, over(order, lab(angle(90) labsize(small)))  ///
ylabel(0(20)100,labsize(small)) ytitle("Percentage",size(small)) ///
title("From thesis (N=`n')", size(medsmall))  ///
name(from, replace)
restore


********** Combine
set graph on
count
graph combine type original from, col(3) title("Origin of the papers and authors (N=`r(N)')", size(medium)) note("{it:Source:} A. Natal. Updated in September 2025.", size(vsmall)) name(origin, replace)
graph export "Beamer/INPUT/RP_origins.pdf", as(pdf) replace

****************************************
* END





















/*
****************************************
* Authors and topics
****************************************
use"Papers_v1", clear
*set graph off

*
fre type
drop if type>4

********** Label
foreach x in $authors $topics {
label define `x' 0"No" 1"`x'", replace
label values `x' `x'
}
keep Title $authors $topics

********** MCA
mca ///
Nordman Guérin Venkat Michiels Natal Mouchel DiSantolo Lanos Hilger Kumar Girollet DEspallier Goedecke Reboul Seetahul ///
Debt Employment Personality Networks Agriculture Gender Income Wealth Inequality Demonetisation Covid Mobility Marriage Trust Caste Migration Education Consumption Saving Decisionmaking ///
, method(indicator) normalize(principal)
*
mcaplot, overlay legend(off) xline(0) yline(0) scale(.8)

****************************************
* END
