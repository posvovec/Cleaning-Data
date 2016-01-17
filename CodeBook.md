---
title: The code book to the "run_analysis.R" script
date: "16 January 2016"
output: html_document
---

1. Downloading the inital data from the WEB and saving it to the working directory.
    * url - the url link from where the original data can be downloaded
    * zipfile_name - is the name of the downloaded .zip file
2. Reading the train and test data sets from the files "test/X_test.txt" and "train/X_train.txt". They are stored in the variables "trainset" and "testset".
3. Reading the "features.txt" file containing 561 different features. 
4. Accoding to the task we need only features computing means and standard deviations. 
5. We seek for the corresponding coloumns using the `grepl` function
    * needcol - is the integer contain the indeces of the needed coloumns
    * namecols is the numeric vector with the names of the needed coloumns. Its length is 79.  It containes the following elements:  
    "tBodyAcc-mean()-X"               
    "tBodyAcc-mean()-Y"  
    "tBodyAcc-mean()-Z"   
    "tGravityAcc-mean()-X"  
    "tGravityAcc-mean()-Y"    
    "tGravityAcc-mean()-Z"           
    "tBodyAccJerk-mean()-X"  
    "tBodyAccJerk-mean()-Y"   
    "tBodyAccJerk-mean()-Z"  
    "tBodyGyro-mean()-X"    
    "tBodyGyro-mean()-Y"  
    "tBodyGyro-mean()-Z"             
    "tBodyGyroJerk-mean()-X"   
    "tBodyGyroJerk-mean()-Y"  
    "tBodyGyroJerk-mean()-Z"  
    "tBodyAccMag-mean()"    
    "tGravityAccMag-mean()"    
    "tBodyAccJerkMag-mean()"         
    "tBodyGyroMag-mean()"       
    "tBodyGyroJerkMag-mean()"    
    "fBodyAcc-mean()-X"               
    "fBodyAcc-mean()-Y"        
    "fBodyAcc-mean()-Z"             
    "fBodyAcc-meanFreq()-X"             
    "fBodyAcc-meanFreq()-Y"       
    "fBodyAcc-meanFreq()-Z"        
    "fBodyAccJerk-mean()-X"             
    "fBodyAccJerk-mean()-Y"         
    "fBodyAccJerk-mean()-Z"       
    "fBodyAccJerk-meanFreq()-X"          
    "fBodyAccJerk-meanFreq()-Y"   
    "fBodyAccJerk-meanFreq()-Z"     
    "fBodyGyro-mean()-X"              
    "fBodyGyro-mean()-Y"          
    "fBodyGyro-mean()-Z"        
    "fBodyGyro-meanFreq()-X"          
    "fBodyGyro-meanFreq()-Y"      
    "fBodyGyro-meanFreq()-Z"     
    "fBodyAccMag-mean()"             
    "fBodyAccMag-meanFreq()"   
    "fBodyBodyAccJerkMag-mean()"    
    "fBodyBodyAccJerkMag-meanFreq()"  
    "fBodyBodyGyroMag-mean()"        
 "fBodyBodyGyroMag-meanFreq()"  
 "fBodyBodyGyroJerkMag-mean()"    
 "fBodyBodyGyroJerkMag-meanFreq()"  
 "tBodyAcc-std()-X"                 
 "tBodyAcc-std()-Y"               
 "tBodyAcc-std()-Z"               
 "tGravityAcc-std()-X"            
 "tGravityAcc-std()-Y"            
 "tGravityAcc-std()-Z"            
 "tBodyAccJerk-std()-X"           
 "tBodyAccJerk-std()-Y"           
 "tBodyAccJerk-std()-Z"            
 "tBodyGyro-std()-X"               
 "tBodyGyro-std()-Y"              
 "tBodyGyro-std()-Z"              
 "tBodyGyroJerk-std()-X"          
 "tBodyGyroJerk-std()-Y"          
 "tBodyGyroJerk-std()-Z"         
 "tBodyAccMag-std()"             
 "tGravityAccMag-std()"           
 "tBodyAccJerkMag-std()"       
 "tBodyGyroMag-std()"            
 "tBodyGyroJerkMag-std()"         
 "fBodyAcc-std()-X"               
 "fBodyAcc-std()-Y"               
 "fBodyAcc-std()-Z"               
 "fBodyAccJerk-std()-X"           
 "fBodyAccJerk-std()-Y"          
 "fBodyAccJerk-std()-Z"           
 "fBodyGyro-std()-X"              
 "fBodyGyro-std()-Y"               
 "fBodyGyro-std()-Z"              
 "fBodyAccMag-std()"             
 "fBodyBodyAccJerkMag-std()"      
 "fBodyBodyGyroMag-std()"         
 "fBodyBodyGyroJerkMag-std()"
  
6. testset_tidy and trainset_tidy are data frames which contain only the neaded features mentioned above.
7. Merging the testset_tidy and trainset_tidy data frames and saving the result into the new variable tidy_data.
8. Add additional coloumns with the type of the activity and the subject who perfoms the activity. Move these coloums to the front using R function `setcolorder`. 
9. Create a new variable "new_tidy_data" containing an independent tidy data set with the average of each variable for each activity and each subject using the function `aggregate`