# ch11_ex04_jaccard.R
# ch11.3 similarity metrics on discrete variables

# load data
df <- read.csv("data/ch11_dat2.csv")

# pairwise Jaccard similarity (see eq(11.19))
# J(x, y) = a / (a + b + c)
# a: number of variables valued 1 in both x and y
# b: number of variables valued 1 in x, but 0 in y
# c: number of variables valued 0 in x, but 1 in y
jaccard_sim <- 1 - dist(df, method = "binary")
jaccard_sim
jaccard_sim_mat <- as.matrix(jaccard_sim)

# similarity between the first and the second rows
jaccard_sim_mat[1, 2]
