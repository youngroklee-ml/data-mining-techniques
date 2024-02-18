# ch03_ex01_lasso_ridge.R
# ch3.1 Lasso
# ch3.2 Ridge

# load library
library(glmnet)

# read csv file
dat1 <- read.csv("data/ch3_dat1.csv")

# data preprocessing
x <- as.matrix(dat1[, 1:2])
y <- dat1$y

# standardize x
std_x <- scale(x)

# ex3.1

# list lambda values and transform based on glmnet's formulation
# See section - Linear Regression: family = "gaussian"
#     on https://glmnet.stanford.edu/articles/glmnet.html 
lambda <- seq(0, 3, by = 1)
N <- length(y) # number of observations in training data
lasso_lambda <- lambda / (2 * N)

# estimate Lasso regression
# input variables are already standardized; so set standardize = FALSE
lasso <- glmnet(
  std_x, y, alpha = 1, lambda = lasso_lambda, standardize = FALSE
)

# coefficients
lasso_coef <- predict(lasso, s = lasso_lambda, type = "coefficients")
round(lasso_coef, 2)

# ex3.2

# transform lambda base don glmnet's formulation
ridge_lambda <- lambda / N

# estimate ridge regression
# input variables are already standardized; so set standardize = FALSE
ridge <- glmnet(
  std_x, y, alpha = 0, lambda = ridge_lambda, standardize = FALSE
)

# coefficients
ridge_coef <- predict(ridge, s = ridge_lambda, type = "coefficients")
round(ridge_coef, 2)
