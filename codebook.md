# Codebook
run_analysis.R contains a couple sets of variables which creates a tidy dataset.
 - In the first two commands, dataset is downloaded and unzipped.
 - In second set features.txt and activity_labels.txt are loaded in `features` and `activity` variables.
 - Now the train data is loaded with x_train.txt loaded into `xtrain`, y_train.txt in `ytrain` with the column names of ytrain as "value", subject_train.txt in `trainsubject` and these three variables are merged with `cbind` into `train`.
 - Then similarly test data is loaded merged with `cbind` into `test`.
 - Next both train and test data are merged with `rbind` into `totaldata`.
 - Then values from `activity` are placed into columns that are named as "value".
 - Afterwards the data is labelled with names. First, the values in the second column of `features` are turned into characters so it can be used as names. Secondly, column names of `totaldata` are changed into "subject", "activity" and the values of `features[,2]` respectively. Finally, some column names of `totaldata` are corrected in readable format.
 - In next step, the required 'Mean' and 'Std' data is subset with `grep` and `totaldata` is modified.
 - In the last step, averages of all columns are taken with `aggregate` with the exception of "subject" and "activity" , then is ordered by "subject" and "activity", saved in a new variable called `newdata` and finally written into the file tidydata.txt.