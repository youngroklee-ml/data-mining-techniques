# ch09_ex06_xor.R
# ch9.3 nonlinear SVM

# ex9.6 xor

# load package
library(kernlab)

# load data
dat <- data.frame(
  x1 = c(-1, -1, 1, 1),
  x2 = c(-1, 1, -1, 1),
  class = factor(c(-1, 1, 1, -1))
)
dat

# 2nd order polynomial kernel
X <- as.matrix(dat[, 1:2])
K <- kernelMatrix(polydot(degree = 2), X)
K

# SVM with 2nd order polynomial kernel
model <- ksvm(
  class ~ x1 + x2,
  data = dat,
  scaled = FALSE,
  kernel = polydot(degree = 2)
)

# support vectors
model@alphaindex[[1]]

# alpha values for support vectors
model@alpha[[1]]

# nonlinear hyperplane's beta
beta1 <- 2 * sum(model@coef[[1]] * model@xmatrix[[1]][, "x1"])
beta2 <- 2 * sum(model@coef[[1]] * model@xmatrix[[1]][, "x2"])
beta11 <- sum(model@coef[[1]] * model@xmatrix[[1]][, "x1"]^2)
beta22 <- sum(model@coef[[1]] * model@xmatrix[[1]][, "x2"]^2)
beta12 <- 2 * sum(model@coef[[1]] * apply(model@xmatrix[[1]], 1, prod))
betas <- c(beta1, beta2, beta11, beta22, beta12)
names(betas) <- c("beta1", "beta2", "beta11", "beta22", "beta12")
round(betas, 4)

# nonlinear hyperplane's intercept b
# Note that we placed minus(-) sign
-model@b
