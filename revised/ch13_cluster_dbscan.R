# ch13_cluster_dbscan.R
# Non-Hierarchical Clustering
# k-means, DBSCAN

## ch12_dat1 (ex 12_1)

# read csv file
dat1 <- read.csv("data/ch12_dat1.csv")
dat2 <- dat1[, -1]

# 1. Euclidean distance
D1 <- dist(dat2)
D1 <- round(D1, 2)
D1

# 2. Minkowski distance
# D2<- dist(m1, method="minkowski", p=3)
# Manhattan distance
# D3 <-dist(dat1, method = "manhattan")

# ch13.1 k-means : Non-hierachical clustering

# step1: to choose the optimal k
library(factoextra)

# may use scale data or raw data for the optimal k
s_dat2 <- scale(dat2)

fviz_nbclust(s_dat2, kmeans, method = "wss", k.max = 5) + 
  geom_vline(xintercept = 3, linetype = 2)

fviz_nbclust(s_dat2, kmeans, method = "gap_stat", k.max = 5)
fviz_nbclust(s_dat2, kmeans, method = "silhouette", k.max = 5)

# step2 : k-means
set.seed(123)
km <- kmeans(dat2, 3)
km

# km <- kmeans(dat1, 3, nstart=10)
# km

# visualize
fviz_cluster(km,
  data = dat2,
  ellipse.type = "convex",
  repel = TRUE, cex = 3
)

# ch13.2 PAM (Partitioning Around Medoids)
library("cluster")

pam_out <- pam(dat2, 3)
pam_out

# freq of each cluster
table(pam_out$clustering)

# visualize
fviz_cluster(pam_out,
  data = dat2,
  ellipse.type = "convex",
  repel = TRUE
)

# ch13.5 DBSCAN
library(fpc)

db <- dbscan(dat2, eps = 3, MinPts = 3)

# The result of clustering
db
db$cluster

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
