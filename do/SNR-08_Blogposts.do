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
* Blog post
****************************************
use"Papers_v1", clear

*
fre type
keep if type==7
ta Name
set graph off


********** Nb
twoway ///
(histogram Year, width(1) freq discrete) ///
, ylabel(1(1)3, grid labsize(small)) xlabel(2016(1)2025, angle(90) labsize(small)) ///
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
ylabel(0(10)50,labsize(small)) ytitle("Percentage",size(small)) ///
title("Topics")  ///
name(topics, replace)
restore


********** Where?
preserve
keep Name
bys Name: gen n=_N
sencode Name, gen(name) gsort(-n)
drop Name n
*
catplot, over(name, lab(angle(90) labsize(small))) vertical ///
ylabel(0(1)3,labsize(small)) ///
ytitle("Number",size(small)) ///
title("Where?") ///
name(where, replace)
restore

********** Language
catplot, over(language, lab(angle(90) labsize(small))) vertical percent ///
ylabel(0(20)70,labsize(small)) ///
ytitle("Number",size(small)) ///
title("Language") ///
name(lang, replace)


********** Combine
graph combine nb topics, col(2) name(top, replace)
graph combine where lang, col(2) name(bot, replace)
count
set graph on
graph combine top bot, col(1) title("Blog posts (N=`r(N)')", size(medium)) note("{it:Source:} A. Natal. Updated in September 2025.", size(vsmall)) name(pub, replace)
graph export "Beamer/INPUT/BP_global.pdf", as(pdf) replace

****************************************
* END
