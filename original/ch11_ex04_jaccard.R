# ch11_ex04_jaccard.R
# ch11.3 similarity metrics on discrete variables

# load data
df <- read.csv("data/ch11_dat2.csv")

# pairwise Jaccard similarity
jaccard_sim <- dist(df, method = "binary")
jaccard_sim
jaccard_sim_mat <- as.matrix(jaccard_sim)

# similarity between the first and the second rows
jaccard_sim_mat[1, 2]
