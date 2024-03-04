# ch14_ex05_internal.R
# ch14.1 cluster solution evaluation (14.1.2 internal index)

# ex14.5

# load package
library(clv) # Dunn, connectivity, silhouette
library(fpc) # Calinski-Harabasz(CH)

# load data
df <- read.csv("data/ch14_dat1.csv", colClasses = "numeric")
mat <- as.matrix(df)
D <- dist(mat)

# cluster solution
sol_1 <- as.integer(c(1, 2, 1, 3, 2, 1, 2, 3))
sol_2 <- as.integer(c(1, 2, 1, 2, 2, 1, 2, 2))

# cluster summary
clust_1 <- cls.scatt.data(df, sol_1)
clust_2 <- cls.scatt.data(df, sol_2)

# see cluster summary, including cluster center, size, 
# and various inter/intra-cluster distance metrics
print(clust_1)
print(clust_2)

# Dunn index
clv.Dunn(clust_1, intracls = "complete", intercls = "single")
clv.Dunn(clust_2, intracls = "complete", intercls = "single")

# Calinski-Harabasz index
calinhara(df, sol_1)
calinhara(df, sol_2)

# connectivity (BI)
connectivity(df, sol_1, neighbour.num = 1)
connectivity(df, sol_2, neighbour.num = 1)

# silhouettes
summary(silhouette(sol_1, dist = D))[["avg.width"]]
summary(silhouette(sol_2, dist = D))[["avg.width"]]

# silhouettes by observations
silhouette(sol_1, dist = D) # cluster solution 1
silhouette(sol_2, dist = D) # cluster solution 2
