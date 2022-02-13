with t1 as (
	select a.user_id as user_id, count(1) as review_count
	from (select user_id from review where user_id is not null) as a 
	join users as b
	    on a.user_id = b.user_id
	group by a.user_id
	having count(1) >= 200
),
t2 as (
	select user_id, business_id
	from
		(select a.user_id as user_id, b.business_id as business_id
		from t1 as a
		join review as b
			on a.user_id = b.user_id
		union all
		select a.user_id as user_id, b.business_id as business_id
		from t1 as a
		join tip as b
			on a.user_id = b.user_id) as a
	group by user_id, business_id
)
select a.user_id as user_id1, b.user_id as user_id2, count(1) as similarity
from t2 as a
join t2 as b
	on a.user_id < b.user_id and a.business_id = b.business_id
group by a.user_id, b.user_id
order by count(1) desc
limit 1;

