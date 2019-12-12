DROP TABLE IF EXISTS test3_4_sum;
CREATE TABLE test3_4_sum

SELECT member, week, (agg_cut1+agg_cut2+agg_cut3+agg_cut4+agg_cut5+agg_cut6+agg_cut7+agg_cut8+agg_cut9+agg_cut10) as agg_SI, (aggp_cut1+aggp_cut2+aggp_cut3+aggp_cut4+aggp_cut5+aggp_cut6+aggp_cut7+aggp_cut8+aggp_cut9+aggp_cut10) as agg_pop FROM music_sample.test3_4;