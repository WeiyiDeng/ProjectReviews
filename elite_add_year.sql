ALTER TABLE yelp_user
ADD COLUMN year_2006 INT(10) AFTER `year_2007`;
/*
ALTER TABLE yelp_user
ADD COLUMN year_2007 INT(10) AFTER `elite`;
ALTER TABLE yelp_user
ADD COLUMN year_2008 INT(10) AFTER `elite`;
ALTER TABLE yelp_user
ADD COLUMN year_2009 INT(10) AFTER `elite`;
ALTER TABLE yelp_user
ADD COLUMN year_2010 INT(10) AFTER `elite`;
ALTER TABLE yelp_user
ADD COLUMN year_2011 INT(10) AFTER `elite`;
ALTER TABLE yelp_user
ADD COLUMN year_2012 INT(10) AFTER `elite`;
ALTER TABLE yelp_user
ADD COLUMN year_2013 INT(10) AFTER `elite`;
ALTER TABLE yelp_user
ADD COLUMN year_2014 INT(10) AFTER `elite`;
ALTER TABLE yelp_user
ADD COLUMN year_2015 INT(10) AFTER `elite`;
ALTER TABLE yelp_user
ADD COLUMN year_2016 INT(10) AFTER `elite`;
ALTER TABLE yelp_user
ADD COLUMN year_2017 INT(10) AFTER `elite`;
# ADD COLUMN `log` VARCHAR(12) NOT NULL AFTER `count`,
# ADD COLUMN `status` INT(10) UNSIGNED NOT NULL AFTER `log`;
*/

SET SQL_SAFE_UPDATES=0;
UPDATE yelp_user
SET year_2006 = 1
WHERE REGEXP_LIKE(elite, '2006')=1;
/*
UPDATE yelp_user
SET year_2007 = 1
WHERE REGEXP_LIKE(elite, '2007')=1;
UPDATE yelp_user
SET year_2008 = 1
WHERE REGEXP_LIKE(elite, '2008')=1;
UPDATE yelp_user
SET year_2009 = 1
WHERE REGEXP_LIKE(elite, '2009')=1;
UPDATE yelp_user
SET year_2010 = 1
WHERE REGEXP_LIKE(elite, '2010')=1;
UPDATE yelp_user
SET year_2011 = 1
WHERE REGEXP_LIKE(elite, '2011')=1;
UPDATE yelp_user
SET year_2012 = 1
WHERE REGEXP_LIKE(elite, '2012')=1;
UPDATE yelp_user
SET year_2013 = 1
WHERE REGEXP_LIKE(elite, '2013')=1;
UPDATE yelp_user
SET year_2014 = 1
WHERE REGEXP_LIKE(elite, '2014')=1;
UPDATE yelp_user
SET year_2015 = 1
WHERE REGEXP_LIKE(elite, '2015')=1;
UPDATE yelp_user
SET year_2016 = 1
WHERE REGEXP_LIKE(elite, '2016')=1;
UPDATE yelp_user
SET year_2017 = 1
WHERE REGEXP_LIKE(elite, '2017')=1;
*/