# ch12_ex01_average_linkage.R
# ch12.1 cluster distance metrics and linkage methods
# ch12.2 algorithm of linkage methods

# ex12.1

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
