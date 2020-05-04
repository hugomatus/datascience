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
file.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dest.file <- "data/zipped-data/wearable-data.zip"
download.file(url = file.url,destfile = dest.file,quiet = TRUE,method = "curl",)
```

##### List Files included in Wearable Dataset

``` r
setwd("~/datascience/")
unzip(zipfile = dest.file,list = TRUE)
```

    ##                                                            Name   Length
    ## 1                           UCI HAR Dataset/activity_labels.txt       80
    ## 2                                  UCI HAR Dataset/features.txt    15785
    ## 3                             UCI HAR Dataset/features_info.txt     2809
    ## 4                                    UCI HAR Dataset/README.txt     4453
    ## 5                                         UCI HAR Dataset/test/        0
    ## 6                        UCI HAR Dataset/test/Inertial Signals/        0
    ## 7     UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt  6041350
    ## 8     UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt  6041350
    ## 9     UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt  6041350
    ## 10   UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt  6041350
    ## 11   UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt  6041350
    ## 12   UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt  6041350
    ## 13   UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt  6041350
    ## 14   UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt  6041350
    ## 15   UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt  6041350
    ## 16                        UCI HAR Dataset/test/subject_test.txt     7934
    ## 17                              UCI HAR Dataset/test/X_test.txt 26458166
    ## 18                              UCI HAR Dataset/test/y_test.txt     5894
    ## 19                                       UCI HAR Dataset/train/        0
    ## 20                      UCI HAR Dataset/train/Inertial Signals/        0
    ## 21  UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt 15071600
    ## 22  UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt 15071600
    ## 23  UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt 15071600
    ## 24 UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt 15071600
    ## 25 UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt 15071600
    ## 26 UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt 15071600
    ## 27 UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt 15071600
    ## 28 UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt 15071600
    ## 29 UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt 15071600
    ## 30                      UCI HAR Dataset/train/subject_train.txt    20152
    ## 31                            UCI HAR Dataset/train/X_train.txt 66006256
    ## 32                            UCI HAR Dataset/train/y_train.txt    14704
    ##                   Date
    ## 1  2012-10-10 15:55:00
    ## 2  2012-10-11 13:41:00
    ## 3  2012-10-15 15:44:00
    ## 4  2012-12-10 10:38:00
    ## 5  2012-11-29 17:01:00
    ## 6  2012-11-29 17:01:00
    ## 7  2012-11-29 15:08:00
    ## 8  2012-11-29 15:08:00
    ## 9  2012-11-29 15:08:00
    ## 10 2012-11-29 15:09:00
    ## 11 2012-11-29 15:09:00
    ## 12 2012-11-29 15:09:00
    ## 13 2012-11-29 15:08:00
    ## 14 2012-11-29 15:09:00
    ## 15 2012-11-29 15:09:00
    ## 16 2012-11-29 15:09:00
    ## 17 2012-11-29 15:25:00
    ## 18 2012-11-29 15:09:00
    ## 19 2012-11-29 17:01:00
    ## 20 2012-11-29 17:01:00
    ## 21 2012-11-29 15:08:00
    ## 22 2012-11-29 15:08:00
    ## 23 2012-11-29 15:08:00
    ## 24 2012-11-29 15:09:00
    ## 25 2012-11-29 15:09:00
    ## 26 2012-11-29 15:09:00
    ## 27 2012-11-29 15:08:00
    ## 28 2012-11-29 15:08:00
    ## 29 2012-11-29 15:08:00
    ## 30 2012-11-29 15:09:00
    ## 31 2012-11-29 15:25:00
    ## 32 2012-11-29 15:09:00

##### Extract Files included in Wearable Dataset

``` r
setwd("~/datascience/")
extract.dir <- "data/"
unzip(zipfile = dest.file,list = FALSE,exdir = extract.dir, overwrite = TRUE)
```
