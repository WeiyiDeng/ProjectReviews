DROP TABLE IF EXISTS test3_4_sum_simuDV;
CREATE TABLE test3_4_sum_simuDV

SELECT member, week, agg_cut1, aggp_cut1
FROM music_sample.test3_4_simuDV;