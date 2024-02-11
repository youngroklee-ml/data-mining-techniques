# ch7_LDA.R
# ch7.2 Linear Discriminant Analysis

# ex7.4

# load library
library(MASS) # for LDA
library(yardstick) # performance measurement

# read csv file
dat1 <- read.csv("data/ch7_dat1.csv")

# remove ID variable
dat1 <- dat1[, -1]

# define class(1,2) as a factor variable
dat1$class <- as.factor(dat1$class)

# Linear Discriminant Analysis (LDA)
lda_fit <- lda(class ~ ., data = dat1, prior = c(1 / 2, 1 / 2))
lda_fit

# predict test data set:
# in this example, test data is the same to training data
pred <- predict(lda_fit, dat1)

# predicted posterior probabilities
pred$posterior

# predicted class
pred$class

# summary table
results <- cbind(dat1, posterior = pred$posterior, pred_class = pred$class)
results

# measuring performance of LDA
metrics_multi <- metric_set(accuracy, sens, spec, f_meas, roc_auc)
metrics_multi(results, truth = "class", estimate = "pred_class", posterior.1)
