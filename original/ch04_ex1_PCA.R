# ch04_ex1_PCA.R
# ch4.3 Principle Component Analysis

# ex4-5 (centered matrix)
x<-matrix(c(1, 2,3,2, -1, 0 , -1, -1, 0,-2,-2,-1), nrow=3, ncol=4, byrow=T)
x

# singular decomposition of x
s<-svd(x)
diag(s$d)
s$u
s$v

#x'x
t(x)%*%x
s1<-svd(t(x)%*%x)
s1
round(diag(s1$d),2)

# check (x'x)*eigenvector[,2]=eigenvalue[2]*eigenvector[,2]
(t(x)%*%x)%*%s1$v[,2]
s1$v[,2]*s1$d[2]

# ex4-6
# read csv file (centered matrix)
dat1<-read.csv(file="data/ch4_dat1.csv")
# define as matrix
x<-as.matrix(dat1)
# singular decomposition
s<-svd(x)
diag(s$d)
s$u
s$v
# check x= s$u%*%diag(s$d)%*%s$v
s$u%*%diag(s$d)%*%s$v

s<-svd(t(x)%*%x)
s$d[1]/sum(s$d)

# ex4-12
# read csv file
dat2<-read.csv(file="data/ch4_dat2.csv")

# data preprocessing
x <- as.matrix(dat2[, 2:6])

#Check correlation
cor(dat2[2:6])
round(cor(dat2[2:6]), 3)

# 1.PCA(center=T->mean=0, scale.=T->variance=1)
pca_fit<-prcomp(dat2[,2:6],center=T,scale.=T)
pca_fit

# eigenvalue of covariance matrix
pca_fit$sdev^2

# 1.scree plot : to choose the number of components
plot(pca_fit,type="l", main="scree plot", cex.main=1.5, cex.axis=2, cex.lab=1.2)

# bar plot 
# eigenvalue of cov(x)
pca_var<-pca_fit$sdev^2
pca_var
# 2. Bar plot of variance proportion explained by each PC
rate_var<-pca_var/sum(pca_var)
rate_var
categories <- c("PC1", "PC2", "PC3", "PC4", "PC5")
barplot(rate_var, names.arg=categories, cex.axis=1,ylab="Variance proportion explained by PC", col="blue", space=0.5,width=1, ylim=c(0,1))


