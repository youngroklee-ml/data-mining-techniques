# ch02_ex08_variable_selection.R
# ch2.4 variable selection
# ch2.7 multicollinearity

# load packages
library("olsrr")
library("car")

# read csv file
# Hitters Baseball data Player.csv (Baseball player salary) data from Kaggle
dat_ba <- read.csv("data/Player.csv")

# multiple regression
lm_model <- lm(Salary ~ Hits + Walks + CRuns + HmRun + CWalks, data = dat_ba)
summary(lm_model)

# ex2.8 all possible regression : variable selection
k <- ols_step_all_possible(lm_model)
k

# ch2.9 stepwise method (pent=0.3, prem=0.3)
ols_step_both_p(lm_model, details = TRUE, pent = 0.3, prem = 0.3)

# stepwise method with entry p-value<0.5 & remove p-value>0.5
ols_step_both_p(lm_model, pent = 0.5, prem = 0.5)


# ex2.13: multicollinearity

# check VIF
vif_value1 <- vif(lm_model)
vif_value1

# check correlation for predictors
vars1 <- c("Hits", "Walks", "CRuns", "HmRun", "CWalks")
cor(dat_ba[vars1])

# plot for variables with high correlation
plot(dat_ba[, c("CRuns", "CWalks")])
abline(lm(CWalks ~ CRuns, data = dat_ba), col = "red", lwd = 2, lty = 1)

# 2nd model after removing one of high correlation variables
lm2_model <- lm(Salary ~ Hits + Walks + CRuns + HmRun, data = dat_ba)
summary(lm2_model)

# check VIF
vif_value2 <- vif(lm2_model)
vif_value2

