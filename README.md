# Cleaning-Data
The project for "Getting and cleaning data" course at Coursera
date: "16 January 2016"

The "run_analysis.R" script performs the cleaning of the data collected from the accelerometers from the Samsung Galaxy S smartphone.  
The code works as follows:

1. Downloading the initial data (.zip file) to the working directory. (Note! If this data has already been downloaded this step is skiped.)
2. Unpacking .zip file. This procedure creates a directory called "UCI HAR Dataset" in the working directory. "UCI HAR Dataset" contains two directories, test and train, containing the data sets from test and train subject groups. 
3. Reading the data sets from the both groups. Each data set has 561 coloumns corresponding to different measurments. However, we are only interested in the ones related with mean and standard deviation. Therefore, unnesessary coloumns are deleted. 
4. The train and test datasets are merged. In the end, we come to a table with 79 coloumns and 10299 rows.
5. We add 2 additional coloumns, called "Exercise" and "Subject" describing what activity is performed and the subject who performs the activity. 
6. The tidy data is stored in the variable 'tidy_data'
7. From the tidy data set 'tidy_data' an independent tidy data set with the average of each variable for each activity and each subject is created and stored into the variable 'new_tidy_data'

CodeBook.md contains all the information about the script.
