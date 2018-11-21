# SELECT IFNULL(year_2017, 0)+IFNULL(year_2005, 0) FROM wtest.yelp_user;

# SELECT IFNULL(year_2017-1, 1) FROM wtest.yelp_user;

# SELECT * from wtest.yelp_user
# where IFNULL(year_2016, 0) =0 and IFNULL(year_2017, 0)=1;

###
# SELECT count(*) from wtest.yelp_user
# where IFNULL(year_2005, 0) =1;

# SELECT count(*) from wtest.yelp_user
# where IFNULL(year_2005, 0) =1 and IFNULL(year_2006, 0) =0;

SELECT count(*) from wtest.yelp_user
where IFNULL(year_2005, 0) =0 and IFNULL(year_2006, 0) =1;