datascience3project
===================


run_analysis.R is a R script to create the 2 datasets required for the project of
the course "Getting and Cleaning Data".

The script:

- stores in a variable data1 the content of both X_train.txt and X_test.txt

- extracts the names of the fields from the file features.txt and use them for
  the names of the dataset data1

- excludes from the dataset the fields which are neither a mean nor a std

- reads the content of the files activity_labels.txt and y_train.txt + y_test.txt
  to create a column with descriptive activity

- adds this columns to the dataset and renames it

- reads from the files y_train.txt and y_test.txt the identification of the volunteers
  and adds the data as a new column in front of the dataset




- then uses aggregates to create a new dataset, data2, with the means of all the
  measurements, aggregated by volunteer_ID and by activity

- writes the dataset data2 to a file dataset2.txt
