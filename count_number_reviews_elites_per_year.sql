/*
SELECT year(date),count(review_id) 
FROM wtest.yelp_review_rm_addelite
group by year(date)
order by year(date);
*/

SELECT year(date),user_id, yes_elite_year,count(review_id),elite
FROM wtest.yelp_review_rm_addelite
group by year(date), user_id;

/*
SELECT year(date),count(review_id)
FROM wtest.yelp_review_rm_addelite
WHERE yes_elite_year=0
group by year(date), yes_elite_year
order by year(date);
*/

/*
SELECT year(date),count(distinct user_id)
FROM wtest.yelp_review_rm_addelite
where yes_elite_year=1
group by year(date)
order by year(date);
*/
