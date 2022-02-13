select avg(a.stars) as avg
from review as a
join
	(select a.user_id as user_id, b.name as name, count(1) as review_count
	from (select user_id from review where user_id is not null) as a 
	join users as b
	    on a.user_id = b.user_id
	group by a.user_id, b.name
	order by count(1) desc, name asc
	limit 10) as b
    on a.user_id = b.user_id;
