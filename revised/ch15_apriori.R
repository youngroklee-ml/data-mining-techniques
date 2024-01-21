# load required packages
library(arules)

# load data
df <- read.csv("data/ch15_transaction.csv")

# convert a data frame into a list of transactions
transaction_list <- split(df$item, df$id)
print(transaction_list)

# convert a list into an object of class "transactions"
transactions <- as(transaction_list, "transactions")
print(transactions)

# ex15.1 - support

# A user defined function to convert a character vector of items to itemMatrix object
# - itemset: a vector of item labels in a itemset
# - labels: a vector of all labels ordered to be column order of output matrix
as_itemMatrix <- function(itemset, transactions) {
  as(
    matrix(labels %in% itemset, nrow = 1, dimnames = list(NULL, labels)),
    "itemMatrix"
  )
}

# retrieve item labels used in transactions
labels <- transactions@itemInfo$labels

# create itemMatrix object for X = {b, c}, and compute the support
X <- as_itemMatrix(c("b", "c"), labels)
supp_X <- support(X, transactions)
print(supp_X)

# create itemMatrix object for Y = {g}, and compute the support
Y <- as_itemMatrix(c("g"), labels)

# create a rule R: X -> Y, and compute the support
R <- rules(Y, X)
supp_R <- support(R, transactions)
print(supp_R)

# ex15.2 - confidence and lift

# confidence
conf_R <- supp_R / supp_X
print(conf_R)
# when using a function instead:
interestMeasure(R, "confidence", transactions)


# lift
supp_Y <- support(Y, transactions)
lift_R <- conf_R / supp_Y
print(lift_R)
# when using a function instead:
interestMeasure(R, "lift", transactions)



# ex15.3 - generate frequent itemsets with minimal support 0.4
itemsets <- apriori(
  transactions,
  parameter = list(
    support = 0.4,
    target = "frequent itemsets"
  ),
  control = list(verbose = FALSE) # do not print progress
)

inspect(itemsets)


# ex15.4 - find association rules with minimal confidence 0.7
rules <- ruleInduction(
  itemsets,
  transactions,
  confidence = 0.7,
  method = "apriori"
)

inspect(rules)


# one function call to execute both ex15.3 and ex15.4
apriori_results <- apriori(
  transactions,
  parameter = list(
    support = 0.4,
    confidence = 0.7,
    target = "rules"
  ),
  control = list(verbose = FALSE) # do not print progress
)

inspect(apriori_results)
