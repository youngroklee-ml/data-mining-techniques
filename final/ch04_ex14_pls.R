# ch04_ex14_pls.R
# ch4.9 Partial least squares with a single response variable

# load package
library(pls)

# read csv file, centered data
dat3 <- read.csv(file = "data/ch4_dat3.csv")

# ex4-14

# estimate PLS model
pls_fit <- plsr(y ~ ., ncomp = 2, data = dat3)

# scores (T)
scores(pls_fit)

# loadings (P)
loadings(pls_fit)

# weights (W)
loading.weights(pls_fit)

# y-loading vector (b)
Yloadings(pls_fit)

# beta-pls
coef(pls_fit)

# ex4-15

# create training data with components
dat4 <- as.data.frame(cbind(scores(pls_fit), y = dat3$y))

# linear regression by using latent variables
# without intercept due to mean-centered response variable
lm_fit <- lm(y ~ 0 + ., data = dat4)
summary(lm_fit)
anova(lm_fit)
