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
  C = 1
)

# support vectors
model@alphaindex[[1]]

# alpha values for support vectors
model@alpha[[1]]

# objective value
# note that we placed minus(-) sign
-model@obj

# hyperplane coefficient vector w and intercept b
w <- model@coef[[1]] %*% model@xmatrix[[1]]
w

# hyperplane's intercept b
# Note that we placed minus(-) sign
-model@b

# misclassified objects
which(model@ymatrix != as.integer(model@fitted))

# visualize
plot(model, data = dat)



# Try with C = 1, C = 5 and C = 100
Cs <- c(1, 5, 100)
models <- vector("list", length = length(Cs))

for (i in seq_along(Cs)) {
  message(paste0("-------\nC = ", Cs[i], "\n-------"))

  # SVM with 2nd order polynomial kernel
  models[[i]] <- ksvm(
    class ~ x1 + x2,
    data = dat,
    scaled = FALSE,
    kernel = "vanilladot",
    C = Cs[i]
  )

  # support vectors
  message("Support vectors:")
  print(models[[i]]@alphaindex[[1]])

  # alpha values for support vectors
  message("Alpha values for support vectors:")
  print(round(models[[i]]@alpha[[1]], 4))

  # objective value
  # note that we placed minus(-) sign
  message("Objective value:")
  print(-models[[i]]@obj)

  # hyperplane coefficient vector w and intercept b
  message("Hyperplane coefficients (w):")
  w <- models[[i]]@coef[[1]] %*% models[[i]]@xmatrix[[1]]
  print(w)

  # hyperplane's intercept b
  # Note that we placed minus(-) sign
  message("Hyperplane intercept (b):")
  print(-models[[i]]@b)

  # misclassified objects
  message("Misclassified instances:")
  print(which(models[[i]]@ymatrix != as.integer(models[[i]]@fitted)))
}
