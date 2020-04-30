Assignment \#1 Air Pollution
================
Hugo O. Matus

-----

#### Datascience Specialization Course: John Hopkins University

-----

#### Data

The zip file containing the data can be downloaded here:
[specdata.zip](https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip)
2.4MB

The zip file contains 332 comma-separated-value (CSV) files containing
pollution monitoring data for fine particulate matter (PM) air pollution
at 332 locations in the United States. Each file contains data from a
single monitor and the ID number for each monitor is contained in the
file name. For example, data for monitor 200 is contained in the file
“200.csv”.

Each file contains three variables:

  - Date: the date of the observation in YYYY-MM-DD format
    (year-month-day)
  - sulfate: the level of sulfate PM in the air on that date (measured
    in micrograms per cubic meter)
  - nitrate: the level of nitrate PM in the air on that date (measured
    in micrograms per cubic meter)

For this programming assignment you will need to unzip this file and
create the directory ‘specdata’. Once you have unzipped the zip file, do
not make any modifications to the files in the ‘specdata’ directory. In
each file you’ll notice that there are many days where either sulfate or
nitrate (or both) are missing (coded as NA). This is common with air
pollution monitoring data in the United States.

-----

#### Part 1

Write a function named ‘pollutantmean’ that calculates the mean of a
pollutant (sulfate or nitrate) across a specified list of monitors. The
function ‘pollutantmean’ takes three arguments: ‘directory’,
‘pollutant’, and ‘id’. Given a vector monitor ID numbers,
‘pollutantmean’ reads that monitors’ particulate matter data from the
directory specified in the ‘directory’ argument and returns the mean of
the pollutant across all of the monitors, ignoring any missing values
coded as NA.

  - A prototype of the function is as follows

<!-- end list -->

``` r
pollutantmean <- function(directory, pollutant, id = 1:2) {
  
  ## 'directory' character vector of length 1 indicating the location of the csv.
  ## 'pollutant' character vector indicating the name of the pollutant for which we will calculate the mean.
  ## 'id' integer vector indicating the montor id to use.
  ## Return the mean of the pollutant cross all monitors.

  ##"Date","sulfate","nitrate","ID"
  
  old.dir <- getwd()
  setwd(directory) 
  
  data <- data.frame()
  
  for (val in id) {
    if (val < 10) {
      data <- rbind(data,read.csv(paste("00",val,".csv", sep = ""),na.strings = "NA"))
    } else if ( val < 100) {
      data <- rbind(data,read.csv(paste("0",val,".csv", sep = ""),na.strings = "NA"))
    } else {
      data <- rbind(data,read.csv(paste(val,".csv", sep = ""),na.strings = "NA"))
    }
  }
  
  #data <- data[complete.cases(data[pollutant]),][pollutant]
  avg <- mean(data[,pollutant],na.rm = TRUE)
  setwd(old.dir)
  avg
}
```

You can see some example output from this function below. The function
that you write should be able to match this output. Please save your
code to a file named pollutantmean.R.

``` r
source("script/pollutantmean.R")
pollutantmean("data/specdata", "sulfate", 1:10)
```

    ## [1] 4.064128

``` r
pollutantmean("data/specdata", "nitrate", 70:72)
```

    ## [1] 1.706047

``` r
pollutantmean("data/specdata", "nitrate", 23)
```

    ## [1] 1.280833

-----

#### Part 2

Write a function that reads a directory full of files and reports the
number of completely observed cases in each data file. The function
should return a data frame where the first column is the name of the
file and the second column is the number of complete cases. A prototype
of this function follows

``` r
complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating the location of the CSV files
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## Return a data frame of the form:
  ## id  nodbs
  ## 1  117
  ## 2 1041
  ## ...
  ## where 'id' is the monitor ID number and the nobs is the number of complete cases
  
  old.dir <- getwd()
  setwd(directory) 
  
  data_cc <- data.frame()
  
  for (val in id) {
    data <- data.frame()
       if (val < 10) {
      data <- rbind(data,read.csv(paste("00",val,".csv", sep = ""),na.strings = "NA"))
    } else if ( val < 100) {
      data <- rbind(data,read.csv(paste("0",val,".csv", sep = ""),na.strings = "NA"))
    } else {
      data <- rbind(data,read.csv(paste(val,".csv", sep = ""),na.strings = "NA"))
    }
    data_cc <- rbind(data_cc,c(id = val,nobs = sum(complete.cases(data))))
  }
  
  setwd(old.dir)  
  #data <- data[complete.cases(data),]
  names(data_cc) <- c("id","nobs")
  data_cc
}
```

