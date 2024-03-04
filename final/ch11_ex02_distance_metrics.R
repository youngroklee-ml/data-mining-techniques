# ch11_ex02_distance_metrics.R
# ch11.2 similarity/distance metrics

# load data
x <- c(3, 4)
origin <- c(0, 0)

# (a) Euclidean distance
dist(rbind(x, origin))

# (b) Standardized Euclidean with s1 = 1, s2 = 2
dist(rbind(x / c(1, 2), origin / c(1, 2)))

# (c) Standardized Euclidean with s1 = 1, s2 = 0.5
dist(rbind(x / c(1, 0.5), origin / c(1, 0.5)))

# (d) Mahalanobis distance with s1 = 1, s2 = 2, r = 0.8
cov_mat <- matrix(c(1^2, 0.8 * 1 * 2, 0.8 * 1 * 2, 2^2), nrow = 2)
sqrt(mahalanobis(x, center = origin, cov_mat))

# (e) Mahalanobis distance with s1 = 1, s2 = 2, r = -0.8
cov_mat <- matrix(c(1^2, -0.8 * 1 * 2, -0.8 * 1 * 2, 2^2), nrow = 2)
sqrt(mahalanobis(x, center = origin, cov_mat))
