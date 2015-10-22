## Load necessary modules
## Download data files
## Get header information
## Merge X-training and X_test data into one, 'XData'
## Assign correct header information to the correct columns in 'XData'
## Trim columns in XData to be only the columns containing '-mean' or '-std'
## Merge y_training and y_test data into one, 'YData' = Activity
## Read in Activity Labels and merge with YData
## Merge subject_training and subject_test into one, 'SubData' = Who did the activity
## Merge 'XData', 'YData', and 'SubData into one large dataset, 'FullData'
## Load and rename column labels with meaningful language
## Create Tidy data
## Write both 'FullData' and Tidy data to flat files


## Load necessary modules, make sure both "data.table" and "plyr" are installed before running.
library(data.table)
library(plyr)

## Download and unpack data files
DownURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./UCI HAR Dataset")) {
     download.file(DownURL, "dataset.zip")
     unzip("dataset.zip")
     unlink("dataset.zip")
}

## Store header info
Headers <- fread("UCI HAR Dataset/features.txt")$V2

##Load data points, give the correct headers, and filter by the correct columns
XData <- rbind(fread("UCI HAR Dataset/test/X_test.txt"), fread("UCI HAR Dataset/train/X_train.txt"))
names(XData) <- Headers
ActX <- XData[, grep("*mean()*|*std()*", Headers), with=FALSE]
ActHead <- names(ActX)

## Read in the Activity info, and re-code with natural language labels
YData <- rbind(fread("UCI HAR Dataset/test/Y_test.txt"), fread("UCI HAR Dataset/train/Y_train.txt"))
ActLabels <- fread("UCI HAR Dataset/activity_labels.txt")
NewY <- merge(YData, ActLabels, by = "V1")$V2

## Read in subject data, and merge data points, activity, and subject data into one dataset.
SubData <- rbind(fread("UCI HAR Dataset/test/subject_test.txt"), fread("UCI HAR Dataset/train/subject_train.txt"))
FullData <- cbind(ActX, NewY, SubData)

## Load in, and rename column labels
names(FullData) <- c(ActHead, "Activity", "Subject")
names(FullData) <- gsub("^t", "Time_", names(FullData))
names(FullData) <- gsub("^f", "Frequency_", names(FullData))
names(FullData) <- gsub("Acc", "Accelerometer_", names(FullData))
names(FullData) <- gsub("Gyro", "Gyroscope_", names(FullData))
names(FullData) <- gsub("Mag", "Magnitude_", names(FullData))
names(FullData) <- gsub("BodyBody", "Body_", names(FullData))
names(FullData) <- gsub("-mean()", "Mean", names(FullData))
names(FullData) <- gsub("-std()", "StDev", names(FullData))

## Create aggregated 'tidy data'
AggData <- aggregate(. ~Subject + Activity, FullData, mean)

## Write both full data and tidy data to flat files
write.table(FullData, file="FullData.txt", row.name=FALSE)
write.table(AggData, file="Tidy.txt", row.name=FALSE)