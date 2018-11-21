# ALTER TABLE yelp_user MODIFY user_id VARCHAR(200);
# ALTER TABLE yelp_user ADD PRIMARY KEY(user_id);

# ALTER TABLE yelp_review MODIFY review_id VARCHAR(200);
# ALTER TABLE yelp_review ADD PRIMARY KEY(review_id);

# ALTER TABLE yelp_review MODIFY user_id VARCHAR(200);

ALTER TABLE yelp_review_rm
ADD CONSTRAINT FK_user_id FOREIGN KEY (user_id) REFERENCES yelp_user(user_id);
