# Getting-and-Cleaning-Data-Course-Project

## This repository contains the following files:
README.md: gives an outline about the data set
CodeBook.md: gives specifics about the data set, including the contents of the tidy data
run_analysis.R: R script for the creation of the final tidy data
tidy_data.txt: contains the final tidy data

The source file was obtained from the Human Activity Recognition Using Smartphones Data Set, which is found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The R script, run_analysis.R, does the following:
	Downloads the source data (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and unzips it if it was not downloaded yet
	Reads the data found in the "UCI HAR Dataset" folder
	Merges the training and the test sets to create one data set
	Extracts only the measurements on the mean and standard deviation for each measurement
	Uses descriptive activity names to name the activities in the data set
	Appropriately labels the data set with descriptive variable names
	Creates a second, independent tidy data set with the average of each variable for each activity and each subject and writes this tidy data set to the tidy_data.txt file
