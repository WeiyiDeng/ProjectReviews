# avg review length elites yearly
SELECT year(A.date), avg(A.review_length) as text_length
FROM (select * from wtest.yelp_review_rm_addelite
where REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=1) as A
GROUP BY year(A.date)
ORDER BY year(A.date);

# avg review length non_elites yearly
SELECT year(A.date), avg(A.review_length) as text_length
FROM (select * from wtest.yelp_review_rm_addelite
where REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=0) as A
GROUP BY year(A.date)
ORDER BY year(A.date);

# total avg review length elites
select avg(review_length)            #,count(review_id),count(distinct user_id)
from wtest.yelp_review_rm_addelite
where REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=1;

# total avg review length non_elites
select avg(review_length)            #,count(review_id),count(distinct user_id)
from wtest.yelp_review_rm_addelite
where REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=0;

######################################################################################
# enter
select avg(review_length)            #,count(review_id),count(distinct user_id)
from wtest.yelp_review_rm_addelite
where REGEXP_LIKE(elite, DATE_FORMAT(DATE_SUB(date, INTERVAL 1 YEAR), '%Y'))=0 and REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=1;

# present
select avg(review_length)            #,count(review_id),count(distinct user_id)
from wtest.yelp_review_rm_addelite
where REGEXP_LIKE(elite, DATE_FORMAT(DATE_SUB(date, INTERVAL 1 YEAR), '%Y'))=1 and REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=1;

# quit
select avg(review_length)            #,count(review_id),count(distinct user_id)
from wtest.yelp_review_rm_addelite
where REGEXP_LIKE(elite, DATE_FORMAT(DATE_SUB(date, INTERVAL 1 YEAR), '%Y'))=1 and REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=0;

