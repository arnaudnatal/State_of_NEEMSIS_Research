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
* Submitted
****************************************
use"Papers_v1", clear

*
fre status
keep if status==2
set graph off


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
ylabel(0(20)100, labsize(small)) ytitle("Percentage",size(small)) ///
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
ylabel(0(20)60,labsize(small)) ytitle("Percentage",size(small)) ///
title("Authors")  ///
name(authors, replace)
restore


********** Title
/*
preserve
split Title, p(:)
split Title1, p(?)
keep Title11 Authors
egen concat=concat(Title11 Authors), p(" by ")
keep concat
*
catplot, over(concat, lab(angle(0) labsize(small))) ///
ylabel(0(20)80, labsize(zero)) ///
ytitle("") ///
title("") ///
name(title, replace)
restore
*/


********** Combine
graph combine panel dataused, col(2) name(top, replace)
graph combine topics authors, col(2) name(bot, replace)

/*
graph combine title topics, col(2) name(topalt, replace)
graph combine panel dataused authors, col(3) name(botalt, replace)
*/

count
set graph on
graph combine top bot, col(1) title("Submitted papers (N=`r(N)')", size(medium)) note("{it:Source:} A. Natal. Updated in September 2025.", size(vsmall)) name(wpglobal, replace)

graph export "Beamer/INPUT/SU_global.pdf", as(pdf) replace

****************************************
* END
















****************************************
* Ongoing
****************************************
use"Papers_v1", clear

*
fre status
keep if status==1
set graph off


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
ylabel(0(20)100, labsize(small)) ytitle("Percentage",size(small)) ///
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
ylabel(0(20)60,labsize(small)) ytitle("Percentage",size(small)) ///
title("Authors")  ///
name(authors, replace)
restore


********** Title
/*
preserve
split Title, p(:)
split Title1, p(?)
keep Title11 Authors
egen concat=concat(Title11 Authors), p(" by ")
keep concat
*
catplot, over(concat, lab(angle(0) labsize(small))) ///
ylabel(0(20)80, labsize(zero)) ///
ytitle("") ///
title("") ///
name(title, replace)
restore
*/


********** Combine
graph combine panel dataused, col(2) name(top, replace)
graph combine topics authors, col(2) name(bot, replace)

/*
graph combine title topics, col(2) name(topalt, replace)
graph combine panel dataused authors, col(3) name(botalt, replace)
*/

count
set graph on
graph combine top bot, col(1) title("Ongoing papers (N=`r(N)')", size(medium)) note("{it:Source:} A. Natal. Updated in September 2025.", size(vsmall)) name(wpglobal, replace)

graph export "Beamer/INPUT/OG_global.pdf", as(pdf) replace

****************************************
* END





















****************************************
* Projects
****************************************
use"Projects_v1", clear
set graph off

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
ylabel(0(20)100, labsize(small)) ytitle("Percentage",size(small)) ///
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
ylabel(0(20)60,labsize(small)) ytitle("Percentage",size(small)) ///
title("Authors")  ///
name(authors, replace)
restore


********** Title
/*
preserve
split Title, p(:)
split Title1, p(?)
keep Title11 Authors
egen concat=concat(Title11 Authors), p(" by ")
keep concat
*
catplot, over(concat, lab(angle(0) labsize(small))) ///
ylabel(0(20)80, labsize(zero)) ///
ytitle("") ///
title("") ///
name(title, replace)
restore
*/


********** Combine
graph combine panel dataused, col(2) name(top, replace)
graph combine topics authors, col(2) name(bot, replace)

/*
graph combine title topics, col(2) name(topalt, replace)
graph combine panel dataused authors, col(3) name(botalt, replace)
*/

count
set graph on
graph combine top bot, col(1) title("Project papers (N=`r(N)')", size(medium)) note("{it:Source:} A. Natal. Updated in September 2025.", size(vsmall)) name(wpglobal, replace)

graph export "Beamer/INPUT/PR_global.pdf", as(pdf) replace

****************************************
* END
