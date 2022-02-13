select count(1) as count
from business as b
left join review as r
on b.business_id = r.business_id
where r.business_id is null;
