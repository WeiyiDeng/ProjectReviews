DROP TABLE IF EXISTS prep_paper3_fix_move_mat;
CREATE TABLE prep_paper3_fix_move_mat

SELECT member, week, sum(SI*paper1_DV_move1) as sum_SI, sum(SI_2) as sum_SI_2, sum(pop*paper1_DV_move1) as sum_pop, sum(SI_pop) as sum_SI_pop, sum(SI_2_pop) as sum_SI_2_pop, sum(paper1_DV_move1-SI-pop) as paper1_NA 
FROM music_sample.prep_paper3_fix_move
group by member, week;

select count(*) from prep_paper3_fix_move_mat
where sum_SI>0