# ch12_cluster.r
# Clustering : Distance measures, linkage method 
# Diana, optimal k

# library for plotting
install.packages(ggplots)
library(ggplot2)

# set working directory
setwd("D:/tempstore/2024_Chjun/data")

# ch12.1 Distance measures 
# ch12.2 Average linkage method

# read csv file
dat1<-read.csv("ch12_dat1.csv")
attach(dat1)

dat1<-na.omit(dat1)
dat2<-dat1[,-1]

# 1. Euclidean distance
D1 <- dist(dat2)
D1<-round(D1, 2)
D1

# 2. Minkowski distance
#D2<- dist(m1, method="minkowski", p=3) 
#D2

help("dist")

# Average linkage method
# check how different from linkage method
hc_c <- hclust(D1, method = "average")
plot(hc_c, hang = -1, cex=0.7, main = "Average linkage with Euclidean distance", 
     ylab="Distance", xlab="observation")

# ch12.3 Ward's method 
# read csv file
dat1<-read.csv("ch12_dat2.csv")
attach(dat1)

dat1<-na.omit(dat1)
dat2<-dat1[,-1]

# Euclidean distance
D1 <- dist(dat2)
D1<-round(D1, 2)
D1

# Ward's linkage method
# check how different from linkage method
hc_c <- hclust(D1, method = "ward.D2")
plot(hc_c, hang = -1, cex=1, main = "Ward's linkage with Euclidean distance", 
     ylab="Distance", xlab="observation")

# ch12.4 Diana
# install.packages("cluster")
library(cluster)

# read csv file
dat1<-read.csv("ch12_dat3.csv")
attach(dat1)

dat1<-na.omit(dat1)
dat2<-dat1[,-1]

# DIANA clustering
clus_diana <- diana(dat2)

# Plot dendrogram
plot(clus_diana , which.plot = 2, main='Dendrogram of Diana')

# Ch12.5 How to choose k 
# Non-hierarchical clustering ###

# read csv file
dat1<-read.csv("ch12_dat2.csv")
attach(dat1)

dat1<-na.omit(dat1)
dat2<-dat1[,-1]

# step1: to choose the optimal k
install.packages("factoextra")
library(factoextra)
fviz_nbclust(dat2, kmeans, method = "wss", k=5)
fviz_nbclust(dat2, kmeans, method = "gap_stat", k=5)
fviz_nbclust(dat2, kmeans, method = "silhouette", k=5)




