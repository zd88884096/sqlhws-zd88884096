with t1 as (
	select a.user_id as user_id
	from (select user_id from review where user_id is not null) as a 
	join users as b
	    on a.user_id = b.user_id
	group by a.user_id
	having count(1) >= 50
),
t2 as (
	select a.user_id as user_id, avg(stars) as avg
	from t1 as a
	join review as b
		on a.user_id = b.user_id
	group by a.user_id
	order by avg(stars) asc
	limit 1
),
t3 as (
select a.user_id as user_id, b.name as user_name, c.business_id as business_id, d.name as business_name, max(c.stars) as star
from t2 as a
join users as b
	on a.user_id = b.user_id
join review as c
	on a.user_id = c.user_id
left join business as d
	on c.business_id = d.business_id
group by a.user_id, b.name, c.business_id, d.name
)
select user_id, user_name, business_id, business_name
from
(
	select *
	from t3 as a
	join
	(
		select max(star) as m
		from t3 
	) as b
	on a.star = b.m
) as a;
