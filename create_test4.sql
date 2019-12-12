DROP TABLE IF EXISTS test4;

CREATE TABLE test4 (
    row2 int NOT NULL,
    cut1 int,
    cut2 int,
    cut3 int,
	cut4 int,
    cut5 int,
    cut6 int,
	cut7 int,
    cut8 int,
    cut9 int,
    cut10 int
);

LOAD DATA INFILE 'E:/Doctoral/ProjectReviews/prep_paper3_fix_paper1_DV_cut10.csv' INTO TABLE test4
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

SET SQL_SAFE_UPDATES = 0;
UPDATE test4
SET row2 = (@rownum := 1 + @rownum)
WHERE 0 = (@rownum:=0);
SET SQL_SAFE_UPDATES = 1;

ALTER TABLE test4 ADD PRIMARY KEY (row2);
ALTER TABLE test4 ADD FOREIGN KEY (row2) REFERENCES test3(ww1);