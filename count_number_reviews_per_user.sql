/*SELECT yelp_user.user_id, count(*) 
FROM wtest.yelp_user, yelp_review_rm
where yelp_user.user_id=yelp_review_rm.user_id;*/

select T.user_id, count(*) as reviews_count
from (SELECT 
    yelp_user.user_id as user_id, yelp_review_rm.review_id as review_id
FROM
    yelp_user
        INNER JOIN
    yelp_review_rm ON yelp_user.user_id = yelp_review_rm.user_id) as T
group by T.user_id;