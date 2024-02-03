# ch5_knn_iris.R
# Classification
# k-Nearest Neighbor with Iris data
# to find optimal k

# load library
library(tidyverse)
library(class) # for knn
library(caret) # for confusion matrix

# read csv file
iris<-read.csv("data/iris.csv", stringsAsFactors = TRUE)
# head(iris)
str(iris)
attach(iris)

# training/ test data : n=150
set.seed(1000, sample.kind="Rounding")
n <- nrow(iris)
# train set 100, test set 50
tr.idx <- sample.int(n, size = round(2/3* n))

# attributes in training and test
iris.train<-iris[tr.idx,-5]
iris.test<-iris[-tr.idx,-5]

# target value in training and test
trainLabels<-iris[tr.idx,5]
testLabels<-iris[-tr.idx,5]

# knn (5-nearest neighbor)
knn_fit<-knn(train=iris.train,test=iris.test,cl=trainLabels,k=5)
knn_fit
help(knn)

# confusion matrix
# accuracy of 5-nearest neighbor classification
confusionMatrix(knn_fit,testLabels)




