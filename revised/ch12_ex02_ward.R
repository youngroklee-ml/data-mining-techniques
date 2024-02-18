# ch12_ex02_ward.R
# ch12.3 Ward's method

# ex12.2

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
