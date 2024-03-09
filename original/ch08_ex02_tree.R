# load package
library(rpart)
library(yardstick)

# load data
df_train <- read.csv("data/ch8_dat1.csv")
df_train$class <- factor(df_train$class, levels = c(1, 2))

df_test <- read.csv("data/ch8_dat2.csv")
df_test$class <- factor(df_test$class, levels = c(1, 2))


# ex8.2
control_depth1 <- rpart.control(
  minsplit = 2, # attempt split when two or more observations are in a node 
  cp = 0, # attempt split even if does not decrease misclassification cost
  xval = 0, # no cross-validation
  maxdepth = 1  # make only one split from root node
)

tree_depth1 <- rpart(
  class ~ x1 + x2, 
  data = df_train,
  control = control_depth1
)

print(tree_depth1)


# ex8.3
control_depth2 <- rpart.control(
  minsplit = 2, # attempt split when two or more observations are in a node 
  cp = 0, # attempt split even if does not decrease misclassification cost
  xval = 0, # no cross-validation
  maxdepth = 2  # make only one split from root node
)

tree_depth2 <- rpart(
  class ~ x1 + x2, 
  data = df_train,
  control = control_depth2
)

print(tree_depth2)


# default value of `maxdepth` is 30
control_maximal <- rpart.control(
  minsplit = 2, # attempt split when two or more observations are in a node 
  cp = 0, # attempt split even if does not decrease misclassification cost
  xval = 0 # no cross-validation
)

tree_maximal <- rpart(
  class ~ x1 + x2, 
  data = df_train,
  control = control_maximal
)

print(tree_maximal)

# ex8.4
# "rel error" is R(T)/R(Root), where Root means a tree with no split
# "nsplit" means a number of splits made to produce tree T
printcp(tree_maximal)

# ex8.5 - ex8.6
T1 <- tree_maximal

T2 <- snip.rpart(T1, toss = 7) # node number corresponding to t5 in the book
print(T2)

T3 <- snip.rpart(T2, toss = 3) # node number corresponding to t2 in the book
print(T3)

# ex8.7
predict(T1, df_test, type = "class")
1 - accuracy_vec(df_test$class, predict(T1, df_test, type = "class"))

predict(T2, df_test, type = "class")
1 - accuracy_vec(df_test$class, predict(T2, df_test, type = "class"))

predict(T3, df_test, type = "class")
1 - accuracy_vec(df_test$class, predict(T3, df_test, type = "class"))


# OPTIONAL: pruning in {rpart} by using argument `cp`
#           that minimize scaled cost-complexity measure
#           R(T) + cp * |T| * R(Root)
#           where Root means a tree with no split.
#           In other words, the pruning minimizes R(T)/R(Root) + cp * |T|
#           where R(T)/R(Root) is "rel error" in `printcp()` output
#           and |T| is 1 + "nsplit" in `printcp()` output
prune(tree_maximal, cp = 0.1)
prune(tree_maximal, cp = 1)
