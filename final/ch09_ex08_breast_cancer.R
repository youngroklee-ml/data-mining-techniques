# ch09_ex08_breast_cancer.R
# ch9.3 nonlinear SVM

# ex9.8

# load package
library(kernlab)
library(yardstick)

# load data
dat <- read.csv("data/breast-cancer-wisconsin.csv")
dat$class <- factor(dat$class)

# remove observations with missing value:
# there are 16 observations with missing values in X7
dat <- na.omit(dat)

# split train/test data
train_idx <- which(dat$X1 %% 3 < 2)
train_dat <- dat[train_idx, ]
test_dat <- dat[-train_idx, ]

# train SVM with Gaussian kernel with sigma = 1
# exclude X1 from predictors
model1 <- ksvm(
  class ~ . - X1,
  data = train_dat,
  kernel = "rbfdot",
  kpar = list(sigma = 1),
  C = 10
)

print(model1)

# confusion matrix on train data
train_results1 <- data.frame(
  class = train_dat$class,
  pred_class = predict(model1, train_dat)
)
conf_mat(train_results1, truth = "class", estimate = "pred_class")

# confusion matrix on test data
test_results1 <- data.frame(
  class = test_dat$class,
  pred_class = predict(model1, test_dat)
)
conf_mat(test_results1, truth = "class", estimate = "pred_class")


# train SVM with Gaussian kernel with sigma = 2
# exclude X1 from predictors
model2 <- ksvm(
  class ~ . - X1,
  data = train_dat,
  kernel = "rbfdot",
  kpar = list(sigma = 2),
  C = 10
)

print(model2)

# confusion matrix on train data
train_results2 <- data.frame(
  class = train_dat$class,
  pred_class = predict(model2, train_dat)
)
conf_mat(train_results2, truth = "class", estimate = "pred_class")

# confusion matrix on test data
test_results2 <- data.frame(
  class = test_dat$class,
  pred_class = predict(model2, test_dat)
)
conf_mat(test_results2, truth = "class", estimate = "pred_class")
