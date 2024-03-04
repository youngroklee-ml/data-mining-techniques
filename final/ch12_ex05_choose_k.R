# ch12_ex05_choose_k.R
# Ch12.5 How to choose k

# load packages
library(factoextra)

# read csv file
dat1 <- read.csv("data/ch12_dat2.csv")
dat2 <- dat1[, -1]

# ex12.5
# choose the optimal k based on average silhouette width
fviz_nbclust(dat2, hcut, method = "silhouette", k.max = 7)
