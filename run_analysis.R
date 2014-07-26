run_analysis <- function() {
      ####################################################
      # STEPS 1 to 4: CREATION OF THE FIRST TIDY DATASET #
      ####################################################
      
      # X-train and X_test contains the measurements of the experiment
      # we store in the variable data1 the content of these two files
      
      data1 <- rbind ( read.table("X_train.txt"), read.table("X_test.txt"))
      
      # the name of the fields are in the file feature.txt. When reading the file into
      # a table, the name are in the column number two
      # therefore we use the following command to assign the names of the fields
      
      names(data1) <- read.table("features.txt")[,2]
      
      # we need to keep data related to the mean and std of the measurements
      # for the mean, the name ends with "mean"
      # for the standard deviation, the name ends with "std"
      # the following command stores in data2 only the fields with "std" or "mean" in their name
      
      data1 <- cbind( data1[, grep("mean", colnames(data1))], data1[, grep("std", colnames(data1))])
      
      # However, some fields end with meanFreq and they need to be excluded of the dataset
      # This command will exclude the meanFreq measurements and store the result in data3
      
      data1 <- data1[, grep("meanFreq", colnames(data1), invert = TRUE)]
      
      # We need to add the descriptive activity in the dataset. The number of the activity is store in 
      # y_test.txt and y_train.txt, while the name is store in the file activity_labels.txt
      # First, we store the names in a variable
      
      label1 <- read.table("activity_labels.txt")[,2]
      
      # then, we store in another variable the numbers corresponding to the activity
      
      activity1 <- rbind ( read.table("y_train.txt"), read.table("y_test.txt"))
      
      # finally, we can add this column at the beginning of our dataset
      
      data1 <- cbind (label1[activity1[,1]], data1)
      
      # renaming the activity column
      
      names(data1) <- c("activity",names(data1[,2:67]))
 
      # we can now add the identifications of the volunteers, which are in 
      # the file subject_train.txt and subject_test.txt
      # We store the content of the file in a variable identif1
      
      identif1 <- rbind ( read.table("subject_train.txt"), read.table("subject_test.txt"))
      
      # we bind this column at the beginning of our dataset
      
      data1 <- cbind (identif1,data1)

      # we rename the field newly added
      
      names(data1) <- c("volunteer_ID",names(data1[,2:68]))

      # cleaning of the temporary variables we don't need anymore
      
      remove(identif1, activity1,label1)
      
      # we now have a tidy dataset ready to be used for data analysis.
      
      ###########################################################
      # STEP 5: CREATION OF THE SECOND DATASET WITH THE AVERAGE #
      #    OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT  #
      ###########################################################
      
      # storing in data2 the mean of each measurement by subject and activity
      
      data2 <- aggregate(data1[,3:68], by=list(data1$volunteer_ID,data1$activity),FUN=mean, na.rm=TRUE)
      
      # renaming the 2 first columns
      
      names(data2) <- c("volunteer_ID", "activity",names(data1[,3:68]))
      
      # writing the final dataset to a file
      
      write.table(data2,file="dataset2.txt",col.names= TRUE, row.names= FALSE, sep = " ")
      
      
      

}