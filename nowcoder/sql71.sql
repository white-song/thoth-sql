drop table if exists login;
drop table if exists passing_number;
drop table if exists user;
drop table if exists client;
CREATE TABLE `login`
(
    `id`        int(4) NOT NULL,
    `user_id`   int(4) NOT NULL,
    `client_id` int(4) NOT NULL,
    `date`      date   NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `passing_number`
(
    `id`      int(4) NOT NULL,
    `user_id` int(4) NOT NULL,
    `number`  int(4) NOT NULL,
    `date`    date   NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `user`
(
    `id`   int(4)      NOT NULL,
    `name` varchar(32) NOT NULL,
    PRIMARY KEY (`id`)
);


INSERT INTO login
VALUES (1, 2, 1, '2020-10-12'),
       (2, 3, 2, '2020-10-12'),
       (3, 1, 2, '2020-10-12'),
       (4, 1, 3, '2020-10-13'),
       (5, 3, 2, '2020-10-13');

INSERT INTO passing_number
VALUES (1, 2, 4, '2020-10-12'),
       (2, 3, 1, '2020-10-12'),
       (3, 1, 0, '2020-10-13'),
       (4, 3, 2, '2020-10-13');

INSERT INTO user
VALUES (1, 'tm'),
       (2, 'fh'),
       (3, 'wangchao');


select name, date, ps_num
from user u
         join (select user_id, date, sum(number) over (partition by user_id order by date) ps_num
               from passing_number) t on u.id = t.user_id
order by date, name;