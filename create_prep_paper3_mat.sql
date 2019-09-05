CREATE TABLE prep_paper3_mat

SELECT member, week, sum(SI) as sum_SI, sum(SI_2) as sum_SI_2, sum(pop) as sum_pop, sum(SI_pop) as sum_SI_pop, sum(SI_2_pop) as sum_SI_2_pop 
FROM music_sample.prep_paper3
group by member, week