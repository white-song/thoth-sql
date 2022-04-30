drop table if exists passing_number;
CREATE TABLE `passing_number` (
`id` int(4) NOT NULL,
`number` int(4) NOT NULL,
PRIMARY KEY (`id`));

INSERT INTO passing_number VALUES
(1,4),
(2,3),
(3,3),
(4,2),
(6,4),
(5,5);

select *, dense_rank() over (order by number desc )
from passing_number;