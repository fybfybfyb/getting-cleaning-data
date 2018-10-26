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
df_sub <- df[,c(1,2,mean_std)]
colnames(df_sub) <- c("subject","activity",features[mean_std])



activityName <- fread('.\\UCI HAR Dataset\\activity_labels.txt',data.table = F)
activityName <- activityName[,2]
df$activity <- activityName[df$activity]
#df$activity <- factor(df$activity, levels = activityName[,1] , labels = activityName[,2])


names(df) <- gsub("\\()","",names(df))
names(df) <- gsub("^t","time",names(df))
names(df) <- gsub("^f","frequence",names(df))
names(df) <- gsub("Acc","Accelerometer",names(df))
names(df) <- gsub("Gyro", "Gyroscope",names(df))
names(df) <- gsub("Mag", "Magnitude",names(df))
names(df) <- gsub("BodyBody", "Body",names(df))



df1 <- df[,3:ncol(df)]
group<-aggregate(df1, by =list(df$subject , df$activity),FUN = mean)
write.table(x = group, file = "group.txt", row.names = FALSE)

