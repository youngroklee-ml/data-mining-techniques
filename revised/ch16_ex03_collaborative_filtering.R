# ch16_ex03_collaborative_filtering.R
# ch16.2 collaborative filtering

# ex16.3

# load package
library("recommenderlab")

# load data
df <- read.csv("data/ch16_ratings.csv")

# convert to rating matrix
ratings <- as(df, "realRatingMatrix")
print(ratings@data)

# set target customer to generate recommendation
target <- 7

# compute similarity
centered <- normalize(ratings)
similarity(centered[-target], centered[target])

# train recommender engine with all users
rec <- Recommender(ratings, method = "UBCF")
rec

# predict ratings from target user
predicted <- predict(rec, ratings[target], type = "ratings")
print(predicted@data)

# create top-N recommendations for target user
recommended <- predict(rec, ratings[target], n = 2)
print(recommended@items)
