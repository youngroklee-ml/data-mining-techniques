# ch09_ex08_breast_cancer.R
# ch9.3 nonlinear SVM

# ex9.8

# load package
library(kernlab)
library(yardstick)

# load data
dat <- read.csv("data/breast-cancer-wisconsin.csv")
dat$class <- factor(dat$class)

# remove ID column (X1)
dat <- dat[, -1]

# remove observations with missing value:
# there are 16 observations with missing values in X7
dat <- na.omit(dat)

# split train/test data
train_idx <- 1:455
train_dat <- dat[train_idx, ]
test_dat <- dat[-train_idx, ]

# train SVM with Gaussian kernel with sigma = 1
model <- ksvm(
  class ~ .,
  data = train_dat,
  kernel = "rbfdot",
  kpar = list(sigma = 1),
  C = 10
)

print(model)

# prediction on train data
train_dat$pred_class <- predict(model, train_dat)

# confusion matrix
conf_mat(train_dat, truth = "class", estimate = "pred_class")

# prediction on test data
test_dat$pred_class <- predict(model, test_dat)

# confusion matrix
conf_mat(test_dat, truth = "class", estimate = "pred_class")


# redo analysis with sigma = 0.1
train_dat$pred_class <- NULL  # remove pred_class variable

model <- ksvm(
  class ~ .,
  data = train_dat,
  kernel = "rbfdot",
  kpar = list(sigma = 0.1),
  C = 10
)

print(model)

# prediction on test data
test_dat$pred_class <- predict(model, test_dat)

# confusion matrix
conf_mat(test_dat, truth = "class", estimate = "pred_class")


