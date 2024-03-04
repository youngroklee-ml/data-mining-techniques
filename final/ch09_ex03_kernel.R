# ch09_ex03_kernel.R
# ch9.3 nonlinear SVM

# ex9.3 kernel
# load package
library(kernlab)

# load data
dat <- matrix(c(1, 2, 2, 2, 2, -1), nrow = 3, byrow = TRUE)
dat

# Gaussian RBF kernel
kernelMatrix(rbfdot(sigma = 1 / 2), dat)

# Polynomial kernel: 2nd order
kernelMatrix(polydot(degree = 2), dat)

# Sigmoid kernel
kernelMatrix(tanhdot(offset = 0), dat)

# Linear kernel
kernelMatrix(vanilladot(), dat)
