adl.labels <- read.table("./R/UCI HAR Dataset/activity_labels.txt", sep = "")
activityLabels <- as.character(adl.labels$V2)
activityLabels

feature.lists <- read.table("./R/UCI HAR Dataset/features.txt", sep = "")
attributeNames <- feature.lists$V2

# Data Input: Training set
Xtrain <- read.table("./R/UCI HAR Dataset/train/X_train.txt", sep = "") 

# named each column in xtrain with its associated feature names
names(Xtrain) <- attributeNames

Ytrain <- read.table("./R/UCI HAR Dataset/train/y_train.txt", sep = "")

# renamed the Ytrain column with "Activity"
names(Ytrain) <- "Activity"

# Convert it as a factor data type.
Ytrain$Activity <- as.factor(Ytrain$Activity)

# linked each level in 'Ytrain$Activity' with its associated activity labels.
levels(Ytrain$Activity) <- activityLabels


# Data Input: Subject who performed the activity for each window sample
trainSubjects <- read.table("./R/UCI HAR Dataset/train/subject_train.txt", sep = "")

# renamed the 'trainSubjects' column with "subject"
names(trainSubjects) <- "subject"

# Convert it as a factor data type.
trainSubjects$subject <- as.factor(trainSubjects$subject)


# Data Input: Test set
Xtest <- read.table("./R/UCI HAR Dataset/test/X_test.txt", sep = "")

# named each column in xtest with its associated feature names
names(Xtest) <- attributeNames


# Data Input: Test set Labels
Ytest <- read.table("./R/UCI HAR Dataset/test/y_test.txt", sep = "")

# renamed the Ytest column with "Activity"
names(Ytest) <- "Activity"

# Convert it as a factor data type.
Ytest$Activity <- as.factor(Ytest$Activity)

# linked each level in 'Ytest$Activity' with its associated activity labels.
levels(Ytest$Activity) <- activityLabels

# Data Input: Subject who performed the activity for each window sample
testSubjects <- read.table("./R/UCI HAR Dataset/test/subject_test.txt", sep = "")

# renamed the 'testSubjects' column with "subject"
names(testSubjects) <- "subject"

# Convert it as a factor data type.
testSubjects$subject <- as.factor(testSubjects$subject)

# combines the subjects, the activity labels, and the features into one data frame
test_set <- cbind(testSubjects, Ytest, Xtest)

# combines the subjects, the activity labels, and the features into one data frame
train_set <- cbind(trainSubjects, Ytrain, Xtrain)

range(colSums(is.na(train_set)))

range(colSums(is.na(test_set)))

# Insert `Partition` column into `train` data frame, then assigned value="Train"
train_set$Partition <- "Train"

# Insert `Partition` column into `test` data frame, then assigned value="Test"
test_set$Partition <- "Test"

# Combine the `train` set and `test` set into one data frame by rows
alldf <- rbind(train_set,test_set)

# Convert it as a factor data type.
alldf$Partition <- as.factor(alldf$Partition)

#extract all the columns containing meand and std
allmean <- alldf[grep('mean()', names(alldf), fixed = TRUE)]
allstd  <- alldf[grep('std()', names(alldf), fixed = TRUE)]

#create a unique dataframe with subject,activity and the selected column
all_mean_std <- cbind(alldf %>%  select(subject, Activity) , allmean, allstd)

library(dplyr)
# group by subject and activity create a dataset with the mean of all the others
by_subject_and_activity <-all_mean_std %>% group_by(subject,Activity) %>% summarise(across(everything(), list(mean)))

#i write the dataframe in a txt file
write.table(by_subject_and_activity,'./R/submission.txt', row.name=FALSE) 


