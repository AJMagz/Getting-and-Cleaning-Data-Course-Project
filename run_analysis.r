##########################################################################################################
# Filename = run_analysis.R
#
# Objective: To output a tidy data set file named "tidy_data.txt" from data
#    collected from the accelerometers from the Samsung Galaxy S smartphone.
#
##########################################################################################################


install.packages("dplyr")

library(dplyr)

filezip <- "GetClean_Dataset.zip"

##########################################################################################################
# Checks if the zip file containing the data set was not downloaded yet

if (!file.exists(filezip)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filezip, method="curl")
}  

# Checks if there's a duplicate of the folder containing the data set
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filezip) 
}
##########################################################################################################


##########################################################################################################
# Reads the data set
##########################################################################################################

features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("ftId","fns"))
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("actId", "activity"))

# Reads train data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$fns)
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "activity")
Subj_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

# Reads test data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$fns)
Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "activity")
Subj_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")



##########################################################################################################
# Merges the training and the test sets to create one data set
##########################################################################################################

Merge_data <- rbind(
  cbind(Subj_train, Y_train, X_train),
  cbind(Subj_test, Y_test, X_test)
)



##########################################################################################################
# Extracts only the measurements on the mean and standard deviation for each measurement
##########################################################################################################

# Determines which columns to include
col_MeanSTD <- grepl("subject|activity|.*mean.*|.*std.*", colnames(Merge_data))

# Keeping records under remaining columns
Merge_data <- Merge_data[, col_MeanSTD]



##########################################################################################################
# Uses descriptive activity names to name the activities in the data set
##########################################################################################################

Merge_data$activity <- factor(Merge_data$activity, levels = activityLabels[, 1], labels = activityLabels[, 2])



##########################################################################################################
# Appropriately labels the data set with descriptive variable names
##########################################################################################################

colnames(Merge_data) <- gsub("-mean()", "Mean", colnames(Merge_data), ignore.case = TRUE)
colnames(Merge_data) <- gsub("-std()", "STD", colnames(Merge_data), ignore.case = TRUE)
colnames(Merge_data) <- gsub("-freq()", "Frequency", colnames(Merge_data), ignore.case = TRUE)
colnames(Merge_data) <- gsub("^t", "Time", colnames(Merge_data))
colnames(Merge_data) <- gsub("^f", "Frequency", colnames(Merge_data))
colnames(Merge_data) <- gsub("Acc", "Accelerometer", colnames(Merge_data))
colnames(Merge_data) <- gsub("Gyro", "Gyroscope", colnames(Merge_data))
colnames(Merge_data) <- gsub("BodyBody", "Body", colnames(Merge_data))
colnames(Merge_data) <- gsub("Mag", "Magnitude", colnames(Merge_data))
colnames(Merge_data) <- gsub("tBody", "TimeBody", colnames(Merge_data))
colnames(Merge_data) <- gsub("angle", "Angle", colnames(Merge_data))
colnames(Merge_data) <- gsub("gravity", "Gravity", colnames(Merge_data))



##########################################################################################################
# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject
##########################################################################################################

Mergedata_Avg <- Merge_data %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(Mergedata_Avg, "tidy_data.txt", row.name=FALSE, quote = FALSE)
