# SELECT * FROM music_sample.mat_export;

/*
CREATE TABLE IF NOT EXISTS music_sample.sum_SI_mat AS
(SELECT member,band, week,DV,BL,sum(dummy) as sum_SI
FROM music_sample.mat_export
group by member,band, week);
*/

# SHOW VARIABLES LIKE 'secure_file_priv';
# 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\'

# export
SELECT *
FROM music_sample.sum_SI_mat
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dummy_SI_mat.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';