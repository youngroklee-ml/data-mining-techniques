# ex5-2: k-nearest neighbor classification

# load package
library(class) # knn
library(proxy) # dist - support cross-distance

# load data
dat1 <- read.csv("data/ch7_dat1.csv")
dat1$class <- factor(dat1$class)
train_x <- dat1[1:7, 2:3]
train_y <- dat1[1:7, 4]
test_x <- dat1[8:9, 2:3]

# compute Euclidean distance between training data
dist(train_x)

# estimate class for each training data
# as the most frequent class among 3-nearest neighbor
knn.cv(train_x, train_y, k = 3)

# compute Euclidean distance between test and training data
dist(test_x, train_x)

# estimate class for each test data
# as the most frequent class among 3-nearest neighbor in training data
knn(train_x, test_x, train_y, k = 3)
