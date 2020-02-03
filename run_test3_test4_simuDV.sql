DROP TABLE IF EXISTS test3_4_simuDV;
CREATE TABLE test3_4_simuDV

select member, week, sum(cut1*SI) as agg_cut1, sum(cut1*pop) as aggp_cut1
from (SELECT music_sample.test3.*, music_sample.test4_simuDV.*
FROM music_sample.test3, music_sample.test4_simuDV
WHERE ww1 = row2) as A
group by member, week;