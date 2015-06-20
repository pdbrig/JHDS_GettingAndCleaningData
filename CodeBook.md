Overview
---------------------
This code book describes process of getting data from the UCI Machine Laearning Repository and creating a tiny data set.  The data is for 30 subjects who performed six activities while wearing smartphone that captured and measured data about their movement while doign the activities. 


Getting the Data
------------------

The script run_analysis.r takes downloads a zip file from the following URL:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip".
A full explanation of data in the zip file can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones following, 

Cleaning Data to make it "Tiny"
---------------------------------

The run_analysis.r script does the following, not in necessarily in this order:

* Unzips the download zip file
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names
* From the data set in the above ste, creates a second, independent tidy data set with the average of each variable for each activity and each subject
* Creates a new csv file for the tiny data set


Data sets that are used to process the data:

train - is combined training data
test is combiend test data
combinedData - is combined test and training sets
Mean_Std_Data - is the data from combinedData that only has mean and std columns 
TinyData - is the independent tiny data with mean for each activity and subject
