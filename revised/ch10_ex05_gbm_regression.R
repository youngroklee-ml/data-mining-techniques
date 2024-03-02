# ch10_ex05_gbm_regression.R
# Ch10.5 Gradient boosting

# ex10.5

# load package
library(gbm)
library(rpart)
library(rpart.plot)

# load data
dat <- read.csv("data/ch10_dat3.csv")

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

# prediction for new data
dat_p <- data.frame(
  X = seq(min(dat$X), max(dat$X), length = 1000)
)

plot(dat$X, dat$Y,
     pch = 16, xlab = "X", ylab = "Y",
     main = paste0("Observed vs Prediction: {gbm} package")
)
lines(dat_p$X, predict(gbm_fit, newdata = dat_p), col = "red")


# implement gradient boosting from scratch

# initial model
dat_m <- dat
dat_m$pred <- mean(dat$Y)
dat_p$pred <- mean(dat$Y)

iter <- 5

for (i in 1:iter) {
  # negative gradients
  dat_m$ngrad <- dat$Y - dat_m$pred

  # plot layout
  layout(matrix(c(1, 2, 3, 3), nrow = 2, byrow = TRUE))

  # plot observed point and prediction
  plot(dat$X, dat$Y,
    pch = 16, xlab = "X", ylab = "Y",
    main = paste0("Observed vs Prediction: Iteration ", i)
  )
  lines(dat_p$X, dat_p$pred, col = "red")

  # plot residuals
  plot(dat_m$X, dat_m$ngrad,
    pch = 16, xlab = "X", ylab = "Residual",
    main = paste0("Residual: Iteration ", i)
  )


  # fit C to negative gradients
  fit <- rpart(
    ngrad ~ X,
    data = dat_m,
    control = rpart.control(maxdepth = 1)
  )

  # plot tree
  rpart.plot(fit, main = paste0("Residual estimation: Iteration ", i))

  # update prediction
  dat_m$pred <- dat_m$pred + predict(fit, newdata = dat_m)
  dat_p$pred <- dat_p$pred + predict(fit, newdata = dat_p)
}

# plot final prediction
par(mfrow = c(1, 1))
plot(dat$X, dat$Y,
  pch = 16, xlab = "X", ylab = "Y",
  main = paste0("Observed vs Prediction: Final")
)
lines(dat_p$X, dat_p$pred, col = "red")


