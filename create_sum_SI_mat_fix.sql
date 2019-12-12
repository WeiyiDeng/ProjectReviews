# SELECT * FROM music_sample.mat_export_fix;

CREATE TABLE IF NOT EXISTS music_sample.sum_SI_mat_fix AS
(SELECT member,band, week,DV,BL,sum(dummy) as sum_SI_fix
FROM music_sample.mat_export_fix
group by member,band, week);