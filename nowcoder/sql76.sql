drop table if exists grade;
CREATE TABLE grade
(
    `id`    int(4)      NOT NULL,
    `job`   varchar(32) NOT NULL,
    `score` int(10)     NOT NULL,
    PRIMARY KEY (`id`)
);

INSERT INTO grade
VALUES (1, 'C++', 11001),
       (2, 'C++', 10000),
       (3, 'C++', 9000),
       (4, 'Java', 12000),
       (5, 'Java', 13000),
       (6, 'B', 12000),
       (7, 'B', 11000),
       (8, 'B', 9999);


select id, g.job as job, score, rk
from (select id, job, score, row_number() over (partition by job order by score desc ) as rk
      from grade) g
         left join (select job, floor((count(id) + 1) / 2) as m1, ceiling((count(id) + 1) / 2) as m2
                    from grade
                    group by job) m on g.job = m.job
where g.rk between m1 and m2
order by id;
