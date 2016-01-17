library(data.table)

# Download .zip file and unzip it into WORKING DIRECTORY 

url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
zipfile_name <- "data.zip"
if(!file.exists(zipfile_name)){
  download.file(url = url, destfile = zipfile_name, method = "curl")
}
if(!file.exists("UCI HAR Dataset")){
  unzip(zipfile_name)
  rm(zipfile_name, url)
}
rm(url, zipfile_name)

# Read test and train sets from "X_test.txt" and "X_train.txt" files.

trainset_path <- paste(getwd(),"/UCI HAR Dataset/train/",sep = "")
trainset <- data.table( read.table( paste(trainset_path, "X_train.txt", sep = "") ) ) 
testset_path <- paste(getwd(),"/UCI HAR Dataset/test/",sep = "")
testset <- data.table( read.table( paste(testset_path, "X_test.txt", sep = "") ) )

#Extract only the measurements on the mean and standard deviation for each measurement.

features_path <- paste(getwd(),"/UCI HAR Dataset/",sep = "")
features<- as.vector( read.table( paste(features_path, "features.txt", sep = "") )[[2]] ) # All the features
rm(features_path)
mean_where <- which(grepl("mean()", c(features))) # Features containing mean
std_where <- which(grepl("std()", c(features))) # Features containing std
needcols<- c(mean_where,  std_where) # Index of couloms containing mean or std 

namecols <- features[needcols] # The coloumn names
testset_tidy <- testset[, needcols, with = F]
trainset_tidy <- trainset[, needcols, with = F]
rm (features, needcols, mean_where, std_where, testset, trainset)

#Merge train and test studies

tidy_data <- merge(trainset_tidy, testset_tidy,  by = names(trainset_tidy), all = T)
rm(testset_tidy, trainset_tidy)

# Read the data about the exercises and the subjects

trainsubj <- as.vector(read.table( paste(trainset_path, "subject_train.txt", sep = "") )[[1]] )
trainex <- as.vector( read.table( paste(trainset_path, "y_train.txt", sep = "") )[[1]] )
testsubj <- as.vector(read.table( paste(testset_path, "subject_test.txt", sep = "") )[[1]] )
testex <- as.vector( read.table( paste(testset_path, "y_test.txt", sep = "") )[[1]] )
subj <- c(trainsubj, testsubj)
ex <- c(trainex, testex)
rm(testsubj, trainsubj, testex, trainex)
rm(testset_path, trainset_path)

ex[ex == 1] <- "WALKING"
ex[ex == 2] <- "WALKING_UPSTAIRS"
ex[ex == 3] <- "WALKING_DOWNSTAIRS"
ex[ex == 4] <- "SITTING"
ex[ex == 5] <- "STANDING"
ex[ex == 6] <- "LAYING"

# Moving the the coloumns with the exercie types und subject names to the first place

colnames(tidy_data) <- namecols
suppressWarnings(tidy_data[,Exercise:=ex])
tidy_data[,Subject:=subj]
col_names <- names(tidy_data)

setcolorder(tidy_data, 
                        c( last(col_names), 
                           last(col_names[1:length(col_names)-1]), 
                           col_names[1:(length(col_names)-2)] ) 
                        )
rm(col_names, namecols, subj, ex)
# Seeking for the averages of each variable for each activity and each subject.

new_tidy_data <- aggregate(tidy_data[, 3:length(tidy_data), with = F], list(tidy_data$Exercise, tidy_data$Subject), mean)
colnames(new_tidy_data)[1] <- "Exercise"
colnames(new_tidy_data)[2] <- "Subject"

write.table(new_tidy_data, file = "step5.txt", row.names = F)

