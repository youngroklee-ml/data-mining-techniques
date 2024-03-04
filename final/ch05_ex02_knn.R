# ch05_ex02_knn.R
# ch5.2 basic methods (ch5.2.1 k-nearest neighbor)

# ex5-2: k-nearest neighbor classification

# load package
library(class) # knn

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

# estimate class for each test data
# as the most frequent class among 3-nearest neighbor in training data
knn(train_x, test_x, train_y, k = 3)
