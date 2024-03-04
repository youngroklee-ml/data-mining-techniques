# ch05_ex06_ROC_2.R
# ch5.4 ROC curve

# ex5-6

# load package
library(yardstick)
library(ggplot2)

# load data
dat <- read.csv("data/ch5_roc.csv")
dat$class <- factor(dat$class)
dat$pred <- factor(dat$pred)

# ROC curve
roc <- roc_curve(dat, truth = "class", posterior1)
roc

# Area under ROC curve
auc <- roc_auc(dat, truth = "class", posterior1)
auc

# Plot
autoplot(roc) +
  labs(title = paste0("ROC Curve: AUC = ", auc[[".estimate"]]))
