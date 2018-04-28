* Teaching do file for Quantitative data analysis (MEd Year 2 RMS)
* Created by Ben Alcott, bma27@cam.ac.uk Data courtesy of Uwezo, uwezo.net
set more off

////////////////////////////////////////////////////////////////////////////////
/// 2 Install commands to export tables to Word. Only do this once
////////////////////////////////////////////////////////////////////////////////
*ssc install estout

////////////////////////////////////////////////////////////////////////////////
/// 3 Generate foundational analysis
////////////////////////////////////////////////////////////////////////////////

* Find the proportion of children who are in 
* the correct grade, overage, and out of school
sum correct_age overage out_of_school

* Now do this by child age
tab correct_age age, col  
tab overage age, col  
tab out_of_school age, col
*alternative to achieve the same
bysort age: sum correct_age overage out_of_school

////////////////////////////////////////////////////////////////////////////////
/// 4 Get analysis into a publishable format
////////////////////////////////////////////////////////////////////////////////

* We will use the 'eststo' command to export tables, first resetting it with 'clear' command
eststo clear

* Table showing averages for full group
eststo: quietly estpost summarize correct_age overage out_of_school, listwise 
esttab using Table1.rtf, cells("mean (fmt(%9.2f))" ) ///
mtitle("Mean") label  nonumber ///
title(Descriptive statistics for sample) replace
eststo clear

* Table showing averages by age
quietly bysort age: eststo: quietly estpost summarize ///
correct_age overage out_of_school, listwise
esttab using Table2.rtf, cells("mean (fmt(%9.2f))" ) label ///
nonumber mtitle("Age 8" "Age 9" "Age 10" "Age 11" "Age 12") ///
title(Descriptive statistics, by age) replace
eststo clear


////////////////////////////////////////////////////////////////////////////////
/// 5 Make graphs that people can interpret
////////////////////////////////////////////////////////////////////////////////

/*	
Basic graph
*/	
	
graph bar out_of_school overage correct_age, over(age) ///
legend(label(3 "Correct grade") label(2 "Overage") ///
label( 1 "Out of school"  )) b1title("Child age") title("Uganda" " ")

/*		 
Same graph reformatted to ease interpretation
*/	
	graph bar out_of_school overage correct_age, stack over(age) ///
	legend(order(3 "Correct grade" 2 "Overage" 1 "Out of school"  ) ///
	symy(4) symx(8) region(lc(white)) size(2.5) col(1) pos(3)) ///
	graphregion(fcolor(white) ic(white)) plotregion(style(none)) xsize(6) ///
	ytitle("Proportion of children" " ") ///
	ylabel(0.25 "25" 0.5 "50" 0.75 "75" 1 "100", nogrid angle(0))  ///
	bar(1, color("gs10") ) ///
	bar(2, color("227 114 34")) ///
	bar(3, color("88 166 24") ) ///
	b1title("Child age") title("Uganda" " ", size(huge))

/*		 
Same graph reformatted with different levels of overage
*/	
	graph bar out_of_school behind3 behind2 behind1 correct_age , stack over(age) ///
	legend(order(5 "Correct grade" 4 "1 behind" 3 "2 behind" 2 "3+ behind" 1 "Out of school" )symy(4) symx(8) region(lc(white)) size(2.5) col(1) pos(3)) ///
	graphregion(fcolor(white) ic(white)) plotregion(style(none)) xsize(6) ///
	ytitle("Proportion of children" " ") ylabel(0.25 "25" 0.5 "50" 0.75 "75" 1 "100", nogrid angle(0))  ///
	bar(5, color("88 166 24") ) ///
	bar(4, color("239 189 71")) ///
	bar(3, color("227 114 34")) ///
	bar(2, color("214 8 59")) ///
	bar(1, color("gs10") ) ///
	b1title("Child age") title("Uganda" " ", size(huge))

