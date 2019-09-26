setwd("E:/Doctoral/ProjectReviews")

require(foreign)
require(ggplot2)
require(MASS)
require(GGally)
require(VGAM)

paper3 <- read.csv("paper3_X.csv",header = FALSE)
paper3_y <- read.csv("paper3_y.csv",header = FALSE)
paper3_lags <- read.csv("paper3_met_lags.csv",header = FALSE)

paper3["DV"] = paper3_y$V1
paper3 <- paper3[-c(1)]
colnames(paper3) <- c("SI","SI_2","pop","SI_pop","SI_2_pop","DV")
colnames(paper3_lags) <- c("SI_lag2","pop_lag2","DV_lag1","DV")

mean(paper3$DV)
sd(paper3$DV)

summary(m1 <- glm.nb(DV ~ .-DV, data = paper3))

# paper3_none0 <- paper3[which(paper3$DV != 0),]
# summary(m1 <- glm.nb(DV ~ .-DV, data = paper3_none0))

m3 <- glm(DV ~ .-DV, family = "poisson", data = paper3)
summary(m3)

pchisq(2 * (logLik(m1) - logLik(m3)), df = 1, lower.tail = FALSE)

## use only SI and popularity
summary(m_nb <- glm.nb(DV ~ SI+pop, data = paper3))

m_poi <- glm(DV ~ SI+pop, family = "poisson", data = paper3)
summary(m_poi)

pchisq(2 * (logLik(m_nb) - logLik(m_poi)), df = 1, lower.tail = FALSE)

## include lags
summary(m_nb <- glm.nb(DV ~ .-DV, data = paper3_lags))
# summary(m_nb <- glm.nb(DV ~ SI_lag2 + pop_lag2, data = paper3_lags))
# summary(m_nb <- glm.nb(DV ~ DV_lag1, data = paper3_lags))

m_poi <- glm(DV ~ .-DV, family = "poisson", data = paper3_lags)
summary(m_poi)
logLik(m_poi)

pchisq(2 * (logLik(m_nb) - logLik(m_poi)), df = 1, lower.tail = FALSE)

summary(m_tobit <- vglm(DV ~ .-DV, tobit(Upper = 800), data = paper3_lags))
# summary(m_tobit <- vglm(DV ~ .-DV-DV_lag1, tobit(Upper = 800), data = paper3_lags))


