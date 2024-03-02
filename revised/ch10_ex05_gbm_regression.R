# ch10_ex06_gbm.R
# Ch10.5 Gradient boosting

# ex10.5

# load package
library(gbm)
library(rpart)
library(rpart.plot)

# load data
dat <- read.csv("data/ch10_dat3.csv")

# initial model
dat.m <- dat
dat.m$pred <- mean(dat$Y)

# prediction for new data
dat.p <- data.frame(
  X = seq(min(dat$X), max(dat$X), length = 1000),
  pred = mean(dat$Y)
)

# gradient boosting
iter <- 5

for (i in 1:iter) {
  # negative gradients
  dat.m$ngrad <- dat$Y - dat.m$pred

  # plot layout
  layout(matrix(c(1, 2, 3, 3), nrow = 2, byrow = TRUE))

  # plot observed point and prediction
  plot(dat$X, dat$Y,
    pch = 16, xlab = "X", ylab = "Y",
    main = paste0("Observed vs Prediction: Iteration ", i)
  )
  lines(dat.p$X, dat.p$pred, col = "red")

  # plot residuals
  plot(dat.m$X, dat.m$ngrad,
    pch = 16, xlab = "X", ylab = "Residual",
    main = paste0("Residual: Iteration ", i)
  )


  # fit C to negative gradients
  fit <- rpart(
    ngrad ~ X,
    data = dat.m,
    control = rpart.control(maxdepth = 1)
  )

  # plot tree
  rpart.plot(fit, main = paste0("Residual estimation: Iteration ", i))

  # update prediction
  dat.m$pred <- dat.m$pred + predict(fit, newdata = dat.m)
  dat.p$pred <- dat.p$pred + predict(fit, newdata = dat.p)
}

# plot final prediction
par(mfrow = c(1, 1))
plot(dat$X, dat$Y,
  pch = 16, xlab = "X", ylab = "Y",
  main = paste0("Observed vs Prediction: Final")
)
lines(dat.p$X, dat.p$pred, col = "red")


# use {gbm} package
gbm_fit <- gbm(
  Y ~ X,
  data = dat,
  distribution = "gaussian",
  n.trees = 5,
  interaction.depth = 1,
  n.minobsinnode = 1,
  shrinkage = 1, # step size = 1
  bag.fraction = 1 # no subsampling of training data
)

plot(dat$X, dat$Y,
  pch = 16, xlab = "X", ylab = "Y",
  main = paste0("Observed vs Prediction: {gbm} package")
)
lines(dat.p$X, predict(gbm_fit, newdata = dat.p), col = "red")
