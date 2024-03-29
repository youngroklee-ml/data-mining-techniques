# ch05_ex05_ROC_1.R
# ch5.4 ROC curve

# ex5-5

# load package
library(yardstick)
library(ggplot2)

# read csv file
dat5 <- read.csv("data/ch5_dat5.csv")
dat5$class <- factor(dat5$class, levels = c(1, 0))

# classification based on rules: x >= 40
dat5$pred40 <- factor(ifelse(dat5$x >= 40, 1, 0), levels = c(1, 0))

# measure performance - pred40
cm40 <- conf_mat(dat5, truth = "class", estimate = "pred40")
cm40

multi_metric <- metric_set(sens, spec)
metric40 <- multi_metric(dat5, truth = "class", estimate = "pred40")
metric40


# classification based on rules: x >= 50
dat5$pred50 <- factor(ifelse(dat5$x >= 50, 1, 0), levels = c(1, 0))

# measure performance - pred50
cm50 <- conf_mat(dat5, truth = "class", estimate = "pred50")
cm50

metric50 <- multi_metric(dat5, truth = "class", estimate = "pred50")
metric50
