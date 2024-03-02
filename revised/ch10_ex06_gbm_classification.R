# ch10_ex06_gbm_classification.R
# Ch10.5 Gradient boosting

# ex10.6

# load package
library(gbm)
library(yardstick)
library(ggplot2)

# load data
dat <- read.csv("data/ch8_dat1.csv")
dat$class <- dat$class - 1 # set class to be 0 or 1


# evaluate base model performance (i.e. p = 0.5)
# based on ROC AUC
result0 <- data.frame(
  class = factor(dat$class, levels = c(1, 0)),
  posterior1 = rep(0.5, nrow(dat))
)
roc_auc(result0, truth = "class", posterior1)
autoplot(roc_curve(result0, truth = "class", posterior1))


# estimate gradient boosting model
# with 1 tree
fit1 <- gbm(
  class ~ x1 + x2,
  data = dat,
  distribution = "bernoulli",
  n.trees = 1,
  interaction.depth = 1,
  n.minobsinnode = 1,
  shrinkage = 1, # step size = 1
  bag.fraction = 1 # no subsampling of training data
)

# evaluate classification performance
# based on ROC AUC
result1 <- data.frame(
  class = factor(dat$class, levels = c(1, 0)),
  posterior1 = predict(fit1, type = "response")
)
roc_auc(result1, truth = "class", posterior1)
autoplot(roc_curve(result1, truth = "class", posterior1))


# estimate gradient boosting model
# with 2 trees
fit2 <- gbm(
  class ~ x1 + x2,
  data = dat,
  distribution = "bernoulli",
  n.trees = 2,
  interaction.depth = 1,
  n.minobsinnode = 1,
  shrinkage = 1, # step size = 1
  bag.fraction = 1 # no subsampling of training data
)

# evaluate classification performance
# based on ROC AUC
result2 <- data.frame(
  class = factor(dat$class, levels = c(1, 0)),
  posterior1 = predict(fit2, type = "response")
)
roc_auc(result2, truth = "class", posterior1)
autoplot(roc_curve(result2, truth = "class", posterior1))

