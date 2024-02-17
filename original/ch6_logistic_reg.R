# ch2_logistic_reg.R

# ch6.1 binary logistic regression

# read csv file
dat1 <- read.csv("data/ch6_dat1.csv")
dat1$Class <- as.factor(dat1$Class)

# binary logistic regression
bin.fit <- glm(Class ~ Break + Sleep + Circle, data = dat1, family = binomial("logit"))

# regression coefficients with significance tests
summary(bin.fit)

# odds ratio
exp(bin.fit$coefficients)

# logit(P)
log(bin.fit$fitted.values/(1-bin.fit$fitted.values))
logit <- bin.fit$linear.predictors

# predicted probability (P)
bin.fit$fitted.values
pred.prob <- predict(bin.fit, type="response")

# predicted class
pred.class <- ifelse(pred.prob>.5, "Excellent", "Average")

# result table
results <- cbind(dat1, logit = logit, P = pred.prob, pred_class = pred.class)

# confusion matrix
table(results$Class, results$pred_class)

# probit(normit) link function
probit.fit <- glm(Class ~ Break + Sleep + Circle, data = dat1, family = binomial("probit"))
summary(probit.fit)


# ch6.2 nominal logistic regression

# load package
library(mlogit) # nominal logistic regression

# read csv file
dat2 <- read.csv("data/ch6_dat2.csv")
dat2$Y <- as.factor(dat2$Y)

# data convert for mlogit function
dat2.mlogit <- mlogit.data(dat2, varying = NULL, choice = "Y", shape = "wide")

# baseline-category logit model
nom.fit <- mlogit(Y~1 | X1 + X2, data = dat2.mlogit, reflevel = "1")

# regression coefficients with significance tests
summary(nom.fit)

# predicted probabilities
pred.prob <- predict(nom.fit, dat2.mlogit)

# predicted class
pred.class <- apply(pred.prob, 1, which.max)

# result table
results <- cbind(Y = dat2$Y, pred.prob, pred_class = pred.class)

# confusion matrix
table(results[,"Y"], results[,"pred_class"])


# ch6.3 ordinal logistic regression

# read csv file
dat3 <- read.csv("data/ch6_dat3.csv")

# load package
library(VGAM)

# cumulative logit model
ord.fit <- vglm(Y ~ N + L, family = cumulative(parallel=TRUE, reverse=FALSE), dat3)

# regression coefficients with significance tests
summary(ord.fit)

# predicted probabilities
pred.prob <- predict(ord.fit, dat3, type="response")

# predicted class
pred.class <- apply(pred.prob, 1, which.max)

# result table
results <- cbind(dat3, pred.prob, pred_class = pred.class)

# confusion matrix
table(results[,"Y"], results[,"pred_class"])

# adjacent-categories logit model
ord.fit <- vglm(Y ~ N + L, family = acat(parallel=FALSE, reverse=FALSE), dat3)

# regression coefficients with significance tests
summary(ord.fit)

# predicted probabilities
pred.prob <- predict(ord.fit, dat3, type="response")

# predicted class
pred.class <- apply(pred.prob, 1, which.max)

# result table
results <- cbind(dat3, pred.prob, pred_class = pred.class)

# confusion matrix
table(results[,"Y"], results[,"pred_class"])

# comparison with baseline-category logit model
# to see that adjacent-categories logit model is equivalent to baseline-category logit model
dat3$Y <- as.factor(dat3$Y)
dat3.mlogit <- mlogit.data(dat3, varying = NULL, choice = "Y", shape = "wide")

# baseline-category logit model
nom.fit <- mlogit(Y~1 | N + L, data = dat3.mlogit, reflevel = "1")

# regression coefficients with significance tests
summary(nom.fit)

# predicted probabilities
pred.prob <- predict(nom.fit, dat3.mlogit)

# predicted class
pred.class <- apply(pred.prob, 1, which.max)

# result table
results <- cbind(dat3, pred.prob, pred_class = pred.class)

# confusion matrix
table(results[,"Y"], results[,"pred_class"])
