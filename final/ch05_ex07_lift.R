# ch05_ex07_lift.R
# ch5.5 gain/lift chart

# ex5-7

# load package
library(yardstick)
library(ggplot2)

# load data:
# 1000 observations with estimated posterior of belonging class 1
dat <- read.csv("data/ch5_lift_2.csv")
dat$class <- factor(dat$class)
head(dat)
tail(dat)
summary(dat)

# load data:
# frequency of class 1 within each 100 observations 
# sorted by posterior
grouped <- read.csv("data/ch5_lift_1.csv")
grouped$group <- factor(grouped$group)
grouped

# total number of observations belong to class 1
total_n1 <- sum(grouped$n1)
print(total_n1)

# overall proportion of class 1
prop_n1 <- sum(grouped$n1) / sum(grouped$n)
print(prop_n1)

# compute statistics 
grouped$response_pct <- grouped$n1 / grouped$n * 100
grouped$captured_response_pct <- grouped$n1 / total_n1 * 100
grouped$gain <- cumsum(grouped$captured_response_pct)
grouped$lift <- (cumsum(grouped$n1) / cumsum(grouped$n)) / prop_n1
grouped

# plot

# Gain chart
ggplot(grouped, aes(x = group, y = gain)) +
  geom_line(group = 1) +
  geom_point() +
  labs(y = "% Gain", title = "Gain Chart for Class 1") +
  theme_classic()

# Lift chart
ggplot(grouped, aes(x = group, y = lift)) +
  geom_hline(yintercept = 1, color = "grey30", linetype = "dashed") +
  geom_line(group = 1) +
  geom_point() +
  labs(y = "Lift", title = "Lift Chart for Class 1") +
  scale_y_continuous(breaks = seq(1, 2.2, by = 0.2)) +
  theme_classic()


# OPTIONAL: Use raw 1000 observations
# gain chart
gain <- gain_curve(dat, truth = class, posterior1)
autoplot(gain)

# lift chart
lift <- lift_curve(dat, truth = class, posterior1)
autoplot(lift)

