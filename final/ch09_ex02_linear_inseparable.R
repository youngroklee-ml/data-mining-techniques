# ch09_ex02_linear_inseparable.R
# ch9.2 linear SVM - inseparable

# ex9.2
# load package
library(kernlab)

# load data
dat <- read.csv("data/ch9_dat2.csv")
dat$class <- factor(dat$class)
dat

# SVM training
model <- ksvm(
  class ~ x1 + x2,
  data = dat,
  scaled = FALSE,
  kernel = "vanilladot",
  C = 1 # please also try 5 and 100
)

# summary result
print(model)

# misclassified objects
which(model@ymatrix != as.integer(model@fitted))

# visualize
plot(model, data = dat)
