SELECT * FROM wtest.yelp_review LIMIT 5261674,1;
# select count(*) from wtest.yelp_review;

/*LOAD DATA LOCAL INFILE 'D:/Downloads/yelp-dataset_csv/yelp_review.csv' INTO TABLE yelp_review
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 104226 LINES;
*/