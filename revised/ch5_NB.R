# ch5.2.Naive Bayes

# ex5-3

# load packages
library(e1071) # naive bayes

# read csv file
dat3 <- read.csv("data/ch5_dat3.csv")
dat3$gender <- factor(dat3$gender)
dat3$age_gr <- factor(dat3$age_gr)
dat3$class <- factor(dat3$class)

# summary about data
summary(dat3)

# Naive Bayes classification
nb_fit <- naiveBayes(class ~ gender + age_gr, data = dat3)
print(nb_fit)

# posterior probability
nb_posterior <- predict(nb_fit, dat3, type = "raw")
round(nb_posterior, 3)

# estimated class
nb_class <- predict(nb_fit, dat3, type = "class")
nb_class

# print summary results
cbind(dat3, pred_class = nb_class, posterior = round(nb_posterior, 3))


