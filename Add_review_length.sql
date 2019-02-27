ALTER TABLE wtest.yelp_review_rm_addelite
ADD COLUMN review_length INT(11) AFTER text;

ALTER TABLE wtest.yelp_review_rm_addelite ADD COLUMN newId INTEGER UNIQUE AUTO_INCREMENT;

# SHOW VARIABLES LIKE 'secure_file_priv';
# C:\ProgramData\MySQL\MySQL Server 8.0\Uploads

# select count(*) from temp

# first use Table Data Import Wizard to load a small part of the data and create table variables !!!
LOAD DATA LOCAL INFILE 'E:/Doctoral/ProjectReviews/text_length.csv' INTO TABLE temp
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 7 LINES;

UPDATE wtest.yelp_review_rm_addelite AS s
JOIN temp AS t ON t.Number=s.newId
SET s.review_length=t.x;



