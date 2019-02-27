setwd("E:/Doctoral/ProjectReviews")

golf <- read.csv("golf_data.csv",header = TRUE)                # read into a dataframe

features <- golf[,2:5]

P <- ncol(features)

X <- features

p_store = 1:P
y <- rep(0,nrow(golf))
y[golf['Decision']=='Yes'] <- 1

processed_rows <- 0

# while (processed_rows<=ncol(features)) {

Feature_rows <- matrix(list(), P, 1)
Feature_info <- matrix(list(), P, 1)
Feature_levels <- matrix(list(), P, 1)

Entropy_compare <- rep(0,length(p_store))
for (c in p_store){
# for (c in 4:4){
  temp_vec <- X[[c]]
  levels_store <- levels(temp_vec)
  Expected_entropy <- 0
  for (i in 1:length(levels_store)){
#  for (i in 1:1){
    rows <- which(temp_vec == levels_store[i])
    P1 <- sum(y[rows])/length(rows)
    P2 = 1-P1
    info <- -(P1*log2(P1+1e-300)+P2*log2(P2+1e-300))               # avoid log(0) NAN problem
    Expected_entropy <- Expected_entropy + length(rows)/nrow(golf)*info
    Feature_rows[[c]] <- c(Feature_rows[[c]], list(rows))
    Feature_info[[c]] <- append(Feature_info[[c]], info)
  }
  Entropy_compare[c] <- Expected_entropy
  Feature_levels[[c]] <- levels_store
}
chosen_feature <- which(Entropy_compare==min(Entropy_compare))
colnames(features)[p_store[chosen_feature]]                        # print chosen feature
p_store <- p_store[which(Entropy_compare!=min(Entropy_compare))]

if (sum(Feature_info[[chosen_feature]]==0)>0){
  level_rm <- which(Feature_info[[chosen_feature]]==0)
  rows_rm <- Feature_rows[[chosen_feature]][[level_rm]]
}
processed_rows <- processed_rows + length(rows_rm)
collect_X <- lapply(which(Feature_info[[chosen_feature]]!=0), function(x) Feature_rows[[chosen_feature]][[x]])
X <- lapply(collect_X, function(s) features[s,-chosen_feature])
# }

# hard to store new braches; the algorithm stops at first level

##########################################################################################
###############################   Decision Tree  #########################################
##########################################################################################

library("rpart")
library("rpart.plot")
library("rattle")

#### Weather data
require(rpart)
require(rpart.plot)
golf_play <- read.csv("golf_data.csv",header = TRUE)
fit <- rpart(Decision ~ Outlook + Temp. + Humidity + Wind,method ="class", data =
               golf_play, control = rpart.control(minsplit = 1),parms = list( split ='information'))
rpart.plot(fit, type = 4, extra = 2, clip.right.labs = FALSE, varlen = 0, faclen = 0)
print(fit)
plot(fit)
text(fit, cex = 0.8, use.n = TRUE, xpd = TRUE)

#### Seaflow data
sea <- read.csv("seaflow_21min.csv",header = TRUE)                # read into a dataframe
# sea <- sea[1:200,]
str(sea)
levels(sea$pop)
# model <- rpart(pop ~ fsc_small + fsc_perp + fsc_big + pe + chl_big + chl_small, 
#                method="class", data=sea,control = rpart.control(cp = 0.0001, minsplit = 0, minbucket = 0))
model <- rpart(pop ~ fsc_small + fsc_perp + fsc_big + pe + chl_big + chl_small, 
               method="class", data=sea,control = rpart.control(cp = 0.01))
print(model)
rpart.plot(model)
fancyRpartPlot(model)
prp(model)
plot(model)
text(model, cex = 0.8, use.n = TRUE, xpd = TRUE)
predict_try <- predict(model, data = sea, type = c("class"))
sum(predict_try==sea$pop)/length(predict_try)
conf.matrix <- table(sea$pop, predict(model,type="class"))
rownames(conf.matrix) <- paste("Actual", rownames(conf.matrix), sep = ":")
colnames(conf.matrix) <- paste("Pred", colnames(conf.matrix), sep = ":")
print(conf.matrix)


#### Titanic data
data(ptitanic)
str(ptitanic)
tree <- rpart(survived ~ ., data = ptitanic, control = rpart.control(cp = 0.0001))
printcp(tree)
bestcp <- tree$cptable[which.min(tree$cptable[,"xerror"]),"CP"]
tree.pruned <- prune(tree, cp = bestcp)
plot(tree.pruned)
text(tree.pruned, cex = 0.8, use.n = TRUE, xpd = TRUE)
prp(tree.pruned, faclen = 0, cex = 0.8, extra = 1)

conf.matrix <- table(ptitanic$survived, predict(tree.pruned,type="class"))
rownames(conf.matrix) <- paste("Actual", rownames(conf.matrix), sep = ":")
colnames(conf.matrix) <- paste("Pred", colnames(conf.matrix), sep = ":")
print(conf.matrix)

##########################################################################################
################################### Random Forest ########################################
##########################################################################################

library(randomForest)
forest <- randomForest(pop ~ fsc_small + fsc_perp + fsc_big + pe + chl_big + chl_small, data=sea)
print(forest)
predict_forest <- predict(forest, data = sea, type = c("class"))
sum(predict_forest==sea$pop)/length(predict_forest)

importance(forest)

##########################################################################################
#####################################   SVM   ############################################
##########################################################################################

library(e1071)
mysvm <- svm(pop ~ fsc_small + fsc_perp + fsc_big + pe + chl_big + chl_small, data=sea)
print(mysvm)
predict_svm <- predict(mysvm, data = sea, type = c("class"))
sum(predict_svm==sea$pop)/length(predict_svm)

##########################################################################################
##################### Split the data into test and training sets #########################
##########################################################################################

set.seed(181102)
idx <- sample(seq(1, 3), size = nrow(sea), replace = TRUE, prob = c(0.7, 0.15, 0.15))
train <- sea[idx == 1,]
test <- sea[idx == 2,]
cross_valid <- sea[idx == 3,]

