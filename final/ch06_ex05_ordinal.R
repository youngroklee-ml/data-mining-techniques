# ch06_ex05_ordinal.R
# ch6.3 ordinal logistic regression

# load package
library(VGAM) # ordinal logistic regression
library(yardstick) # confusion matrix

# read csv file
dat3 <- read.csv("data/ch6_dat3.csv")
dat3$Y <- factor(dat3$Y, levels = c(1, 2, 3), ordered = TRUE)

# ex6.5
# cumulative logit model
cum.fit <- vglm(
  Y ~ N + L,
  data = dat3,
  family = cumulative(parallel = TRUE, reverse = FALSE)
)

# regression coefficients with significance tests
# use `HDEtest = FALSE` to disable test for Hauck-Donner effect
summary(cum.fit, HDEtest = FALSE)

# predicted probabilities
pred.prob <- predict(cum.fit, dat3, type = "response")
pred.prob

# predicted class
pred.class <- factor(
  apply(pred.prob, 1, which.max),
  levels = c(1, 2, 3),
  ordered = TRUE
)
pred.class

# result table
results <- cbind(dat3, P = pred.prob, pred_class = pred.class)
results

# confusion matrix
conf_mat(results, truth = "Y", estimate = "pred_class")


# ex6.6
# adjacent-categories logit model
adj.fit <- vglm(
  Y ~ N + L,
  data = dat3,
  family = acat(parallel = FALSE, reverse = FALSE)
)

# regression coefficients with significance tests
summary(adj.fit, HDEtest = FALSE)

# predicted probabilities
pred.prob <- predict(adj.fit, dat3, type = "response")
pred.prob

# predicted class
pred.class <- factor(
  apply(pred.prob, 1, which.max),
  levels = c(1, 2, 3),
  ordered = TRUE
)
pred.class

# result table
results <- cbind(dat3, P = pred.prob, pred_class = pred.class)
results

# confusion matrix
conf_mat(results, truth = "Y", estimate = "pred_class")
