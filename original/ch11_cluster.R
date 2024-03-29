# ch11_cluster.r
# Euclidean distance, Minkowski distance

# set working directory
setwd("D:/tempstore/2024_Chjun/data")

# ch11_dat1 (ex 11_1) ##########

# read csv file
dat1<-read.csv("ch11_dat1.csv")
attach(dat1)

dat1<-na.omit(dat1)
dat2<-dat1[,-1]

# 1. Euclidean distance
D1 <- dist(dat2)
D1<-round(D1, 2)
D1

# Minkowski distance
#D2<- dist(m1, method="minkowski", p=3) 
#D2

# Mean and covariance matrix
mean_vector <- colMeans(dat2)
mean_vector

cov_matrix <- cov(dat2)
sqrt(cov_matrix)

# 2. correlation measure between samples
row_cor <- cor(t(dat2), use = "pairwise.complete.obs", method = "pearson")
row_cor

# 2. scaled data : correlation measure between samples
s_dat2<-scale(dat2)
row_cor_s <- cor(t(s_dat2), use = "pairwise.complete.obs", method = "pearson")
row_cor_s

help("dist")

