# GCDP
Coursera Getting and cleaning data final project created by Michael

The script does the following:
1)read "features" - a list of names of the dataset variables (columns).
2)if not already in memory, read "X_train", "X_test" - the actual data 
3)by using regular expressions, extract only columns holding mean and 
  standard deviation values (inds, reqFeatures)
4)by using regular expressions, exclude all meanFreq columns (inds2, reqFeatures)
5)select from "X_train", "X_test" only columns defined by reqFeatures
6)read "y_train", "y_test", which indicate what activity is made in each 
  measurement (by activity id)
7)read "subject_train", "subject_test" which indicate a person making that activity
8)read "activity_labels" - list of all activity types by id
9)merge "activity_labels" with "y_*" so that every measurement row 
  has its activity name corresponding to it  ("activities_train","activities_test")
10)bind the subject, activity name and the data columns together ("X_train", "X_test")
11)join the two datasets into one (X)
12)group the dataset by subject and activity (Xg)
13)calculate the average of each variable for each activity and each subject (Xmean)
14)save result to "Q5.txt" file