select year(yelping_since) as start_year, 
       count(user_id) as users_count
from yelp_user
group by start_year
order by start_year asc