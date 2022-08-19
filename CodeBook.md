##Original source:
he data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

##R script :
1. Reading in the files and merging the training and the test sets to create one data set.      
2. Extracting only the measurements on the mean and standard deviation for each measurement:   
3. Using descriptive activity names to name the activities in the data set   
4. Appropriately labeling the data set with descriptive variable names(done during the code, not in particular parts)
5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject:
   Making and Writing a second tidy dataset.  

##tidyDataset:
output of R script: download R script and execute it in R studio.

##variables: 
*`x_train`, `x_test`,`y_train`, `y_test`, `subject_train` and `subject_test` are from the original files.
* `features` contains the correct names for the `x_data` dataset.


