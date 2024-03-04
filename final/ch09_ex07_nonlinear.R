# ch09_ex07_nonlinear.R
# ch9.3 nonlinear SVM

# ex9.7
# load package
library(kernlab)

# load data
dat <- read.csv("data/ch9_dat3.csv")
dat$class <- factor(dat$class)

# SVM with 2nd order polynomial kernel
model <- ksvm(
  class ~ x1 + x2,
  data = dat,
  scaled = FALSE,
  kernel = polydot(degree = 2),
  C = 1 # please also try 5 and 100
)

# summary result
print(model)

# support vectors
model@alphaindex[[1]]

# alpha values for support vectors
model@alpha[[1]]

# misclassified objects
which(model@ymatrix != as.integer(model@fitted))

