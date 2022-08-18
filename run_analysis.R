library(dplyr)


# Download and unzip data
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "UCI HAR Dataset.zip"
if (!file.exists(fileName)) {download.file(fileURL, fileName, mode = "wb")}

dataPath <- "UCI HAR Dataset"
if (!file.exists(dataPath)) {unzip(fileName)}



# load train and test data into R
trainingSubject <- read.table(file.path(dataPath, "train", "subject_train.txt"))
trainingValue <- read.table(file.path(dataPath, "train", "X_train.txt"))
trainingActivity <- read.table(file.path(dataPath, "train", "y_train.txt"))

testSubject <- read.table(file.path(dataPath, "test", "subject_test.txt"))
testValue <- read.table(file.path(dataPath, "test", "X_test.txt"))
testActivity <- read.table(file.path(dataPath, "test", "y_test.txt"))

# load features and activity into R
features <- read.table(file.path(dataPath, "features.txt"), as.is = TRUE)
activities <- read.table(file.path(dataPath, "activity_labels.txt"))
colnames(activities) <- c("activityId", "activityLabel")


# 1. Merge the training and the test sets to create one data set

mergedActivity <- rbind(
  cbind(trainingSubject, trainingValue, trainingActivity),
  cbind(testSubject, testValue, testActivity)
)
colnames(mergedActivity) <- c("subject", features[, 2], "activity")



# 2. Extract only the measurements on the mean and standard deviation for each measurement

columnsNeed <- grepl("subject|activity|mean|std", colnames(mergedActivity))
mergedActivity <- mergedActivity[, columnsNeed]



# 3. Use descriptive activity names to name the activities in the dataset

mergedActivity$activity <- factor(mergedActivity$activity, 
                                  levels = activities[, 1], labels = activities[, 2])



# 4. Appropriately label the data set with descriptive variable names
mergedActivityCols <- colnames(mergedActivity)

# remove special characters
mergedActivityCols <- gsub("[\\(\\)-]", "", mergedActivityCols)

# expand abbreviations and clean up names

mergedActivityCols <- gsub("Freq", "Frequency", mergedActivityCols)
mergedActivityCols <- gsub("mean", "Mean", mergedActivityCols)
mergedActivityCols <- gsub("std", "StandardDeviation", mergedActivityCols)
mergedActivityCols <- gsub("Acc", "Accelerometer", mergedActivityCols)
mergedActivityCols <- gsub("Gyro", "Gyroscope", mergedActivityCols)
mergedActivityCols <- gsub("Mag", "Magnitude", mergedActivityCols)
mergedActivityCols <- gsub("^f", "frequencyDomain", mergedActivityCols)
mergedActivityCols <- gsub("^t", "timeDomain", mergedActivityCols)

# avoid typo and use new labels as column names
mergedActivityCols <- gsub("BodyBody", "Body", mergedActivityCols)
colnames(mergedActivity) <- mergedActivityCols

# 5. Create a second, independent tidy set with the average of each variable for each activity and each subject

mergedActivityMeans <- mergedActivity %>% 
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

# final output
write.table(mergedActivityMeans, "tidy_data.txt", row.names = FALSE, quote = FALSE)
