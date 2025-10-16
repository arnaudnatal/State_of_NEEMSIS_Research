*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@ifpindia.org
*September 22, 2025
*-----
*Figures for published papers
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
* Published research papers
****************************************
use"Stata_cmd\Papers_v1", clear

*
fre type
drop if type>4
fre status
keep if status==3

********** Nb
twoway ///
(histogram Year if status==2 | status==3, width(1) freq discrete) ///
, ylabel(1(1)4, grid labsize(small)) xlabel(2010(2)2026, angle(90) labsize(small)) ///
ytitle("Number", size(small)) xtitle("") title("Papers over the years") ///
name(nb, replace)


********** Panel
catplot, over(panel, lab(angle(90) labsize(small))) percent vertical ///
ylabel(0(20)80, labsize(small)) ///
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
ylabel(0(20)80,labsize(small)) ytitle("Percentage",size(small)) ///
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
ylabel(0(20)80,labsize(small)) ytitle("Percentage",size(small)) ///
title("Authors")  ///
name(authors, replace)
restore


********** Published in
catplot, over(type, lab(angle(90) labsize(small))) percent vertical ///
ylabel(0(20)100,labsize(small)) ///
ytitle("Percentage",size(small)) ///
title("Published in...") ///
name(publishedin, replace)


********** Availability
catplot, over(availability, lab(angle(90) labsize(small))) percent vertical ///
ylabel(0(20)80,labsize(small)) ///
ytitle("Percentage",size(small)) ///
title("Free of charge*") ///
name(availability, replace)


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
graph combine panel dataused publishedin availability, col(5) name(top, replace)
graph combine nb topics authors, col(3) name(bot, replace)


********** Citations
preserve
egen totcite=sum(Citesep25)
egen totnetcite=sum(CiteNsep252)
sum totcite
local c=`r(mean)'
sum totnetcite
local cn=`r(mean)'
restore


********** Combine 2
count
graph combine top bot, col(1) title("Published research papers (N=`r(N)')", size(medium)) note("{it:Note:} *Green or gold open access. Papers cited `c' times (`cn')." "{it:Source:} $authordate", size(vsmall)) name(pub, replace)
graph export "Stata_cmd\Stata_fig\PP_global.svg", as(svg) replace

****************************************
* END













****************************************
* Citations per authors and per topics for published papers
****************************************
use"Stata_cmd\Papers_v1", clear

