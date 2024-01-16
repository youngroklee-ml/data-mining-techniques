# ch3_lasso_ridge_text.R
# LASSO, Ridge, Elastic net
# data : example data in Chap3

# install package for regularization
install.packages("glmnet")
library (glmnet)
#help("glmnet")
#help("cv.glmnet")

# set working directory
setwd("D:/tempstore/2024_Chjun/data")

# read csv file
dat1<-read.csv("ch3_dat1.csv")
attach(dat1)

# data description
dim(dat1)
str(dat1)

## Ridge & Lasso Regression 
# remove missing one
dat_ex = na.omit(dat1)
# transform indicator variable if there is a factor variable
x<-model.matrix(y~.,dat1)[,-1]
y<-dat1$y

x<-scale(x)
#y<-scale(y)

dat1<-cbind.data.frame(x, y)
#y<-scale(y, center = TRUE, scale = TRUE)


# pariwise plot - Explanatory Data Analysis
var1<-c("x1","x2" )
pairs(dat1[var1],cex=1)

cor(x1,x2)

# 2. LASSO Optimal lambda
cv.lasso<-cv.glmnet(x, y, alpha=1, nfolds=4, grouped = FALSE)
par(mfrow=c(1,1))
plot(cv.lasso)

opt_lambda <-cv.lasso$lambda.min
log(opt_lambda)
opt_lambda

# LASSO model
lamda=0
lasso<-glmnet(x,y,alpha=1)
predict(lasso,s = opt_lambda,type="coefficients")

## LASSO model evaluation
pred_lasso <-predict(lasso,s=opt_lambda,newx=x)
# RMSE in LASSO model
rmse_lasso = sqrt(mean((pred_lasso - y)^2))
rmse_lasso

# specific lamda
opt_lambda=0
predict(lasso,s =opt_lambda,type="coefficients")
pred_lasso <-predict(lasso,s=opt_lambda,newx=x)
# RMSE in LASSO model
rmse_lasso = sqrt(mean((pred_lasso - y)^2))
rmse_lasso

# another try
lambda=0
lasso<- glmnet(x, y, alpha = 1, lambda = lambda)
print(coef(lasso))

## compare with MLR
#  multiple regression : 1st full model 
r1<-lm(y ~ x1+x2, data=dat1)
summary(r1)

pred_lm <- predict(r1, newdata=dat1[,-3])
# RMSE in MLR model
rmse_lm = sqrt(mean((pred_lm - y)^2))
rmse_lm

# residual diagnostic plot 
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(r1)

## 3. Ridge regression
# Optimal lambda
cv<-cv.glmnet(x, y, alpha=0)
plot(cv)

opt_lambda <-cv$lambda.min
log(opt_lambda)
opt_lambda

# Another try
lambda_values <- 10^seq(1, -2, length = 50)
ridge_model <- cv.glmnet(x, y, alpha = 0, lambda = lambda_values)
plot(ridge_model)

best_lambda <- ridge_model$lambda.min
cat("Optimal Lambda:", best_lambda, "\n")

# Ridge model
opt_lambda=0.2

opt_lamda=log(opt_lambda)
#ridge<-glmnet(x,y,alpha=0)
ridge<- glmnet(x, y, alpha = 0, lambda = 0.2)
print(coef(ridge))

predict(ridge,s = opt_lambda,type="coefficients")

#write.csv(dat1, file='lasso_dat1.csv')

## Ridge model evaluation
pre_ridge <-predict(ridge,s=opt_lambda, newx=x)
# RMSE in Rigde model
rmse_ridge = sqrt(mean((pre_ridge - y)^2))
rmse_ridge

# computation 
install.packages("tidyverse")
library (tidyverse)

# Ridge reg coeff for lamda=0.2
vector_rep <- rep(1, times = n)
vector1<- matrix(vector_rep, ncol = 1)
x3<-cbind(vector1, x)

t1<-solve(t(x3)%*%x3+0.2*diag(3))
t2<-t1%*%t(x3)
t2%*%y

# MLR coeff 
t1<-solve(t(x3)%*%x3)
t2<-t1%*%t(x3)
beta<-t2%*%y
beta


