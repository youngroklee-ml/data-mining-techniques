# ch05_ex03_NB.R
# ch5.2 basic methods (ch5.2.2 naive Bayes)
# ch5.3 classification performance metrics 

# load packages
library(e1071) # naive bayes
library(yardstick) # measure performance

# read csv file
dat3 <- read.csv("data/ch5_dat3.csv")
dat3$gender <- factor(dat3$gender)
dat3$age_gr <- factor(dat3$age_gr)
dat3$class <- factor(dat3$class)

# summary about data
summary(dat3)


# ex5-3: Naive Bayes classification

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
results <- cbind(dat3, pred_class = nb_class, posterior = round(nb_posterior, 3))
results


# ex5-4: measure performance for ex5-3 results

# confusion matrix
conf_mat(results, truth = "class", estimate = "pred_class")

# sensitivity, specificity, F1-score
multi_metric <- metric_set(accuracy, sens, spec, f_meas)
multi_metric(results, truth = "class", estimate = "pred_class")
