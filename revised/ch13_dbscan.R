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
