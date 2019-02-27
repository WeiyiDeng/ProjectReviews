# each year enter
SELECT year(A.date), count(A.review_id) as count_reviews, count(distinct A.user_id) as count_users
FROM (select * from wtest.yelp_review_rm_addelite
where REGEXP_LIKE(elite, DATE_FORMAT(DATE_SUB(date, INTERVAL 1 YEAR), '%Y'))=0 and REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=1) as A
GROUP BY year(A.date)
ORDER BY year(A.date);

# present
SELECT year(A.date), count(A.review_id) as count_reviews, count(distinct A.user_id) as count_users
FROM (select * from wtest.yelp_review_rm_addelite
where REGEXP_LIKE(elite, DATE_FORMAT(DATE_SUB(date, INTERVAL 1 YEAR), '%Y'))=1 and REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=1) as A
GROUP BY year(A.date)
ORDER BY year(A.date);

# quit
SELECT year(A.date), count(A.review_id) as count_reviews, count(distinct A.user_id) as count_users
FROM (select * from wtest.yelp_review_rm_addelite
where REGEXP_LIKE(elite, DATE_FORMAT(DATE_SUB(date, INTERVAL 1 YEAR), '%Y'))=1 and REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=0) as A
GROUP BY year(A.date)
ORDER BY year(A.date);

# non-exist
SELECT year(A.date), count(A.review_id) as count_reviews, count(distinct A.user_id) as count_users
FROM (select * from wtest.yelp_review_rm_addelite
where REGEXP_LIKE(elite, DATE_FORMAT(DATE_SUB(date, INTERVAL 1 YEAR), '%Y'))=0 and REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=0) as A
GROUP BY year(A.date)
ORDER BY year(A.date);

SELECT year(date),user_id, yes_elite_year,count(review_id),elite
FROM wtest.yelp_review_rm_addelite;

# total elites yearly
SELECT year(A.date), count(A.review_id) as count_reviews, count(distinct A.user_id) as count_users
FROM (select * from wtest.yelp_review_rm_addelite
where REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=1) as A
GROUP BY year(A.date)
ORDER BY year(A.date);

# total non-elites yearly
SELECT year(A.date), count(A.review_id) as count_reviews, count(distinct A.user_id) as count_users
FROM (select * from wtest.yelp_review_rm_addelite
where REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=0) as A
GROUP BY year(A.date)
ORDER BY year(A.date);

