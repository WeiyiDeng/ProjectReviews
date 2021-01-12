SELECT member, count(distinct friend) as num_friends FROM music_sample.mat_export_innov
group by member
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/friend_statistics.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';