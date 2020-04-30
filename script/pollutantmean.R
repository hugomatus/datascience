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
      data <-
        rbind(data, read.csv(paste("00", val, ".csv", sep = ""), na.strings = "NA"))
    } else if (val < 100) {
      data <-
        rbind(data, read.csv(paste("0", val, ".csv", sep = ""), na.strings = "NA"))
    } else {
      data <-
        rbind(data, read.csv(paste(val, ".csv", sep = ""), na.strings = "NA"))
    }
  }
  #data <- data[complete.cases(data[pollutant]),][pollutant]
  avg <- mean(data[, pollutant], na.rm = TRUE)
  setwd(old.dir)
  
  return(avg)
}


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
      data <-
        rbind(data, read.csv(paste("00", val, ".csv", sep = ""), na.strings = "NA"))
    } else if (val < 100) {
      data <-
        rbind(data, read.csv(paste("0", val, ".csv", sep = ""), na.strings = "NA"))
    } else {
      data <-
        rbind(data, read.csv(paste(val, ".csv", sep = ""), na.strings = "NA"))
    }
    data_cc <-
      rbind(data_cc, c(id = val, nobs = sum(complete.cases(data))))
  }
  
  setwd(old.dir)
  #data <- data[complete.cases(data),]
  names(data_cc) <- c("id", "nobs")
  
  return(data_cc)
}


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
