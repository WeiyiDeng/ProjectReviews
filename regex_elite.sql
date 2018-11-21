# SELECT * FROM wtest.yelp_user;

/*SELECT elite FROM wtest.yelp_user
where elite <> 'None';
*/

SELECT * from wtest.yelp_user
where REGEXP_LIKE(elite, '2017')=1;

# SELECT REGEXP_LIKE('CamelCase', 'CAMELCASE');

# SELECT REGEXP_INSTR('dog cat dog', 'dog');