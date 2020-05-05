Assignment \#4
================
Hugo O. Matus

##### Datascience Specialization Course: John Hopkins University

-----

#### Purpose

The purpose of this project is to demonstrate your ability to collect,
work with, and clean a data set. The goal is to prepare tidy data that
can be used for later analysis. You will be graded by your peers on a
series of yes/no questions related to the project.

#### Review Criteria

  - The submitted data set is tidy.
  - The Github repo contains the required scripts.
  - GitHub contains a code book that modifies and updates the available
    codebooks with the data to indicate all the variables and summaries
    calculated, along with units, and any other relevant information.
  - The README that explains the analysis files is clear and
    understandable.
  - The work submitted for this project is the work of the student who
    submitted it.
  - Getting and Cleaning Data Course Project

#### You will be required to submit:

  - a tidy data set as described below,
  - a link to a Github repository with your script for performing the
    analysis, and
  - a code book that describes the variables, the data, and any
    transformations or work that you performed to clean up the data
    called CodeBook.md.
  - You should also include a README.md in the repo with your scripts.
    This repo explains how all of the scripts work and how they are
    connected.

One of the most exciting areas in all of data science right now is
wearable computing - see for example this article . Companies like
Fitbit, Nike, and Jawbone Up are racing to develop the most advanced
algorithms to attract new users. The data linked to from the course
website represent data collected from the accelerometers from the
Samsung Galaxy S smartphone. A full description is available at the site
where the data was
obtained:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

Here are the data for the
project:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

You should create one R script called run\_analysis.R that does the
following.

  - Merges the training and the test sets to create one data set.
  - Extracts only the measurements on the mean and standard deviation
    for each measurement.
  - Uses descriptive activity names to name the activities in the data
    set
  - Appropriately labels the data set with descriptive variable names.
  - From the data set in step 4, creates a second, independent tidy data
    set with the average of each variable for each activity and each
    subject.

Good luck\!

-----

TIDYNG DATA
STEPS

-----

#### Step 1: Merges the training and the test sets to create one data set.

##### Download Wearable Data Set

``` r
setwd("~/datascience/")
dest.file <- "data/zipped-data/wearable-data.zip"
file.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists(dest.file)) {
  download.file(url = file.url,destfile = dest.file,quiet = TRUE,method = "curl")
}
```

##### List Files included in Wearable Dataset

``` r
setwd("~/datascience/")
dir.extracted.to <- "data/UCI HAR Dataset"

if (!file.exists(dir.extracted.to)) {
  unzip(zipfile = dest.file,list = TRUE, exdir = "data/")
} else (
  list.files("data/UCI HAR Dataset")
)
```

    ## [1] "activity_labels.txt" "features_info.txt"   "features.txt"       
    ## [4] "README.txt"          "test"                "train"

##### Extract Files included in Wearable Dataset

``` r
setwd("~/datascience/")
extract.dir <- "data/"
unzip(zipfile = dest.file,list = FALSE,exdir = extract.dir, overwrite = TRUE)
```

##### Loading Training Dataset(s)

  - x\_train.txt
  - y\_train.txt
  - subject\_train.txt
  - activity\_labels.txt

##### Loading Training Dataset: x\_train

``` r
setwd("~/datascience/")
file.name.x_train <- "data/UCI HAR Dataset/train/X_train.txt"

x_train <- read.table(file.name.x_train,header = FALSE)
dim(x_train)
```

    ## [1] 7352  561

##### Loading Training Dataset: y\_train

``` r
setwd("~/datascience/")
file.name.y_train <- "data/UCI HAR Dataset/train/y_train.txt"

y_train <- read.table(file.name.y_train,header = FALSE)
dim(y_train)
```

    ## [1] 7352    1

``` r
str(y_train)
```

    ## 'data.frame':    7352 obs. of  1 variable:
    ##  $ V1: int  5 5 5 5 5 5 5 5 5 5 ...

``` r
head(y_train,3)
```

    ##   V1
    ## 1  5
    ## 2  5
    ## 3  5

##### Loading Training Dataset: subject\_train

