# SELECT * FROM music_sample.mat_export
# where member = 2898 and friend = 6114 and band = 349 and week = 295;

# first use Table Data Import Wizard to load a small part of the data and create table variables !!!
LOAD DATA LOCAL INFILE 'E:/Doctoral/ProjectReviews/mat_export.csv' INTO TABLE music_sample.mat_export
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1926 LINES;