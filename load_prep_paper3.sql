#SELECT * FROM music_sample.prep_paper3;

LOAD DATA INFILE 'E:/Doctoral/ProjectReviews/prep_paper3.csv' INTO TABLE prep_paper3
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 2 LINES;