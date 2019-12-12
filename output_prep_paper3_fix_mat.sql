SELECT *
FROM music_sample.prep_paper3_fix_mat
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/prep_paper3_fix_mat.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';