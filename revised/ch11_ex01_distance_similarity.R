# ch11_ex01_cluster.R
# ch11.2 similarity/distance metrics


# read csv file
dat1 <- read.csv("data/ch11_dat1.csv")
dat2 <- dat1[, -1]

# ex11.1

# compute Euclidean distance
D1 <- dist(dat2)
round(D1, 2)

# convert to matrix
D1_mat <- as.matrix(D1)
round(D1_mat, 2)

# Distance between O2 and O4
D1_mat[2, 4]

# Distance between O2 and O5
D1_mat[2, 5]


# standardize data
std_dat2 <- scale(dat2)
attr(std_dat2, "scaled:center") # mean
attr(std_dat2, "scaled:scale") # standard deviation

# compute standardized Euclidean distance
std_D1 <- dist(std_dat2)
std_D1_mat <- as.matrix(std_D1)
round(std_D1_mat, 2)

# standardized Euclidean distance between O2 and O4
std_D1_mat[2, 4]

# standardized Euclidean distance between O2 and O5
std_D1_mat[2, 5]


# OPTIONAL: standardized Minkowski distance with p = 3; 
std_D2 <- dist(std_dat2, method = "minkowski", p = 3)
round(std_D2, 2)


# ex11.3

# correlation measure between samples
row_cor <- cor(t(dat2), use = "pairwise.complete.obs", method = "pearson")
round(row_cor, 2)

# correlation between O1 and O6
row_cor[1, 6]

# correlation between O1 and O8
row_cor[1, 8]


# scaled data : correlation measure between samples
std_row_cor <- cor(t(std_dat2), use = "pairwise.complete.obs", method = "pearson")
round(std_row_cor, 2)

# correlation between O1 and O6 after standardization
std_row_cor[1, 6]

# correlation between O1 and O8 after standardization
std_row_cor[1, 8]


