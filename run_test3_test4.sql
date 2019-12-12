DROP TABLE IF EXISTS test3_4;
CREATE TABLE test3_4

select member, week, sum(cut1*SI) as agg_cut1, sum(cut2*SI) as agg_cut2, sum(cut3*SI) as agg_cut3, sum(cut4*SI) as agg_cut4, sum(cut5*SI) as agg_cut5, sum(cut6*SI) as agg_cut6, sum(cut7*SI) as agg_cut7, sum(cut8*SI) as agg_cut8, sum(cut9*SI) as agg_cut9, sum(cut10*SI) as agg_cut10, sum(cut1*pop) as aggp_cut1, sum(cut2*pop) as aggp_cut2, sum(cut3*pop) as aggp_cut3, sum(cut4*pop) as aggp_cut4, sum(cut5*pop) as aggp_cut5, sum(cut6*pop) as aggp_cut6, sum(cut7*pop) as aggp_cut7, sum(cut8*pop) as aggp_cut8, sum(cut9*pop) as aggp_cut9, sum(cut10*pop) as aggp_cut10  
from (SELECT music_sample.test3.*, music_sample.test4.*
FROM music_sample.test3, music_sample.test4
WHERE ww1 = row2) as A
group by member, week;