# https://en.wikibooks.org/wiki/Data_Mining_Algorithms_In_R/Sequence_Mining/SPADE

# load package
library(arulesSequences)

# read specifically formatted data into transactions with temporal information
trans <- read_baskets(
  con = "data/ch15_sequence.txt", 
  info = c("sequenceID","eventID","SIZE") # do not change the names
)

# ex15.7 - maximal sequences

# frequent sequences
seqs <- cspade(trans, parameter = list(support = 0.4))
inspect(seqs)

# frequent maximal sequences
max_seqs <- subset(seqs, is.maximal(seqs))
inspect(max_seqs)


# ex15.8 - frequent itemsets
itemsets <- cspade(trans, parameter = list(support = 0.4, maxlen = 1))
inspect(itemsets)


# ex15.9 - association rule mining

# association rules
rules <- ruleInduction(seqs, confidence = 0.5)
inspect(rules)

# association rules for frequent maximal sequences
# it may throw a warning
max_rules <- ruleInduction(max_seqs, trans, confidence = 0.5)
inspect(max_rules)


