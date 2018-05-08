* Evaluation Methods and Economic Appraisal
* 19 & 20 March 2018 
* Ordinary Least Squares exercise

clear all
set more off
ssc install outreg2

reg subt private
outreg2  using ASERPakteaching.doc, replace label(proper) keep(private female age mater electr mothersc balo kp sindh) dec(2) 2aster 
reg subt private female age
outreg2  using ASERPakteaching.doc, append  label(proper) keep(private female age mater electr mothersc balo kp sindh)  dec(2) 2aster 
reg subt private female age mater electr mothersc
outreg2  using ASERPakteaching.doc, append  label(proper) keep(private female age mater electr mothersc balo kp sindh)  dec(2) 2aster 
reg subt private female age mater electr mothersc balo kp sindh
outreg2  using ASERPakteaching.doc, append  label(proper) keep(private female age mater electr mothersc balo kp sindh) dec(2) 2aster 

/* If you're more experienced with Stata and/or OLS
- use stata help and message boards to try adding:
	- interaction terms (also known as factor variables)
	- margins effects
	- visualisation of interaction terms
	- play with outreg2 command to tailor the table outpus
	
 - for subsequent session on propensity score matching:
	Ð one popular programme is psmatch 2
	Ð read on package at 
		http://repec.org/bocode/p/psmatch2.html
		https://www.bgsu.edu/content/dam/BGSU/college-of-arts-and-sciences/center-for-family-and-demographic-research/documents/Workshops/2013-workshop-PSA-brief-Stata-example.pdf
	Ð install the programme with command
		ssc install psmatch2
	- to generate propensity score, run regression model, then use command pscore1:
		logit private female age mater electr mothersc balo kp sindh
		predict pscore1, ps
	
  
   
	
