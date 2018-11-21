# SELECT * FROM wtest.yelp_user_nof LIMIT 968987,1;

# select count(*) from wtest.yelp_user_nof

LOAD DATA LOCAL INFILE 'D:/Downloads/yelp-dataset_csv/yelp_user_nof.csv' INTO TABLE wtest.yelp_user_nof
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 968988 LINES;