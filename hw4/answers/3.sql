select sum(case when a.sums > 0 then 1 else 0 end) as count
from
(select sum(case when r.business_id is null then 0 else 1 end) as sums
from business as b
left join review as r
on b.business_id = r.business_id
group by b.business_id) as a
