# ch9 SVM
# ch9.1 linearly separable

# ex9.1

# load package
library(kernlab)

# load data
dat <- read.csv("data/ch9_dat1.csv")
dat$class <- factor(dat$class)
dat

# SVM training
svm_model <- ksvm(
  class ~ x1 + x2,
  data = dat,
  scaled = FALSE,
  kernel = "vanilladot"
)

# support vectors
svm_model@alphaindex[[1]]

# alpha values for support vectors
svm_model@alpha[[1]]

# objective value
# note that we placed minus(-) sign
-svm_model@obj

# hyperplane coefficient vector w and intercept b
w <- svm_model@coef[[1]] %*% svm_model@xmatrix[[1]]
w

# hyperplane's intercept b
# Note that we placed minus(-) sign
-svm_model@b

# visualize
plot(svm_model, data = dat)

