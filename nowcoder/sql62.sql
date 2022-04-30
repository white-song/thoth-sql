drop table if exists grade;
CREATE TABLE `grade` (
`id` int(4) NOT NULL,
`number` int(4) NOT NULL,
PRIMARY KEY (`id`));

INSERT INTO grade VALUES
(1,111),
(2,333),
(3,111),
(4,111),
(5,333);

select number from grade group by number having count(number) > 2 order by number;