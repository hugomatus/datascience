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
old.dir <- getwd()
data.dir <- "data/rprog_data_ProgAssignment3-data/"
setwd(data.dir)
outcome <-
  read.csv("outcome-of-care-measures.csv", colClasses = "character")
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
setwd(old.dir)
```

``` r
outcome[,11] <- as.numeric(outcome[,11])
```

    ## Warning: NAs introduced by coercion

``` r
hist(outcome[,11],col = 2, main = "Hospital.30.Day.Death",xlab = "Num Heart Attacks" )
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
rank_by_outcome <- function(outcome) {
  ## Read outcome data
  ## Returns data.frame with cols: 
  
  data.dir <- "data/rprog_data_ProgAssignment3-data/"
  
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

For example, the call

``` r
source("script/pollutantmean.R")
rankhospital("MD", "heart failure", 5)
```

    ##                  Hospital Outcome
    ## 1876 SAINT AGNES HOSPITAL     9.3

would return a character vector containing the name of the hospital with
the 5th lowest 30-day death rate for heart failure. The num argument can
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
source("script/pollutantmean.R")
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
rankall("heart attack", "best")
```

    ##                                      Hospital Outcome state
    ## 99           PROVIDENCE ALASKA MEDICAL CENTER    13.4    AK
    ## 78                   CRESTWOOD MEDICAL CENTER    13.3    AL
    ## 237                   ARKANSAS HEART HOSPITAL    11.9    AR
    ## 159                      MAYO CLINIC HOSPITAL    12.0    AZ
    ## 387         GLENDALE ADVENTIST MEDICAL CENTER    10.5    CA
    ## 626      ST MARYS HOSPITAL AND MEDICAL CENTER    12.4    CO
    ## 687                        WATERBURY HOSPITAL    10.6    CT
    ## 717         BAYHEALTH - KENT GENERAL HOSPITAL    12.9    DE
    ## 748                MOUNT SINAI MEDICAL CENTER    12.2    FL
    ## 931                  STEPHENS COUNTY HOSPITAL    12.9    GA
    ## 1044                      HILO MEDICAL CENTER    13.3    HI
    ## 1401              MARY GREELEY MEDICAL CENTER    12.5    IA
    ## 1068                  PORTNEUF MEDICAL CENTER    12.3    ID
    ## 1197                    SAINT JOSEPH HOSPITAL    11.0    IL
    ## 1340   ST VINCENT HEART CENTER OF INDIANA LLC    11.5    IN
    ## 1545                    KANSAS HEART HOSPITAL    13.2    KS
    ## 1639        ST ELIZABETH MEDICAL CENTER NORTH    12.2    KY
    ## 1763                ST FRANCIS MEDICAL CENTER    13.6    LA
    ## 1953     BETH ISRAEL DEACONESS MEDICAL CENTER    12.1    MA
    ## 1875              JOHNS HOPKINS HOSPITAL, THE    12.4    MD
    ## 1836                            YORK HOSPITAL    12.6    ME
    ## 2025                    MUNSON MEDICAL CENTER    11.8    MI
    ## 2118                        ST MARYS HOSPITAL    12.1    MN
    ## 2358                    BOONE HOSPITAL CENTER    12.0    MO
    ## 2289                    WESLEY MEDICAL CENTER    12.9    MS
    ## 2440                    BENEFIS HOSPITALS INC    13.6    MT
    ## 2926       CAROLINAS MEDICAL CENTER-NORTHEAST    13.2    NC
    ## 3040             SANFORD MEDICAL CENTER FARGO    13.1    ND
    ## 2508           FAITH REGIONAL HEALTH SERVICES    14.0    NE
    ## 2622                  CATHOLIC MEDICAL CENTER    12.3    NH
    ## 2686             EAST ORANGE GENERAL HOSPITAL    11.8    NJ
    ## 2702                      ST VINCENT HOSPITAL    13.9    NM
    ## 2583      SUNRISE HOSPITAL AND MEDICAL CENTER    13.4    NV
    ## 2850                     NYU HOSPITALS CENTER    10.1    NY
    ## 3085                     JEWISH HOSPITAL, LLC    12.0    OH
    ## 3335            OKLAHOMA HEART HOSPITAL SOUTH    12.5    OK
    ## 3388               PORTLAND VA MEDICAL CENTER    12.5    OR
    ## 3550                      DOYLESTOWN HOSPITAL    10.4    PA
    ## 3664                          MIRIAM HOSPITAL    11.9    RI
    ## 3668                      MUSC MEDICAL CENTER    12.9    SC
    ## 3752 AVERA HEART HOSPITAL OF SOUTH DAKOTA LLC    10.5    SD
    ## 3799    METHODIST MEDICAL CENTER OF OAK RIDGE    12.8    TN
    ## 4103         CYPRESS FAIRBANKS MEDICAL CENTER    12.0    TX
    ## 4234            DIXIE REGIONAL MEDICAL CENTER    13.2    UT
    ## 4349       CHESAPEAKE REGIONAL MEDICAL CENTER    12.5    VA
    ## 4263       FLETCHER ALLEN HOSPITAL OF VERMONT    14.8    VT
    ## 4396   PROVIDENCE SACRED HEART MEDICAL CENTER    13.1    WA
    ## 4531                    BELLIN MEMORIAL HSPTL    11.8    WI
    ## 4464       MONONGALIA COUNTY GENERAL HOSPITAL    14.4    WV
    ## 4638                   WYOMING MEDICAL CENTER    14.9    WY

``` r
rankall("heart failure", "best")
```

    ##                                                               Hospital Outcome
    ## 115                                           SOUTH PENINSULA HOSPITAL    10.8
    ## 16                                  GEORGE H. LANIER MEMORIAL HOSPITAL     8.8
    ## 232                       VA CENTRAL AR. VETERANS HEALTHCARE SYSTEM LR     9.0
    ## 117                               BANNER GOOD SAMARITAN MEDICAL CENTER     8.7
    ## 552                                  CENTINELA HOSPITAL MEDICAL CENTER     7.1
    ## 653                                          PARKER ADVENTIST HOSPITAL     9.3
    ## 701                                            YALE-NEW HAVEN HOSPITAL     8.0
    ## 717                                  BAYHEALTH - KENT GENERAL HOSPITAL     9.5
    ## 794                          FLORIDA HOSPITAL HEARTLAND MEDICAL CENTER     8.6
    ## 997                                                   DOCTORS HOSPITAL     8.6
    ## 1046                                            KUAKINI MEDICAL CENTER    10.0
    ## 1414                               MERCY MEDICAL CENTER - CEDAR RAPIDS     9.1
    ## 1064                            SAINT ALPHONSUS MEDICAL CENTER - NAMPA     9.4
    ## 1148                                    RUSH UNIVERSITY MEDICAL CENTER     6.8
    ## 1276                                         ST CATHERINE HOSPITAL INC     7.6
    ## 1507                                               HAYS MEDICAL CENTER     8.7
    ## 1686                                        WESTLAKE REGIONAL HOSPITAL     9.0
    ## 1758                                    WILLIS KNIGHTON MEDICAL CENTER     8.4
    ## 1930                                     ST ELIZABETH'S MEDICAL CENTER     7.9
    ## 1907                                   MEDSTAR GOOD SAMARITAN HOSPITAL     7.4
    ## 1831                MILES MEMORIAL HOSPITAL (LINCOLN COUNTY HEALTHCARE     9.5
    ## 2030                                        HARPER UNIVERSITY HOSPITAL     7.2
    ## 2145                        ESSENTIA HEALTH ST JOSEPH'S MEDICAL CENTER     8.9
    ## 2370                                        NORTH KANSAS CITY HOSPITAL     8.9
    ## 2274                                         SOUTH CENTRAL REG MED CTR     9.2
    ## 2443                                      COMMUNITY MEDICAL CENTER INC    10.4
    ## 2981                               FIRSTHEALTH MOORE REGIONAL HOSPITAL     8.2
    ## 3066                                        ST ALOISIUS MEDICAL CENTER     9.4
    ## 2510                                           NEBRASKA HEART HOSPITAL     9.5
    ## 2631                                          VALLEY REGIONAL HOSPITAL    10.6
    ## 2686                                      EAST ORANGE GENERAL HOSPITAL     6.7
    ## 2732                              LOVELACE REGIONAL HOSPITAL - ROSWELL     9.1
    ## 2596                                             MOUNTAINVIEW HOSPITAL     9.6
    ## 2842                                  KINGSBROOK JEWISH MEDICAL CENTER     7.0
    ## 3122                                                 FAIRVIEW HOSPITAL     7.9
    ## 3259                                     DUNCAN REGIONAL HOSPITAL, INC     9.3
    ## 3388                                        PORTLAND VA MEDICAL CENTER     8.4
    ## 3491                                    PHILADELPHIA VA MEDICAL CENTER     7.4
    ## 3665                                                 WESTERLY HOSPITAL    10.1
    ## 3714                                           PALMETTO HEALTH BAPTIST     9.5
    ## 3752                          AVERA HEART HOSPITAL OF SOUTH DAKOTA LLC     9.9
    ## 3797                         WELLMONT HAWKINS COUNTY MEMORIAL HOSPITAL     9.4
    ## 3935                                        FORT DUNCAN MEDICAL CENTER     8.1
    ## 4237 VA SALT LAKE CITY HEALTHCARE - GEORGE E. WAHLEN VA MEDICAL CENTER    10.7
    ## 4341                                          SENTARA POTOMAC HOSPITAL     8.4
    ## 4275                                              SPRINGFIELD HOSPITAL    10.9
    ## 4399                                         HARBORVIEW MEDICAL CENTER     8.9
    ## 4561                                    AURORA ST LUKES MEDICAL CENTER     9.3
    ## 4473                                         FAIRMONT GENERAL HOSPITAL     9.5
    ## 4644                                        CHEYENNE VA MEDICAL CENTER    10.3
    ##      state
    ## 115     AK
    ## 16      AL
    ## 232     AR
    ## 117     AZ
    ## 552     CA
    ## 653     CO
    ## 701     CT
    ## 717     DE
    ## 794     FL
    ## 997     GA
    ## 1046    HI
    ## 1414    IA
    ## 1064    ID
    ## 1148    IL
    ## 1276    IN
    ## 1507    KS
    ## 1686    KY
    ## 1758    LA
    ## 1930    MA
    ## 1907    MD
    ## 1831    ME
    ## 2030    MI
    ## 2145    MN
    ## 2370    MO
    ## 2274    MS
    ## 2443    MT
    ## 2981    NC
    ## 3066    ND
    ## 2510    NE
    ## 2631    NH
    ## 2686    NJ
    ## 2732    NM
    ## 2596    NV
    ## 2842    NY
    ## 3122    OH
    ## 3259    OK
    ## 3388    OR
    ## 3491    PA
    ## 3665    RI
    ## 3714    SC
    ## 3752    SD
    ## 3797    TN
    ## 3935    TX
    ## 4237    UT
    ## 4341    VA
    ## 4275    VT
    ## 4399    WA
    ## 4561    WI
    ## 4473    WV
    ## 4644    WY

``` r
rankall("pneumonia", "best")
```

    ##                                                Hospital Outcome state
    ## 104                  YUKON KUSKOKWIM DELTA REG HOSPITAL     9.7    AK
    ## 6                         MARSHALL MEDICAL CENTER NORTH     8.7    AL
    ## 250                         STONE COUNTY MEDICAL CENTER     9.9    AR
    ## 159                                MAYO CLINIC HOSPITAL     7.5    AZ
    ## 518                         CEDARS-SINAI MEDICAL CENTER     6.8    CA
    ## 616                     EXEMPLA LUTHERAN MEDICAL CENTER     8.4    CO
    ## 695                                SAINT MARYS HOSPITAL     8.9    CT
    ## 719                                BEEBE MEDICAL CENTER    10.7    DE
    ## 748                          MOUNT SINAI MEDICAL CENTER     8.2    FL
    ## 1010                          PIEDMONT FAYETTE HOSPITAL     9.0    GA
    ## 1052                           PALI MOMI MEDICAL CENTER     9.1    HI
    ## 1401                        MARY GREELEY MEDICAL CENTER     8.2    IA
    ## 1084                 ST LUKES WOOD RIVER MEDICAL CENTER    10.3    ID
    ## 1154                               LAKE FOREST HOSPITAL     7.9    IL
    ## 1304                          INDIANA UNIVERSITY HEALTH     8.7    IN
    ## 1594      COMMUNITY HOSPITAL, ONAGA AND ST MARYS CAMPUS     8.9    KS
    ## 1695                              CASEY COUNTY HOSPITAL     8.6    KY
    ## 1758                     WILLIS KNIGHTON MEDICAL CENTER     8.4    LA
    ## 1968                                  FALMOUTH HOSPITAL     8.2    MA
    ## 1900                   GREATER BALTIMORE MEDICAL CENTER     7.4    MD
    ## 1831 MILES MEMORIAL HOSPITAL (LINCOLN COUNTY HEALTHCARE     8.4    ME
    ## 2020                   BEAUMONT HOSPITAL, GROSSE POINTE     8.9    MI
    ## 2156                                     MERCY HOSPITAL     9.1    MN
    ## 2392                                   LIBERTY HOSPITAL     8.2    MO
    ## 2293                         GREENWOOD LEFLORE HOSPITAL     9.5    MS
    ## 2440                              BENEFIS HOSPITALS INC     8.6    MT
    ## 2980                                       REX HOSPITAL     8.1    NC
    ## 3064                      MERCY HOSPITAL OF VALLEY CITY     8.9    ND
    ## 2575                         BOX BUTTE GENERAL HOSPITAL     9.5    NE
    ## 2620                                EXETER HOSPITAL INC     8.2    NH
    ## 2667              ENGLEWOOD HOSPITAL AND MEDICAL CENTER     8.9    NJ
    ## 2729                         LOVELACE WESTSIDE HOSPITAL     9.5    NM
    ## 2599              SPRING VALLEY HOSPITAL MEDICAL CENTER     7.8    NV
    ## 2835                          MAIMONIDES MEDICAL CENTER     7.4    NY
    ## 3153                GRANDVIEW HOSPITAL & MEDICAL CENTER     7.7    OH
    ## 3289                         HILLCREST HOSPITAL CUSHING     8.2    OK
    ## 3388                         PORTLAND VA MEDICAL CENTER     8.1    OR
    ## 3495                            KANE COMMUNITY HOSPITAL     7.8    PA
    ## 3658                                   NEWPORT HOSPITAL    10.0    RI
    ## 3672             CAROLINA PINES REGIONAL MEDICAL CENTER     9.0    SC
    ## 3740                      SIOUX FALLS VA MEDICAL CENTER     9.4    SD
    ## 3782                     UNITED REGIONAL MEDICAL CENTER     7.5    TN
    ## 4095 UNIVERSITY OF TEXAS HEALTH SCIENCE CENTER AT TYLER     7.3    TX
    ## 4224                                       LDS HOSPITAL     9.9    UT
    ## 4279                          NORTON COMMUNITY HOSPITAL     8.6    VA
    ## 4264                    RUTLAND REGIONAL MEDICAL CENTER     9.9    VT
    ## 4408                  EVERGREEN HOSPITAL MEDICAL CENTER     8.7    WA
    ## 4531                              BELLIN MEMORIAL HSPTL     8.8    WI
    ## 4463                             WEIRTON MEDICAL CENTER     9.0    WV
    ## 4644                         CHEYENNE VA MEDICAL CENTER     9.5    WY

``` r
rankall("heart attack", "worst")
```

    ##                                                                  Hospital
    ## 100                                        MAT-SU REGIONAL MEDICAL CENTER
    ## 11                                         HELEN KELLER MEMORIAL HOSPITAL
    ## 229                                         MEDICAL CENTER SOUTH ARKANSAS
    ## 119                                           VERDE VALLEY MEDICAL CENTER
    ## 508                                      METHODIST HOSPITAL OF SACRAMENTO
    ## 641                                         NORTH SUBURBAN MEDICAL CENTER
    ## 690                                             JOHNSON MEMORIAL HOSPITAL
    ## 716                                                 ST FRANCIS HEALTHCARE
    ## 831                                             PALMETTO GENERAL HOSPITAL
    ## 920                                           WEST GEORGIA MEDICAL CENTER
    ## 1052                                             PALI MOMI MEDICAL CENTER
    ## 1492                                                BOONE COUNTY HOSPITAL
    ## 1066                                EASTERN IDAHO REGIONAL MEDICAL CENTER
    ## 1200                                         SAINT ANTHONY MEDICAL CENTER
    ## 1279                                              MARION GENERAL HOSPITAL
    ## 1516                                                OLATHE MEDICAL CENTER
    ## 1637                                      MURRAY-CALLOWAY COUNTY HOSPITAL
    ## 1776                                              RIVER PARISHES HOSPITAL
    ## 1940                                                       NOBLE HOSPITAL
    ## 1872                                            HARFORD MEMORIAL HOSPITAL
    ## 1854                                            PENOBSCOT VALLEY HOSPITAL
    ## 2041                                                HURLEY MEDICAL CENTER
    ## 2165                                        HEALTHEAST ST JOHN'S HOSPITAL
    ## 2381                                 POPLAR BLUFF REGIONAL MEDICAL CENTER
    ## 2292                                 SOUTHWEST MS REGIONAL MEDICAL CENTER
    ## 2448                                           BOZEMAN DEACONESS HOSPITAL
    ## 2931                                              WAYNE MEMORIAL HOSPITAL
    ## 3042                                                       ALTRU HOSPITAL
    ## 2503 OMAHA VA MEDICAL CENTER (VA NEBRASKA WESTERN IOWA HEALTHCARE SYSTEM)
    ## 2629                                           FRANKLIN REGIONAL HOSPITAL
    ## 2654                    ROBERT WOOD JOHNSON UNIVERSITY HOSPITAL AT RAHWAY
    ## 2731                                MOUNTAIN VIEW REGIONAL MEDICAL CENTER
    ## 2593                                              DESERT SPRINGS HOSPITAL
    ## 2777                                                F F THOMPSON HOSPITAL
    ## 3144                              MERCY FRANCISCAN HOSPITAL WESTERN HILLS
    ## 3272                                         MERCY MEMORIAL HEALTH CENTER
    ## 3371                                      THREE RIVERS COMMUNITY HOSPITAL
    ## 3558                                           EPHRATA COMMUNITY HOSPITAL
    ## 3665                                                    WESTERLY HOSPITAL
    ## 3718                                          WACCAMAW COMMUNITY HOSPITAL
    ## 3730                                               PRAIRIE LAKES HOSPITAL
    ## 3823                                    DYERSBURG REGIONAL MEDICAL CENTER
    ## 3906                                                LAREDO MEDICAL CENTER
    ## 4246                                                    ST MARKS HOSPITAL
    ## 4323                                      RIVERSIDE TAPPAHANNOCK HOSPITAL
    ## 4272                               NORTHEASTERN VERMONT REGIONAL HOSPITAL
    ## 4397                                       KADLEC REGIONAL MEDICAL CENTER
    ## 4556                                             HOLY FAMILY MEMORIAL INC
    ## 4465                                             THOMAS MEMORIAL HOSPITAL
    ## 4634                                           SHERIDAN MEMORIAL HOSPITAL
    ##      Outcome state
    ## 100     17.7    AK
    ## 11      19.6    AL
    ## 229     21.9    AR
    ## 119     20.0    AZ
    ## 508     19.2    CA
    ## 641     17.2    CO
    ## 690     17.2    CT
    ## 716     15.6    DE
    ## 831     19.1    FL
    ## 920     19.9    GA
    ## 1052    17.9    HI
    ## 1492    16.7    IA
    ## 1066    17.0    ID
    ## 1200    18.9    IL
    ## 1279    18.2    IN
    ## 1516    18.4    KS
    ## 1637    20.0    KY
    ## 1776    19.9    LA
    ## 1940    17.0    MA
    ## 1872    18.1    MD
    ## 1854    18.4    ME
    ## 2041    19.8    MI
    ## 2165    17.7    MN
    ## 2381    18.7    MO
    ## 2292    19.3    MS
    ## 2448    15.9    MT
    ## 2931    19.0    NC
    ## 3042    19.8    ND
    ## 2503    17.3    NE
    ## 2629    18.8    NH
    ## 2654    20.5    NJ
    ## 2731    19.0    NM
    ## 2593    20.1    NV
    ## 2777    18.8    NY
    ## 3144    19.2    OH
    ## 3272    18.5    OK
    ## 3371    20.1    OR
    ## 3558    18.7    PA
    ## 3665    17.7    RI
    ## 3718    18.3    SC
    ## 3730    18.0    SD
    ## 3823    19.0    TN
    ## 3906    21.6    TX
    ## 4246    16.6    UT
    ## 4323    18.2    VA
    ## 4272    19.5    VT
    ## 4397    19.1    WA
    ## 4556    19.3    WI
    ## 4465    18.2    WV
    ## 4634    18.3    WY

``` r
rankall("heart failure", "worst")
```

    ##                                              Hospital Outcome state
    ## 102                       FAIRBANKS MEMORIAL HOSPITAL    15.6    AK
    ## 8                      DEKALB REGIONAL MEDICAL CENTER    16.6    AL
    ## 234                     NEA BAPTIST MEMORIAL HOSPITAL    17.2    AR
    ## 141                 MT GRAHAM REGIONAL MEDICAL CENTER    14.0    AZ
    ## 473                   CLOVIS COMMUNITY MEDICAL CENTER    15.9    CA
    ## 623            CENTURA HEALTH-ST THOMAS MORE HOSPITAL    15.4    CO
    ## 704                      MANCHESTER MEMORIAL HOSPITAL    16.0    CT
    ## 719                              BEEBE MEDICAL CENTER    11.7    DE
    ## 749                         MANATEE MEMORIAL HOSPITAL    15.6    FL
    ## 961                    COFFEE REGIONAL MEDICAL CENTER    15.7    GA
    ## 1042                     MAUI MEMORIAL MEDICAL CENTER    15.1    HI
    ## 1492                            BOONE COUNTY HOSPITAL    16.4    IA
    ## 1069                          KOOTENAI MEDICAL CENTER    17.5    ID
    ## 1266                        SPARTA COMMUNITY HOSPITAL    16.1    IL
    ## 1274      INDIANA UNIVERSITY HEALTH LA PORTE HOSPITAL    16.3    IN
    ## 1538                     SOUTH CENTRAL KS  MED CENTER    15.0    KS
    ## 1707                          CALDWELL MEDICAL CENTER    16.8    KY
    ## 1825                   ABROM KAPLAN MEMORIAL HOSPITAL    16.4    LA
    ## 1952                                 EMERSON HOSPITAL    14.3    MA
    ## 1881                 GARRETT COUNTY MEMORIAL HOSPITAL    14.0    MD
    ## 1864             SEBASTICOOK VALLEY HOSPITAL (HEALTH)    14.2    ME
    ## 2038                              MEMORIAL HEALTHCARE    15.4    MI
    ## 2151              MAYO CLINIC HEALTH SYSTEM - MANKATO    14.9    MN
    ## 2409                   COMMUNITY HOSPITAL ASSOCIATION    15.3    MO
    ## 2249                 NORTH MISSISSIPPI MEDICAL CENTER    15.4    MS
    ## 2438                              ST PETER'S HOSPITAL    14.8    MT
    ## 2969                            THE MCDOWELL HOSPITAL    15.6    NC
    ## 3039                                TRINITY HOSPITALS    13.3    ND
    ## 2505           ALEGENT HEALTH IMMANUEL MEDICAL CENTER    15.8    NE
    ## 2629                       FRANKLIN REGIONAL HOSPITAL    16.1    NH
    ## 2669                          SOMERSET MEDICAL CENTER    14.0    NJ
    ## 2705                 SAN JUAN REGIONAL MEDICAL CENTER    15.6    NM
    ## 2588             SAINT MARY'S REGIONAL MEDICAL CENTER    14.7    NV
    ## 2892                  CAYUGA MEDICAL CENTER AT ITHACA    15.6    NY
    ## 3142               COSHOCTON COUNTY MEMORIAL HOSPITAL    16.3    OH
    ## 3294                          INTEGRIS GROVE HOSPITAL    16.2    OK
    ## 3395                         ADVENTIST MEDICAL CENTER    18.1    OR
    ## 3483                       SUNBURY COMMUNITY HOSPITAL    16.5    PA
    ## 3660                        SOUTH COUNTY HOSPITAL INC    15.6    RI
    ## 3711                    AIKEN REGIONAL MEDICAL CENTER    15.6    SC
    ## 3739                      SPEARFISH REGIONAL HOSPITAL    14.7    SD
    ## 3821                   ATHENS REGIONAL MEDICAL CENTER    17.4    TN
    ## 3975                                    ETMC CARTHAGE    15.8    TX
    ## 4228                              CASTLEVIEW HOSPITAL    16.0    UT
    ## 4322 MEMORIAL HOSPITAL OF MARTINSVILLE & HENRY COUNTY    15.1    VA
    ## 4263               FLETCHER ALLEN HOSPITAL OF VERMONT    16.2    VT
    ## 4441                              MID VALLEY HOSPITAL    16.7    WA
    ## 4528                             ST NICHOLAS HOSPITAL    15.1    WI
    ## 4470                       OHIO VALLEY MEDICAL CENTER    14.3    WV
    ## 4638                           WYOMING MEDICAL CENTER    14.3    WY

``` r
rankall("pneumonia", "worts")
```

    ## [1] hospital state   
    ## <0 rows> (or 0-length row.names)
