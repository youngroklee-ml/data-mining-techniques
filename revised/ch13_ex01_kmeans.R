# ch13_ex01_kmeans.R
# ch13.1 k-means : Non-hierarchical clustering

# ex13.1

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
             stand = FALSE,
             repel = TRUE, cex = 3
)
