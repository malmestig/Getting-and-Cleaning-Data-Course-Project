## Getting and Cleaning Data - Course Project

## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement. 
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 
## Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Read in the features (column names for the datasets)
features <- read.table("UCI HAR Dataset/features.txt")
colnames(features) <- c("ID", "name")

## Read in the activity labels.
labels <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(labels) <- c("ID", "name")

## Read in test labels, subjects & set to separate dataframes
test.labels <- read.table("UCI HAR Dataset/test/y_test.txt")
test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt",colClasses = c("factor"))
test.set <- read.table("UCI HAR Dataset/test/X_test.txt")
## Label each variable with its corresponding feature name
colnames(test.set) <- features$name

## Add columns 
## * Subject (denoted by ID) 
## * Activity (denoted by corresponding activity label), 
## * Only the ones matching "mean" or "std" from the original dataset
test.set <- cbind(Subject = test.subject[,1],
                  Activity = sapply(test.labels[,1], function(x) labels[labels$ID == x,]$name),
                  test.set[, grep("mean|std", colnames(test.set))])

## Read in training labels, subjects & set to separate dataframes
training.labels <- read.table("UCI HAR Dataset/train/y_train.txt")
training.subject <- read.table("UCI HAR Dataset/train/subject_train.txt",colClasses=c("factor"))
training.set <- read.table("UCI HAR Dataset/train/X_train.txt")
## Label each variable with its corresponding feature name
colnames(training.set) <- features$name

## Add columns 
## * Subject (denoted by ID) 
## * Activity (denoted by corresponding activity label), 
## * Only the ones matching "mean" or "std" from the original dataset
training.set <- cbind(Subject = training.subject[, 1],
                      Activity=sapply(training.labels[, 1], function(x) labels[labels$ID == x,]$name),
                      training.set[, grep("mean|std", colnames(training.set))])
## Rowbind together the two.
total.set <- rbind(test.set, training.set)
## Write tidy data set to a text file
write.table(total.set,file="tidydata1.txt",row.name=FALSE)

## Create the mean aggregate of all variables given Subject + Activity
aggregate <- aggregate(total.set[, -c(1:2)], 
                       list(Subject = as.numeric(total.set$Subject),
                            Activity = total.set$Activity), 
                       mean)

## Change the column names to signify that it is an aggregated mean of the variable
colnames(aggregate)[-c(1:2)] <- sapply(colnames(aggregate)[-c(1:2)], function(x) paste("Mean of", x))

## Write tidy data set to a text file
write.table(aggregate,file="tidydata2.txt",row.name=FALSE)