 select avg(avgscore) as avg, maxplayers from games group by maxplayers having avg(avgscore) > 6 order by maxplayers ASC;
