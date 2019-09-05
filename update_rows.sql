# SELECT * FROM music_sample.prep_paper3;

SET SQL_SAFE_UPDATES = 0;

UPDATE prep_paper3 
SET 
    SI = 0,
    SI_2 = 0,
    pop = 0,
    SI_pop = 0,
    SI_2_pop = 0
WHERE
    week = 222;
    
SET SQL_SAFE_UPDATES = 1;