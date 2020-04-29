pollutantmean <- function(directory, pollutant, id = 1:2) {
  
  ## 'directory' character vector of length 1 indicating the location of the csv.
  ## 'pollutant' character vector indicating the name of the pollutant for which we will calculate the mean.
  ## 'id' integer vector indicating the montor id to use.
  ## Return the mean of the pollutant cross all monitors.

  ##"Date","sulfate","nitrate","ID"
  
  old.dir <- getwd()
  setwd("data/specdata/") 
  
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