*
fre type
drop if type>4
fre status
keep if status==3
set graph off
count
local N=`r(N)'
* Total
preserve
egen tc=sum(Citesep25)
egen tnc=sum(CiteNsep25)
sum tc
local ttc=`r(mean)'
sum tnc
local ttnc=`r(mean)'
restore

********** By papers
preserve
split Title, p(:)
split Title1, p(?)
drop Title Title1 Title2 Title12
rename Title11 Title
keep Title Citesep25 CiteNsep25
order Title
*
replace Title="Data paper" if strpos(Title,"NEEMSIS")
replace Title="Surviving Debt" if strpos(Title,"Surviving Debt")
replace Title="Insights on Demonetisation" if strpos(Title,"Insights on Demonetisation")
replace Title="Psychology of Debt" if strpos(Title,"Psychology of Debt")
*
sencode Title, gen(title) gsort(-Citesep25)
order title, first
drop Title
*
graph hbar Citesep25 CiteNsep25, over(title, lab(labsize(tiny))) ///
ylabel(0(10)120,labsize(vsmall)) ///
legend(order(1 "Total" 2 "Team net") size(small)) ///
title("Citations by paper", size(medsmall)) name(citepaper, replace)
restore



********** By authors
preserve
foreach x in $authors {
bys `x': egen tc_`x'=sum(Citesep25) if `x'==1
bys `x': egen tnc_`x'=sum(CiteNsep25) if `x'==1
}
keep Title tc_* tnc_*
reshape long tc_ tnc_, i(Title) j(authors) string
drop if tc_==.
drop Title
duplicates drop
rename tc_ cite
rename tnc_ netcite
sencode authors, gen(Authors) gsort(-cite)
gsort Authors
drop if cite==0
drop authors
*
twoway ///
(connected cite Authors, mlabel(cite) mlabposition(12)) ///
(connected netcite Authors) ///
, xlabel(1(1)12,valuelabel angle(90)) xtitle("") ///
ylabel(0(250)500) ytitle("Citation") ///
title("Citations by author") ///
legend(order(1 "Total" 2 "Team net")) name(citauthors, replace)
restore

********** By topics
preserve
foreach x in $topics {
bys `x': egen tc_`x'=sum(Citesep25) if `x'==1
bys `x': egen tnc_`x'=sum(CiteNsep25) if `x'==1
}
keep Title tc_* tnc_*
reshape long tc_ tnc_, i(Title) j(topics) string
drop if tc_==.
drop Title
duplicates drop
rename tc_ cite
rename tnc_ netcite
sencode topics, gen(Topics) gsort(-cite)
gsort Topics
drop if cite==0
drop topics
*
twoway ///
(connected cite Topics, mlabel(cite) mlabposition(12)) ///
(connected netcite Topics) ///
, xlabel(1(1)12,valuelabel angle(90)) xtitle("") ///
ylabel(0(200)400) ytitle("Citation") ///
title("Citations by topic") ///
legend(order(1 "Total" 2 "Team net")) name(cittopics, replace)
restore

**********  By wave
preserve
foreach x in $data {
bys `x': egen tc_`x'=sum(Citesep25) if `x'==1
bys `x': egen tnc_`x'=sum(CiteNsep25) if `x'==1
}
keep Title tc_* tnc_*
reshape long tc_ tnc_, i(Title) j(data) string
drop if tc_==.
drop Title
duplicates drop
rename tc_ cite
rename tnc_ netcite
gen Data=.
replace Data=1 if data=="R"
replace Data=2 if data=="N1"
replace Data=3 if data=="N2"
label define Data 1"RUME" 2"NEEMSIS-1" 3"NEEMSIS-2"
label values Data Data
drop data
*
sort Data
order Data
twoway ///
(connected cite Data, mlabel(cite) mlabposition(12)) ///
(connected netcite Data) ///
, xlabel(1(1)3,valuelabel angle(90)) xtitle("") ///
ylabel(0(200)400) ytitle("Citation") ///
title("Citations by wave") ///
legend(order(1 "Total" 2 "Team net")) name(citdata, replace)
restore




********** Combine
graph combine citepaper citdata, col(2) name(top, replace)
graph combine citauthors cittopics, col(2) name(bot, replace)
*
count
graph combine top bot, col(1) title("Citations for published papers (N=`r(N)')", size(medium)) note("{it:Note:} For a total of `ttc' citations (`ttnc')." "{it:Source:} $authordate", size(vsmall)) name(cite, replace)
graph export "Stata_cmd\Stata_fig\PP_citations.svg", as(svg) replace

****************************************
* END





















****************************************
* Published papers WP
****************************************
use"Stata_cmd\Papers_v1", clear

*
fre type
drop if type>4
fre status
keep if status==3
count
local N=`r(N)'




********** WP?
catplot, over(WP, lab(angle(90) labsize(small))) percent vertical ///
ylabel(0(10)80,labsize(small)) ///
ytitle("Percentage",size(small)) ///
title("WP available?", size(medsmall)) ///
name(wp, replace)


********** Selection
keep if WP==1
keep Title Year WP1serie WP1date WP2serie WP2date


********** Where?
bys WP1serie: gen n=_N
sencode WP1serie, gen(wp1) gsort(-n)
drop n WP1serie
*
catplot, over(wp1, lab(labsize(small))) percent vertical ///
ylabel(0(10)80,labsize(small)) ///
ytitle("Percentage",size(small)) ///
title("WP series if WP available", size(medsmall)) ///
name(serie, replace)


********** When?
split Title, p(:)
split Title1, p(?)
drop Title Title1 Title2 Title12
rename Title11 Title
order Title
*
replace Title="Data paper" if strpos(Title,"NEEMSIS")
replace Title="Surviving Debt" if strpos(Title,"Surviving Debt")
replace Title="Insights on Demonetisation" if strpos(Title,"Insights on Demonetisation")
replace Title="Psychology of Debt" if strpos(Title,"Psychology of Debt")
*
sencode Title, gen(title) gsort(-Year)
order title, first
drop Title
*
twoway ///
(scatter title WP1date, msize(small)) ///
(scatter title Year, msize(small)) ///
, ylabel(1(1)9,valuelabel angle(0)labsize(small)) xlabel(2016(1)2026, angle(0)labsize(small)) ///
ytitle("") xtitle("") ///
title("WP date if WP available", size(medsmall)) ///
legend(order(1 "WP date" 2 "Publication date")) name(wpdate, replace)



********** Combine
graph combine wp serie, col(2) name(top, replace)
graph combine top wpdate, col(1) title("WP (N=`N')", size(medium)) note("{it:Source:} $authordate", size(vsmall)) name(wpglobal, replace)
graph export "Stata_cmd\Stata_fig\PP_wp.svg", as(svg) replace

****************************************
* END













