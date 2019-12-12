select member, week, sum(cut1) as agg_cut1, sum(cut10) as agg_cut10 
from (SELECT music_sample.test1.*, cut1,cut10 
FROM music_sample.test1, music_sample.test2
WHERE ww1 = row2) as A
group by member, week;