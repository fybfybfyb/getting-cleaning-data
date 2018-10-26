## Getting and Cleaning Data Course Project
## Purpose
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit:
* 1 a tidy data set as described below, 
* 2 a link to a Github repository with your script for performing the analysis
* 3 a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 

You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

## Steps
* 1 Merges the training and the test sets to create one data set.
* 2 Extracts only the measurements on the mean and standard deviation for each measurement.
* 3 Uses descriptive activity names to name the activities in the data set
* 4 Appropriately labels the data set with descriptive variable names.
* 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## run_analysis.R
* 1 we download the data set and load them including test and train data set into our work environment.
* 2 After loading, we did the merging by using the **rbind** function
* 3 By calling **grep** function, we can extract the mean and standard deviation meansurements from the features data set.
* 4 We applied a new name vector to the column of the merged data set.
* 5 By using fread and set data.table to be false, we can laod the activities data set. Then, we replace the colunmn "activity" of merged data set with the descriptive activity names.
* 6 With **gsub** , we use the descriptive variable names to replace some short notation in the names of the merged data set.
* 7 By using the **aggregate** function, we can create a new clean data set with average of each variable for each activity and each subject.
* 8 Finally, we export our second data set into a text file called **group.txt.**
