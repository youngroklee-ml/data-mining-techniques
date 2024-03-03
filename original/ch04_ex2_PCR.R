# ch04_ex2_PCR.R
# ch4.7 Principle Component Regression

# ex4-14

# read csv file, centered data
dat3<-read.csv(file="data/ch4_dat3.csv")
dat3

# PCA(center=T->mean=0, scale.=T->variance=1)
pca_fit<-prcomp(dat3[,1:3],center=T,scale.=F)
pca_fit

#eigenvalue of x'x
pca_var<-pca_fit$sdev^2
pca_var

# principal component score
PRC<-as.matrix(dat3[,1:3])%*%pca_out$rotation
PRC

# make data with components
dat4<-cbind(as.data.frame(PRC),dat3$y)
dat4<-as.data.frame(dat4)

# Principal component regression
lm_fit <- lm(dat3$y ~ PC1 + PC2, data=dat4)
summary(lm_fit)
anova(lm_fit)

# compare linear regression with original variable
lm_fit <- lm(y ~ x1 + x2+x3 -1, data=dat3)
summary(lm_fit)
anova(lm_fit)