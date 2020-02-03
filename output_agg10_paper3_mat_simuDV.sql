SELECT *
FROM music_sample.test3_4_simuDV
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/agg10_paper3_mat_simuDV.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';