# ex16.2

# load data
df <- read.csv("data/ch16_content.csv")
user_weights <- as.vector(df[, 2])
doc_weights <- as.matrix(df[, -c(1, 2)])

# compute utility
numerator <- t(user_weights) %*% doc_weights
denominator <- norm(user_weights, type = "2") * apply(doc_weights, 2, norm, type = "2")
utility <- numerator / denominator
round(utility, 4)
