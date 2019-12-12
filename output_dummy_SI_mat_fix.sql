# SELECT count(*) FROM music_sample.sum_si_mat_fix;

SELECT *
FROM music_sample.sum_si_mat_fix
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dummy_SI_mat_fix.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';