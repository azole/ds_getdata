temp: the id of train data starts from 1 and to nrow(subject_train), so the id of test data start from nrow(subject_train) plus 1. this variable set to nrow(subject_train) plus 1 to create id for test data.

total: the total of rows of train and test data.

subject_train: the subject data of train
subject_test: the subject data of test
subject: the data merged from subject_train and subject_test

x_train: the x data of train
x_test: the x data of test
x: the data merged from x_train and x_test

y_train: the y data of train
y_test: the y data of test
y: the data merged from y_train and y_test

newY: add id and rename cols name for Y

newX: add id and rename cols name for X

df: join subjec and newY
df2: join df nad newX

byGroup: group df2 by subject and y

result: calculate mean for each subject and y