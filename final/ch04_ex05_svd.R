# ch04_ex05_svd.R
# ch4.3 Matrix decomposition
# ch4.4 Principal component score

# ex4-5
# load data
dat1 <- read.csv(file = "data/ch4_dat1.csv")
dat1
# define as matrix
x <- as.matrix(dat1)

# singular value decomposition of x
s <- svd(x)
diag(s$d)
s$u
s$v

# ex4-6
# covariance matrix of x
cov(x)
svd(cov(x))
# correlation matrix of x
cor(x)
svd(cor(x))

# ex4-7
# principal component T=xp
x %*% s$v

# ex4-8
# eigenvalue & eigenvector of x'x
eigen(t(x) %*% x)
