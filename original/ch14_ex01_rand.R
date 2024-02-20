# ch14_ex01_rand.R
# ch14.1 cluster solution evaluation (14.1.1 external index)

# load package
library(clv)

# load data
sol_1 <- as.integer(c(1, 1, 2, 2, 2, 3, 3))
sol_2 <- as.integer(c(1, 1, 2, 3, 2, 1, 3))

# count pairs
# SS: same cluster in both solutions
# SD: same cluster in solution 1, but different cluster in solution 2
# DS: different cluster in solution 1, but same cluster in solution 2
# DD: different cluster in both solutions
std <- std.ext(sol_1, sol_2)
std

# ex14.1
# compute rand index
clv.Rand(std)

# ex14.3
# compute adjusted rand index
clv.Phi(std)
