# ch7_iris_LDA.R
# ch7.5 LDA with 3 types 

# load library
library(ggplot2)
library(MASS) # for LDA, QDA
library(caret) # confusion matrix

# read csv file# read csv file
iris<-read.csv("data/iris.csv",stringsAsFactors = TRUE)

# training/ test data : n=150
set.seed(1000)
n <- nrow(iris)
# train set 100, test set 50
tr.idx <- sample.int(n, size = round(2/3* n))

# attributes in training and test
iris.train<-iris[tr.idx,-5]
iris.test<-iris[-tr.idx,-5]

# target value in training and test
trainLabels<-iris[tr.idx,5]
testLabels<-iris[-tr.idx,5]

train<-iris[tr.idx,]
test<-iris[-tr.idx,]

# Linear Discriminant Analysis (LDA)
iris.lda <- lda(Species ~ ., data=train, prior=c(1/3,1/3,1/3))
iris.lda

#iris.lda <- lda(Species=Setal.Length+Setal.Width+Petal.Length+Petal.Width, data=train, prior=c(1/3,1/3,1/3))

# predict test data set n=50
testpred <- predict(iris.lda, iris.test)
testpred

# accuracy of LDA
confusionMatrix(testpred$class,testLabels)
