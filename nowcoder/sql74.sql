drop table if exists grade;
drop table if exists language;
CREATE TABLE `grade`
(
    `id`          int(4) NOT NULL,
    `language_id` int(4) NOT NULL,
    `score`       int(4) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `language`
(
    `id`   int(4)      NOT NULL,
    `name` varchar(32) NOT NULL,
    PRIMARY KEY (`id`)
);

INSERT INTO grade
VALUES (1, 1, 12000),
       (2, 1, 13000),
       (3, 2, 11000),
       (4, 2, 10000),
       (5, 3, 11000),
       (6, 1, 11000),
       (7, 2, 11000);

INSERT INTO language
VALUES (1, 'C++'),
       (2, 'JAVA'),
       (3, 'Python');



select g.id, name, score
from (select *, dense_rank() over (partition by language_id order by score desc ) rk from grade) g
         join language l on g.language_id = l.id and g.rk < 3
order by name, score desc, g.id;