*-------------------------
cls
*Arnaud NATAL
*arnaud.natal@ifpindia.org
*September 22, 2025
*-----
*Figures for journal articles
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
* Published in journals
****************************************
use"Stata_cmd\Papers_v1", clear

*
fre type
keep if type==1
fre status
keep if status==3

********** Nb
twoway ///
(histogram Year, width(1) freq discrete) ///
, ylabel(1(1)4, grid labsize(small)) xlabel(2010(2)2026, angle(90) labsize(small)) ///
ytitle("Number", size(small)) xtitle("") title("Papers over the years") ///
name(nb, replace)



********** Which journal?
ta Name
count
catplot, over(Name, lab(labsize(small))) ///
ylabel(0(1)4,labsize(small)) ///
ytitle("Number",size(small)) ///
title("Journals") ///
name(journals, replace)



********** Topics
preserve
keep Title $journaltopics
gen id=_n
reshape long j_, i(id) j(which) string
rename j_ j
replace j=j*100
bys which: egen x=sum(j)
drop if x==0
drop x
myaxis order=which, sort(sum j) descending
*
graph bar j, over(order, lab(angle(90) labsize(small)))  ///
ylabel(0(10)60,labsize(small)) ytitle("Percentage",size(small)) ///
title("Topics of journals")  ///
name(topics, replace)
restore


********** Cat
catplot, over(j_q_SJR2024, lab(labsize(small))) percent vertical ///
ylabel(0(10)40,labsize(small)) ///
ytitle("Percentage",size(small)) ///
title("Category of journals (SJR 2024)") ///
name(cat, replace)


********** Combine
graph combine nb journals, col(2) name(top, replace)
graph combine topics cat, col(2) name(bot, replace)
count
graph combine top bot, col(1) title("Papers published in journals (N=`r(N)')", size(medium)) note("{it:Source:} $authordate", size(vsmall)) name(pub, replace)
graph export "Stata_cmd\Stata_fig\J_global.svg", as(svg) replace

****************************************
* END



