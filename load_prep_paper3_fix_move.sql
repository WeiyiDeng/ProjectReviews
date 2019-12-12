DROP TABLE IF EXISTS prep_paper3_fix_move;
CREATE TABLE prep_paper3_fix_move LIKE prep_paper3;

ALTER TABLE prep_paper3_fix_move
ADD COLUMN paper1_DV_move1 INT;

LOAD DATA INFILE 'E:/Doctoral/ProjectReviews/prep_paper3_fix_move.csv' INTO TABLE prep_paper3_fix_move
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';