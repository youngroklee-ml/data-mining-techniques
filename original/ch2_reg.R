# ch2_reg.r

# ch2.3 regression model(ch2_reg.R) 

# read csv file
dat1<-read.csv("data/ch2_reg1.csv")

# regression results
lm_fit <- lm(weight ~ age + height, data = dat1)
summary(lm_fit)
anova(lm_fit)

# ch.2.4 variable selection (ch2_stepwise.R)
  
# load packages
library("olsrr")

# read csv file
# Hitters Baseball data Player.csv (Baseball player salary) data from Kaggle
dat_ba<-read.csv("data/Player.csv")
attach(dat_ba)

# linear regression
lm_model <- lm( Salary~Hits+Walks+CRuns+HmRun+CWalks, data = dat_ba)
#summary(lm_model)
#anova(lm_model)

# ch.2.4.2 all possible regression : variable selection 
k<-ols_step_all_possible(lm_model)
k
# R-square, Cp, AIC
plot(k)

# ch2.4.3 stepwise method (pent=0.3, prem=0.3)
ols_step_both_p(lm_model, details = TRUE, pent=0.3, prem=0.3)

# stepwise method with entry p-value<0.5 & remove p-value>0.5
ols_step_both_p(lm_model, pent=0.5, prem=0.5)

#k1<-ols_step_best_subset(lm_model)
#k1
#plot(k1)

# ch.2.5 residual diagnostic plot (ch2_diagnostic.R)

# read csv file
dat1<-read.csv("data/ch2_reg1.csv")

# regression results
lm_fit <- lm(weight ~ age + height, data = dat1)
summary(lm_fit)
anova(lm_fit)

# residual diagnostic plot 
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(lm_fit)

# ch2.6 Estimation for predicted value (ch2_reg_pred.R) 

# read csv file
dat1<-read.csv("data/ch2_reg1.csv")

# regression results
lm_fit <- lm(weight ~ age + height, data = dat1)
summary(lm_fit)
anova(lm_fit)

# regression coefficient
coef(lm_fit)
# covariance for regression coefficient
vcov(lm_fit)

# predicted value & confidence interval for age=40, height=170
predict(lm_fit, newdata = tibble(age = 40, height = 170),
        interval = "confidence", level = 0.95)


# ch.2.7 multi-collinearity (ch2_vif.R)

# load library for VIF
library(car)

# read csv file
dat_ba<-read.csv("data/Player.csv")
attach(dat_ba)

# multiple regression
lm_model <- lm( Salary~Hits+Walks+CRuns+HmRun+CWalks, data = dat_ba)
# check VIF
vif_value1 <- vif(lm_model)
vif_value1

# check correlation for predictors 
vars1<-c("Hits","Walks", "CRuns","HmRun", "CWalks")
cor(dat_ba[c("Hits","Walks", "CRuns","HmRun","CWalks")])

# plot for variables with high correlation
plot(CRuns,CWalks, data=dat_ba)
abline(lm(CWalks~CRuns), col="red", lwd=2, lty=1)

# 2nd model after removing one of high correlation variables 

lm2_model <- lm(Salary~Hits+Walks+CRuns+HmRun, data = dat_ba)
summary(lm2_model)
vif_value2 <- vif(lm2_model)
vif_value2


##### extra  R-code  ########
# ch2.2 coefficent estimation 

# load packages
library(tidyverse)

# read csv file
dat1<-read.csv("data/ch2_reg1.csv")

## manual computation for regression coefficients
# matrix with x1, x2 
x<-dat1[,2:3]
# y
y<-dat1[,4]

# regression coefficient estimation
intercept<-rep(1,length=10)
x<-cbind(intercept, x )
x<-as.matrix(x)

# matrix : X'X
t(x)%*%x
# matrix : inverse of (X'X)
solve(t(x)%*%x)
# matrix : X'y
xty<-t(x)%*%y
xty
# beta coefficients
beta<-solve(t(x)%*%x)%*%xty
beta

sse<-t(y)%*%y-t(beta)%*%xty
sse




