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
       (5, 4, 1, '2020-10-13'),
       (6, 1, 2, '2020-10-13'),
       (7, 1, 2, '2020-10-14');


select round(count(distinct user_id) * 1.0 / (select count(distinct user_id) from login), 3)
from login
where (user_id, date) in (select user_id, date_add(min(date), interval 1 day) from login group by user_id);


