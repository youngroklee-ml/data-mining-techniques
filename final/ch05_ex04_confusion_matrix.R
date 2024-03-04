# ch05_ex04_confusion_matrix.R
# ch5.3 classification performance metrics

# ex5-4

# load packages
library(yardstick)

# load data
dat <- read.csv("data/ch5_cm.csv")
dat$pred_y <- factor(dat$pred_y, levels = c(1, 0))
dat$true_y <- factor(dat$true_y, levels = c(1, 0))
summary(dat)
table(dat)

# confusion matrix
cm <- conf_mat(dat, truth = "true_y", estimate = "pred_y")
cm

# accuracy, sensitivity, specification, F1
multi_metric <- metric_set(accuracy, sens, spec, f_meas)
multi_metric(dat, truth = "true_y", estimate = "pred_y")

# OPTIONAL: show many other metrics from confusion matrix
summary(cm)
