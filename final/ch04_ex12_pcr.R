# ch04_ex12_pcr.R
# ch4.7 Principle Component Regression

# ex4-12

# read csv file, centered data
dat3 <- read.csv(file = "data/ch4_dat3.csv")
dat3

# covert data frame to matrix
x <- as.matrix(dat3[, 1:3])

# PCA with centering and without scaling
pca_fit <- prcomp(dat3[, 1:3], center = TRUE, scale. = FALSE)
pca_fit

# eigenvalue of cov(x)
pca_fit$sdev^2

# eigenvalue of x'x
pca_fit$sdev^2 * (nrow(x) - 1)

# principal component score
PRC <- predict(pca_fit, dat3[, 1:3])
PRC

# create training data with components
dat4 <- as.data.frame(cbind(PRC, y = dat3$y))

# Principal component regression
lm_fit <- lm(y ~ 0 + PC1 + PC2, data = dat4)
summary(lm_fit)
anova(lm_fit)
