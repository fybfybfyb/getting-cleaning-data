library(data.table)
test_x <- fread(file = '.\\UCI HAR Dataset\\test\\X_test.txt')
test_y <- fread(file = '.\\UCI HAR Dataset\\test\\y_test.txt')
subject_test <- fread(file = '.\\UCI HAR Dataset\\test\\subject_test.txt')
train_x <- fread(file = '.\\UCI HAR Dataset\\train\\X_train.txt')
train_y <- fread(file = '.\\UCI HAR Dataset\\train\\y_train.txt')
subject_train <- fread(file = '.\\UCI HAR Dataset\\train\\subject_train.txt')
features<-fread(".\\UCI HAR Dataset\\features.txt", data.table = F)[,2]
activity<-fread(".\\UCI HAR Dataset\\activity_labels.txt")
df_test <- cbind(subject_test,test_y,test_x)
df_train <- cbind(subject_train,train_y,train_x)
df <- rbind(df_test, df_train)
names(df) <- c('subject','activity',features)



features <- as.character(features)
mean_std <- grep("mean\\(\\)|std\\(\\)",features)
df_clean <- df[,c(1,2,mean_std + 2)]
colnames(df_clean) <- c("subject","activity",features[mean_std])



activityName <- fread('.\\UCI HAR Dataset\\activity_labels.txt',data.table = F)
activityName <- activityName[,2]
df_clean$activity <- activityName[df_clean$activity]
#df$activity <- factor(df$activity, levels = activityName[,1] , labels = activityName[,2])


names(df_clean) <- gsub("\\()","",names(df_clean))
names(df_clean) <- gsub("^t","time",names(df_clean))
names(df_clean) <- gsub("^f","frequence",names(df_clean))
names(df_clean) <- gsub("Acc","Accelerometer",names(df_clean))
names(df_clean) <- gsub("Gyro", "Gyroscope",names(df_clean))
names(df_clean) <- gsub("Mag", "Magnitude",names(df_clean))
names(df_clean) <- gsub("BodyBody", "Body",names(df_clean))



df1 <- df_clean[,3:ncol(df_clean)]
group<-aggregate(df1, by =list(df_clean$subject , df_clean$activity),FUN = mean)
write.table(x = group, file = "group.txt", row.names = FALSE)

