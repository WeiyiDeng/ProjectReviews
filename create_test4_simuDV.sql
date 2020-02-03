DROP TABLE IF EXISTS test4_simuDV;

CREATE TABLE test4_simuDV (
    row2 int NOT NULL,
    cut1 int
);

LOAD DATA INFILE 'E:/Doctoral/ProjectReviews/prep_paper3_fix_paper1_DV_cut10_simuKort.csv' INTO TABLE test4_simuDV
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

SET SQL_SAFE_UPDATES = 0;
UPDATE test4_simuDV
SET row2 = (@rownum := 1 + @rownum)
WHERE 0 = (@rownum:=0);
SET SQL_SAFE_UPDATES = 1;

ALTER TABLE test4_simuDV ADD PRIMARY KEY (row2);
ALTER TABLE test4_simuDV ADD FOREIGN KEY (row2) REFERENCES test3(ww1);