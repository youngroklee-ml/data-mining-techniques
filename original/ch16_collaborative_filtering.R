# ex16.3

# load library
library("recommenderlab")

# load data
df <- read.csv("data/ch16_ratings.csv")

# convert to rating matrix
ratings <- as(df, "realRatingMatrix")
ratings

# set target customer to generate recommendation
target <- 7

# compute similarity
centered <- normalize(ratings)
centered
similarity(centered[-target], centered[target])

# train recommender engine with all users
rec <- Recommender(ratings, method = "UBCF")
rec

# predict ratings from target user
predicted <- predict(rec, ratings[target], type = "ratings")
predicted
print(predicted@data)

# create top-N recommendations for target user
recommended <- predict(rec, ratings[target], n = 2)
print(recommended)
print(recommended@items)
print(recommended@ratings)

