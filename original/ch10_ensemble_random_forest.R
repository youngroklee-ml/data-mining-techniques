library(randomForestSRC)
library(yardstick)

# load data
dat <- read.csv("data/ch10_dat1.csv")
dat$X1 <- factor(dat$X1)
dat$X2 <- factor(dat$X2)
dat$X3 <- factor(dat$X3)
dat$Y <- factor(dat$Y)

set.seed(5678)

# try random forest with 4 trees
rf1 <- rfsrc(
  Y ~ .,
  data = dat,
  ntree = 4,
  mtry = 1,
  samptype = "swr" # sampling with replacement
)

# observations used in training data
matrix(
  rf1$forest$nativeArrayTNDS$tnRMBR,
  ncol = 4
)

# plot each tree
plot(get.tree(rf1, 1))
plot(get.tree(rf1, 2))
plot(get.tree(rf1, 3))
plot(get.tree(rf1, 4))

# out-of-bag prediction: probability
rf1$predicted.oob

# out-of-bag prediction: classification
rf1$class.oob

# out-of-bag prediction performance
result1 <- cbind(dat, pred_class = rf1$class.oob)
cm1 <- conf_mat(result1, truth = "Y", estimate = "pred_class")
cm1
summary(cm1)


# increase number of trees
rf2 <- rfsrc(
  Y ~ .,
  data = dat,
  ntree = 8,
  mtry = 1,
  samptype = "swr" # sampling with replacement
)

# out-of-bag prediction: probability
rf2$predicted.oob

# out-of-bag prediction: classification
rf2$class.oob

# out-of-bag prediction performance
result2 <- cbind(dat, pred_class = rf2$class.oob)
cm2 <- conf_mat(result2, truth = "Y", estimate = "pred_class")
cm2
summary(cm2)

# ------------------------------------------------------------------------
# using randomForest package
library(randomForest)

# load data
dat2 <- read.csv("data/ch10_dat2.csv")
dat2$Y <- factor(dat2$Y)

rf3 <- randomForest(Y~., data=dat2)
rf3

# variable importance
rf3$importance
varImpPlot(rf3)

