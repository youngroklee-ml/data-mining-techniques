# ch13_ex03_pam.R
# ch13.2 K-medoids (13.2.1 PAM: Partitioning Around Medoids)

# ex13.3

# load packages
library(cluster)
library(factoextra)

# read csv file
dat1 <- read.csv("data/ch13_pam.csv")
dat2 <- dat1[, -1]

# PAM
pam_out <- pam(dat2, 2)
pam_out

# freq of each cluster
table(pam_out$clustering)

# visualize
fviz_cluster(pam_out,
             data = dat2,
             ellipse.type = "convex",
             stand = FALSE,
             repel = TRUE
)
