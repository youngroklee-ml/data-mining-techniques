# ch04_ex05_svd.R
# ch4.3 Matrix decomposition

# load package
library(Matrix)

# load data
dat1 <- read.csv(file = "data/ch4_dat1.csv")

# define as matrix
x <- as.matrix(dat1)

# ex4-5

# dimension of x
n <- dim(x)[1]
k <- dim(x)[2]

# singular value decomposition of x
s <- svd(x, nu = n, nv = k)
diag(s$d, nrow = n, ncol = k)
s$u
s$v


# rank of matrix x
r <- rankMatrix(x)

# singular value decomposition of x
s <- svd(x, nu = r, nv = r)
diag(s$d[1:r])
s$u
s$v
