DROP TABLE IF EXISTS test2;
# CREATE TABLE test1 LIKE prep_paper3_fix_move_mat;

CREATE TABLE test2 (
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
    cut10 int,
    PRIMARY KEY (row2),
    FOREIGN KEY (row2) REFERENCES test1(ww1)
);

LOAD DATA INFILE 'E:/Doctoral/ProjectReviews/prep_paper3_fix_paper1_DV_cut10_test.csv' INTO TABLE test2
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';