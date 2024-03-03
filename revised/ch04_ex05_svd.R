# ch04_ex05_svd.R
# ch4.3 Matrix decomposition

# load package
library(Matrix)

# load data
# centered matrix
x <- matrix(
  c(
    1, 2, 3, 2,
    -1, 0, -1, -1,
    0, -2, -2, -1
  ),
  nrow = 3,
  byrow = TRUE
)
print(x)


# ex4-5

# dimension of x
n <- dim(x)[1]
k <- dim(x)[2]

# singular decomposition of x
s <- svd(x, nu = n, nv = k)
diag(s$d, nrow = n, ncol = k)
s$u
s$v

# verify Theorem 4.8
all.equal(
  x, 
  s$u %*% diag(s$d, nrow = n, ncol = k) %*% t(s$v)
)

# x'x
xtx <- t(x) %*% x
print(xtx)
n_xtx <- dim(xtx)[1]
k_xtx <- dim(xtx)[2]
s_xtx <- svd(xtx, nu = n_xtx, nv = k_xtx)
diag(s_xtx$d, nrow = n_xtx, ncol = k_xtx)
s_xtx$u
s_xtx$v

# check (x'x)*eigenvector[,2]=eigenvalue[2]*eigenvector[,2]
xtx %*% s_xtx$v[, 2]
s_xtx$v[, 2] * s_xtx$d[2]


# ex4-7

# rank of matrix x
r <- rankMatrix(x)

# singular decomposition of x
s <- svd(x, nu = r, nv = r)
diag(s$d[1:r])
s$u
s$v

# verify Theorem 4.9
all.equal(
  x, 
  s$u %*% diag(s$d[1:r]) %*% t(s$v)
)


