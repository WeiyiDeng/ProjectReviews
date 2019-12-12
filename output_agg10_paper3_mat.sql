SELECT *
FROM music_sample.test3_4_sum
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/agg10_paper3_mat.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';