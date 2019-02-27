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

rs = dbSendQuery(mydb, "select T.user_id, count(*) as reviews_count
from (SELECT 
                 yelp_user.user_id as user_id, yelp_review_rm.review_id as review_id
                 FROM
                 yelp_user
                 INNER JOIN
                 yelp_review_rm ON yelp_user.user_id = yelp_review_rm.user_id) as T
                 group by T.user_id")

mydata = fetch(rs, n=-1)

reviews_per_user <- mydata[,2]

hist(reviews_per_user[reviews_per_user<100], breaks = 50)
hist(reviews_per_user[reviews_per_user<100 & reviews_per_user>1], breaks = 50)
length(reviews_per_user[reviews_per_user>1])

rs = dbSendQuery(mydb, "SELECT review_count FROM wtest.yelp_user")

mydata2 = fetch(rs, n=-1)

reviews_per_user_original = as.numeric(mydata2[['review_count']])

hist(reviews_per_user_original[reviews_per_user_original<100], breaks = 50)

hist(reviews_per_user_original[reviews_per_user_original<100 & reviews_per_user_original>1], breaks = 50)
length(reviews_per_user_original[reviews_per_user_original>1])

rs = dbSendQuery(mydb, "select year(yelping_since) as start_year, 
       count(user_id) as users_count
                 from yelp_user
                 group by start_year
                 order by start_year asc")

mydata3 = fetch(rs, n=-1)

ggplot(data=mydata3, aes(x=start_year, y=users_count)) +
  geom_bar(stat="identity", fill = "#999999") +
  ggtitle("users entry per year") + theme(plot.title = element_text(hjust = 0.5))

# on.exit(dbDisconnect(mydb))

mean(reviews_per_user)
mean(reviews_per_user_original)
sum(reviews_per_user)
mean(reviews_per_user[reviews_per_user>1])
hist(reviews_per_user, breaks = 50)
hist(reviews_per_user_original[reviews_per_user_original>100], breaks = 50)
sum(reviews_per_user>=50)
sum(reviews_per_user>100)
length(reviews_per_user)

#######################################################################################################
###------------------------------------each year elites------------------------------------------------
#######################################################################################################
###
year_current_elite_vec <- c()

for (y in 2005:2017){
  year <- y
  year_current <- paste0("year_",year)

  rs = dbSendQuery(mydb, paste0("SELECT count(*) from wtest.yelp_user where IFNULL(",year_current,", 0) =1"))

  mydata_current = fetch(rs, n=-1)
  year_current_elite_vec <- c(year_current_elite_vec, as.numeric(mydata_current))}

year_current_elite_vec
mean(year_current_elite_vec)

###
year_join_elite_vec <- c()

for (y in 2006:2017){
  year <- y
  year_current <- paste0("year_",year)
  year_last <- paste0("year_",year-1)
  
  rs = dbSendQuery(mydb, paste0("SELECT count(*) from wtest.yelp_user 
                                where IFNULL(",year_current,", 0) =1 and IFNULL(",year_last,", 0) =0"))
  
  mydata_join = fetch(rs, n=-1)
  year_join_elite_vec <- c(year_join_elite_vec, as.numeric(mydata_join))}

year_join_elite_vec <- c(0, year_join_elite_vec)
year_join_elite_vec
mean(year_join_elite_vec)

###
year_exit_elite_vec <- c()

for (y in 2005:2016){
  year <- y
  year_current <- paste0("year_",year)
  year_next <- paste0("year_",year+1)
  
  rs = dbSendQuery(mydb, paste0("SELECT count(*) from wtest.yelp_user 
                                where IFNULL(",year_current,", 0) =1 and IFNULL(",year_next,", 0) =0"))
  
  mydata_exit = fetch(rs, n=-1)
  year_exit_elite_vec <- c(year_exit_elite_vec, as.numeric(mydata_exit))}

year_exit_elite_vec <- c(year_exit_elite_vec, 0)
year_exit_elite_vec
mean(year_exit_elite_vec)

###--------------------------------plots--------------------------------------------
# save.image(file='variation_elites.RData')
# load('variation_elites.RData')

df <- data.frame(year=seq(2005, 2017, 1),
                 year_join_elite_vec,
                 year_current_elite_vec,
                 year_exit_elite_vec)
colnames(df) <- c("year", "join", "current", "quit")
df


df.m <- melt(df, id.vars='year')
df.m

colnames(df.m) <- c("year", "elites_status", "count")

ggplot(data=df.m, aes(x=year, y=count, fill=elites_status)) +
  geom_bar(stat="identity", position=position_dodge())

ggplot(data=df, aes(x=year, y=join)) +
  geom_bar(stat="identity", fill = "#FF9999") +
  ggtitle("elite join(N-Y) by year 2005-2017") + theme(plot.title = element_text(hjust = 0.5))

ggplot(data=df, aes(x=year, y=current)) +
  geom_bar(stat="identity", fill = "#009E73") +
  ggtitle("elite existence by year 2005-2017") + theme(plot.title = element_text(hjust = 0.5))

ggplot(data=df, aes(x=year, y=quit)) +
  geom_bar(stat="identity", fill = "#56B4E9") +
  ggtitle("elite quit(Y-N) by year 2005-2017") + theme(plot.title = element_text(hjust = 0.5))

###------------------------------NYY------------------------------------------
year_N_Y_Y_elite_vec <- c()

for (y in 2006:2016){
  year <- y
  year_current <- paste0("year_",year)
  year_last <- paste0("year_",year-1)
  year_next <- paste0("year_",year+1)
  
  rs = dbSendQuery(mydb, paste0("SELECT count(*) from wtest.yelp_user
                                where IFNULL(",year_last,", 0) =0 and IFNULL(",year_current,", 0) =1 and IFNULL(",year_next,", 0) =1"))
  
  mydata_NYY = fetch(rs, n=-1)
  year_N_Y_Y_elite_vec <- c(year_N_Y_Y_elite_vec, as.numeric(mydata_NYY))}

year_N_Y_Y_elite_vec <- c(0, year_N_Y_Y_elite_vec)
year_N_Y_Y_elite_vec <- c(year_N_Y_Y_elite_vec,0)
mean(year_N_Y_Y_elite_vec)

df_NYY <- data.frame(year=seq(2005, 2017, 1),
                 year_N_Y_Y_elite_vec)

ggplot(data=df_NYY, aes(x=year, y=year_N_Y_Y_elite_vec)) +
  geom_bar(stat="identity", fill = "#999999") +
  ggtitle("elite N_Y_Y") + theme(plot.title = element_text(hjust = 0.5))

###------------------------------YNY------------------------------------
year_Y_N_Y_elite_vec <- c()

for (y in 2006:2016){
  year <- y
  year_current <- paste0("year_",year)
  year_last <- paste0("year_",year-1)
  year_next <- paste0("year_",year+1)
  
  rs = dbSendQuery(mydb, paste0("SELECT count(*) from wtest.yelp_user 
                                where IFNULL(",year_last,", 0) =1 and IFNULL(",year_current,", 0) =0 and IFNULL(",year_next,", 0) =1"))
  
  mydata_NYY = fetch(rs, n=-1)
  year_Y_N_Y_elite_vec <- c(year_Y_N_Y_elite_vec, as.numeric(mydata_NYY))}

year_Y_N_Y_elite_vec <- c(0, year_Y_N_Y_elite_vec)
year_Y_N_Y_elite_vec <- c(year_Y_N_Y_elite_vec,0)
year_Y_N_Y_elite_vec
mean(year_Y_N_Y_elite_vec)

df_YNY <- data.frame(year=seq(2005, 2017, 1),
                     year_Y_N_Y_elite_vec)

ggplot(data=df_YNY, aes(x=year, y=year_Y_N_Y_elite_vec)) +
  geom_bar(stat="identity", fill = "#999999") +
  ggtitle("elite Y_N_Y") + theme(plot.title = element_text(hjust = 0.5))

###-----------------------------save-------------------------------------
save.image(file='variation_elites.RData')
# load('variation_elites.RData')
