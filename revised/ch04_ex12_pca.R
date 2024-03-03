# ch04_ex12_pca.R
# ch4.5 principal component - proportion of variance

# ex4.12

# load data
# specify `fileEncoding` argument if needed
dat2 <- read.csv("data/ch4_dat2.csv", fileEncoding = "euc-kr")

# covert data frame to matrix
x <- as.matrix(dat2[, 2:6])

# correlation matrix
round(cor(x), 3)

# principal component analysis
pca_fit <- prcomp(x, center = TRUE, scale. = TRUE)
pca_fit

# eigenvalue of cor(x)
pca_var <- pca_fit$sdev^2
pca_var

# scree plot : to choose the number of components
screeplot(pca_fit, type = "lines", main = "scree plot")

# bar plot of variance proportion explained by each PC
rate_var <- pca_var / sum(pca_var)
rate_var
categories <- c("PC1", "PC2", "PC3", "PC4", "PC5")
barplot(rate_var, names.arg = categories, cex.axis = 1, 
        ylab = "Variance proportion explained by PC", 
        col = "blue", space = 0.5, width = 1, ylim = c(0, 1))
