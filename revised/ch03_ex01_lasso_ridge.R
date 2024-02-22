# ch03_ex01_lasso_ridge.R
# ch3.1 Lasso
# ch3.2 Ridge

# load library
library(penalized)

# read csv file
dat1 <- read.csv("data/ch3_dat1.csv")

# data preprocessing
x <- as.matrix(dat1[, 1:2])
y <- dat1$y

# standardize x
std_x <- scale(x)

# ex3.1

# list lambda values and transform for penalized()
lambda <- seq(0, 3, by = 1)
lasso_lambda <- lambda / 2

# for each value of lambda
for (i in lasso_lambda) {
  # estimate Lasso regression
  lasso <- penalized(y, std_x, lambda1 = i, trace = FALSE)
  # print coefficients
  print(round(coef(lasso), 4))
}


# ex3.2

ridge_lambda <- lambda

# for each value of lambda
for (i in ridge_lambda) {
  # estimate Lasso regression
  ridge <- penalized(y, std_x, lambda2 = i, trace = FALSE)
  # print coefficients
  print(round(coef(ridge), 4))
}
