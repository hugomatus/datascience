load_files <- function(data.dir, id = 1:332) {
  data.file.names <- sort(list.files(data.dir), decreasing = FALSE)
  
  data <- data.frame()
  
  for (val in id) {
    #print(data.file.names[val])
    file.path.name <-
      paste(data.dir, data.file.names[val], sep = "")
    data <-
      rbind(data, read.csv(file.path.name, na.strings = "NA"))
  }
  
  return(data)
}

pollutantmean <- function(directory, pollutant, id = 1:2) {
  ## 'directory' character vector of length 1 indicating the location of the csv.
  ## 'pollutant' character vector indicating the name of the pollutant for which we will calculate the mean.
  ## 'id' integer vector indicating the montor id to use.
  ## Return the mean of the pollutant cross all monitors.
  
  ##"Date","sulfate","nitrate","ID"
  
  data <- load_files(directory, id)
  avg <- mean(data[, pollutant], na.rm = TRUE)
  
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
  
  #load files, extract complete cases only and split by monitor id
  data <- load_files(directory, id)
  data <- data[complete.cases(data),]
  data <- split(data, data$ID)
  
  results <- c()
  
  for (item in data) {
    #pop monitor_id off the col with name ID
    monitor_id <- item[1, 'ID']
    num_obs <- nrow(item)
    results <- rbind(results, c(id = monitor_id, nobs = num_obs))
  }
  
  return(results)
}

complete_threshold <-
  function(directory,
           id = 1:332,
           threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating the location of the CSV files
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## Return a data frame of the form:
    
    #load files, extract complete cases only and split by monitor id
    data <- load_files(directory, id)
    data <- data[complete.cases(data),]
    data <- split(data, data$ID)
    
    results <- c()
    
    for (item in data) {
      #pop monitor_id off the col with name ID
      monitor_id <- item[1, 'ID']
      num_obs <- nrow(item)
      
      if (num_obs > threshold) {
        results <- rbind(results, item)
      }
    }
    
    return(results)
  }

corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating the location of the CSV files
  ## 'threshold' is the numeric vector of length 1 indicating the number of completely observed obervations
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the results
  
  # vector to hold results of cor()
  id <- 1:332
  results <- NULL
  data <- complete_threshold(directory, id, threshold)
  
  data_by_id <- NULL
  
  if (!is.null(data)) {
    data_by_id <- split(data, data$ID)
  }
  
  for (item in data_by_id) {
    x <- item[, 2]
    y <- item[, 3]
    
    z <- cor(x,
             y,
             use = "complete.obs",
             method = c("pearson", "kendall", "spearman"))
    
    results <- c(results, z)
  }
  
  return(results)
}

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

#---


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


