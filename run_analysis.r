  #  Here are the objectives of the project:  
  # 1. Merges the training and the test sets to create one data set.
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  # 3. Uses descriptive activity names to name the activities in the data set
  # 4. Appropriately labels the data set with descriptive variable names
  # 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Pre steps , get the file and unzip and read data into variable to merge
zip_file_url <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists("./Data/Dataset.zip")){
	download.file(zip_file_url, destfile = "./Data/Dataset.zip", method = "curl")
  }
unzip("./Data/Dataset.zip",overwrite=TRUE)

setwd("./UCI HAR Dataset/")

library(reshape2)

  # load files into variables
x_test <- read.csv("./test/X_test.txt",header = FALSE,sep = "")
y_test <- read.csv("./test/y_test.txt",header = FALSE,sep = "")
subject_test <- read.csv("./test/subject_test.txt",header = FALSE,sep = "")
x_train <- read.csv("./train/X_train.txt",header = FALSE,sep = "")
y_train <- read.csv("./train/y_train.txt",header = FALSE,sep = "")
subject_train <- read.csv("./train/subject_train.txt",header = FALSE,sep = "")
activity_labels <-read.csv("./activity_labels.txt",header = FALSE,sep = "")
features <- read.csv("./features.txt",header = FALSE, sep =  "")


  # add descriptive labels 
names(subject_test) <- "subjectID"
names(subject_train) <- "subjectID"
names(x_train) <-features$V2
names(x_test) <-features$V2
names(y_train) <-"activity"
names(y_test) <-"activity"


# add descriptions for activity
y_train$activity_desc <- ifelse(y_train$activity == 1, "WALKING",
                                ifelse(y_train$activity == 2, "WALKING_UPSTAIRS",
                                       ifelse(y_train$activity == 3, "WALKING_DOWNSTAIRS",
                                              ifelse(y_train$activity == 4, "SITTING",
                                                     ifelse(y_train$activity == 5, "STANDING",
                                                            ifelse(y_train$activity == 6,"LAYING",NA))))))

y_test$activity_desc <- ifelse(y_test$activity == 1, "WALKING",
                               ifelse(y_test$activity == 2, "WALKING_UPSTAIRS",
                                      ifelse(y_test$activity == 3, "WALKING_DOWNSTAIRS",
                                             ifelse(y_test$activity == 4, "SITTING",
                                                    ifelse(y_test$activity == 5, "STANDING",
                                                           ifelse(y_test$activity == 6,"LAYING",NA))))))

# combine datasets
train <-cbind(subject_train, y_train, x_train)
test <-cbind(subject_test, y_test, x_test)
combinedData <-rbind(train,test)



# get only the mean and standard deviation columns
MeanColumns <- grep("mean()",names(combinedData),invert = "FALSE",fixed = TRUE)
StdColumns <- grep("std()",names(combinedData),invert = "FALSE",fixed = TRUE)
Mean_Std_Data <- combinedData [,c(1,3,MeanColumns,StdColumns)]


# melta the data nd create a tidy data
grouped <-group_by(Mean_Std_Data,subjectID,activity_desc)
MeltData <- melt(grouped,id=c("subjectID","activity_desc"),meausure.vars=c(MeanColumns,StdColumns))
TinyData <-dcast(MeltData, subjectID + activity_desc ~ variable, mean)
# create tiny data set
write.csv(TinyData,"TinyData.csv",row.names = FALSE)
