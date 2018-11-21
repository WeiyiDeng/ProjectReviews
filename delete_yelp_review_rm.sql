# SELECT count(distinct user_id) FROM wtest.yelp_user;   # 1326100

# SELECT count(distinct user_id) FROM wtest.yelp_review;

# SELECT * FROM yelp_review
# where yelp_review.user_id not in (select distinct user_id from yelp_user);

# CREATE TABLE yelp_review_rm LIKE yelp_review; 
# INSERT yelp_review_rm SELECT * FROM yelp_review;

SET SQL_SAFE_UPDATES=0;
DELETE FROM yelp_review_rm WHERE yelp_review_rm.user_id not in (select distinct user_id from yelp_user);
SET SQL_SAFE_UPDATES=1;