``` r
setwd("~/datascience/")
file.name.subject_train <- "data/UCI HAR Dataset/train/subject_train.txt"

subject_train <- read.table(file.name.subject_train,header = FALSE)
dim(subject_train)
```

    ## [1] 7352    1

``` r
str(subject_train)
```

    ## 'data.frame':    7352 obs. of  1 variable:
    ##  $ V1: int  1 1 1 1 1 1 1 1 1 1 ...

``` r
head(subject_train,3)
```

    ##   V1
    ## 1  1
    ## 2  1
    ## 3  1

##### Loading Training Dataset: features

``` r
setwd("~/datascience/")
file.name.features <- "data/UCI HAR Dataset/features.txt"

features <- read.table(file.name.features,header = FALSE)

dim(features)
```

    ## [1] 561   2

``` r
str(features)
```

    ## 'data.frame':    561 obs. of  2 variables:
    ##  $ V1: int  1 2 3 4 5 6 7 8 9 10 ...
    ##  $ V2: Factor w/ 477 levels "angle(tBodyAccJerkMean),gravityMean)",..: 243 244 245 250 251 252 237 238 239 240 ...

``` r
head(features,3)
```

    ##   V1                V2
    ## 1  1 tBodyAcc-mean()-X
    ## 2  2 tBodyAcc-mean()-Y
    ## 3  3 tBodyAcc-mean()-Z

``` r
#load activity labels
setwd("~/datascience/")
file.name.activity_labels <- "data/UCI HAR Dataset/activity_labels.txt"
activity_labels <- read.table(file.name.activity_labels,header = FALSE)
dim(activity_labels)
```

    ## [1] 6 2

``` r
str(activity_labels)
```

    ## 'data.frame':    6 obs. of  2 variables:
    ##  $ V1: int  1 2 3 4 5 6
    ##  $ V2: Factor w/ 6 levels "LAYING","SITTING",..: 4 6 5 2 3 1

``` r
head(activity_labels,3)
```

    ##   V1                 V2
    ## 1  1            WALKING
    ## 2  2   WALKING_UPSTAIRS
    ## 3  3 WALKING_DOWNSTAIRS

##### Setting descriptive feature names on : x\_train

``` r
setwd("~/datascience/")

#replace '(' and ')' with empty space ''
feature_names <- gsub("([()])", "", features$V2)

# Make syntactically valid names out of character vectors.
feature_names <- make.names(feature_names, unique = TRUE, allow_ = TRUE)

# Make names more descriptive
feature_names <- gsub("^t", "time", feature_names)
feature_names <- gsub("^f", "frequency", feature_names)
feature_names <- gsub(".mean", "Mean", feature_names)
feature_names <- gsub(".std", "Std", feature_names)
feature_names <- gsub(".gravity", "Gravity", feature_names)
feature_names <- gsub("Freq", "Frequency", feature_names)
feature_names <- gsub("Mag", "Magnitude", feature_names)
feature_names <- gsub("Gyro", "Gyroscope", feature_names)
feature_names <- gsub("Acc", "Accelerometer", feature_names)

# set feature labels on x_train
names(x_train) <- feature_names
```

##### Setting descriptive feature names and merging all Training dataset(s)

``` r
setwd("~/datascience/")
names(activity_labels) <- c("Activity_Id", "Activity")
names(y_train) <- "Activity_Id"
names(subject_train) <- "Subject"


# column bind all training datasets
train <- cbind(
  x_train,
  subject_train,
  inner_join(activity_labels, y_train)
)
```

    ## Joining, by = "Activity_Id"

##### Loading Test Dataset(s) and Merging

  - x\_test.txt
  - y\_test.txt
  - subject\_ttest.txt

##### Loading Test Dataset: x\_test

``` r
setwd("~/datascience/")
file.name.x_test <- "data/UCI HAR Dataset/test/X_test.txt"

x_test <- read.table(file.name.x_test,header = FALSE)
dim(x_test)
```

    ## [1] 2947  561

##### Loading Test Dataset: y\_test

