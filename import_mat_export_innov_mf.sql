# SELECT count(*) FROM music_sample.mat_export_innov;


LOAD DATA INFILE 'E:/Doctoral/ProjectReviews/mat_export_innov_mf.csv' INTO TABLE music_sample.mat_export_innov_mf
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 4 LINES;


# SELECT dummy*innov_d FROM music_sample.mat_export_innov;

# INSERT INTO `mat_export_innov`(member,friend,band,week,DV,BL,dummy,innov_d) VALUES (2898,6114,52,222,0,0.44149,0,0.00492);

/*
CREATE TABLE IF NOT EXISTS music_sample.sum_SI_innov_mat AS
(SELECT member,band, week,DV,BL,sum(dummy),sum(innov_d),sum(dummy*innov_d) as sum_SI_innov
FROM music_sample.mat_export_innov
group by member,band, week);
*/

# export
/*
SELECT *
FROM music_sample.sum_SI_innov_mat
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dummy_SI_innov_mat.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
*/