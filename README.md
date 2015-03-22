
# Introduction

The purpose of this project is to demonstrate how to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.  

For this project, the raw data represents data collected from the accelerometers from the Samsung Galaxy S smartphone. The script then creates tidy data set with 
the average of each variable for each activity and each subject.


# Steps

This script performs the following:

* Merges the training and the test sets to create one data set
* Extracts only the measurements on the mean and standard deviation for each measurement 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

Detailed steps to accomplish each of the above objectives can be found in the comments section of the run_analysis.R code


# Results

To view the results file, download Results.txt file to a local directory, point R to directory containing the Results.txt file, and execute the following R commands:

* library(data.table)
* data <- read.table(".\\Results.txt", header = TRUE)
* view(data)

Here is a snapshot of the Results:

![alt text] (https://github.com/primo1/Project/blob/master/Results.jpg "Results.txt")


# References

A full description of collected data is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data used in the project can be found here: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
