# ch12_cluster.r
# Clustering : Distance measures, linkage method
# Diana, optimal k

# library for plotting
library(ggplot2)

# ch12.1 Distance measures
# ch12.2 Average linkage method

# read csv file
dat1 <- read.csv("data/ch12_dat1.csv")

dat2 <- dat1[, -1]

# 1. Euclidean distance
D1 <- dist(dat2)
D1 <- round(D1, 2)
D1

# 2. Minkowski distance
# D2<- dist(m1, method="minkowski", p=3)
# D2

# Average linkage method
# check how different from linkage method
hc_c <- hclust(D1, method = "average")
plot(hc_c,
  hang = -1, cex = 0.7, main = "Average linkage with Euclidean distance",
  ylab = "Distance", xlab = "observation"
)

# ch12.3 Ward's method
# read csv file
dat1 <- read.csv("data/ch12_dat2.csv")

dat2 <- dat1[, -1]

# Euclidean distance
D1 <- dist(dat2)
D1 <- round(D1, 2)
D1

# Ward's linkage method
# check how different from linkage method
hc_c <- hclust(D1, method = "ward.D2")
plot(hc_c,
  hang = -1, cex = 1, main = "Ward's linkage with Euclidean distance",
  ylab = "Distance", xlab = "observation"
)

# ch12.4 Diana
# install.packages("cluster")
library(cluster)

# read csv file
dat1 <- read.csv("data/ch12_dat3.csv")

dat2 <- dat1[, -1]

# DIANA clustering
clus_diana <- diana(dat2)

# Plot dendrogram
plot(clus_diana, which.plot = 2, main = "Dendrogram of Diana")

# Ch12.5 How to choose k
# Non-hierachical clustering ###

# read csv file
dat1 <- read.csv("data/ch12_dat2.csv")

dat2 <- dat1[, -1]

# 1. Euclidean distance
D1 <- dist(dat2)
D1 <- round(D1, 2)
D1

# step1: to choose the optimal k
library(factoextra)
fviz_nbclust(dat1, kmeans, method = "wss")

fviz_nbclust(dat1, kmeans, method = "gap_stat")
fviz_nbclust(dat1, kmeans, method = "silhouette")

# visualization
fviz_cluster(db,
  data = dat2,
  ellipse.type = "convex",
  repel = TRUE
)

# calculate silhouette
library(cluster)
sil_pam <- silhouette(pam_out$clustering, dist(dat1))
sil_pam
mean(sil_pam[, 3])

sil_db <- silhouette(db$cluster, dist(dat1))
mean(sil_db[, 3])

# plot silhouette
library(factoextra)
fviz_silhouette(sil_pam)
fviz_silhouette(sil_db)
