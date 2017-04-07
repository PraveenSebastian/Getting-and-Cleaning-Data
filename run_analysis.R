# Creating a directory named data if it does not exist

setwd("C:/Users/praveen/Desktop/coursera")

if(!file.exists("./data"))
{
  dir.create("./data")
}

#Specifying file Url, download the file from web and put the zip file in the data folder.
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Testdata.zip")

#Unzip the file
unzip("./data/Testdata.zip",exdir="./data")

#Get the list of the files.Unzipped files are kept in UCI HAR Dataset
path_ref <- file.path("./data", "UCI HAR Dataset")
files <- list.files(path_ref,recursive=TRUE)
files

#Read the files like activity,subject etc..
dataActivityTest  <- read.table(file.path(path_ref, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_ref, "train", "Y_train.txt"),header = FALSE)

dataSubjectTrain <- read.table(file.path(path_ref, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_ref, "test" , "subject_test.txt"),header = FALSE)

dataFeaturesTest  <- read.table(file.path(path_ref, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_ref, "train", "X_train.txt"),header = FALSE)

#Properties of variable
str(dataActivityTest)
str(dataActivityTrain)
str(dataSubjectTest)
str(dataSubjectTrain)
str(dataFeaturesTest)
str(dataFeaturesTrain)

#Merges the training and the test sets to create one data set
#Concatenate the data tables by rows
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity <- rbind(dataActivityTrain, dataActivityTest)
dataFeatures <- rbind(dataFeaturesTrain, dataFeaturesTest)

#Set names to variables
names(dataSubject) <- c("subject")
names(dataActivity) <- c("activity")
dataFeaturesNames <- read.table(file.path(path_ref,"features.txt"),head =FALSE)
names(dataFeatures) <- dataFeaturesNames$V2
#Merge columns
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)
#Extracts only the measurements on the mean and standard deviation for each measurement

#Subset Name of Features by measurements on the mean and standard deviation
subdataFeaturesNames <- dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)",dataFeaturesNames$V2)]

#Subset the data frame Data by seleted names of Features
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

#seeing the structures of the data frame Data
str(Data)

#Uses descriptive activity names to name the activities in the data set
#Read descriptive activity names from "activity_labels.txt"
activityLabels <- read.table(file.path(path_ref, "activity_labels.txt"),header = FALSE)

#Facorize Variale activity in the data frame Data using descriptive activity names and check
head(Data$activity,30)

#Appropriately labels the data set with descriptive variable names
#Replacing short forms with full names
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

#Checking
names(Data)

#Creates a second, independent tidy data set with the average of each variable for each activity and each subject
install.packages("plyr")
library(plyr)
Data2 <- aggregate(. ~subject + activity, Data,mean)
Data2 <- Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)









