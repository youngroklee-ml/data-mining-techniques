# ch04_ex3_PLS.R
# ch4.5 Partial Least Square

# ex 4.16

# load library
library(pls)

# read csv file, centered data
dat3<-read.csv(file="data/ch4_dat3.csv")

x<-as.matrix(dat3[,1:3])
y<-dat3[,4]

# 1st pls component t1
# step1 : 1
w<-solve((t(y)%*%y))%*%(t(y)%*%x)
#normalize
w<-as.vector(w)
w<-w%*%solve(sqrt(t(w)%*%w))
w
# step2 : t
t<-(x%*%w)
t<-(x%*%w)%*%solve(t(w)%*%w)
t
# step3 : p
p<-(t(x)%*%t)%*%solve(t(t)%*%t)
p
# step4 : adjust t & w with vector sqrt(t(p1)*p1)
d<-sqrt(t(p)%*%p)
t1<-d%*%t(t)
t1
w1<-d%*%t(w)
w1
# step5 normalize p1
p1<-p%*%solve(sqrt(t(p)%*%p))
p1
# step6 : beta
t1<-as.vector(t1)
b1<-(t(y)%*%t1)%*%solve(t(t1)%*%t1)
b1
# step7
x1<-x-t1%*%t(p1)
y1<-y-t1%*%b1
y1

#--------------------------------------
# stage2 : 2nd pls component t2 
# step1 : 1
w<-solve((t(y1)%*%y1))%*%(t(y1)%*%x1)
#normalize
w<-as.vector(w)
w<-w%*%solve(sqrt(t(w)%*%w))
w
# step2 : t
t<-(x1%*%w)
t<-(x1%*%w)%*%solve(t(w)%*%w)
t
# step3 : p
p<-(t(x1)%*%t)%*%solve(t(t)%*%t)
p
# step4 : adjust t & w with vector sqrt(t(p1)*p1)
d<-sqrt(t(p)%*%p)
t2<-d%*%t(t)
t2
w2<-d%*%t(w)
w2
# step5 normalize p1
p2<-p%*%solve(sqrt(t(p)%*%p))
p2
# step6 : beta
t2<-as.vector(t2)
b2<-(t(y1)%*%t2)%*%solve(t(t2)%*%t2)
b2

# ex 4.17

# read csv file, centered data
dat3<-read.csv(file="data/ch4_dat3.csv")

# pls model by training set (find LV by leave-one-out) 
pls_fit <- plsr(y ~ ., ncomp = 2, data = dat3 )
summary(pls_fit)
coef(pls_fit)

# Calculate the VIP scores 
vip_scores <- vip(pls_fit, ncomp=2)

