select g.*
from grade g
         join (select job, round(avg(score), 3) as s
               from grade
               group by job
               order by s desc) t on g.job = t.job and g.score > t.s
order by g.id;