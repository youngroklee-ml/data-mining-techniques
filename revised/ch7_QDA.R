# ch7_QDA.R
# ch7.4 Quadratic Discriminant Analysis

# load library
library(ggplot2)
library(MASS) # for LDA, QDA
library(caret) # confusion matrix

# read csv file# read csv file
dat1 <- read.csv("data/ch7_dat1.csv")

# remove ID variable
dat1 <- dat1[, -1]

# define class(1,2) as a factor variable
dat1$class <- as.factor(dat1$class)

# Quadratic Discriminant Analysis (QDA)
qda_fit <- qda(class ~ ., data = dat1, prior = c(1 / 2, 1 / 2))
qda_fit

# Predict posterior probabilities
posterior_probs <- predict(qda_fit, type = "posterior")
posterior <- round(posterior_probs$posterior, 3)
posterior

# predict test data
testpred <- predict(qda_fit, dat1)
testpred

# accuracy of QDA
confusionMatrix(testpred$class, as.factor(dat1$class))
