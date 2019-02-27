/*
# select count(*) from (
SELECT 
    yelp_user.user_id as user_id, yelp_review_rm.review_id as review_id
FROM
    yelp_user
        INNER JOIN
    yelp_review_rm ON yelp_user.user_id = yelp_review_rm.user_id
#    ) as A
*/
CREATE TABLE yelp_review_rm_addElite
AS
(select yelp_user.elite, yelp_review_rm.* 
from yelp_review_rm, yelp_user 
where yelp_user.user_id = yelp_review_rm.user_id);