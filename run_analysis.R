#
# This script performs the following:
#
# 1. Merges the training and the test sets to create one data set
# 2. Extracts only the measurements on the mean and standard deviation for each measurement 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
#    for each activity and each subject

library(data.table)
library(plyr)
library(dplyr)
library(Hmisc)

#
# Task #1:  Merges the training and the test sets to create one data set
#
xTrain <- read.table("UCI HAR Dataset\\train\\X_train.txt", header=FALSE)       # Read xTrain data set
yTrain <- read.table("UCI HAR Dataset\\train\\y_train.txt", header=FALSE)       # Read Training labels
xtest <- read.table("UCI HAR Dataset\\test\\X_test.txt", header=FALSE)          # Read test data set
ytest <- read.table("UCI HAR Dataset\\test\\y_test.txt", header=FALSE)          # Read test labels
xyTrain <- cbind(yTrain, xTrain)                                                # Label Train data set
xytest <- cbind(ytest, xtest)                                                   # Label test data set
z <- rbind(xyTrain,xytest)                                                      # Merge Traing and test data sets

#
# Task #2: Extracts only the measurements on the mean and standard deviation for each measurement
# Task #4: Appropriately labels the data set with descriptive variable names 
#
colNumbers <- read.table("UCI HAR Dataset\\features.txt", header=FALSE, sep=" ")  # Read features.txt
colNumbers <- as.data.frame(colNumbers)                                           # Coerce object to data frame
#colNames <- as.character(colNumbers[,2])                                         # Coerce activity names, second column" to character
colnames(z)[1] <- ("Activity")                                                    # Name activity codes, first column, as "Activity" 
colnames(z)[2:562] <- as.character(colNumbers[,2])                                # Coerce activity names, second column" to character
colnames(z) <- gsub("\\(|\\)", "", colnames(z))                                   # Remove parentheses '()' from column names
m <- sapply(c("mean"), grep, colNumbers$V2, ignore.case=TRUE)                     # Search Activity Names for matches to string "mean"
s <- sapply(c("std"), grep, colNumbers$V2, ignore.case=TRUE)                      # Search Activity Names for matches to string "standard deviation"    
k <- sort(consolidate(m+1, s+1))                                                  # Consolidate and sort measurments of mean and standard deviation
z <- cbind(z[1], z[k])                                                            # Extracts only the measurements on the mean and standard deviation for each measurement from merged data set

#
# Task #3: Uses descriptive activity names to name the activities in the data set
#
z$Activity[z$Activity == 1] <- "WALKING"
z$Activity[z$Activity == 2] <- "WALKING_UPSTAIRS"
z$Activity[z$Activity == 3] <- "WALKING_DOWNSTAIRS"
z$Activity[z$Activity == 4] <- "SITTING"
z$Activity[z$Activity == 5] <- "STANDING"
z$Activity[z$Activity == 6] <- "LAYING"

#
# Task #5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable
# for each activity and each subject
#
n <- z %>% group_by(Activity) %>% summarise_each(funs(mean))                        # Calculate average of each variable for each activity
write.table(n, file =".\\Results.txt", row.names=FALSE, col.names=TRUE)    

