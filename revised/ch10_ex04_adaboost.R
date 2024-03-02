# ch10_ex04_adaboost.R
# Ch10.4 AdaBoost

# load packages
library(JOUSBoost)
library(rpart)
library(rpart.plot)

# load data
dat <- read.csv("data/ch10_dat1.csv")
dat$X1 <- factor(dat$X1)
dat$X2 <- factor(dat$X2)
dat$X3 <- factor(dat$X3)
dat$Y <- factor(dat$Y)

# create training data
X <- model.matrix(Y ~ . - 1, dat) # create predictor variable matrix
y <- ifelse(dat$Y == "yes", 1, -1)

# estimate AdaBoost model
# with 3 trees
fit <- adaboost(X, y, tree_depth = 1, n_rounds = 3)

# plot each score tree
for (i in seq_along(fit$trees)) {
  rpart.plot(fit$trees[[i]], roundint = FALSE)
}

# values of alpha
fit$alphas

# predicted probability of y = 1 on training data
posterior1 <- predict(fit, X = X, type = "prob")
round(posterior1, 2)

# predicted class on training data
pred_class <- predict(fit, X = X, type = "response")
pred_class

# confusion matrix on training data
fit$confusion_matrix
