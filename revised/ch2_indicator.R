# ch2.8 regression with indicator variable (ch2_indicator.R)

# read csv file
dat1 <- read.csv("data/ch2_coil.csv")
summary(dat1)

dat1$thick <- factor(dat1$thick, levels = c(6, 2))

lm_fit <- lm(y ~ temp + thick, data = dat1)
summary(lm_fit)
anova(lm_fit)

lm_fit_interaction <- lm(y ~ temp + thick + temp:thick, data = dat1)
summary(lm_fit_interaction)
anova(lm_fit_interaction)
