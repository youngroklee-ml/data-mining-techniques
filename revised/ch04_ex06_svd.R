# ch04_ex06_svd.R
# ch4.3 Matrix decomposition

# load package
library(Matrix)

# load data
dat1 <- read.csv(file = "data/ch4_dat1.csv")

# define as matrix
x <- as.matrix(dat1)

# dimension of x
n <- dim(x)[1]
k <- dim(x)[2]

# ex4-6

# singular decomposition
s <- svd(x, nu = n, nv = k)
diag(s$d, nrow = n, ncol = k)
s$u
s$v


# ex4-7

# rank of matrix x
r <- rankMatrix(x)

# singular decomposition of x
s <- svd(x, nu = r, nv = r)
diag(s$d[1:r])
s$u
s$v
