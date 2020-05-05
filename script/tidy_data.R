library(tidyverse)

# Downloads and unzips file usinfg default method = "curl" and unzip = TRUE
#
# Args:
#   url: file url
#   file.name: destination file name
#   method: defaults to "curl"
#   unzip: if TRUE, then attempts to unzip
#
# Returns:
#
# Error handling:
#
#
#
hm.file.download <- function(url, file.name, method = "curl", unzip = TRUE) {
  if (!file.exists(file.name)) {
    print(paste("downloading : ", file.name))
    download.file(url, destfile = file.name, method = method)
  } else {
    print(paste("file exist: ", file.name))
  }
  
  file_name <- strsplit(file.name, "\\.")
  
  if (unzip & !file.exists(file_name[[1]][[1]])) {
    print(paste("unzipping: ", file.name))
    unzip(file_name[[1]][[1]],list = TRUE)
  } else {
    print("no action: already unzipped")
  }
}

# Loads .csv or .txt files from specified directory
# while ignoring files in ignore.files
#
# Args:
#   directory: Base dorectory from where to load files
#   ignore.files: List of files to ignore - don't load
#   na.rm: if TRUE, then only complete records are included
#   pattern: allowable file extension : ".txt" or ".csv"
#
# Returns:
#   list" list contaiing data.frames of loaded files
#
# Error handling:
#
#
hm.file.load <- function(directory, ignore.files, na.rm = FALSE, pattern = ".csv") {
  data.list <- list()
  
  allowable_pattern <- c(".csv", ".txt")
  
  if (length(allowable_pattern[which(allowable_pattern == pattern)]) != 1) {
    stop(call. = FALSE, "invalid pattern")
  }
  
  # list to save files
  data.filenames <- list.files(path = directory, pattern)
  
  print(paste("Loading from: ", directory, " : ", (length(data.filenames)), " data file(s)"))
  
  data.content <- data.frame()
  
  for (i in 1:length(data.filenames)) {
    if (length(ignore.files[which(ignore.files == data.filenames[i])]) == 0) {
      filename <- paste(directory, "/", data.filenames[i], sep = "")
      
      if (pattern == ".csv") {
        data.list[[data.filenames[i]]] <- read.csv(filename, stringsAsFactors = FALSE, header = FALSE) %>% tbl_df()
      } else if (pattern == ".txt") {
        data.list[[data.filenames[i]]] <- read.table(filename, stringsAsFactors = FALSE, header = FALSE) %>% tbl_df()
      }
    }
  }
  
  if (na.rm == TRUE) {
    print("Removing NA(s)")
    is.complete <- complete.cases(data.content)
    
    return(data.content[is.complete, ][, ])
  }
  
  return(data.list)
}

# Loads UCI HAR Dataset : Training, Test, Subject, Features and Activity Labels
#
# Args:
#
# Returns:
#   list: list contaiing data.frames of loaded files
#
# Error handling:
#
#
run_analysis_step1 <- function() {
  print("Step1: Loading Training and Test Datasets")
  
  data.list <- list()
  
  file.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  file.name <- "data/zipped-data/wearable-data.zip"
  
  if (!file.exists(file.name)) {
    download.file(file.url, destfile = file.name)
  }
  
  if (!file.exists(file.name)) {
    unzip(file.name)
  }
  
  folders <- c("data/UCI HAR Dataset/train", "data/UCI HAR Dataset/test", "UCI HAR Dataset")
  
  ignore <- c("features_info.txt", "README.txt")
  
  for (folder in folders) {
    data.list[[folder]] <- hm.file.load(directory = folder, ignore, pattern = ".txt")
  }
  
  #data.list2 <- list()
  
  #for (x in data.list) {
   # ref <- names(as.list(x))
    
    #for (z in ref) {
     # data.list2[z] <- x[z]
    #}
  #}
  
  print("Step1: DONE")
  return(data)
  #invisible(data.list2)
}

