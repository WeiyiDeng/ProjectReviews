ALTER TABLE yelp_review_rm_addelite
ADD COLUMN yes_elite_year INT(10) AFTER `date`;

SET SQL_SAFE_UPDATES=0;
UPDATE yelp_review_rm_addelite
SET yes_elite_year = 1
WHERE REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=1;
UPDATE yelp_review_rm_addelite
SET yes_elite_year = 0
WHERE REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=0;

# SELECT * from wtest.yelp_review_rm_addelite
# where REGEXP_LIKE(elite, DATE_FORMAT(date, '%Y'))=1;

# SELECT DATE_FORMAT(date, '%Y') AS your_date
# FROM wtest.yelp_review_rm;