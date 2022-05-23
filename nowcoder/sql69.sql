drop table if exists login;
CREATE TABLE `login`
(
    `id`        int(4) NOT NULL,
    `user_id`   int(4) NOT NULL,
    `client_id` int(4) NOT NULL,
    `date`      date   NOT NULL,
    PRIMARY KEY (`id`)
);

INSERT INTO login
VALUES (1, 2, 1, '2020-10-12'),
       (2, 3, 2, '2020-10-12'),
       (3, 1, 2, '2020-10-12'),
       (4, 2, 2, '2020-10-13'),
       (5, 1, 2, '2020-10-13'),
       (6, 3, 1, '2020-10-14'),
       (7, 4, 1, '2020-10-14'),
       (8, 4, 1, '2020-10-15');

select t1.date, if(t2.c is null, 0, t2.c)
from (select date, count(distinct user_id) from login group by date) t1
         left join (select t.d, count(distinct user_id) c
                    from (select user_id, min(date) d from login group by user_id) t
                    group by t.d) t2 on t1.date = t2.d
order by date;


select date,
       count(case
                 when (user_id, date) in (select user_id, min(date) from login group by user_id) then user_id end) cut
from login
group by date
order by date;