``` r
setwd("~/datascience/")
file.name.y_test <- "data/UCI HAR Dataset/test/y_test.txt"

y_test <- read.table(file.name.y_test,header = FALSE)
dim(y_test)
```

    ## [1] 2947    1

``` r
str(y_test)
```

    ## 'data.frame':    2947 obs. of  1 variable:
    ##  $ V1: int  5 5 5 5 5 5 5 5 5 5 ...

``` r
head(y_test,3)
```

    ##   V1
    ## 1  5
    ## 2  5
    ## 3  5

##### Loading Test Dataset: subject\_test

``` r
setwd("~/datascience/")
file.name.subject_test <- "data/UCI HAR Dataset/test/subject_test.txt"

subject_test <- read.table(file.name.subject_test,header = FALSE)
dim(subject_test)
```

    ## [1] 2947    1

``` r
str(subject_test)
```

    ## 'data.frame':    2947 obs. of  1 variable:
    ##  $ V1: int  2 2 2 2 2 2 2 2 2 2 ...

``` r
head(subject_test,3)
```

    ##   V1
    ## 1  2
    ## 2  2
    ## 3  2

##### Setting descriptive feature names and merging all Test dataset(s)

``` r
setwd("~/datascience/")


# Sets descriptive column names : X_Test, Y_Test and Subject_Test
names(x_test) <- feature_names
names(y_test) <- "Activity_Id"
names(subject_test) <- "Subject"

# column bind all test datasets
test <- cbind(y_test, subject_test)
test <- cbind(x_test, subject_test,
              (inner_join(activity_labels, y_test)))
```

    ## Joining, by = "Activity_Id"

``` r
dim(test)
```

    ## [1] 2947  564

##### Merging all Training and Test dataset(s)

``` r
setwd("~/datascience/")

data_set <- tbl_df(rbind(train, test))
```

#### Step 2: Extract only the measurements on the mean and standard deviation for each measurement.

##### Select Feature Subset, Arrange/Group by Activity and Subject

