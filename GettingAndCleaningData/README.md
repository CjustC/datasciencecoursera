  

Course Project for 'Getting and Cleaning Data'
=========================================

Purpose
=========================================
To demonstrate ability to collect, work with, and clean a data set.

Raw Data
------------------

This dataset is derived from the "Human Activity Recognition Using Smartphones Data Set" which was originally made avaiable here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The dataset includes the following files:
-----------------------------------------

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

Features (561 features) that are unlabled and can be found in the x_test.txt. Each feature vector is a row on the text file.
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

Overview of script:
1. Modules: data.table and plyr
2. Download and unpack the UCI HAR Dataset
3. the UCI HAR Dataset must be availble in a directory called "UCI HAR Dataset"
4. Get features (headers)
5. Merge X_training and X_test data into one; XData
6. Trim columns to be only the columns needed; columns containing '-mean' and '-std'
7. Merge y_training and y_test into one; YData (Activity)
8. Match Activity levels with YData
9. Merge subject_training and subject_test into one; SubData  (Who did the Activity)
10. Merge XData, YData, and SubData into one large dataset; 'FullData'
11. Load and rename column labels with meaningful language
12. Create Tidy data
13. Write both 'FullData' and Tidy data to flat files
