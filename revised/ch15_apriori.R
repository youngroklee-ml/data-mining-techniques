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

# ex15.3 - explore frequent itemsets
itemsets <- apriori(
  transactions,
  parameter = list(
    support = 0.4,
    target = "frequent itemsets"
  )
)

inspect(itemsets)


# ex15.4 - explore association rules
rules <- ruleInduction(
  itemsets,
  transactions,
  confidence = 0.7
)

inspect(rules)
