# ch7_iris_LDA.R
# ch7.5 LDA with 3 types

# load library
library(MASS) # for LDA
library(yardstick) # confusion matrix

# read csv file# read csv file
iris <- read.csv("data/iris.csv", stringsAsFactors = TRUE)
names(iris) <- c("x1", "x2", "x3", "x4", "class")

# train set: first 30 rows by class
tr_idx <- c(1:30, 51:80, 101:130)
train <- iris[tr_idx, ]

# Linear Discriminant Analysis (LDA)
iris_lda <- lda(class ~ ., data = train, prior = c(1 / 3, 1 / 3, 1 / 3))
iris_lda

# predict: first row by class 
pred_idx <- c(1, 51, 101)
pred <- predict(iris_lda, newdata = iris[pred_idx, -5])
pred

# summary table
results <- cbind(iris[pred_idx, ], pred_class = pred$class)
results

# OPTIONAL: Predict on hold-out test data

# test set: all except training data
test <- iris[-tr_idx, ]
pred_test <- predict(iris_lda, newdata = iris[-tr_idx, -5])
results_test <- cbind(test, pred_class = pred_test$class)

# confusion matrix
cm <- conf_mat(results_test, truth = "class", estimate = "pred_class")
cm
