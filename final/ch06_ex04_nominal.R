# ch06_ex04_nominal.R
# ch6.2 nominal logistic regression

# load package
library(nnet) # nominal logistic regression
library(yardstick) # confusion matrix

# read csv file
dat2 <- read.csv("data/ch6_dat2.csv")
dat2$Y <- factor(dat2$Y, levels = c(1, 2, 3))

# ex6.4
# baseline-category logit model
# set the first class (1) as reference level
nom.fit <- multinom(
  Y ~ X1 + X2,
  data = dat2
)

# regression coefficients with significance tests
summary(nom.fit)


# predicted probabilities
pred.prob <- predict(nom.fit, newdata = dat2, type = "probs")
pred.prob

# predicted class
pred.class <- predict(nom.fit, newdata = dat2, type = "class")
pred.class

# result table
results <- cbind(dat2, P = pred.prob, pred_class = pred.class)
results

# confusion matrix
conf_mat(results, truth = "Y", estimate = "pred_class")
