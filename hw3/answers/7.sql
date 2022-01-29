select d.designer as designer, a.category as category, a.max as max
from designers as d
join desgame as dg
    on d.des_id = dg.des_id
join gamecat as gc
    on dg.g_id = gc.g_id
join games as g
    on dg.g_id = g.g_id
join categories as c
    on gc.c_id = c.c_id
join
(
	select c.category as category, max(maxplaytime) as max
	from designers as d
	join desgame as dg
	    on d.des_id = dg.des_id
	join gamecat as gc
	    on dg.g_id = gc.g_id
	join games as g
	    on dg.g_id = g.g_id
	join categories as c
	    on gc.c_id = c.c_id
	group by c.category
) as a
    on a.category = c.category
where g.maxplaytime = a.max
group by d.designer, a.category, a.max, concat(d.designer, '!@#$%^&*', a.category)
order by a.category desc, d.designer asc;
