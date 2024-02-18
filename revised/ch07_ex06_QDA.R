# ch07_ex06_QDA.R
# ch7.4 Quadratic Discriminant Analysis

# load library
library(MASS) # QDA
library(yardstick) # measure performance

# read csv file# read csv file
dat1 <- read.csv("data/ch7_dat1.csv")

# remove ID variable
dat1 <- dat1[, -1]

# define class(1,2) as a factor variable
dat1$class <- as.factor(dat1$class)

# ex7.6
# Quadratic Discriminant Analysis (QDA)
qda_fit <- qda(class ~ ., data = dat1, prior = c(1 / 2, 1 / 2))
qda_fit

# predict test data set:
# in this example, test data is the same to training data
pred <- predict(qda_fit, dat1)

# predicted posterior probabilities
pred$posterior

# predicted class
pred$class

# summary table
results <- cbind(dat1, posterior = pred$posterior, pred_class = pred$class)
results

# measuring performance of QDA
metrics_multi <- metric_set(accuracy, sens, spec, f_meas, roc_auc)
metrics_multi(results, truth = "class", estimate = "pred_class", posterior.1)
