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


select t1.date, round(count(t2.user_id) * 1.0 / count(t1.user_id), 3) p
from (select user_id, min(date) as date
      from login
      group by user_id) t1
         left join login t2 on t1.user_id = t2.user_id and t2.date = date_add(t1.date, interval 1 day)
group by t1.date
union
select date, 0.000 as p
from login
where date not in (select min(date) from login group by user_id)
order by date;

