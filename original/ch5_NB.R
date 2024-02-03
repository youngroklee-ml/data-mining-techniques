# ch5.2.Naive Bayes 

# load packages
library(e1071) # naive bayes
library(caret) # confusion matrix
library(tidyverse)

# read csv file
dat3<-read.csv("data/ch5_dat3.csv")

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
dat3$age_gr<-as.factor(dat3$age_gr)
dat3$class<-as.factor(dat3$class)

# summary about data
summary(dat3)

# Naive Bayes classification
nb_fit <- naiveBayes(formula = class ~ gender + age_gr, data = dat3)
print(nb_fit)

nb_fit$tables

# predicted class from Naive Bayes model
pred_y <- predict(nb_fit, dat3)
pred_y

# posterior probability 
nb_posterior <- predict(nb_fit, dat3, type = "raw") %>%
  as_tibble() %>%
  `colnames<-`(str_c("p", levels(dat3$class)))
nb_posterior

# classification performance measure  
cm <- confusionMatrix(data = pred_y, reference = dat3$class)
