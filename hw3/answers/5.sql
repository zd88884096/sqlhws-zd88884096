select t.category as category, avg(g.avgscore) as avg
from gamecat as c 
join games as g 
    on g.g_id = c.g_id 
join categories as t 
    on t.c_id = c.c_id 
group by t.category
having count(1) >= 15
order by avg(g.avgscore) desc, t.category asc 
limit 5;
