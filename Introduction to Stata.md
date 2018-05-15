#Introduction to Stata


##Why Stata?

* Cheaper than SPSS and SAS
* More accessible than R
* Command line and GUI
* Strong on regression analysis and complex survey design
* Focused on researchers
* Large community of users

##Quick look at the user interface

* Result window
* Command window
* Variables window
* Review window
* Do-file editor
* Graph window

##How to work with Stata?


You can type everything in the command window...
...or you can use do-files. Do-files enable you to save your commands and programmes.

---> *Remember: to be useful do-files should include all the commands you run, including changing directory, loading data etc..*

##Getting some help on Stata

Stata help : type 'help'  + 'anything in the command window

```Stata
*Example
help regression
```

Internet is your friend, lot of great resources on Stata
Main Stata forum: https://www.statalist.org/
UCLA website: http://www.ats.ucla.edu/stat/Stata/
Google...


##Some initial installations

Integrate text editor with Stata (see here for more detailed tutorial:

####Notepad++ and Sublime
https://donlelek.github.io/2015-01-16-integrate-TE-with-stata/):

#####Stata highlighting in Notepad++

Save the xml file on your computer
Language -> define your language -> import
Choose the xml file where it was saved, close Notepad++ (save if needed) and open again, you should see some difference by now

#####Running Stata from Notepad++
*Rundolines:*
Follow these instructions https://huebler.blogspot.co.ke/2008/04/stata.html

####Atom
Install packages:
- script
- stata-exec
- stata-language

##Introduction

###General Stata command syntax
Most Stata commands follow the same underlying principles:

*Command varlist, options,* (e.g., sum var1 var2)*, detail*

>CAUTION - in some cases, if you type a command and don't specify a variable, Stata will perform the command on all variables in your dataset
You can find command-specific syntax in the help files

###Preparing your folders:

For every project create a Stata folder in which you will include at least four folders:
* dta
* log
* do
* outputs

Create a do file in the do folder. You can usually do so by creating a new file in your text editor and saving it with the '.do' extension.

***

####0- Commenting in Stata
***
The symbols **//** and * comment just one line

```Stata
 generate var0=1 //creates a variable of value 1
 describe var0
*Can also use this
```

To generate a commented block, enclose the text in

```Stata
/*Can be a veryyyyyy long block of comment
in which you can write pretty much what you
want.
*/
```

If your command is too long you can also break it over multiple lines.

```Stata
// break commands over multiple lines
generate var1=3
generate var2="A"
generate var3=8
generate var4="Hello"

describe var0 var1 var2 ///
var3 var4
```
***
####1 - Structuring a do-file
***

>It is good practice to structure do-files in the same way as you never know when you are going to come back to your files. Having a systematic structure helps decoding rapidly everything each do-file does even few years later.


1. Use comments to describe what the file does
2. Set working directory
3. Begin log file
4. Call up data
5. Data manipulation, statistics etc.
6. Save data under new name (if making changes to dataset)

Below is a template do-file.

```Stata
/***********************************************************************************************************************
************************************************************************************************************************
**
**   Intro to Stata
**   filename: Day "_Intro to Stata.do
**   started: March 20, 2018
**   closed: ongoing
**
**   A short file containing: basics stata commands. Based on this great website:
**   http://tutorials.iq.harvard.edu/Stata/StataIntro/StataIntro.html
***********************************************************************************************************************
***************************************************************************************/

clear
/*Working directory*/
cd "C:\Users\Patrick M\Documents\Cambridge\PAL Network\Stata training\Stata\dta"

//Begin log file
log using "C:\Users\Patrick M\Documents\Cambridge\PAL Network\Stata training\Stata\log\day3.txt", text replace

//open data file
use 4HouseholdSurvey

/*save datafile ->> it's good practice to save right away under a different name so that you keep the original dataset*/
save HHSurveyPK.dta, replace //notice 'replace', it tells Stata ok to overwrite existing file with same name
```

Once a file is open, data can be found:
- In the data editor(Browse) -> better to just view data
- In the data editor (Edit) -> but be careful to not change data  if you don't want

####Import other type of data

Often you will be presented with data files with a different extension than .dat.

Stata enables to import several types of data files, below are examples with csv files.
```Stata
//text-csv
insheet using HHSurveyPK.csv, names clear
outsheet using HHSurveyPKbis.csv, replace comma  

insheet using Districtsdata.csv, names clear
save districtsdata.dta, replace
```
And with excel files

```Stata
import excel using HHSurveyPK.xlsx, firstrow clear
export excel using HHSurveyPKbis.xlsx, replace
```
######Exercise 1:

Close down Stata and your text editor and open a new session.
1. Create a new do-file and:
2. Begin a log file
3. Open the Stata dataset (5HouseholdChildInformation.dta)
4. Save your Stata dataset using a different name
5. Save it as a csv file
6. Clear the .dta and open the csv
7. Save it as an excel file
8. Clear the .csv and open the xlsx

***

####2   Frequently used commands*/
***********************************

//Commands for reviewing and inspecting data:
describe // labels, storage type etc.
sum // statistical summary (mean, sd, min/max etc.)
codebook // storage type, unique values, labels
list // print actual values
tab // (cross) tabulate variables
browse // view the data in a spreadsheet-like window

/*for some of these if you don't put an argument it will do it for all*/
use 5HouseholdChildInformation
save HHchildinfo.dta, replace

use 5HouseholdChildInformationFlood
saveold "C:\Users\Patrick M\Documents\Cambridge\PAL Network\Stata training\Stata\dta\Version 2013\5HouseholdChildInformationFlood.dta", version(13) replace

tab childage readinghighestlevel

bysort gender: tab childage readinghighestlevel, row nofreq

clear
use 3VillageMapSurvey

describe
describe province_code
sum educationstatus
browse educationstatus
codebook currentclassgrade

bysort gender: tab childage readinghighestlevel

tabulate ischildtakingpaidtution
tab ischildtakingpaidtution institutetype
tab ischildtakingpaidtution institutetype, row col

/***3 basic charts****************/
***********************************

//Univariate distribution(s) using hist
/* Histograms */
hist institutetype
// histogram with normal curve; see 'help hist' for other options
hist childage, normal  

graph bar mathhighestlevel, over(childage)

//Bivariate distribution using scatter plots
/* scatterplots */
twoway (scatter childage tutionfee)
/*Useful for graphic exploration*/
graph matrix childage tutionfee institutetype


/***4 By Processing *************/
**********************************
// tabulate math highest level separately for men and women
bysort gender: tab mathhighestlevel
// summarize eudcation by marital status
bysort currentclassgrade: sum childage
graph bar mathhighestlevel, over(currentclassgrade)

/*Exercise 2: Descriptive statistics
Use the dataset, 5HouseholdChildInformation.dta
1.Using the describe, sum and codebook commands:
	- How many variables in total in the dataset? What is the size of the dataset? How many string type variables?
describe
*31
*38,846,034
*5
	- What is the average age? The modal value?
sum childage
*8.94
*10 years old 9.52%

	- How many missing values for the variable gender?
codebook gender
*2,066

2.Summarize highest level of reading separately for each type of institution:
bysort institutetype: sum readinghighestlevel
bysort institutetype: tab readinghighestlevel
	- Which institution has the highest % of high achievers?
*type 2, 35%

3.Cross-tabulate the grade of drop out with the reason for dropping out:
tab schooldropoutclass schooldropoutreason
	- How many children dropped out because of flood?
*89
	- What is the main reason for dropping out at grade 7?
*other

Generate a histogram of highest level of reading:
	- What do you see?
hist readinghighestlevel
*1, 3, 5 are more discriminatory

Generate a histogram of tuition fee by grade:
graph bar tutionfee, over(currentclassgrade)
	- For which grade is the tuition fee the highest?
*11
	- Anything strange?
*Is it fine to call tution fee for pre-primary and early childhood?
*/


/*** 5 Basic data management*/
// Labels
/*You never know why and when your data may be reviewed
ALWAYS label every variable no matter how insignificant it may seem
Stata uses two sets of labels: variable labels and value labels
Variable labels are very easy to use – value labels are a little more complicated*/

//Variable and value labels
*Variable labels
/* Labelling and renaming */
// Label variable tutionfee for better understanding
label var tutionfee "Tuition fee in local currency"

// change the name 'tutionfee' to 'tuition_fee'
rename tutionfee tuition_fee

// you can search names and labels with 'lookfor'
lookfor id


//Value labels are a two step process: define a value label, then assign defined label to variable(s)
/*define a value label for sex */
label define genderlab 0 "Male" 1 "Female"
label define YNquestion 0 "No" 1 "Yes"
/* assign our label set to the gender*/
label val gender  genderlab
label val ischildtakingpaidtution  YNquestion


/*Exercise 3: Variable labels and value labels
Using the manual for Pakistan:
1. Label the variable 'schooldropoutreason' 'reason for dropping out'
2. Change the variable name 'ischildtakingpaidtution' to 'TakesTution'
3. Define and assign the labels of institutetype
*/

label define institutiontype 1 "Government" 2 "Private" 3 "Madrasah" 4 "Other"
label val institutetype institutiontype

/*** 6 Working on subsets/selections  */
***************************************

/*Sometimes we want to select only certain rows selected by a condition (eg; male only, or age >5)
The following operators allow you to do this:
Operator	Meaning
==	equal to
!=	not equal to
>	greater than
>=	greater than or equal to
<	less than
<=	less than or equal to
&	and
|	or
!!!!Note the double equal signs for testing equality*/

/****7 Generating and replacing variables   */
**********************************************

//Create new variables using "gen"*/
generate Thisisgrade4=1 if currentclassgrade == "4"

/* the 'generate and replace' strategy: start with blank values and fill them in based on values of existing variables*/
// create a new variable named ISCED with missing values
gen isced=.
// Next, start adding your qualifications using "or"
replace isced=1 if currentclassgrade == "1"  | currentclassgrade == "2" | currentclassgrade == "3" | currentclassgrade == "4" | currentclassgrade == "5"
replace isced=2 if currentclassgrade == "6"  | currentclassgrade == "7" | currentclassgrade == "8"
replace isced=3 if currentclassgrade == "9"  | currentclassgrade == "10" | currentclassgrade == "11" | currentclassgrade == "12"
replace isced=0 if currentclassgrade == "ECE"  | currentclassgrade == "KG" | currentclassgrade == "Kachi" | currentclassgrade == "Nursery" | currentclassgrade == "PG" | currentclassgrade == "Prep"
replace isced=99 if currentclassgrade == "Hafiz" | currentclassgrade == "NFBE"


/*Exercise 4: Manipulating variables
1. Create a numerical variable SDG41a coding 1 if the grade correspond to grade 2 and 0 otherwise, only if currentclassgrade has a non missing value
2. Create a variable 'proficiency', labeled 'at or above proficiency level para'
for which value will be 1 if the child can read para or stories and 0 otherwise
3. Tabulate SDG41a proficiency
*/
drop SDG41a
drop proficiency

gen SDG41a=0 if currentclassgrade!=""
replace SDG41a=1 if currentclassgrade=="2"


gen proficiency=1 if readinghighestlevel >= 4 & readinghighestlevel!=.
replace proficiency=0 if readinghighestlevel<4

tab SDG41a proficiency, row



*Close log file
log close

*End do file
