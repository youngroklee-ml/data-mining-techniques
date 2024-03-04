# ch10_ex02_rf.R
# ch10.2 Bootstrapping

# load packages
library(randomForestSRC)
library(yardstick)

# load data
dat <- read.csv("data/ch10_dat1.csv")
dat$X1 <- factor(dat$X1)
dat$X2 <- factor(dat$X2)
dat$X3 <- factor(dat$X3)
dat$Y <- factor(dat$Y)

# ex10.2

# try random forest with 4 trees, 2 candidate variables at each split
# results depend on random seed number
set.seed(5678)
rf <- rfsrc(
  Y ~ .,
  data = dat,
  ntree = 4, # 4 trees
  mtry = 2, # 2 candidate variables at each split
  samptype = "swr" # sampling with replacement
)

# observations used in training data
# results would be different from book example
# due to randomness in resampling
matrix(
  rf$forest$nativeArrayTNDS$tnRMBR,
  ncol = 4
)

# plot each tree
plot(get.tree(rf, 1))
plot(get.tree(rf, 2))
plot(get.tree(rf, 3))
plot(get.tree(rf, 4))


# ex10.3

# out-of-bag prediction: probability
rf$predicted.oob

# out-of-bag prediction: classification
rf$class.oob

# out-of-bag prediction performance
results <- cbind(dat, pred_class = rf$class.oob)
cm <- conf_mat(results, truth = "Y", estimate = "pred_class")
cm
summary(cm)
