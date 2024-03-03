# ch04_ex14_pcr.R
# ch4.7 Principle Component Regression

# ex4-14

# read csv file, centered data
dat3 <- read.csv(file = "data/ch4_dat3.csv")
dat3

# covert data frame to matrix
x <- as.matrix(dat3[, 1:3])


# PCA(center=T->mean=0, scale.=T->variance=1)
pca_fit <- prcomp(x, center = TRUE, scale. = FALSE)
pca_fit

# eigenvalue of cov(x)
pca_var <- pca_fit$sdev^2
pca_var

# principal component score
PRC <- predict(pca_fit, x)
PRC

# create training data with components
dat4 <- as.data.frame(cbind(PRC, y = dat3$y))

# Principal component regression
lm_fit <- lm(y ~ PC1 + PC2, data = dat4)
summary(lm_fit)
anova(lm_fit)

# compare linear regression with original variable
lm_fit <- lm(y ~ x1 + x2 + x3 - 1, data = dat3)
summary(lm_fit)
anova(lm_fit)
