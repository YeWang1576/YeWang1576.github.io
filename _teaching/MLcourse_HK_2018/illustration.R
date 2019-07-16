rm(list=ls())

# double selection
data <- read.csv("~/Dropbox/CurrentProjects/HKElection/WorkingData/Difference.csv")

require(glmnet)

Y <- "delta_antigov_share"
W <- "traveltime"
X <- names(data)[c(18:27)]

outcome <- scale(data[, Y])
treatment <- scale(data[, W])
X.all <- scale(data[, X])


for (i in 1:length(X)){
  for (j in 1:length(X)){
    data[, (i-1) * length(X) + j + 44] <- data[, X[i]] * data[, X[j]]
    names(data)[(i-1) * length(X) + j + 44] <- paste0(X[i], "*", X[j])
  }
}

features <- as.matrix(data[, c(45:144)])
colnames(features) <- names(data)[c(45:144)]

DoubleSelection.Y <- cv.glmnet(features, outcome, alpha = 1, family = "gaussian")
DoubleSelection.W <- cv.glmnet(features, treatment, alpha = 1, family = "gaussian")

lasso.coef.Y <- coef(DoubleSelection.Y)
lasso.coef.W <- coef(DoubleSelection.W)


# causal tree
require(causalTree)
n <- nrow(simulation.1)

trIdx <- which(simulation.1$treatment == 1)
conIdx <- which(simulation.1$treatment == 0)
train_idx <- c(sample(trIdx, length(trIdx) / 2), sample(conIdx, length(conIdx) / 2))
train_data <- simulation.1[train_idx, ]
est_data <- simulation.1[-train_idx, ]

honestTree <- honest.causalTree(y ~ x1 + x2 + x3 + x4, data = train_data,
                                treatment = train_data$treatment, 
                                est_data = est_data, 
                                est_treatment = est_data$treatment, 
                                split.Rule = "CT", split.Honest = T, 
                                HonestSampleSize = nrow(est_data), 
                                split.Bucket = T, cv.option = "CT")

opcp <-  honestTree$cptable[,1][which.min(honestTree$cptable[,4])]
opTree <- prune(honestTree, opcp)

rpart.plot(opTree)