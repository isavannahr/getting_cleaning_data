setwd("~/Documents/Data Science")
library(plyr)
# Getting and Cleaning Data Course Project
# The purpose of this project is to demonstrate your ability to collect, work 
# with, and clean a data set. The goal is to prepare tidy data that can be used 
# for later analysis. You will be graded by your peers on a series of yes/no 
# questions related to the project. You will be required to submit: 

#1) a tidy data set as described below, 
#2) a link to a Github repository with your script for performing the analysis,
#3) a code book that describes the variables, the data, and any transformations or work that 
#   you performed to clean up the data called CodeBook.md. You should also include a README.md 
#   in the repo with your scripts. This repo explains how all of the scripts work and how they 
#   are connected.
# 
# One of the most exciting areas in all of data science right now is wearable computing - see 
# for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the 
# most advanced algorithms to attract new users. The data linked to from the course website represent data collected 
# from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the 
# data was obtained:
#   
#   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# 
# Here are the data for the project
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
              destfile = "~/Documents/Data Science/wearabletech.zip", method = "curl")



# You should create one R script called run_analysis.R that does the following.
 
# Merges the training and the test sets to create one data set.
#Extract all data
unzip("wearabletech.zip")
x_train <- read.table("~/Documents/Data Science/UCI HAR Dataset/train/X_train.txt", header = TRUE)
y_train <- read.table("~/Documents/Data Science/UCI HAR Dataset/train/y_train.txt", header = TRUE)
subject_train <- read.table("~/Documents/Data Science/UCI HAR Dataset/train/subject_train.txt", header = TRUE)
head(x_train)
head(y_train)
head(subject_train)

x_test <- read.table("~/Documents/Data Science/UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test <- read.table("~/Documents/Data Science/UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_test <- read.table("~/Documents/Data Science/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
head(x_test)
str(y_test)
head(subject_test)

features <- read.table("~/Documents/Data Science/UCI HAR Dataset/features.txt", header = FALSE)
activity_labels <- read.table("~/Documents/Data Science/UCI HAR Dataset/activity_labels.txt", header = FALSE)

# Uses descriptive activity names to name the activities in the data set
#Labels 
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "Subject"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "Subject"

colnames(activity_labels) <- c('activityId','activityType')
str(mean_std_data)
colnames(Data)
Data[,"activityId"]



x_merge <- rbind(x_test, x_train)
y_merge <- rbind(y_test, y_train)
head(y_test)
head(y_train)
subject <- rbind(subject_test,subject_train)

x_y_data <- cbind(x_merge,y_merge)
Data <- cbind(x_y_data,subject)
head(Data)
str(Data)
colnames(Data)
# Extracts only the measurements on the mean and standard deviation for each measurement.



mean_std_columns <- grep("std()|mean()",colnames(Data))
std_mean_data <- Data[mean_std_columns]
std_mean_data_names <- as.character(colnames(std_mean_data))

sData <- subset(Data, select = c(std_mean_data_names))
sData <- cbind(sData, Data$activityId, Data$Subject)
# Appropriately labels the data set with descriptive variable names.

colnames(sData)
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
activities <- read.table("UCI HAR Dataset/activity_labels.txt",header = FALSE)
colnames(sData)[names(sData) == 'Data$activityId'] <- 'activity'
colnames(sData)[names(sData) == 'Data$Subject'] <- 'subject'
colnames(activities) <- c("label", "activity")
colnames(sData)

colnames(sData)<-gsub("^t", "time", colnames(sData))
colnames(sData)<-gsub("^f", "frequency",colnames(sData))
colnames(sData)<-gsub("Acc", "accelerometer", colnames(sData))
colnames(sData)<-gsub("Gyro", "gyroscope", colnames(sData))
colnames(sData)<-gsub("Mag", "magnitude", colnames(sData))
colnames(sData)<-gsub("BodyBody", "body", colnames(sData))
colnames(sData)<-gsub("Body", "body", colnames(sData))

colnames(sData)
finalData <- aggregate(. ~subject + activity, sData, mean)
finalData <- finalData[order(finalData$subject, finalData$activity),]
write.table(finalData, file = "tidydata.txt", row.names=FALSE)

# The Github repo contains the required scripts.
# GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
# The README that explains the analysis files is clear and understandable.
