  

Course Project for 'Getting and Cleaning Data'
=========================================

Purpose
=========================================
To demonstrate your ability to collect, work with, and clean a data set.

Raw Data
------------------

This dataset is derived from the "Human Activity Recognition Using Smartphones Data Set" which was originally made avaiable here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Features (561 features) that are unlabled and can be found in the x_test.txt. 
Activity labels can be found in the y_test.txt file.
Test subjects can be found in the subject_test.txt file.

The same holds for the training set.

Script and Tidy data
-------------------------------------
The 'run_analysis.R' file can be ran from any working directory, but it does require the data.table and plyr libraries to be installed to work. The script will merge the test and training sets together. The Script will create a Tidy dataset containing the means of all the columns per test subject and per activity. The final output will be 'FullData.txt' which contains the complete dataset, and 'Tidy.txt' which contains the 'tidy' aggregated dataset.

Both the FullData.txt and 'Tidy.txt' can be found in this repository

About the Code Book
-------------------
The CodeBook.md file describes the variables, the data, and any transformations performed to clean up the data.
