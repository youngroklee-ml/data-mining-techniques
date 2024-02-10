# ch9 SVM
# ch9.3 nonlinear svm

# ex9.6 xor

# load package
library(kernlab)

# load data
dat <- data.frame(
  x1 = c(-1, -1, 1, 1),
  x2 = c(-1, 1, -1, 1),
  class = factor(c(-1, 1, 1, -1))
)

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

# nonlinear hyperplane's intercept b
# Note that we placed minus(-) sign
-model@b
