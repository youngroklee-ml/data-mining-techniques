# ch5_NB_accuracy_ROC.R
# Classification
# Naive Bayes 
# sensitivity, specificity, f-score, ROC

# packages
install.packages("tidyverse")
install.packages("class")# for knn
install.packages("caret")# for confusion matrix
install.packages("e1071")# for naiveBayes

library(tidyverse)
library(class)
library(caret)
library(e1071)

# set working directory
setwd("D:/tempstore/2024_Chjun/data")

# ch5.2.Naive Bayes 

# read csv file
dat3<-read.csv("ch5_dat3.csv")

# training/ test data 
#set.seed(1000, sample.kind="Rounding")
n <- nrow(dat3)
# train set 2/3, test set 1/3
tr.idx <- sample.int(n, size = round(2/3* n))

# attributes in training and test
train<-dat1[tr.idx,-4]
test<-dat1[-tr.idx,-4]

# target value in training and test
trainLabels<-dat1[tr.idx,4]
testLabels<-dat1[-tr.idx,4]

# define as factor variables
dat3$age_gr<-as.factor(age_gr)
dat3$class<-as.factor(class)

attach(dat3)

# summary about data
summary(dat3)

# NaiveBayes classification
nb_fit <- naiveBayes(formula = class ~ gender + age_gr, data = dat3)
#nb_fit <- e1071::naiveBayes(formula = class ~ gender + age_gr, data = dat3)
print(nb_fit)

nb_fit$tables

# predicted class from NaiveBayes model
pred_y <- predict(nb_fit, dat3)
pred_y

# posterior probability 
nb_posterior <- predict(nb_fit, dat3, type = "raw") %>%
  as_tibble() %>%
  `colnames<-`(str_c("p", levels(dat3$class)))
nb_posterior

# predicted class for new observation for gender=M & age_gr=1
predict(nb_fit, tibble(gender = "M", age_gr = "1"))

# confusion matrix : caret library
cm <- confusionMatrix(data = pred_y, reference = dat3$class)

# accuracy measure, sensitivity, specificity, and f-score
cm$table
cm$byClass

# ch5.3.2 accuracy measure ;  f-score

# ex5-4 dat
true_y <- factor(c(rep(1, 20), rep(0, 80)), levels = c(1, 0))
pred_y <-factor(c(rep(1, 15), rep(0, 75), rep(1, 10)), levels = c(1, 0))

# confusion matrix
cm <- caret::confusionMatrix(data = pred_y, reference = true_y)
cm

# confusion table
cm$table

# accuracy measure, sensitivity, specificity, and f-score
cm$byClass

f_score <- cm$byClass['F1']
print(f_score)

# ch5.4 ROC

# ex5-5 dat

# read csv file
dat5<-read.csv("ch5_dat5.csv")

dat5$class<-factor(dat5$class,levels = c(1, 0))

# (1) if x>=40 then class=1
pred_y<-factor(as.integer(dat5$x >= 40), levels = c(1, 0))

cm40 <- caret::confusionMatrix(pred_y,dat5$class)

# confusion table
cm40$table

# accuracy measure, sensitivity, specificity, and f-score
cm40$byClass

# (2) if x>=50 then class=1
pred_y<-factor(as.integer(dat5$x >= 50), levels = c(1, 0))

cm50 <- caret::confusionMatrix(pred_y,dat5$class)

# confusion table
cm50$table

# accuracy measure, sensitivity, specificity, and f-score
cm50$byClass

