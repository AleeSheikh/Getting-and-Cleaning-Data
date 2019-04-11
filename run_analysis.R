# Getting dataset ready
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "uci-data.zip")
unzip("uci-data.zip")



# Reading features and activities
features <- read.table("UCI HAR Dataset/features.txt")
activity <- read.table("UCI HAR Dataset/activity_labels.txt")



# Reading train data
xtrain <- read.table("UCI HAR DATASET/train/X_train.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "value")
trainsubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainsubject, ytrain, xtrain)



# Reading test data
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "value")
testsubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testsubject, ytest, xtest)



# Merging Data
totaldata <- rbind(train, test)



# Naming Activities 
totaldata$value <- activity[totaldata$value,2]



# Labeling data
features[,2] <- as.character(features[,2])
colnames(totaldata) <- c("subject", "activity", features[,2])
names(totaldata) <- gsub("-mean", "Mean", names(totaldata))
names(totaldata) <- gsub("-std", "STD", names(totaldata))
names(totaldata) <- gsub("Acc", "Accelerometer", names(totaldata))
names(totaldata) <- gsub("Gyro", "Gyroscope", names(totaldata))
names(totaldata) <- gsub("BodyBody", "Body", names(totaldata))
names(totaldata) <- gsub("Mag", "Magnitude", names(totaldata))
names(totaldata) <- gsub("^t", "time", names(totaldata))
names(totaldata) <- gsub("^f", "frequency", names(totaldata))
names(totaldata) <- gsub("-freq()", "Frequency", names(totaldata))
names(totaldata) <- gsub("[-()]", "", names(totaldata))



# Extracting mean and std data
totaldata <- totaldata[grep("^subject|^activity|.*Mean.*|.*STD.*", names(totaldata))]



# Creating a second tidy data set
newdata <- aggregate(. ~subject + activity, totaldata, mean)
newdata <- newdata[order(newdata$subject, newdata$activity),]
write.table(newdata, "tidydata.txt", row.names = FALSE)