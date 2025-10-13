The input dataset is placed in the directory /R under the working directory
import the activity labels and the attribute names lists for test and train set
For the training and test set extrac the attributes and the features
Then names each column in xtrain and xtest with its associated feature names
Then links each level  with its associated activity labels.
Extracts Subject who performed the activity for each window sample for test and train set
combines the subjects, the activity labels, and the features into one data frame for train and test set
Insert `Partition` column into `train` data frame, then assigned value="Train"
Insert `Partition` column into `test` data frame, then assigned value="Test"
Combine the `train` set and `test` set into one data frame by rows
extract all the columns containing meand and std
create a unique dataframe with subject,activity and the selected column
group by subject and activity create a dataset with the mean of all the others
write the dataframe in a txt file
