# ch12_cluster.r
# Clustering : Distance measures, linkage method
# Diana, optimal k

# ch12.1 Distance measures
# ch12.2 Average linkage method

# read csv file
dat1 <- read.csv("data/ch12_dat1.csv")
dat2 <- dat1[, -1]

# Euclidean distance
D1 <- dist(dat2)
round(D1, 2)

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

# Squared Euclidean distance
D1 <- dist(dat2)
D1^2

# Ward's linkage method
# check how different from linkage method
hc_c <- hclust(D1, method = "ward.D2")
plot(hc_c,
  hang = -1, cex = 1, main = "Ward's linkage with Euclidean distance",
  ylab = "Distance", xlab = "observation"
)

# ch12.4 Diana

# load packages
library(cluster)

# read csv file
dat1 <- read.csv("data/ch12_dat3.csv")
dat2 <- dat1[, -1]

# DIANA clustering
clus_diana <- diana(dat2)

# Plot dendrogram
plot(clus_diana, which.plots = 2, main = "Dendrogram of Diana")

# Ch12.5 How to choose k
# Non-hierarchical clustering ###

# load packages
library(factoextra)

# read csv file
dat1 <- read.csv("data/ch12_dat2.csv")
dat2 <- dat1[, -1]

# step1: to choose the optimal k
fviz_nbclust(dat2, hcut, method = "silhouette", k.max = 7)