``` r
data_set_mean_std <- select(
  data_set,
  contains("mean"),
  contains("std"),
  contains("Activity"),
  contains("Subject"),
  -(contains("angle"))
)


# Arrange and Group by activity and subject
arrange(data_set_mean_std, Activity, Subject)
```

    ## # A tibble: 10,299 x 82
    ##    timeBodyAcceler… timeBodyAcceler… timeBodyAcceler… timeGravityAcce…
    ##               <dbl>            <dbl>            <dbl>            <dbl>
    ##  1            0.274         -0.0218           -0.102             0.875
    ##  2            0.281         -0.0113           -0.103             0.875
    ##  3            0.381          0.0505            0.0691            0.798
    ##  4            0.267         -0.0196            0.0746            0.834
    ##  5            0.313          0.00368          -0.0501            0.837
    ##  6            0.277         -0.0179           -0.108             0.847
    ##  7            0.272         -0.0196           -0.132             0.848
    ##  8            0.281         -0.0158           -0.144             0.846
    ##  9            0.275         -0.0243           -0.137             0.846
    ## 10            0.279         -0.0156           -0.105             0.846
    ## # … with 10,289 more rows, and 78 more variables:
    ## #   timeGravityAccelerometerMean.Y <dbl>, timeGravityAccelerometerMean.Z <dbl>,
    ## #   timeBodyAccelerometerJerkMean.X <dbl>,
    ## #   timeBodyAccelerometerJerkMean.Y <dbl>,
    ## #   timeBodyAccelerometerJerkMean.Z <dbl>, timeBodyGyroscopeMean.X <dbl>,
    ## #   timeBodyGyroscopeMean.Y <dbl>, timeBodyGyroscopeMean.Z <dbl>,
    ## #   timeBodyGyroscopeJerkMean.X <dbl>, timeBodyGyroscopeJerkMean.Y <dbl>,
    ## #   timeBodyGyroscopeJerkMean.Z <dbl>,
    ## #   timeBodyAccelerometerMagnitudeMean <dbl>,
    ## #   timeGravityAccelerometerMagnitudeMean <dbl>,
    ## #   timeBodyAccelerometerJerkMagnitudeMean <dbl>,
    ## #   timeBodyGyroscopeMagnitudeMean <dbl>,
    ## #   timeBodyGyroscopeJerkMagnitudeMean <dbl>,
    ## #   frequencyBodyAccelerometerMean.X <dbl>,
    ## #   frequencyBodyAccelerometerMean.Y <dbl>,
    ## #   frequencyBodyAccelerometerMean.Z <dbl>,
    ## #   frequencyBodyAccelerometerMeanFrequency.X <dbl>,
    ## #   frequencyBodyAccelerometerMeanFrequency.Y <dbl>,
    ## #   frequencyBodyAccelerometerMeanFrequency.Z <dbl>,
    ## #   frequencyBodyAccelerometerJerkMean.X <dbl>,
    ## #   frequencyBodyAccelerometerJerkMean.Y <dbl>,
    ## #   frequencyBodyAccelerometerJerkMean.Z <dbl>,
    ## #   frequencyBodyAccelerometerJerkMeanFrequency.X <dbl>,
    ## #   frequencyBodyAccelerometerJerkMeanFrequency.Y <dbl>,
    ## #   frequencyBodyAccelerometerJerkMeanFrequency.Z <dbl>,
    ## #   frequencyBodyGyroscopeMean.X <dbl>, frequencyBodyGyroscopeMean.Y <dbl>,
    ## #   frequencyBodyGyroscopeMean.Z <dbl>,
    ## #   frequencyBodyGyroscopeMeanFrequency.X <dbl>,
    ## #   frequencyBodyGyroscopeMeanFrequency.Y <dbl>,
    ## #   frequencyBodyGyroscopeMeanFrequency.Z <dbl>,
    ## #   frequencyBodyAccelerometerMagnitudeMean <dbl>,
    ## #   frequencyBodyAccelerometerMagnitudeMeanFrequency <dbl>,
    ## #   frequencyBodyBodyAccelerometerJerkMagnitudeMean <dbl>,
    ## #   frequencyBodyBodyAccelerometerJerkMagnitudeMeanFrequency <dbl>,
    ## #   frequencyBodyBodyGyroscopeMagnitudeMean <dbl>,
    ## #   frequencyBodyBodyGyroscopeMagnitudeMeanFrequency <dbl>,
    ## #   frequencyBodyBodyGyroscopeJerkMagnitudeMean <dbl>,
    ## #   frequencyBodyBodyGyroscopeJerkMagnitudeMeanFrequency <dbl>,
    ## #   timeBodyAccelerometerStd.X <dbl>, timeBodyAccelerometerStd.Y <dbl>,
    ## #   timeBodyAccelerometerStd.Z <dbl>, timeGravityAccelerometerStd.X <dbl>,
    ## #   timeGravityAccelerometerStd.Y <dbl>, timeGravityAccelerometerStd.Z <dbl>,
    ## #   timeBodyAccelerometerJerkStd.X <dbl>, timeBodyAccelerometerJerkStd.Y <dbl>,
    ## #   timeBodyAccelerometerJerkStd.Z <dbl>, timeBodyGyroscopeStd.X <dbl>,
    ## #   timeBodyGyroscopeStd.Y <dbl>, timeBodyGyroscopeStd.Z <dbl>,
    ## #   timeBodyGyroscopeJerkStd.X <dbl>, timeBodyGyroscopeJerkStd.Y <dbl>,
    ## #   timeBodyGyroscopeJerkStd.Z <dbl>, timeBodyAccelerometerMagnitudeStd <dbl>,
    ## #   timeGravityAccelerometerMagnitudeStd <dbl>,
    ## #   timeBodyAccelerometerJerkMagnitudeStd <dbl>,
    ## #   timeBodyGyroscopeMagnitudeStd <dbl>,
    ## #   timeBodyGyroscopeJerkMagnitudeStd <dbl>,
    ## #   frequencyBodyAccelerometerStd.X <dbl>,
    ## #   frequencyBodyAccelerometerStd.Y <dbl>,
    ## #   frequencyBodyAccelerometerStd.Z <dbl>,
    ## #   frequencyBodyAccelerometerJerkStd.X <dbl>,
    ## #   frequencyBodyAccelerometerJerkStd.Y <dbl>,
    ## #   frequencyBodyAccelerometerJerkStd.Z <dbl>,
    ## #   frequencyBodyGyroscopeStd.X <dbl>, frequencyBodyGyroscopeStd.Y <dbl>,
    ## #   frequencyBodyGyroscopeStd.Z <dbl>,
    ## #   frequencyBodyAccelerometerMagnitudeStd <dbl>,
    ## #   frequencyBodyBodyAccelerometerJerkMagnitudeStd <dbl>,
    ## #   frequencyBodyBodyGyroscopeMagnitudeStd <dbl>,
    ## #   frequencyBodyBodyGyroscopeJerkMagnitudeStd <dbl>, Activity_Id <int>,
    ## #   Activity <fct>, Subject <int>