# Merges UCI HAR Dataset : Training, Test, Subject, Features and Activity Labels
# to create one tidy data set
# - Uses descriptive activity names to name the activities in the data set
# - Appropriately labels the data set with descriptive variable names.
# - Extracts only the measurements on the mean and standard deviation
#   for each measurement.
# Args:
#
# Returns:
#   data: Merge Results of the training and the test sets.
#
# Error handling:
#
#
run_analysis_step2 <- function(data) {
  print("STEP2 : BEGIN")
  print("BEGIN: 2.1 Merge the training dataset")
  
  # Sets descriptive column names : Activity, X_Train, Y_Train and Subject_Train
  names(data$activity_labels.txt) <- c("Activity_Id", "Activity")
  features <- gsub("([()])", "", data$features$V2)
  
  names(data$X_train.txt) <- features
  
  # Make syntactically valid names out of character vectors.
  new_col_names <- make.names(names(data$X_train.txt), unique = TRUE, allow_ = TRUE)
  
  # Make names more descriptive
  new_col_names <- gsub("^t", "time", new_col_names)
  new_col_names <- gsub("^f", "frequency", new_col_names)
  new_col_names <- gsub(".mean", "Mean", new_col_names)
  new_col_names <- gsub(".std", "Std", new_col_names)
  new_col_names <- gsub(".gravity", "Gravity", new_col_names)
  new_col_names <- gsub("Freq", "Frequency", new_col_names)
  new_col_names <- gsub("Mag", "Magnitude", new_col_names)
  new_col_names <- gsub("Gyro", "Gyroscope", new_col_names)
  new_col_names <- gsub("Acc", "Accelerometer", new_col_names)
  
  
  names(data$X_train.txt) <- new_col_names
  
  names(data$y_train.txt) <- "Activity_Id"
  names(data$subject_train.txt) <- "Subject"
  
  # column bind all training datasets
  train <- cbind(
    data$X_train.txt, data$subject_train.txt,
    inner_join(data$activity_labels.txt, data$y_train.txt)
  )
  
  print("DONE: 2.1 Merge the training dataset")
  
  print("BEGIN: 2.2 Merge the test dataset")
  
  # Sets descriptive column names : X_Test, Y_Test and Subject_Test
  names(data$X_test.txt) <- new_col_names
  names(data$y_test.txt) <- "Activity_Id"
  names(data$subject_test.txt) <- "Subject"
  
  # column bind all test datasets
  test <- cbind(data$y_test.txt, data$subject_test.txt)
  test <- cbind(
    data$X_test.txt, data$subject_test.txt,
    (inner_join(data$activity_labels.txt, data$y_test.txt))
  )
  
  print("DONE: 2.2 Merge the test dataset")
  
  print("BEGIN: 2.3 Merge the training and the test sets to create one data set.")
  
  # row bind all datasets: traiing and test
  data <- tbl_df(rbind(train, test))
  
  print("DONE: 2.3 Merge the training and the test sets to create one data set.")
  print("STEP2 : DONE")
  invisible(data)
}

################################################################################
################################################################################
################################################################################
# **** MAIN Executable Function ****
#
# Merges UCI HAR Dataset : Training, Test, Subject, Features and Activity Labels
# to create one tidy data set
# Processing
# (1) Merges the training and the test sets to create one data set.
# (2) Extracts only the measurements on the mean and standard deviation
#     for each measurement.
# (3) Uses descriptive activity names to name the activities in the data set
# (4) Appropriately labels the data set with descriptive variable names.
# (5) From the data set in step 4, creates a second, independent tidy data set
#     with the average of each variable for each activity and each subject.
# Args:
#   write.file: if TRUE, write output to text file
#   output.file: output file name for results
# Returns:
#   list: list contaiing tidy data.frame with the average of each variable
#         for each activity and each subject.
#
# Error handling:
#
run_analysis <- function() {
  
  # creates a second, independent tidy data set
  #     with the average of each variable for each activity and each subject.
  
  print("extracting only the measurements on the mean and standard deviation")
  
  
  # Load data and select measurments only and Activity and Subject
  data <- run_analysis_step1() %>%
    run_analysis_step2() %>%
    select(
      contains("mean"), contains("std"),
      contains("Activity"), contains("Subject"), -(contains("angle"))
    )
  
  print("grouping by Activity and Subject")
  print("summarise_all(funs(mean))")
  
  # Arrange and Group by activity and subject
  arrange(data, Activity, Subject)
  tidy_data_means_std <- data %>%
    group_by(Activity, Subject) %>%
    summarise_all(funs(mean))
  
  # re-order columns
  tidy_data_means_std <- select(tidy_data_means_std, Activity_Id, Activity, Subject, timeBodyAccelerometerMean.X:frequencyBodyBodyGyroscopeJerkMagnitudeStd)
  
  # write tidy dataframe to txt file
  write.table(tidy_data_means_std, "tidy_data.txt", row.names = FALSE, quote = FALSE)
  
  # return tidy dataframe
  return(tidy_data_means_std)
}