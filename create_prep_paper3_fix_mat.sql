DROP TABLE IF EXISTS prep_paper3_fix_mat;
CREATE TABLE prep_paper3_fix_mat

SELECT member, week, sum(SI*paper1_DV) as sum_SI, sum(SI_2) as sum_SI_2, sum(pop*paper1_DV) as sum_pop, sum(SI_pop) as sum_SI_pop, sum(SI_2_pop) as sum_SI_2_pop 
FROM music_sample.prep_paper3_fix
group by member, week;

# select count(*) from prep_paper3_fix_mat
# where sum_SI>0