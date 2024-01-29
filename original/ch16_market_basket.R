# ex16.4

# load library
library("recommenderlab")

# load data
df <- read.csv("data/ch16_purchase.csv")
purchases <- as(df, "binaryRatingMatrix")
purchases

target <- 7

# compute similarity
sim <- similarity(purchases[-target], purchases[target], method = "jaccard")
round(sim, 4)

# train recommender engine with all users
rec <- Recommender(purchases, method = "UBCF")
rec

# predict ratings from target user
predicted <- predict(rec, purchases[target], type = "ratings")
predicted
print(round(predicted@data, 4))

# create top-N recommendations for 7th (target) user
pre <- predict(rec, purchases[target], n = 2)
pre
as(pre, "list")
