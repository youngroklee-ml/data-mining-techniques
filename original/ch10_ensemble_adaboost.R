# library(adabag) - issue with mac os; please consider using different package
library(yardstick)

# load data
dat <- read.csv("data/ch10_dat1.csv")
dat$X1 <- factor(dat$X1)
dat$X2 <- factor(dat$X2)
dat$X3 <- factor(dat$X3)
dat$Y <- factor(dat$Y)

# AdaBoost
fit <- boosting(
  Y ~ .,
  data = dat,
  boos = TRUE,  # sampling by weights, if FALSE weighted learning
  mfinal = 3,
  control = rpart.control(maxdepth = 1, minsplit = 2),  # tree with depth 1
)

# plot each tree
plot(fit$trees[[1]])
text(fit$trees[[1]])
plot(fit$trees[[2]])
text(fit$trees[[2]])
plot(fit$trees[[3]])
text(fit$trees[[3]])

# prediction performance
result <- cbind(dat, pred_class = factor(fit$class))
cm <- conf_mat(result, truth = "Y", estimate = "pred_class")
cm
summary(cm)

# ----------------------------------------------------------------
# Vehicle data example

library(mlbench)
data(Vehicle)
dat <- Vehicle

# AdaBoost
fit <- boosting(
  Class ~ .,
  data = dat,
  boos = FALSE,
  mfinal = 5,
  control = rpart.control(maxdepth = 5)
)

# plot each tree
plot(fit$trees[[1]])
text(fit$trees[[1]])
plot(fit$trees[[2]])
text(fit$trees[[2]])
plot(fit$trees[[3]])
text(fit$trees[[3]])
plot(fit$trees[[4]])
text(fit$trees[[4]])
plot(fit$trees[[5]])
text(fit$trees[[5]])

# prediction performance
result <- cbind(dat, pred_class = factor(fit$class))
cm <- conf_mat(result, truth = "Class", estimate = "pred_class")
cm
summary(cm)

