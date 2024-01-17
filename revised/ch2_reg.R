# ch2_reg.r
# multiple regression

# ch2_dat1  ##########

# read csv file
dat1 <- read.csv("data/ch2_reg.csv")

lm_fit <- lm(weight ~ age + height, data = dat1)
summary(lm_fit)
anova(lm_fit)

# predicted value for age=40, height=170
predict(lm_fit,
  newdata = data.frame(age = 40, height = 170),
  interval = "confidence", level = 0.95
)

## manual computation for regression coefficients

# matrix with x1, x2
dat2 <- dat1[, -3]
# y
y <- dat1[, 3]

# estimation
intercept <- rep(1, length = 10)
x <- cbind(intercept, dat2)
x <- as.matrix(x)
t(dat2) %*% dat2

solve(t(dat2) %*% dat2)

xty <- t(dat2) %*% y
xty

beta <- solve(t(dat2) %*% dat2) %*% xty
beta

sse <- t(y) %*% y - t(beta) %*% xty

# regression coefficient
coef(lm_fit)
# covariance for regression coefficient
vcov(lm_fit)

# ch.2.4 variable selection
# read csv file
library(MASS)

dat_ba <- read.csv("data/Player.csv")

lm_model <- lm(Salary ~ Hits + Walks + CRuns + CAtBat + RBI + AtBat + HmRun, data = dat_ba)
step_model <- step(lm_model)

step_model <- step(lm_model, direction = "both")
