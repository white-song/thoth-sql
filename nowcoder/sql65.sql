drop table if exists email;
drop table if exists user;
CREATE TABLE `email`
(
    `id`         int(4)      NOT NULL,
    `send_id`    int(4)      NOT NULL,
    `receive_id` int(4)      NOT NULL,
    `type`       varchar(32) NOT NULL,
    `date`       date        NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `user`
(
    `id`           int(4) NOT NULL,
    `is_blacklist` int(4) NOT NULL,
    PRIMARY KEY (`id`)
);

INSERT INTO email
VALUES (1, 2, 3, 'completed', '2020-01-11'),
       (2, 1, 3, 'completed', '2020-01-11'),
       (3, 1, 4, 'no_completed', '2020-01-11'),
       (4, 3, 1, 'completed', '2020-01-12'),
       (5, 3, 4, 'completed', '2020-01-12'),
       (6, 4, 1, 'completed', '2020-01-12');

INSERT INTO user
VALUES (1, 0),
       (2, 1),
       (3, 0),
       (4, 0);


# ----------------

select date, round(sum(case e.type when 'completed' then 0 else 1 end) * 1.0 / count(e.type), 3)
from email e
         join user u1 on (u1.id = e.send_id and u1.is_blacklist = 0)
         join user u2 on (u2.is_blacklist = 0 and u2.id = e.receive_id)
group by date
order by date
