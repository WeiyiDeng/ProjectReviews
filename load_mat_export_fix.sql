DROP TABLE IF EXISTS mat_export_fix;
CREATE TABLE mat_export_fix LIKE mat_export;

# ALTER TABLE mat_export_fix
# DROP COLUMN dummy_fix;
# ADD COLUMN dummy_fix INT;

LOAD DATA INFILE 'E:/Doctoral/ProjectReviews/mat_export_fix.csv' INTO TABLE music_sample.mat_export_fix
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'

# INSERT INTO mat_export_fix (member, friend, band, week, DV, BL, dummy)  
# SELECT member, friend, band, week, DV, BL, dummy FROM mat_export

#CREATE TABLE dummy_prep_fix LIKE mat_export;
#ALTER TABLE dummy_prep_fix
#ADD COLUMN dummy_fix INT

/*
ALTER TABLE dummy_prep_fix
DROP COLUMN member,
DROP COLUMN friend,
DROP COLUMN band,
DROP COLUMN week,
DROP COLUMN DV,
DROP COLUMN BL,
DROP COLUMN dummy;
*/

/*
LOAD DATA INFILE 'E:/Doctoral/ProjectReviews/dummy_prep_fix.csv' INTO TABLE music_sample.dummy_prep_fix
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
*/

#INSERT INTO mat_export_fix (dummy_fix_prep)  
#SELECT dummy_fix FROM dummy_prep_fix
