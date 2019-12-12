DROP TABLE IF EXISTS prep_paper3_fix;
CREATE TABLE prep_paper3_fix LIKE prep_paper3;

ALTER TABLE prep_paper3_fix
ADD COLUMN paper1_DV INT;

LOAD DATA INFILE 'E:/Doctoral/ProjectReviews/prep_paper3_fix.csv' INTO TABLE prep_paper3_fix
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';