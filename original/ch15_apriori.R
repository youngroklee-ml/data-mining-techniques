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

# ex15.3 - generate frequent itemsets with minimal support 0.4
itemsets <- apriori(
  transactions,
  parameter = list(
    support = 0.4,
    target = "frequent itemsets"
  ),
  control = list(verbose = FALSE)  # do not print progress
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
  control = list(verbose = FALSE)  # do not print progress
)

inspect(apriori_results)
