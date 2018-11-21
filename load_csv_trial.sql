# first use Table Data Import Wizard to load a small part of the data and create table variables !!!

# LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/yelp_user.csv' INTO TABLE wtest.yelp_user;
# https://bugs.mysql.com/bug.php?id=91891
LOAD DATA LOCAL INFILE 'D:/Downloads/yelp-dataset_csv/yelp_user.csv' INTO TABLE wtest.yelp_user
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
