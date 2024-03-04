# ch06_ex01_binary.R
# ch6.1 binary logistic regression

# load package
library(yardstick) # confusion matrix

# read csv file
dat1 <- read.csv("data/ch6_dat1.csv")
dat1$Class <- factor(dat1$Class, levels = c("Average", "Excellent"))

# ex6.1
# estimate binary logistic regression
bin.fit <- glm(
  Class ~ Break + Sleep + Circle,
  data = dat1,
  family = binomial("logit")
)

# regression coefficients with significance tests
summary(bin.fit)

# odds ratio
exp(coef(bin.fit))

# logit(P)
logit <- predict(bin.fit, newdata = dat1, type = "link")
logit

# predicted probability (P)
pred.prob <- predict(bin.fit, newdata = dat1, type = "response")
pred.prob

# predicted class
pred.class <- factor(
  ifelse(pred.prob > .5, "Excellent", "Average"), 
  levels = c("Average", "Excellent")
)
pred.class

# result table
results <- cbind(dat1, logit = logit, P = pred.prob, pred_class = pred.class)
results

# confusion matrix
conf_mat(results, truth = "Class", estimate = "pred_class")


# ex6.3
# estimate with complementary log-log(gompit) link function
gompit.fit <- glm(
  Class ~ Break + Sleep + Circle, 
  data = dat1, 
  family = binomial("cloglog")
)

summary(gompit.fit)

# estimate with probit(normit) link function
normit.fit <- glm(
  Class ~ Break + Sleep + Circle, 
  data = dat1, 
  family = binomial("probit")
)

summary(normit.fit)
