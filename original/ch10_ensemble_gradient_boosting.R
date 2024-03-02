# gradient boosting for regression

# load data
dat <- read.csv("data/ch10_dat3.csv")

# plot data
plot(dat$X, dat$Y, xlab="X", ylab="Y")

# initial model
C <- mean(dat$Y)

# gradient boosting
iter <- 5
for(i in 1:iter){
  
  # negative gradients
  ngrad <- dat$Y - C
  
  # fit C to negative gradients
  dat.m <- data.frame(X=dat$X, ngrad=ngrad)
  fit <- rpart(ngrad ~ X, data=dat.m, control=rpart.control(maxdepth=1))
  
  C <- C + predict(fit)
}

# plot predicted values
plot(dat$X, C, xlab="X", ylab="Y")

# using gbm package
library(gbm)

dat <- read.csv("data/Player.csv")
dat.sub <- dat[!is.na(dat[,"Salary"]),c("Salary","Hits","Walks","CRuns","HmRun","CWalks")]

fit <- gbm(
  Salary ~ .,
  data = dat.sub,
  distribution = "gaussian",  # squared loss
  n.trees = 100,              # try to change n.trees
  interaction.depth = 10      # try to change tree depth
)

pred <- predict(fit)

# R-squared
R.squared <- cor(dat.sub$Salary, pred)^2

# plot true vs predicted
plot(dat.sub$Salary, pred, xlab="true", ylab="predicted", xim=c(0,2500), ylim=c(0,2500))
lines(c(0,2500), c(0,2500))

# gradient boosting for classification
# using gbm package

# load data: letter recognition
dat <- read.csv("data/ch10_dat4.csv")
dat$class <- factor(dat$class)

fit <- gbm(
  class ~ .,
  data = dat,
  distribution = "multinomial",
  n.trees = 10,
  interaction.depth = 3
)

# class probabilities
pred.prob <- predict(fit, dat, type = "response")

# predicted classes
pred.idx <- apply(pred.prob, 1, which.max)
pred.class <- NULL
for(i in 1:length(pred.idx)){pred.class[i]<-LETTERS[pred.idx[i]]}

# prediction performance
result <- cbind(dat, pred_class = factor(pred.class))
cm <- conf_mat(result, truth = "class", estimate = "pred_class")
cm
summary(cm)
