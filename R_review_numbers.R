setwd("E:/Doctoral/ProjectReviews")

# library(RMariaDB)
library(RMySQL)
library(ggplot2)
library(reshape2)

db_user <- 'root'
db_password <- 'aptx4869'
db_name <- 'wtest'
db_table <- 'yelp_user'
db_host <- '127.0.0.1' # for local access
db_port <- 3306

mydb <-  dbConnect(MySQL(), user = db_user, password = db_password,
                   dbname = db_name, host = db_host, port = db_port)

# rs = dbSendQuery(mydb, "select count(*) from yelp_user")

rs = dbSendQuery(mydb, "SELECT year(date),count(review_id) 
                 FROM wtest.yelp_review_rm_addelite
                 group by year(date)
                 order by year(date)")

mydata = fetch(rs, n=-1)
colnames(mydata) <- c("year", "number_reviews")
total_reviews_yearly <- mydata

ggplot(data=total_reviews_yearly, aes(x=year, y=number_reviews)) +
  geom_bar(stat="identity") +
  ggtitle("number of reviews by year 2004-2017") + theme(plot.title = element_text(hjust = 0.5))

###
rs = dbSendQuery(mydb, "SELECT year(date),count(review_id)
                 FROM wtest.yelp_review_rm_addelite
                 WHERE yes_elite_year=0
                 group by year(date), yes_elite_year
                 order by year(date)")

mydata = fetch(rs, n=-1)
amount_reviews_non_elite_yearly <- mydata

rs = dbSendQuery(mydb, "SELECT year(date),count(review_id)
                 FROM wtest.yelp_review_rm_addelite
                 WHERE yes_elite_year=1
                 group by year(date), yes_elite_year
                 order by year(date)")

mydata = fetch(rs, n=-1)
amount_reviews_elites_yearly <- mydata

df <- data.frame(year=seq(2004, 2017, 1),
                 c(0,amount_reviews_elites_yearly[,2]),
                 amount_reviews_non_elite_yearly[,2])
colnames(df) <- c("year", "reviews_by_elites", "reviews_by_non_elites")
df


df.m <- melt(df, id.vars='year')
df.m

colnames(df.m) <- c("year", "count_reviews", "count")

ggplot(data=df.m, aes(x=year, y=count, fill=count_reviews)) +
  geom_bar(stat="identity", position=position_dodge())

###
rs = dbSendQuery(mydb, "SELECT year(date),count(distinct user_id)
                 FROM wtest.yelp_review_rm_addelite
                 group by year(date)
                 order by year(date)")

mydata = fetch(rs, n=-1)
total_users_yearly <- mydata

rs = dbSendQuery(mydb, "SELECT year(date),count(distinct user_id)
                 FROM wtest.yelp_review_rm_addelite
                 where yes_elite_year=0
                 group by year(date)
                 order by year(date)")

mydata = fetch(rs, n=-1)
amount_non_elites_yearly <- mydata

rs = dbSendQuery(mydb, "SELECT year(date),count(distinct user_id)
                 FROM wtest.yelp_review_rm_addelite
                 where yes_elite_year=1
                 group by year(date)
                 order by year(date)")

mydata = fetch(rs, n=-1)
amount_elites_yearly <- mydata

df2 <- data.frame(year=seq(2004, 2017, 1),
                 c(0,amount_elites_yearly[,2]),
                 amount_non_elites_yearly[,2])
colnames(df2) <- c("year", "# elites", "# non_elites")
df2


df2.m <- melt(df2, id.vars='year')
df2.m

colnames(df2.m) <- c("year", "count_users", "count")

ggplot(data=df2.m, aes(x=year, y=count, fill=count_users)) +
  geom_bar(stat="identity", position=position_dodge())


####
rs = dbSendQuery(mydb, "SELECT year(A.date), count(A.review_id) as count_reviews, count(distinct A.user_id) as count_users
                 FROM (select * from wtest.yelp_review_rm_addelite
                 where REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=1) as A
                 GROUP BY year(A.date)
                 ORDER BY year(A.date)")

mydata = fetch(rs, n=-1)
total_elites_yearly <- mydata

rs = dbSendQuery(mydb, "SELECT year(A.date), count(A.review_id) as count_reviews, count(distinct A.user_id) as count_users
                 FROM (select * from wtest.yelp_review_rm_addelite
                 where REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=0) as A
                 GROUP BY year(A.date)
                 ORDER BY year(A.date)")

mydata = fetch(rs, n=-1)
total_non_elites_yearly <- mydata

df3 <- data.frame(year=seq(2004, 2017, 1),
                  c(0,total_elites_yearly[,2]/total_elites_yearly[,3]),
                  total_non_elites_yearly[,2]/total_non_elites_yearly[,3])
colnames(df3) <- c("year", "reviews per elites", "reviews per non_elites")
df3


df3.m <- melt(df3, id.vars='year')
df3.m

colnames(df3.m) <- c("year", "avg_number_reviews_per_user", "avg")

ggplot(data=df3.m, aes(x=year, y=avg, fill=avg_number_reviews_per_user)) +
  geom_bar(stat="identity", position=position_dodge())

mean(total_elites_yearly[,2]/total_elites_yearly[,3])
mean(total_non_elites_yearly[,2]/total_non_elites_yearly[,3])

######
# enter
rs = dbSendQuery(mydb, "SELECT year(A.date), count(A.review_id) as count_reviews, count(distinct A.user_id) as count_users
                 FROM (select * from wtest.yelp_review_rm_addelite
                 where REGEXP_LIKE(elite, DATE_FORMAT(DATE_SUB(date, INTERVAL 1 YEAR), '%Y'))=0 and REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=1) as A
                 GROUP BY year(A.date)
                 ORDER BY year(A.date)")

mydata = fetch(rs, n=-1)
enter_reviews_yearly <- mydata

# present
rs = dbSendQuery(mydb, "SELECT year(A.date), count(A.review_id) as count_reviews, count(distinct A.user_id) as count_users
                 FROM (select * from wtest.yelp_review_rm_addelite
                 where REGEXP_LIKE(elite, DATE_FORMAT(DATE_SUB(date, INTERVAL 1 YEAR), '%Y'))=1 and REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=1) as A
                 GROUP BY year(A.date)
                 ORDER BY year(A.date)")

mydata = fetch(rs, n=-1)
present_reviews_yearly <- mydata

# quit
rs = dbSendQuery(mydb, "SELECT year(A.date), count(A.review_id) as count_reviews, count(distinct A.user_id) as count_users
                 FROM (select * from wtest.yelp_review_rm_addelite
                 where REGEXP_LIKE(elite, DATE_FORMAT(DATE_SUB(date, INTERVAL 1 YEAR), '%Y'))=1 and REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=0) as A
                 GROUP BY year(A.date)
                 ORDER BY year(A.date)")

mydata = fetch(rs, n=-1)
quit_reviews_yearly <- mydata

# non_present
rs = dbSendQuery(mydb, "SELECT year(A.date), count(A.review_id) as count_reviews, count(distinct A.user_id) as count_users
                 FROM (select * from wtest.yelp_review_rm_addelite
                 where REGEXP_LIKE(elite, DATE_FORMAT(DATE_SUB(date, INTERVAL 1 YEAR), '%Y'))=0 and REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=0) as A
                 GROUP BY year(A.date)
                 ORDER BY year(A.date)")

mydata = fetch(rs, n=-1)
non_present_reviews_yearly <- mydata

df4 <- data.frame(year=seq(2004, 2017, 1),
                 c(0,enter_reviews_yearly[,2]/enter_reviews_yearly[,3]),
                 c(0,0,present_reviews_yearly[,2]/present_reviews_yearly[,3]),
                 c(0,0,quit_reviews_yearly[,2]/quit_reviews_yearly[,3]),
                 non_present_reviews_yearly[,2]/non_present_reviews_yearly[,3])
colnames(df4) <- c("year", "join", "current", "quit","non_elite")
df4

df4.m <- melt(df4, id.vars='year')
df4.m

colnames(df4.m) <- c("year", "elite_status", "count")

ggplot(data=df4.m, aes(x=year, y=count, fill=elite_status)) +
  geom_bar(stat="identity", position=position_dodge()) + 
  ggtitle("average number of reviews by elite status") + theme(plot.title = element_text(hjust = 0.5))

######################################### review length ######################################################
# enter
rs = dbSendQuery(mydb, "select avg(review_length)
                 from wtest.yelp_review_rm_addelite
                 where REGEXP_LIKE(elite, DATE_FORMAT(DATE_SUB(date, INTERVAL 1 YEAR), '%Y'))=0 and REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=1")

mydata = fetch(rs, n=-1)
enter_avg_reviews_length <- mydata

# present
rs = dbSendQuery(mydb, "select avg(review_length)
                 from wtest.yelp_review_rm_addelite
                 where REGEXP_LIKE(elite, DATE_FORMAT(DATE_SUB(date, INTERVAL 1 YEAR), '%Y'))=1 and REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=1")

mydata = fetch(rs, n=-1)
present_avg_reviews_length <- mydata

# quit
rs = dbSendQuery(mydb, "select avg(review_length)
                 from wtest.yelp_review_rm_addelite
                 where REGEXP_LIKE(elite, DATE_FORMAT(DATE_SUB(date, INTERVAL 1 YEAR), '%Y'))=1 and REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=0
                 ")

mydata = fetch(rs, n=-1)
quit_avg_reviews_length <- mydata

# total avg review length elites
rs = dbSendQuery(mydb, "select avg(review_length)            #,count(review_id),count(distinct user_id)
                 from wtest.yelp_review_rm_addelite
                 where REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=1")

mydata = fetch(rs, n=-1)
total_avg_review_length_elites <- mydata
total_avg_review_length_elites

# total avg review length non_elites
rs = dbSendQuery(mydb, "select avg(review_length)            #,count(review_id),count(distinct user_id)
                 from wtest.yelp_review_rm_addelite
                 where REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=0")

mydata = fetch(rs, n=-1)
total_avg_review_length_non_elites <- mydata
total_avg_review_length_non_elites

df5 <- data.frame(status=c('enter','present','quit','non_elite'),
                  c(enter_avg_reviews_length[[1]], present_avg_reviews_length[[1]], 
                    quit_avg_reviews_length[[1]],total_avg_review_length_non_elites[[1]]))
colnames(df5) <- c("status", "avg_review_length")
df5

ggplot(data=df5, aes(x=status, y=avg_review_length)) +
  geom_bar(stat="identity") +
  ggtitle("average review length by status") + theme(plot.title = element_text(hjust = 0.5))

df6 <- data.frame(status=c('elite','non_elite'),
                  c(total_avg_review_length_elites[[1]], total_avg_review_length_non_elites[[1]]))
colnames(df6) <- c("status", "avg_review_length")
df6

ggplot(data=df6, aes(x=status, y=avg_review_length)) +
  geom_bar(stat="identity",fill = "#56B4E9") +
  ggtitle("average review length by status") + theme(plot.title = element_text(hjust = 0.5))

#  avg_review_length_yearly
rs = dbSendQuery(mydb, "SELECT year(A.date), avg(A.review_length) as text_length
FROM (select * from wtest.yelp_review_rm_addelite) as A
GROUP BY year(A.date)
ORDER BY year(A.date)")

mydata = fetch(rs, n=-1)
avg_review_length_yearly <- mydata
avg_review_length_yearly

#  avg_review_length_elites_yearly
rs = dbSendQuery(mydb, "SELECT year(A.date), avg(A.review_length) as text_length
FROM (select * from wtest.yelp_review_rm_addelite
                 where REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=1) as A
                 GROUP BY year(A.date)
                 ORDER BY year(A.date)")

mydata = fetch(rs, n=-1)
avg_review_length_elites_yearly <- mydata

#  avg_review_length_non_elites_yearly
rs = dbSendQuery(mydb, "SELECT year(A.date), avg(A.review_length) as text_length
FROM (select * from wtest.yelp_review_rm_addelite
                 where REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=0) as A
                 GROUP BY year(A.date)
                 ORDER BY year(A.date)")

mydata = fetch(rs, n=-1)
avg_review_length_non_elites_yearly <- mydata

df7 <- data.frame(year=seq(2004, 2017, 1),
                  c(0,avg_review_length_elites_yearly[,2]),
                  avg_review_length_non_elites_yearly[,2])
colnames(df7) <- c("year", "elite","non_elite")
df7

df7.m <- melt(df7, id.vars='year')
df7.m

colnames(df7.m) <- c("year", "elite_status", "count")

ggplot(data=df7.m, aes(x=year, y=count, fill=elite_status)) +
  geom_bar(stat="identity", position=position_dodge()) + 
  ggtitle("average review length by elite status") + theme(plot.title = element_text(hjust = 0.5))

colnames(avg_review_length_yearly) <- c("year", "text_length")
avg_review_length_yearly

ggplot(data=avg_review_length_yearly, aes(x=year, y=text_length)) +
  geom_bar(stat="identity",fill = "#56B4E9") +
  ggtitle("all users average review length by year") + theme(plot.title = element_text(hjust = 0.5))

save.image(file='review_numbers_length.RData')
# load('review_numbers_length.RData')

##################################################################################
################################# text length ####################################
##################################################################################

# compute text length for each review
rs = dbSendQuery(mydb, "SELECT text FROM wtest.yelp_review_rm_addelite")

mydata = fetch(rs, n=-1)
full_review_text_rm <- mydata$text

text_length <- rep(0,length(full_review_text_rm))
for (t in 1:length(full_review_text_rm)){
  text_length[t] <- sapply(strsplit(full_review_text_rm[t], " "), length)
}

write.csv(file="text_length.csv", x=text_length)

library(tidyverse)
library(tm)

