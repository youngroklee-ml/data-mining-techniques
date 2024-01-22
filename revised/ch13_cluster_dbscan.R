# ch13_cluster_dbscan.R
# Non-Hierarchical Clustering
# k-means, PAM, DBSCAN

# ch13.1 k-means : Non-hierarchical clustering

# load packages
library(factoextra)

# read csv file
dat1 <- read.csv("data/ch12_dat1.csv")
dat2 <- dat1[, -1]

# step1: to choose the optimal k

# may use scale data or raw data for the optimal k
s_dat2 <- scale(dat2)

fviz_nbclust(s_dat2, kmeans, method = "silhouette", k.max = 5)

# step2 : k-means
set.seed(123)
km <- kmeans(dat2, 3)
km

# visualize
fviz_cluster(km,
  data = dat2,
  ellipse.type = "convex",
  repel = TRUE, cex = 3
)


# ch13.2 PAM (Partitioning Around Medoids)

# load packages
library(cluster)
library(factoextra)

# read csv file
dat1 <- read.csv("data/ch13_pam.csv")
dat2 <- dat1[, -1]

# PAM
pam_out <- pam(dat2, 2)
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

# load packages
library(fpc)
library(factoextra)

# read csv file
dat1 <- read.csv("data/ch12_dat1.csv")
dat2 <- dat1[, -1]

# DBSCAN
db <- dbscan(dat2, eps = 2.5, MinPts = 3)

# The result of clustering
db
db$cluster

# visualization
fviz_cluster(db,
  data = dat2,
  ellipse.type = "convex",
  repel = TRUE
)
