# ex16.4

# load library
library("recommenderlab")

# load data
df <- read.csv("data/ch16_purchase.csv")

# convert to binary rating matrix
purchases <- as(df, "binaryRatingMatrix")
mat <- as(purchases@data, "matrix")
mat

# set target customer to generate recommendation
target <- 7

# compute similarity
sim <- similarity(purchases[-target], purchases[target], method = "jaccard")
round(sim, 4)

# predicted score
target_items <- !mat[target, ]
predicted <- 1 / sum(sim) *
  t(sim) %*% as(purchases[-target], "matrix")[, target_items]
round(predicted, 4)
