# ch5.4 ROC curve
# Receiver Operating Characteristic curve

# load library
library(MASS) # for LDA
library(caret) # confusion matrix
library(pROC) #  ROC curve

# read csv file : chap7 data
dat1<-read.csv("data/ch7_dat1.csv")

# remove ID variable
dat1<-dat1[,-1]
# define class(1,2) as a factor variable
dat1$class<-as.factor(dat1$class)

# Linear Discriminant Analysis (LDA) 
lda_fit <- lda(class ~ ., data=dat1, prior=c(1/2, 1/2))
lda_fit

# Predict posterior probabilities
posterior_probs <- predict(lda_fit, type = "posterior")
posterior_probs

# Convert to a binary factor (0, 1)
bi_class <- as.factor(as.numeric(dat1$class) - 1)

# Create a ROC curve
roc_curve <- roc(bi_class, posterior_probs$posterior[,1])

# Plot the ROC curve
plot(roc_curve, main = "ROC Curve", col = "blue", lwd = 2, xlim=c(1,0))

# Add AUC value to the plot
auc_value <- auc(roc_curve)
text(0.7, 0.3, paste("AUC =", round(auc_value, 2)), col = "blue", cex = 1.2)
