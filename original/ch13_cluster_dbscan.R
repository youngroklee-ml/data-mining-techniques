# ch13_cluster_dbscan.R
# Non-Hierarchical Clustering
# k-means,PAM, DBSCAN

# set working directory
setwd("D:/tempstore/2024_Chjun/data")

# ch13.1 k-means : Non-hierarchical clustering 

# read csv file
dat1<-read.csv("ch12_dat1.csv")
attach(dat1)

# include only with predictors & not missing cases
dat1<-na.omit(dat1)
dat2<-dat1[,-1]

# step1: to choose the optimal k
install.packages("factoextra")
library(factoextra)

# may use scale data or raw data for the optimal k
s_dat2 <- scale(dat2)
fviz_nbclust(s_dat2, kmeans, method = "silhouette", k.max=5)

#fviz_nbclust(dat2, kmeans, method = "silhouette", k.max=5)
#fviz_nbclust(s_dat2, kmeans, method = "gap_stat", k.max=5)

# step2 : k-means
set.seed(123)
km <- kmeans(dat2, 3)
km

#km <- kmeans(dat1, 3, nstart=10)
#km

# visualize
fviz_cluster(km, data = dat2, 
             ellipse.type="convex", 
             repel = TRUE, cex=3)

# ch13.2 PAM (Partitioning Around Medoids)
library("cluster")

pam_out <- pam(dat2, 3)
pam_out

# freq of each cluster
table(pam_out$clustering)

# visualize
fviz_cluster(pam_out, data = dat2,
             ellipse.type="convex", 
             repel = TRUE)

# ch13.5 DBSCAN

install.packages("fpc")
library(fpc)

db<-dbscan(dat2, eps=2.5, MinPts=3)

#The result of clustering
db
db$cluster

#visualization
fviz_cluster(db, data = dat2, 
             ellipse.type="convex", 
             repel = TRUE)


