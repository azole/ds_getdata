## set correct working directory
## setwd("Course/DataScience/03Getting and Cleaning Data/homeworks/project1/UCI HAR Dataset/")

## load test data
subject_test<-read.csv("test/subject_test.txt", header=F)
x_test<-read.table("test/X_test.txt", header=F)
y_test<-read.csv("test/y_test.txt", header=F)

## load train data
subject_train<-read.csv("train/subject_train.txt", header=F)
x_train<-read.table("train/X_train.txt", header=F)
y_train<-read.csv("train/y_train.txt", header=F)

## calculate id
temp<-nrow(subject_train)+1
total<-nrow(subject_test)+nrow(subject_train)

# merge subject by id
subject_train$id<-c(1:nrow(subject_train))
subject_test$id<-c(temp:total)
subject<-merge(subject_train, subject_test, all=T)
names(subject)<-c("subject", "id")

# merge data y by id
y_train$id<-c(1:nrow(y_train))
y_test$id<-c(temp:total)
y<-merge(y_train, y_test, all=T)
newY<-arrange(y, id)

## finished step3: Uses descriptive activity names to name the activities in the data set
activity<-read.table("activity_labels.txt", header=F)
newY<-join(newY, activity, by="V1")
newY<-newY[, c("id", "V2")]
names(newY)<-c("id", "y")

## merge data x by id
x_train$id<-c(1:nrow(x_train))
x_test$id<-c(temp:total)
x<-merge(x_train, x_test, all=T)
newX<-arrange(x, id)

## step4: Appropriately labels the data set with descriptive variable names. 
features<-read.table("features.txt", header=F, stringsAsFactors=F)
f<-features$V2
f[562]="id"
names(newX)<-f

subX<-newX[, c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543, 562)]

## join all data
library(plyr)
df<-join(subject, newY, by="id")

df2<-join(df, subX, by="id")
df2$subject<-as.factor(df2$subject)

## step5: calculate the average of each variable for each activity and each subject.
library(dplyr)
byGroup <- df2 %>% group_by(subject, y)
result <- byGroup %>% summarise_each(funs(mean(.)))
write.table(result, file="result.txt", row.name=F)