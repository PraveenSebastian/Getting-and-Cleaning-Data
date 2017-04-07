

No of files in this repopsitory are 3.

1.Readme
2.Codebook
3.R code for analysis 


Main code contains the following steps:

#Read the files like activity,subject etc..
#Merges the training and the test sets to create one data set
#Concatenate the data tables by rows

#Set names to variables

#Extracts only the measurements on the mean and standard deviation for each measurement

#Subset Name of Features by measurements on the mean and standard deviation


#Subset the data frame Data by seleted names of Features


#seeing the structures of the data frame Data


#Uses descriptive activity names to name the activities in the data set
#Read descriptive activity names from “activity_labels.txt”


#Facorize Variale activity in the data frame Data using descriptive activity names and check
head(Data$activity,30)

#Appropriately labels the data set with descriptive variable names
#Replacing short forms with full names

#Checking
names(Data)

#Creates a second, independent tidy data set with the average of each variable for each activity and each subject










