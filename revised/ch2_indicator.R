# ch2.8 regression with indicator variable (ch2_indicator.R)

# load package
library(ggplot2)

# read csv file
dat1 <- read.csv("data/ch2_coil.csv")
summary(dat1)

# convert variable `thick` to factor
dat1$thick <- factor(dat1$thick, levels = c(6, 2))
summary(dat1)

# ex2.14: fit a regression model
lm_fit <- lm(y ~ temp + thick, data = dat1)
summary(lm_fit)

# ex2.16
lm_fit_interaction <- lm(y ~ temp + thick + temp:thick, data = dat1)
summary(lm_fit_interaction)

# plot
ggplot(dat1, aes(x = temp, y = y, shape = thick, linetype = thick)) +
  geom_smooth(method = "lm", se = FALSE, color = "grey30") +
  geom_point(size = 3) +
  labs(x = "CT", y = "TS", shape = "thickness", linetype = "thickness") +
  theme_classic() +
  theme(legend.position = c(0.2, 0.2))
