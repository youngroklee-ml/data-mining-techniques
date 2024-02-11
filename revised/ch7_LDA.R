# ch7_LDA.R
# ch7.2 Linear Discriminant Analysis

# load library
library(ggplot2)
library(MASS) # for LDA
library(caret) # confusion matrix

# read csv file# read csv file
dat1 <- read.csv("data/ch7_dat1.csv")

# remove ID variable
dat1 <- dat1[, -1]

# define class(1,2) as a factor variable
dat1$class <- as.factor(dat1$class)

# Linear Discriminant Analysis (LDA)
lda_fit <- lda(class ~ ., data = dat1, prior = c(1 / 2, 1 / 2))
lda_fit

# Predict posterior probabilities
posterior_probs <- predict(lda_fit, type = "posterior")
round(posterior_probs$posterior, 3)

# Display the first few rows of posterior probabilities
head(posterior_probs$posterior)

# predict test data set
testpred <- predict(lda_fit, dat1)
testpred

# accuracy of LDA
confusionMatrix(testpred$class, as.factor(dat1$class))
