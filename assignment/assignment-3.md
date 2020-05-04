Assignment \#3
================
Hugo O. Matus

-----

###### Datascience Specialization Course: John Hopkins University

-----

#### Introduction

Download the file ProgAssignment3-data.zip file containing the data for
Programming Assignment 3 from the Coursera web site. Unzip the file in a
directory that will serve as your working directory. When you start up R
make sure to change your working directory to the directory where you
unzipped the data.

The data for this assignment come from the Hospital Compare web site
(<http://hospitalcompare.hhs.gov>) run by the U.S. Department of Health
and Human Services. The purpose of the web site is to provide data and
information about the quality of care at over 4,000 Medicare-certified
hospitals in the U.S. This dataset essentially covers all major U.S.
hospitals. This dataset is used for a variety of purposes, including
determining whether hospitals should be fined for not providing high
quality care to patients (see <http://goo.gl/jAXFX> for some background
on this particular topic).

The Hospital Compare web site contains a lot of data and we will only
look at a small subset for this assignment. The zip file for this
assignment contains three files

  - outcome-of-care-measures.csv: Contains information about 30-day
    mortality and readmission rates for heart attacks, heart failure,
    and pneumonia for over 4,000 hospitals.
  - hospital-data.csv: Contains information about each hospital.
  - Hospital\_Revised\_Flatfiles.pdf: Descriptions of the variables in
    each file (i.e the code book).

A description of the variables in each of the files is in the included
PDF file named Hospital\_Revised\_Flatfiles.pdf. This document contains
information about many other files that are not included with this
programming assignment. You will want to focus on the variables for
Number 19 (“Outcome of Care Measures.csv”) and Number 11 (“Hospital
Data.csv”). You may find it useful to print out this document (at least
the pages for Tables 19 and 11) to have next to you while you work on
this assignment. In particular, the numbers of the variables for each
table indicate column indices in each table (i.e. “Hospital Name” is
column 2 in the outcome-of-care-measures.csv file).

-----

#### 1\. Plot the 30-day mortality rates for heart attack

``` r
setwd("~/datascience/")
outcome <-
  read.csv("data/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
str(outcome)
```

    ## 'data.frame':    4706 obs. of  46 variables:
    ##  $ Provider.Number                                                                      : chr  "010001" "010005" "010006" "010007" ...
    ##  $ Hospital.Name                                                                        : chr  "SOUTHEAST ALABAMA MEDICAL CENTER" "MARSHALL MEDICAL CENTER SOUTH" "ELIZA COFFEE MEMORIAL HOSPITAL" "MIZELL MEMORIAL HOSPITAL" ...
    ##  $ Address.1                                                                            : chr  "1108 ROSS CLARK CIRCLE" "2505 U S HIGHWAY 431 NORTH" "205 MARENGO STREET" "702 N MAIN ST" ...
    ##  $ Address.2                                                                            : chr  "" "" "" "" ...
    ##  $ Address.3                                                                            : chr  "" "" "" "" ...
    ##  $ City                                                                                 : chr  "DOTHAN" "BOAZ" "FLORENCE" "OPP" ...
    ##  $ State                                                                                : chr  "AL" "AL" "AL" "AL" ...
    ##  $ ZIP.Code                                                                             : chr  "36301" "35957" "35631" "36467" ...
    ##  $ County.Name                                                                          : chr  "HOUSTON" "MARSHALL" "LAUDERDALE" "COVINGTON" ...
    ##  $ Phone.Number                                                                         : chr  "3347938701" "2565938310" "2567688400" "3344933541" ...
    ##  $ Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack                            : chr  "14.3" "18.5" "18.1" "Not Available" ...
    ##  $ Comparison.to.U.S..Rate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack  : chr  "No Different than U.S. National Rate" "No Different than U.S. National Rate" "No Different than U.S. National Rate" "Number of Cases Too Small" ...
    ##  $ Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack : chr  "12.1" "14.7" "14.8" "Not Available" ...
    ##  $ Upper.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack : chr  "17.0" "23.0" "21.8" "Not Available" ...
    ##  $ Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack       : chr  "666" "44" "329" "14" ...
    ##  $ Footnote...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack                 : chr  "" "" "" "number of cases is too small (fewer than 25) to reliably tell how well the hospital is performing" ...
    ##  $ Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure                           : chr  "11.4" "15.2" "11.3" "13.6" ...
    ##  $ Comparison.to.U.S..Rate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure : chr  "No Different than U.S. National Rate" "Worse than U.S. National Rate" "No Different than U.S. National Rate" "No Different than U.S. National Rate" ...
    ##  $ Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure: chr  "9.5" "12.2" "9.1" "10.0" ...
    ##  $ Upper.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure: chr  "13.7" "18.8" "13.9" "18.2" ...
    ##  $ Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure      : chr  "741" "234" "523" "113" ...
    ##  $ Footnote...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure                : chr  "" "" "" "" ...
    ##  $ Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia                               : chr  "10.9" "13.9" "13.4" "14.9" ...
    ##  $ Comparison.to.U.S..Rate...Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia     : chr  "No Different than U.S. National Rate" "No Different than U.S. National Rate" "No Different than U.S. National Rate" "No Different than U.S. National Rate" ...
    ##  $ Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia    : chr  "8.6" "11.3" "11.2" "11.6" ...
    ##  $ Upper.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia    : chr  "13.7" "17.0" "15.8" "19.0" ...
    ##  $ Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia          : chr  "371" "372" "836" "239" ...
    ##  $ Footnote...Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia                    : chr  "" "" "" "" ...
    ##  $ Hospital.30.Day.Readmission.Rates.from.Heart.Attack                                  : chr  "19.0" "Not Available" "17.8" "Not Available" ...
    ##  $ Comparison.to.U.S..Rate...Hospital.30.Day.Readmission.Rates.from.Heart.Attack        : chr  "No Different than U.S. National Rate" "Number of Cases Too Small" "No Different than U.S. National Rate" "Number of Cases Too Small" ...
    ##  $ Lower.Readmission.Estimate...Hospital.30.Day.Readmission.Rates.from.Heart.Attack     : chr  "16.6" "Not Available" "14.9" "Not Available" ...
    ##  $ Upper.Readmission.Estimate...Hospital.30.Day.Readmission.Rates.from.Heart.Attack     : chr  "21.7" "Not Available" "21.5" "Not Available" ...
    ##  $ Number.of.Patients...Hospital.30.Day.Readmission.Rates.from.Heart.Attack             : chr  "728" "21" "342" "1" ...
    ##  $ Footnote...Hospital.30.Day.Readmission.Rates.from.Heart.Attack                       : chr  "" "number of cases is too small (fewer than 25) to reliably tell how well the hospital is performing" "" "number of cases is too small (fewer than 25) to reliably tell how well the hospital is performing" ...
    ##  $ Hospital.30.Day.Readmission.Rates.from.Heart.Failure                                 : chr  "23.7" "22.5" "19.8" "27.1" ...
    ##  $ Comparison.to.U.S..Rate...Hospital.30.Day.Readmission.Rates.from.Heart.Failure       : chr  "No Different than U.S. National Rate" "No Different than U.S. National Rate" "Better than U.S. National Rate" "No Different than U.S. National Rate" ...
    ##  $ Lower.Readmission.Estimate...Hospital.30.Day.Readmission.Rates.from.Heart.Failure    : chr  "21.3" "19.2" "17.2" "22.4" ...
    ##  $ Upper.Readmission.Estimate...Hospital.30.Day.Readmission.Rates.from.Heart.Failure    : chr  "26.5" "26.1" "22.9" "31.9" ...
    ##  $ Number.of.Patients...Hospital.30.Day.Readmission.Rates.from.Heart.Failure            : chr  "891" "264" "614" "135" ...
    ##  $ Footnote...Hospital.30.Day.Readmission.Rates.from.Heart.Failure                      : chr  "" "" "" "" ...
    ##  $ Hospital.30.Day.Readmission.Rates.from.Pneumonia                                     : chr  "17.1" "17.6" "16.9" "19.4" ...
    ##  $ Comparison.to.U.S..Rate...Hospital.30.Day.Readmission.Rates.from.Pneumonia           : chr  "No Different than U.S. National Rate" "No Different than U.S. National Rate" "No Different than U.S. National Rate" "No Different than U.S. National Rate" ...
    ##  $ Lower.Readmission.Estimate...Hospital.30.Day.Readmission.Rates.from.Pneumonia        : chr  "14.4" "15.0" "14.7" "15.9" ...
    ##  $ Upper.Readmission.Estimate...Hospital.30.Day.Readmission.Rates.from.Pneumonia        : chr  "20.4" "20.6" "19.5" "23.2" ...
    ##  $ Number.of.Patients...Hospital.30.Day.Readmission.Rates.from.Pneumonia                : chr  "400" "374" "842" "254" ...
    ##  $ Footnote...Hospital.30.Day.Readmission.Rates.from.Pneumonia                          : chr  "" "" "" "" ...

``` r
outcome[,11] <- as.numeric(outcome[,11])
```

    ## Warning: NAs introduced by coercion

``` r
hist(outcome[,11],col = 2, main = "Hospital.30.Day.Death",xlab = "Heart Attacks" )
```

![](assignment-3_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

-----

#### 2\. Finding the best hospital in a state

Write a function called best that take two arguments: the 2-character
abbreviated name of a state and an outcome name. The function reads the
outcome-of-care-measures.csv file and returns a character vector with
the name of the hospital that has the best (i.e. lowest) 30-day
mortality for the specified outcome in that state. The hospital name is
the name provided in the Hospital.Name variable. The outcomes can be one
of “heart attack”, “heart failure”, or “pneumonia”. Hospitals that do
not have data on a particular outcome should be excluded from the set of
hospitals when deciding the rankings.

#### Handling ties.

If there is a tie for the best hospital for a given outcome, then the
hospital names should be sorted in alphabetical order and the first
hospital in that set should be chosen (i.e. if hospitals “b”, “c”, and
“f” are tied for best, then hospital “b” should be returned).

``` r
setwd("~/datascience/")

rank_by_outcome <- function(outcome) {
  ## Read outcome data
  ## Returns data.frame with cols: 
  
  data <-
    read.csv(
      "data/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv",
      na.strings = "Not Available",
      stringsAsFactors = FALSE,
      check.names = TRUE
    )
  
  
  ## Check that state and outcome are valid
  outcome_values <-
    c(
      "heart attack" = 4,
      "heart failure" = 5,
      "pneumonia" = 6
    )
  
  ## outcome check
  if (length(which(names(outcome_values) == outcome)) == 0) {
    stop(call. = FALSE,
         paste("in best(", state, ", ", outcome, ")", " :  invalid outcome"))
  }
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  obs <- data[, c(1, 2, 7, 11, 17, 23)]
  
  ## order filtered data by outcome and by hospital name
  obs <- obs[order(obs[, outcome_values[outcome]], obs[, 2]),  ]
  
  obs <- obs[complete.cases(obs[, outcome_values[outcome]]), ]
  
  results <- obs[,c(1,2,3,outcome_values[outcome])]
  
  names(results) <- c("Provider","Hospital","State","Outcome")
  return(results)
  
}

rank_by_state_outcome <- function(state, outcome) {
  
  ## Check that state and outcome are valid
  outcome_values <-
    c(
      "heart attack",
      "heart failure",
      "pneumonia"
    )
  
  ## state check
  if (length(which(state.abb == state)) == 0) {
    stop(call. = FALSE,
         paste("in best(", state, ", ", outcome, ")", " : invalid state"))
  }
  
  ## outcome check
  if (length(which((outcome_values) == outcome)) == 0) {
    stop(call. = FALSE,
         paste("in best(", state, ", ", outcome, ")", " :  invalid outcome"))
  }
  
  data <- rank_by_outcome(outcome)
  
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  ## filter and get data for state requested
  obs <- data[data[, "State"] == state, ]
  
  ## order filtered data by outcome and by hospital name
  obs <- obs[order(obs[,"Outcome"], obs[, "State"]),  ]
  obs <- obs[complete.cases(obs[, "Outcome"]), ]
  return(obs)
  
}


best <- function(state, outcome) {
 
  data <- rank_by_state_outcome(state,outcome) 
  
  return(data[1,2])
  
} 
```

The function should check the validity of its arguments. If an invalid
state value is passed to best, the function should throw an error via
the stop function with the exact message “invalid state”. If an invalid
outcome value is passed to best, the function should throw an error via
the stop function with the exact message “invalid outcome”.

#### Here are some sample output from the function.

``` r
setwd("~/datascience/")
best("TX", "heart attack")
```

    ## [1] "CYPRESS FAIRBANKS MEDICAL CENTER"

``` r
best("TX", "heart failure")
```

    ## [1] "FORT DUNCAN MEDICAL CENTER"

``` r
best("MD", "heart attack")
```

    ## [1] "JOHNS HOPKINS HOSPITAL, THE"

``` r
best("MD", "pneumonia")
```

    ## [1] "GREATER BALTIMORE MEDICAL CENTER"

-----

#### 3 Ranking hospitals by outcome in a state

Write a function called rankhospital that takes three arguments: the
2-character abbreviated name of a state (state), an outcome (outcome),
and the ranking of a hospital in that state for that outcome (num). The
function reads the outcome-of-care-measures.csv file and returns a
character vector with the name of the hospital that has the ranking
specified by the num argument.

For example, the call rankhospital(“MD”, “heart failure”, 5) would
return a character vector containing the name of the hospital with the
5th lowest 30-day death rate for heart failure. The num argument can
take values “best”, “worst”, or an integer indicating the ranking
(smaller numbers are better). If the number given by num is larger than
the number of hospitals in that state, then the function should return
NA. Hospitals that do not have data on a particular outcome should be
excluded from the set of hospitals when deciding the rankings.

#### Handling ties.

It may occur that multiple hospitals have the same 30-day mortality rate
for a given cause of death. In those cases ties should be broken by
using the hospital name. For example, in Texas (“TX”), the hospitals
with lowest 30-day mortality rate for heart failure are shown here.

ROW\_NUM Hospital.Name Rate Rank

3935 FORT DUNCAN MEDICAL CENTER 8.1 1

4085 TOMBALL REGIONAL MEDICAL CENTER 8.5 2

4103 CYPRESS FAIRBANKS MEDICAL CENTER 8.7 3

3954 DETAR HOSPITAL NAVARRO 8.7 4

4010 METHODIST HOSPITAL,THE 8.8 5

3962 MISSION REGIONAL MEDICAL CENTER 8.8 6

Note that Cypress Fairbanks Medical Center and Detar Hospital Navarro
both have the same 30-day rate (8.7). However, because Cypress comes
before Detar alphabetically, Cypress is ranked number 3 in this scheme
and Detar is ranked number 4. One can use the order function to sort
multiple vectors in this manner (i.e. where one vector is used to break
ties in another vector).

The function should use the following template.

``` r
setwd("~/datascience/")
rankhospital <- function(state, outcome, num = "best") {

  outcome_values <-
    c(
      "heart attack",
      "heart failure",
      "pneumonia"
    )
  
  ## state check
  if (length(which(state.abb == state)) == 0) {
    stop(call. = FALSE,
         paste("in best(", state, ", ", outcome, ")", " : invalid state"))
  }
  
  ## outcome check
  if (length(which((outcome_values) == outcome)) == 0) {
    stop(call. = FALSE,
         paste("in best(", state, ", ", outcome, ")", " :  invalid outcome"))
  }
  
  
  obs <- rank_by_state_outcome(state,outcome)
  
  if (num == "best") {
    obs <- obs[1, c("Hospital", "Outcome")]
    
  } else if (num == "worst") {
    obs <- (obs[nrow(obs), c("Hospital","Outcome")])
  } else {
    obs <- (obs[num, c("Hospital","Outcome")])
  }
  
  names(obs) <- c("Hospital", "Outcome")
  return(obs)
}
```

#### Here is some sample output from the function.

``` r
setwd("~/datascience/")
rankhospital("TX", "heart failure", 4)
```

    ##                    Hospital Outcome
    ## 3954 DETAR HOSPITAL NAVARRO     8.7

``` r
rankhospital("MD", "heart attack", "worst")
```

    ##                       Hospital Outcome
    ## 1872 HARFORD MEMORIAL HOSPITAL    18.1

``` r
rankhospital("MN", "heart attack", 5000)
```

    ##    Hospital Outcome
    ## NA     <NA>      NA

-----

#### 4 Ranking hospitals in all states

Write a function called rankall that takes two arguments: an outcome
name (outcome) and a hospital ranking (num). The function reads the
outcome-of-care-measures.csv file and returns a 2-column data frame
containing the hospital in each state that has the ranking specified in
num. For example the function call rankall(“heart attack”, “best”) would
return a data frame containing the names of the hospitals that are the
best in their respective states for 30-day heart attack death rates. The
function should return a value for every state (some may be NA). The
first column in the data frame is named hospital, which contains the
hospital name, and the second column is named state, which contains the
2-character abbreviation for the state name. Hospitals that do not have
data on a particular outcome should be excluded from the set of
hospitals when deciding the rankings.

#### Handling ties.

The rankall function should handle ties in the 30-day mortality rates in
the same way that the rankhospital function handles ties. The function
should use the following template.

``` r
rankall <- function(outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  
  df <- data.frame(hospital = character(0), state = character(0))
  
  for (s in sort(state.abb)) {
    e <- rankhospital(s, outcome, num)
    
    if (!is.na(e[1,1])) {
      df <- rbind(df, data.frame(e, "state" = s))
    }
  }
  return(df)
}
```

NOTE: For the purpose of this part of the assignment (and for
efficiency), your function should NOT call the rankhospital function
from the previous section.

The function should check the validity of its arguments. If an invalid
outcome value is passed to rankall, the function should throw an error
via the stop function with the exact message “invalid outcome”. The num
variable can take values “best”, “worst”, or an integer indicating the
ranking (smaller numbers are better). If the number given by num is
larger than the number of hospitals in that state, then the function
should return NA.

#### Here is some sample output from the function.

``` r
setwd("~/datascience/")
head(rankall("heart attack", "best"),3)
```

    ##                             Hospital Outcome state
    ## 99  PROVIDENCE ALASKA MEDICAL CENTER    13.4    AK
    ## 78          CRESTWOOD MEDICAL CENTER    13.3    AL
    ## 237          ARKANSAS HEART HOSPITAL    11.9    AR

``` r
head(rankall("heart failure", "best"),3)
```

    ##                                         Hospital Outcome state
    ## 115                     SOUTH PENINSULA HOSPITAL    10.8    AK
    ## 16            GEORGE H. LANIER MEMORIAL HOSPITAL     8.8    AL
    ## 232 VA CENTRAL AR. VETERANS HEALTHCARE SYSTEM LR     9.0    AR

``` r
head(rankall("pneumonia", "best"),3)
```

    ##                               Hospital Outcome state
    ## 104 YUKON KUSKOKWIM DELTA REG HOSPITAL     9.7    AK
    ## 6        MARSHALL MEDICAL CENTER NORTH     8.7    AL
    ## 250        STONE COUNTY MEDICAL CENTER     9.9    AR

``` r
head(rankall("heart attack", "worst"),3)
```

    ##                           Hospital Outcome state
    ## 100 MAT-SU REGIONAL MEDICAL CENTER    17.7    AK
    ## 11  HELEN KELLER MEMORIAL HOSPITAL    19.6    AL
    ## 229  MEDICAL CENTER SOUTH ARKANSAS    21.9    AR

``` r
head(rankall("heart failure", "worst"),3)
```

    ##                           Hospital Outcome state
    ## 102    FAIRBANKS MEMORIAL HOSPITAL    15.6    AK
    ## 8   DEKALB REGIONAL MEDICAL CENTER    16.6    AL
    ## 234  NEA BAPTIST MEMORIAL HOSPITAL    17.2    AR

``` r
head(rankall("pneumonia", "worts"),3)
```

    ## [1] hospital state   
    ## <0 rows> (or 0-length row.names)
