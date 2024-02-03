# ch5.3 accuracy measure 
# Sensitivity, Specificity, f-score

# load packages
library(caret) # confusion matrix

# ex5-4 data
true_y <- factor(c(rep(1, 20), rep(0, 80)), levels = c(1, 0))
pred_y <-factor(c(rep(1, 15), rep(0, 75), rep(1, 10)), levels = c(1, 0))

# confusion matrix
cm <- confusionMatrix(data = pred_y, reference = true_y)
cm

# confusion table
cm$table

# accuracy measure, sensitivity, specificity, and f-score
cm$byClass

f_score <- cm$byClass['F1']
print(f_score)
