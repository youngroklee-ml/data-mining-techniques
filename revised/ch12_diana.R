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
