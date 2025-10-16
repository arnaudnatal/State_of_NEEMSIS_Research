*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@ifpindia.org
*September 22, 2025
*-----
*Figures for dissertation
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
* Dissertation
****************************************
use"Stata_cmd\Papers_v1", clear

*
fre type
keep if type==5
replace Name="Paris Cité" if Name=="Université Paris Cité"
replace Name="Bordeaux" if Name=="Université de Bordeaux"
replace Name="PSL" if Name=="Université Paris Sciences et Lettres"


********** Nb
twoway ///
(histogram Year, width(1) freq discrete) ///
, ylabel(1(1)2, grid labsize(small)) xlabel(2016(1)2025, angle(90) labsize(small)) ///
ytitle("Number", size(small)) xtitle("") title("Over the years") ///
name(nb, replace)


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


********** Institutions
catplot, over(Name, lab(angle(90) labsize(small))) vertical ///
ylabel(0(1)3,labsize(small)) ///
ytitle("Number",size(small)) ///
title("Universities") ///
name(instit, replace)


********** Language
catplot, over(language, lab(angle(90) labsize(small))) vertical ///
ylabel(0(1)5,labsize(small)) ///
ytitle("Number",size(small)) ///
title("Language") ///
name(lang, replace)


********** Combine
graph combine nb topics, col(2) name(top, replace)
graph combine instit lang, col(2) name(bot, replace)
count
graph combine top bot, col(1) title("Dissertations (N=`r(N)')", size(medium)) note("{it:Source:} $authordate", size(vsmall)) name(pub, replace)
graph export "Stata_cmd\Stata_fig\D_global.svg", as(svg) replace

****************************************
* END
