SELECT count(*) FROM wtest.yelp_user
where REGEXP_LIKE(elite, 'None')=1;