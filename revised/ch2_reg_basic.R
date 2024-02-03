# ch2.2 - 2.3 regression model

# read csv file
dat1 <- read.csv("data/ch2_reg1.csv")

# ex2.3 regression coefficients estimation
lm_fit <- lm(weight ~ age + height, data = dat1)
coef(lm_fit)

# ex2.4 MSE
sum(lm_fit$residuals^2) / lm_fit$df.residual

# ex2.5 ANOVA
anova(lm_fit)

# ex2.7 summary
summary(lm_fit)

# ex2.10 prediction

# variance-covariance matrix of regression coefficient
vcov(lm_fit)

# new data with predictor variables only
newdata <- data.frame(age = 40, height = 170)

# Expected mean weight for new data
predict(lm_fit, newdata)

# 95% confidence interval of mean weight for new data
# `lwr` represents a lower bound, and `upr` represents an upper bound
conf_interval <- predict(lm_fit, newdata, interval = "confidence", level = 0.95)
conf_interval
conf_interval[, c("lwr", "upr")]


# ex2.11 prediction interval
pred_interval <- predict(lm_fit, newdata, interval = "prediction", level = 0.95)
pred_interval
pred_interval[, c("lwr", "upr")]