You can see some example output from this function below. The function
that you write should be able to match this output. Please save your
code to a file named complete.R. To run the submit script for this part,
make sure your working directory has the file complete.R in it.

    ##   id nobs
    ## 1  1  117

    ##   id nobs
    ## 1  2 1041
    ## 2  4  474
    ## 3  8  192
    ## 4 10  148
    ## 5 12   96

    ##   id nobs
    ## 1 30  932
    ## 2 29  711
    ## 3 28  475
    ## 4 27  338
    ## 5 26  586
    ## 6 25  463

    ##   id nobs
    ## 1  3  243

-----

#### Part 3

Write a function that takes a directory of data files and a threshold
for complete cases and calculates the correlation between sulfate and
nitrate for monitor locations where the number of completely observed
cases (on all variables) is greater than the threshold. The function
should return a vector of correlations for the monitors that meet the
threshold requirement. If no monitors meet the threshold requirement,
then the function should return a numeric vector of length 0. A
prototype of this function follows

``` r
corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating the location of the CSV files
  ## 'threshold' is the numeric vector of length 1 indicating the number of completely observed obervations
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the results
  
  # vector to hold results of cor()
  results <- c(0)
  
  old.dir <- getwd()
  setwd(directory)
  
  data_cc <- data.frame()
  
  id <- 1:332
  
  count <- 0
  
  for (val in id) {
    data <- data.frame()
    if (val < 10) {
      data <-
        rbind(data, read.csv(paste("00", val, ".csv", sep = ""), na.strings = "NA"))
    } else if (val < 100) {
      data <-
        rbind(data, read.csv(paste("0", val, ".csv", sep = ""), na.strings = "NA"))
    } else {
      data <-
        rbind(data, read.csv(paste(val, ".csv", sep = ""), na.strings = "NA"))
    }
    
    num_complete_cases <- sum(complete.cases(data))
    
    if (num_complete_cases > threshold) {
      data_cc <- data[complete.cases(data),]
      
      
      x <- data_cc[, 2]
      y <- data_cc[, 3]
      
      z <- cor(x,
               y,
               use = "complete.obs",
               method = c("pearson", "kendall", "spearman"))
      
      if (count != 0) {
        results <- c(results, z)
      } else {
        results <- c(z)
      }
      count <- count + 1
    }
    
  }
  setwd(old.dir)
  
  return(results)
}
```

For this function you will need to use the ‘cor’ function in R which
calculates the correlation between two vectors. Please read the help
page for this function via ‘?cor’ and make sure that you know how to use
it.

You can see some example output from this function below. The function
that you write should be able to approximately match this output. Note
that because of how R rounds and presents floating point numbers, the
output you generate may differ slightly from the example output. Please
save your code to a file named corr.R. To run the submit script for this
part, make sure your working directory has the file corr.R in it.

``` r
source("script/pollutantmean.R")
cr <- corr("data/specdata", 150)
head(cr)
```

    ## [1] -0.01895754 -0.14051254 -0.04389737 -0.06815956 -0.12350667 -0.07588814

``` r
summary(cr)
```

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ## -0.21057 -0.04999  0.09463  0.12525  0.26844  0.76313

``` r
cr <- corr("data/specdata", 400)
head(cr)
```

    ## [1] -0.01895754 -0.04389737 -0.06815956 -0.07588814  0.76312884 -0.15782860

``` r
summary(cr)
```

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ## -0.17623 -0.03109  0.10021  0.13969  0.26849  0.76313

``` r
cr <- corr("data/specdata", 5000)
head(cr)
```

    ## [1] 0

``` r
summary(cr)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##       0       0       0       0       0       0

``` r
cr <- corr("data/specdata")
head(cr)
```

    ## [1] -0.22255256 -0.01895754 -0.14051254 -0.04389737 -0.06815956 -0.12350667

``` r
summary(cr)
```

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ## -1.00000 -0.05282  0.10718  0.13684  0.27831  1.00000