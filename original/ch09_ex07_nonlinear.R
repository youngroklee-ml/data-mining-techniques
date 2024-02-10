# ch9 SVM
# ch9.3 nonlinear svm

# ex9.7

# load package
library(kernlab)

# load data
dat <- read.csv("data/ch9_dat3.csv")
dat$class <- factor(dat$class)
dat

# SVM with 2nd order polynomial kernel
model <- ksvm(
  class ~ x1 + x2,
  data = dat,
  scaled = FALSE,
  kernel = polydot(degree = 2),
  C = 1
)

# support vectors
model@alphaindex[[1]]

# alpha values for support vectors
model@alpha[[1]]

# betas
beta1 <- 2 * sum(model@coef[[1]] * model@xmatrix[[1]][, "x1"])
beta2 <- 2 * sum(model@coef[[1]] * model@xmatrix[[1]][, "x2"])
beta11 <- sum(model@coef[[1]] * model@xmatrix[[1]][, "x1"]^2)
beta22 <- sum(model@coef[[1]] * model@xmatrix[[1]][, "x2"]^2)
beta12 <- 2 * sum(model@coef[[1]] * apply(model@xmatrix[[1]], 1, prod))
betas <- c(-model@b, beta1, beta2, beta11, beta22, beta12)
names(betas) <- c("b", "beta1", "beta2", "beta11", "beta22", "beta12")
round(betas, 4)

# misclassified objects
which(model@ymatrix != as.integer(model@fitted))


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
    kernel = polydot(degree = 2),
    C = Cs[i]
  )
  
  # support vectors
  message("Support vectors:")
  print(models[[i]]@alphaindex[[1]])
  
  # alpha values for support vectors
  message("Alpha values for support vectors:")
  print(round(models[[i]]@alpha[[1]], 4))
  
  # betas
  beta1 <- 2 * sum(models[[i]]@coef[[1]] * models[[i]]@xmatrix[[1]][, "x1"])
  beta2 <- 2 * sum(models[[i]]@coef[[1]] * models[[i]]@xmatrix[[1]][, "x2"])
  beta11 <- sum(models[[i]]@coef[[1]] * models[[i]]@xmatrix[[1]][, "x1"]^2)
  beta22 <- sum(models[[i]]@coef[[1]] * models[[i]]@xmatrix[[1]][, "x2"]^2)
  beta12 <- 2 * sum(models[[i]]@coef[[1]] * apply(models[[i]]@xmatrix[[1]], 1, prod))
  betas <- c(-models[[i]]@b, beta1, beta2, beta11, beta22, beta12)
  names(betas) <- c("b", "beta1", "beta2", "beta11", "beta22", "beta12")
  message("Hyperplane coefficients:")
  print(round(betas, 4))
  
  # misclassified objects
  message("Misclassified instances:")
  print(which(models[[i]]@ymatrix != as.integer(models[[i]]@fitted)))
}

