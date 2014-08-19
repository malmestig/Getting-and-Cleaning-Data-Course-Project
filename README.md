# Getting and Cleaning Data Course Project

This is the course project for Getting and Cleaning Data. 
The purpose of the project is to demonstrate the ability to collect, work with, and clean a data set. 

## Original dataset

The original dataset is from [Human Activity Recognition Using Smartphones Data Set ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The dataset was downloaded and consists of a number of files, which can be read in directly using R, without any need for pre-processing.
Reading the forums for some pointers led me to understand that we don't need the inertial folders, and that the data is ready to transform straight away.

## Transformations to the dataset

I keep all the transformations in a single script file, run_analysis.R. 
The initial intuition is that some of the files are meant to be joined or linked and can be seen as "dictionaries".
These files are read in and given a name-value style (ID, name)

Next it is a question of reading in the test and training data. 
Since the 

What I understand from the description is to extract measurements relating to the mean and standard deviation. 
From reading the information provided in the original dataset (feature_info.txt), if a features is a mean or standard deviation, it will be decorated with mean, or std, respectively. So what I do is I run a grep and search for variables (columns) with "mean or "std" in them. These variables are retained in the resulting dataset while the ones not matching are not included.

When I join the dataframes together, I also  

## My tidy dataset

As for the variable names, I chose to retain the somewhat hard-to-read name because of 3 facts:

1. I don't know enough about the actual features used to change the names substantially.
2. I build on an existing dataset and want to be able to cross-reference the results I get with the original dataset.
3. The names are already quite compact and expanding the names, for example "fBodyAccJerk-meanFreq()-Y" into something like "Body Acceleration Jerk Mean Frequency Y", would make my dataset more difficult to read - which is less tidy in my mind. English is also not my main language so I might just mess it up.

So what I chose instead was to prefix "Mean of " to each column. That makes it clearer that the value is aggregated.