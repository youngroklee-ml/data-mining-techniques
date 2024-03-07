# ch11_ex01_distance_similarity.R
# ch11.2 similarity/distance metrics

# read csv file
dat1 <- read.csv("data/ch11_dat1.csv")
dat2 <- dat1[, -1]

# ex11.1
# compute Euclidean distance
D1 <- dist(dat2)
round(D1, 2)

# ex11.3
# correlation measure between samples
row_cor <- cor(t(dat2))
round(row_cor, 4)

# scaled data : correlation measure between samples
std_dat2 <- scale(dat2)
std_row_cor <- cor(t(std_dat2))
round(std_row_cor, 4)

# OPTIONAL: standardized Minkowski distance with p = 3
std_D2 <- dist(std_dat2, method = "minkowski", p = 3)
round(std_D2, 2)
