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
model <- ksvm(
  class ~ x1 + x2,
  data = dat,
  scaled = FALSE,
  kernel = "vanilladot"
)

# support vectors
model@alphaindex[[1]]

# alpha values for support vectors
model@alpha[[1]]

# objective value
# note that we placed minus(-) sign
-model@obj

# hyperplane coefficient vector w
w <- model@coef[[1]] %*% model@xmatrix[[1]]
w

# hyperplane's intercept b
# Note that we placed minus(-) sign
-model@b

# visualize
plot(model, data = dat)