``` r
tidy_data_means_std <- data_set_mean_std %>%
  group_by(Activity, Subject) %>%
  summarise_all(funs(mean))
```

    ## Warning: funs() is soft deprecated as of dplyr 0.8.0
    ## Please use a list of either functions or lambdas: 
    ## 
    ##   # Simple named list: 
    ##   list(mean = mean, median = median)
    ## 
    ##   # Auto named with `tibble::lst()`: 
    ##   tibble::lst(mean, median)
    ## 
    ##   # Using lambdas
    ##   list(~ mean(., trim = .2), ~ median(., na.rm = TRUE))
    ## This warning is displayed once per session.

``` r
# re-order columns
tidy_data_means_std <-
  select(
    tidy_data_means_std,
    Activity_Id,
    Activity,
    Subject,
    timeBodyAccelerometerMean.X:frequencyBodyBodyGyroscopeJerkMagnitudeStd
  )

dim(tidy_data_means_std)
```

    ## [1] 40 82

``` r
str(tidy_data_means_std)
```

    ## tibble [40 × 82] (S3: grouped_df/tbl_df/tbl/data.frame)
    ##  $ Activity_Id                                             : num [1:40] 6 6 6 6 6 6 4 4 4 4 ...
    ##  $ Activity                                                : Factor w/ 6 levels "LAYING","SITTING",..: 1 1 1 1 1 1 2 2 2 2 ...
    ##  $ Subject                                                 : int [1:40] 20 24 27 28 29 30 12 13 17 18 ...
    ##  $ timeBodyAccelerometerMean.X                             : num [1:40] 0.268 0.277 0.278 0.278 0.279 ...
    ##  $ timeBodyAccelerometerMean.Y                             : num [1:40] -0.0154 -0.0177 -0.0169 -0.0192 -0.0185 ...
    ##  $ timeBodyAccelerometerMean.Z                             : num [1:40] -0.103 -0.108 -0.112 -0.11 -0.109 ...
    ##  $ timeGravityAccelerometerMean.X                          : num [1:40] 0.591 0.695 0.585 0.624 0.683 ...
    ##  $ timeGravityAccelerometerMean.Y                          : num [1:40] 0.00244 0.07295 0.02348 -0.14758 0.11549 ...
    ##  $ timeGravityAccelerometerMean.Z                          : num [1:40] 0.1078 0.0623 0.1206 -0.047 0.2082 ...
    ##  $ timeBodyAccelerometerJerkMean.X                         : num [1:40] 0.075 0.0785 0.0769 0.0807 0.0788 ...
    ##  $ timeBodyAccelerometerJerkMean.Y                         : num [1:40] -0.00274 0.00397 0.00518 0.01382 0.009 ...
    ##  $ timeBodyAccelerometerJerkMean.Z                         : num [1:40] -0.002515 -0.00701 -0.005548 0.000824 -0.003553 ...
    ##  $ timeBodyGyroscopeMean.X                                 : num [1:40] -0.0225 -0.0213 -0.0683 -0.0645 -0.0102 ...
    ##  $ timeBodyGyroscopeMean.Y                                 : num [1:40] -0.079 -0.0782 -0.0496 -0.0471 -0.0883 ...
    ##  $ timeBodyGyroscopeMean.Z                                 : num [1:40] 0.09 0.0842 0.1163 0.1008 0.0882 ...
    ##  $ timeBodyGyroscopeJerkMean.X                             : num [1:40] -0.0946 -0.0998 -0.0874 -0.0881 -0.1007 ...
    ##  $ timeBodyGyroscopeJerkMean.Y                             : num [1:40] -0.0402 -0.0391 -0.0465 -0.0448 -0.0464 ...
    ##  $ timeBodyGyroscopeJerkMean.Z                             : num [1:40] -0.0526 -0.0553 -0.0601 -0.0608 -0.0528 ...
    ##  $ timeBodyAccelerometerMagnitudeMean                      : num [1:40] -0.452 -0.62 -0.536 -0.61 -0.554 ...
    ##  $ timeGravityAccelerometerMagnitudeMean                   : num [1:40] -0.452 -0.62 -0.536 -0.61 -0.554 ...
    ##  $ timeBodyAccelerometerJerkMagnitudeMean                  : num [1:40] -0.565 -0.714 -0.626 -0.689 -0.665 ...
    ##  $ timeBodyGyroscopeMagnitudeMean                          : num [1:40] -0.435 -0.682 -0.623 -0.649 -0.602 ...
    ##  $ timeBodyGyroscopeJerkMagnitudeMean                      : num [1:40] -0.625 -0.792 -0.778 -0.789 -0.802 ...
    ##  $ frequencyBodyAccelerometerMean.X                        : num [1:40] -0.571 -0.708 -0.601 -0.654 -0.58 ...
    ##  $ frequencyBodyAccelerometerMean.Y                        : num [1:40] -0.325 -0.612 -0.554 -0.585 -0.588 ...
    ##  $ frequencyBodyAccelerometerMean.Z                        : num [1:40] -0.672 -0.656 -0.647 -0.715 -0.681 ...
    ##  $ frequencyBodyAccelerometerMeanFrequency.X               : num [1:40] -0.274 -0.263 -0.216 -0.218 -0.165 ...
    ##  $ frequencyBodyAccelerometerMeanFrequency.Y               : num [1:40] 0.0404 -0.0176 0.0858 -0.0652 0.1281 ...
    ##  $ frequencyBodyAccelerometerMeanFrequency.Z               : num [1:40] 0.0964 0.0813 0.1283 0.019 0.0886 ...
    ##  $ frequencyBodyAccelerometerJerkMean.X                    : num [1:40] -0.625 -0.752 -0.642 -0.687 -0.63 ...
    ##  $ frequencyBodyAccelerometerJerkMean.Y                    : num [1:40] -0.467 -0.704 -0.618 -0.671 -0.641 ...
    ##  $ frequencyBodyAccelerometerJerkMean.Z                    : num [1:40] -0.731 -0.72 -0.711 -0.779 -0.768 ...
    ##  $ frequencyBodyAccelerometerJerkMeanFrequency.X           : num [1:40] -0.1408 -0.057 -0.075 -0.0342 0.0108 ...
    ##  $ frequencyBodyAccelerometerJerkMeanFrequency.Y           : num [1:40] -0.2702 -0.2311 -0.148 -0.2776 -0.0816 ...
    ##  $ frequencyBodyAccelerometerJerkMeanFrequency.Z           : num [1:40] -0.17111 -0.13977 -0.10883 -0.12606 -0.00953 ...
    ##  $ frequencyBodyGyroscopeMean.X                            : num [1:40] -0.579 -0.723 -0.712 -0.674 -0.686 ...
    ##  $ frequencyBodyGyroscopeMean.Y                            : num [1:40] -0.526 -0.754 -0.746 -0.747 -0.736 ...
    ##  $ frequencyBodyGyroscopeMean.Z                            : num [1:40] -0.431 -0.709 -0.63 -0.674 -0.689 ...
    ##  $ frequencyBodyGyroscopeMeanFrequency.X                   : num [1:40] -0.12985 -0.05011 -0.10212 -0.15164 0.00201 ...
    ##  $ frequencyBodyGyroscopeMeanFrequency.Y                   : num [1:40] -0.1608 -0.0975 -0.019 -0.2706 -0.2539 ...
    ##  $ frequencyBodyGyroscopeMeanFrequency.Z                   : num [1:40] -0.0451 -0.0556 -0.0198 -0.0897 0.0204 ...
    ##  $ frequencyBodyAccelerometerMagnitudeMean                 : num [1:40] -0.505 -0.65 -0.586 -0.629 -0.589 ...
    ##  $ frequencyBodyAccelerometerMagnitudeMeanFrequency        : num [1:40] 0.0739 0.0236 0.1766 0.018 0.1628 ...
    ##  $ frequencyBodyBodyAccelerometerJerkMagnitudeMean         : num [1:40] -0.538 -0.697 -0.61 -0.675 -0.61 ...
    ##  $ frequencyBodyBodyAccelerometerJerkMagnitudeMeanFrequency: num [1:40] 0.117 0.198 0.214 0.174 0.227 ...
    ##  $ frequencyBodyBodyGyroscopeMagnitudeMean                 : num [1:40] -0.547 -0.754 -0.735 -0.738 -0.722 ...
    ##  $ frequencyBodyBodyGyroscopeMagnitudeMeanFrequency        : num [1:40] -0.00263 0.01945 0.02829 -0.123 -0.04465 ...
    ##  $ frequencyBodyBodyGyroscopeJerkMagnitudeMean             : num [1:40] -0.659 -0.795 -0.797 -0.807 -0.84 ...
    ##  $ frequencyBodyBodyGyroscopeJerkMagnitudeMeanFrequency    : num [1:40] 0.09479 0.16174 0.18305 -0.00201 0.21243 ...
    ##  $ timeBodyAccelerometerStd.X                              : num [1:40] -0.547 -0.675 -0.575 -0.649 -0.574 ...
    ##  $ timeBodyAccelerometerStd.Y                              : num [1:40] -0.259 -0.582 -0.541 -0.574 -0.598 ...
    ##  $ timeBodyAccelerometerStd.Z                              : num [1:40] -0.64 -0.636 -0.608 -0.686 -0.606 ...
    ##  $ timeGravityAccelerometerStd.X                           : num [1:40] -0.958 -0.975 -0.972 -0.974 -0.973 ...
    ##  $ timeGravityAccelerometerStd.Y                           : num [1:40] -0.951 -0.961 -0.97 -0.96 -0.965 ...
    ##  $ timeGravityAccelerometerStd.Z                           : num [1:40] -0.944 -0.956 -0.957 -0.946 -0.942 ...
    ##  $ timeBodyAccelerometerJerkStd.X                          : num [1:40] -0.586 -0.74 -0.624 -0.681 -0.623 ...
    ##  $ timeBodyAccelerometerJerkStd.Y                          : num [1:40] -0.426 -0.686 -0.594 -0.652 -0.635 ...
    ##  $ timeBodyAccelerometerJerkStd.Z                          : num [1:40] -0.739 -0.736 -0.73 -0.801 -0.794 ...
    ##  $ timeBodyGyroscopeStd.X                                  : num [1:40] -0.652 -0.776 -0.746 -0.74 -0.735 ...
    ##  $ timeBodyGyroscopeStd.Y                                  : num [1:40] -0.486 -0.763 -0.754 -0.741 -0.635 ...
    ##  $ timeBodyGyroscopeStd.Z                                  : num [1:40] -0.461 -0.708 -0.595 -0.67 -0.714 ...
    ##  $ timeBodyGyroscopeJerkStd.X                              : num [1:40] -0.653 -0.764 -0.776 -0.721 -0.736 ...
    ##  $ timeBodyGyroscopeJerkStd.Y                              : num [1:40] -0.644 -0.793 -0.796 -0.825 -0.854 ...
    ##  $ timeBodyGyroscopeJerkStd.Z                              : num [1:40] -0.537 -0.797 -0.728 -0.77 -0.77 ...
    ##  $ timeBodyAccelerometerMagnitudeStd                       : num [1:40] -0.519 -0.651 -0.6 -0.636 -0.579 ...
    ##  $ timeGravityAccelerometerMagnitudeStd                    : num [1:40] -0.519 -0.651 -0.6 -0.636 -0.579 ...
    ##  $ timeBodyAccelerometerJerkMagnitudeStd                   : num [1:40] -0.541 -0.689 -0.619 -0.688 -0.62 ...
    ##  $ timeBodyGyroscopeMagnitudeStd                           : num [1:40] -0.521 -0.743 -0.697 -0.711 -0.654 ...
    ##  $ timeBodyGyroscopeJerkMagnitudeStd                       : num [1:40] -0.653 -0.789 -0.796 -0.806 -0.84 ...
    ##  $ frequencyBodyAccelerometerStd.X                         : num [1:40] -0.539 -0.664 -0.567 -0.648 -0.573 ...
    ##  $ frequencyBodyAccelerometerStd.Y                         : num [1:40] -0.274 -0.595 -0.565 -0.595 -0.631 ...
    ##  $ frequencyBodyAccelerometerStd.Z                         : num [1:40] -0.651 -0.655 -0.62 -0.696 -0.603 ...
    ##  $ frequencyBodyAccelerometerJerkStd.X                     : num [1:40] -0.584 -0.751 -0.64 -0.704 -0.652 ...
    ##  $ frequencyBodyAccelerometerJerkStd.Y                     : num [1:40] -0.42 -0.688 -0.595 -0.655 -0.656 ...
    ##  $ frequencyBodyAccelerometerJerkStd.Z                     : num [1:40] -0.746 -0.752 -0.747 -0.822 -0.818 ...
    ##  $ frequencyBodyGyroscopeStd.X                             : num [1:40] -0.677 -0.794 -0.759 -0.762 -0.753 ...
    ##  $ frequencyBodyGyroscopeStd.Y                             : num [1:40] -0.467 -0.772 -0.763 -0.741 -0.589 ...
    ##  $ frequencyBodyGyroscopeStd.Z                             : num [1:40] -0.523 -0.736 -0.623 -0.7 -0.749 ...
    ##  $ frequencyBodyAccelerometerMagnitudeStd                  : num [1:40] -0.604 -0.706 -0.672 -0.697 -0.639 ...
    ##  $ frequencyBodyBodyAccelerometerJerkMagnitudeStd          : num [1:40] -0.548 -0.682 -0.634 -0.706 -0.636 ...
    ##  $ frequencyBodyBodyGyroscopeMagnitudeStd                  : num [1:40] -0.588 -0.782 -0.727 -0.744 -0.671 ...
    ##  $ frequencyBodyBodyGyroscopeJerkMagnitudeStd              : num [1:40] -0.67 -0.796 -0.81 -0.818 -0.851 ...
    ##  - attr(*, "groups")= tibble [6 × 2] (S3: tbl_df/tbl/data.frame)
    ##   ..$ Activity: Factor w/ 6 levels "LAYING","SITTING",..: 1 2 3 4 5 6
    ##   ..$ .rows   :List of 6
    ##   .. ..$ : int [1:6] 1 2 3 4 5 6
    ##   .. ..$ : int [1:7] 7 8 9 10 11 12 13
    ##   .. ..$ : int [1:7] 14 15 16 17 18 19 20
    ##   .. ..$ : int [1:6] 21 22 23 24 25 26
    ##   .. ..$ : int [1:6] 27 28 29 30 31 32
    ##   .. ..$ : int [1:8] 33 34 35 36 37 38 39 40
    ##   ..- attr(*, ".drop")= logi TRUE

``` r
# write tidy dataframe to txt file
write.table(tidy_data_means_std,
            "tidy_data.txt",
            row.names = FALSE,
            quote = FALSE)
```
