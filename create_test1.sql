DROP TABLE IF EXISTS test1;
CREATE TABLE test1 LIKE prep_paper3_fix_move;

ALTER TABLE test1
DROP COLUMN paper1_DV_move1,
ADD COLUMN sth INT FIRST;
#ADD PRIMARY KEY (ww1);

LOAD DATA INFILE 'E:/Doctoral/ProjectReviews/prep_paper3_fix_move_agg10_test.csv' INTO TABLE test1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

ALTER TABLE test1
ADD COLUMN ww1 INT FIRST;

SET SQL_SAFE_UPDATES = 0;

UPDATE test1
SET ww1 = (@rownum := 1 + @rownum)
WHERE 0 = (@rownum:=0);

SET SQL_SAFE_UPDATES = 1;

ALTER TABLE test1 ADD PRIMARY KEY (ww1),
DROP COLUMN sth;