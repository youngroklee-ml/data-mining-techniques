# ch3_lasso_Ridge_Enet.R
# LASSO, Ridge, Elastic net
# data : Player.csv (from Kaggle)

# install package for regularization
install.packages("glmnet")
library (glmnet)
#help("glmnet")
#help("cv.glmnet")

# set working directory
setwd("D:/tempstore/2024_chjun")

# read csv file
baseball<-read.csv("Player.csv",stringsAsFactors = TRUE)
attach(baseball)

# data description
dim(baseball)
str(baseball)

## Ridge Regression 
# remove missing cases
dat_plalyer = na.omit(baseball)
# remove player's name
dat_player=dat_plalyer[,-1]

# convert to indicator variables from categorical variables for matrix
x<-model.matrix(Salary~.,dat_player)[,-1]
# target variables y as Salary
y<-dat_player$Salary

# training & test set
# set.seed(234)
N=nrow(dat_player)
set.seed(234)

tr.idx=sample(1:N, size=N*2/3, replace=FALSE)
x.train <- x[ tr.idx,]
x.test  <- x[-tr.idx,]
y.train <- y[tr.idx]
y.test <- y[-tr.idx]

## 1. LASSO regression
# Optimal lambda
cv.lasso<-cv.glmnet(x.train, y.train, alpha=1)
plot(cv.lasso)

opt_lambda <-cv.lasso$lambda.min
log(opt_lambda)
opt_lambda

# LASSO model
lasso<-glmnet(x.train,y.train,alpha=1)
predict(lasso,s = opt_lambda,type="coefficients")

## LASSO model evaluation
pre_lasso <-predict(lasso,s=opt_lambda,newx=x.test)
# RMSE in LASSO model
rmse_lasso = sqrt(mean((pre_lasso - y.test)^2))
rmse_lasso

## 2. Ridge regression
# Optimal lambda
cv<-cv.glmnet(x.train, y.train, alpha=0)
plot(cv)

opt_lambda <-cv$lambda.min
log(opt_lambda)
opt_lambda

# Ridge model
ridge<-glmnet(x.train,y.train,alpha=0)
predict(ridge,s = opt_lambda,type="coefficients")

## Ridge model evaluation
pre_ridge <-predict(ridge,s=opt_lambda, newx=x.test)
# RMSE in Rigde model
rmse_ridge = sqrt(mean((pre_ridge - y.test)^2))
rmse_ridge


## 3. Elastic net regression
# Optimal lambda
cv.enet<-cv.glmnet(x.train, y.train, alpha=.5)
plot(cv.enet)

opt_lambda <-cv.enet$lambda.min
log(opt_lambda)
opt_lambda

# elastic net model
enet<-glmnet(x.train,y.train,alpha=.5)
predict(enet,s = opt_lambda,type="coefficients")

## elastic net model evaluation
pre_enet <-predict(enet,s=opt_lambda,newx=x.test)
# RMSE in elastic net model
rmse_enet = sqrt(mean((pre_enet - y.test)^2))
rmse_enet

# 4. RMSE in MLR model
lm_model <- lm(Salary~., data=dat_player[tr.idx,])
summary(lm_model)

pred_lm <- predict(lm_model, newdata=dat_player[-tr.idx,,-20])
# RMSE in MLR model
rmse_lm = sqrt(mean((pred_lm - y.test)^2))
rmse_lm

#install.packages("car") for VIF
#library("car")
#vif(lm_model)

