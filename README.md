# Getting and Cleaning Data Course Project

This is the course project for Getting and Cleaning Data. 
The purpose of the project is to demonstrate the ability to collect, work with, and clean a data set. 

## Original dataset

The original dataset is from [Human Activity Recognition Using Smartphones Data Set ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The dataset was downloaded and consists of a number of files, which can be read in directly using R, without any need for pre-processing.
Reading the forums for some pointers led me to understand that we don't need the inertial folders, and that data provided is ready to transform straight away.

## Transformations to the dataset

All the transformations are in a single script file, run_analysis.R. 

1. Doing a quick analysis of the text files shows that some of the files are meant to be joined or linked and can be seen as "dictionaries". These contain the feature names, and the activity label names. 
The files are read in as dataframes and given a name-value style (ID, name)

2. Next it is a question of reading in the test and training data.

a. For each, there are 3 important pieces: The activity labels being measured, the subjects undergoing the measurements (subjects are divided among the test and training data, no subject is in both), and the variable ( feature ) measurements. These are all read in as dataframes.

b. For the variable measurements dataframe , I set the column names to the feature names extracted in step 1. 

c. What I understand from the project description is to extract measurements relating to the mean and standard deviation. By reading the information provided in the original dataset (feature_info.txt), if a features is a mean or standard deviation, it will be decorated with mean, or std, respectively. Since I now have set the variable names to the feature names, I run a grep and search for variables (columns) containing "mean or "std" . These variables are retained in the resulting dataset while the ones not matching are not included.

d. I expand the variable measurements dataframe with the subject and activity columns by colbinding them together.

3. I add the test and training sets together to form a total dataset. 

4. The means of the measuremtns is acheived by using an aggregate function given the Subject and Activity columns.
Finally the column names are changed slightly, see below.

## My tidy dataset

As for the variable names, I chose to retain the somewhat hard-to-read name because of 3 facts:

1. I don't know enough about the actual features used to change the names substantially.
2. I build on an existing dataset and want to be able to cross-reference the results I get with the original dataset.
3. The names are already quite compact and expanding the names, for example "fBodyAccJerk-meanFreq()-Y" into something like "Body Acceleration Jerk Mean Frequency Y", might just end up making the dataset more difficult to read. English is also not my first language so I could just mess it up.

So what I chose instead was to prefix "Mean of " to each column. That makes it clear that the column is an aggregated variable.
