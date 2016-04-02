
library(dplyr)

features <- read.table("UCI HAR Dataset/features.txt",header = FALSE,stringsAsFactors = FALSE)

if (!exists("X_train_src")) # dont read these massive tables at every run
{
  X_train_src <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features[,2] ,header = FALSE,stringsAsFactors = FALSE)#,check.names=FALSE)
  X_test_src <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features[,2] ,header = FALSE,stringsAsFactors = FALSE)#,check.names=FALSE)
}

features <-colnames(X_train_src)
inds<- grep("mean|std",features)
reqFeatures <- features[inds]
inds2<- grep('^(?!.*meanFreq).*$',reqFeatures, perl =T)
reqFeatures <- reqFeatures[inds2]

X_train<- X_train_src[,reqFeatures]
X_test<- X_test_src[,reqFeatures]

y_train <- read.table("UCI HAR Dataset/train/y_train.txt",header = FALSE,stringsAsFactors = FALSE, col.names = "actid")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt",header = FALSE,stringsAsFactors = FALSE, col.names = "actid")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",header = FALSE,stringsAsFactors = FALSE, col.names = "subject")
subject_test<- read.table("UCI HAR Dataset/test/subject_test.txt",header = FALSE,stringsAsFactors = FALSE, col.names = "subject")

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",header = FALSE,stringsAsFactors = FALSE, col.names = c("actid","activityName"))

activities_train <- left_join(x = y_train, y = activity_labels, by.x  = "actid",by.y  = "actid" ,  all = TRUE ,sort = FALSE )
activities_test <- left_join(x = y_test,y = activity_labels,  by.x  = "actid",by.y  = "actid" ,  all = TRUE ,sort = FALSE)

X_train <-cbind(subject_train["subject"],activities_train["activityName"], X_train)
X_test <-cbind(subject_test["subject"], activities_test["activityName"], X_test)

X<- full_join(X_train,X_test)

Xg<- group_by(X, subject, activityName)
Xmean <- summarise_each(Xg, funs(mean))

write.table(Xmean, file = "Q5.txt", row.names = FALSE)



