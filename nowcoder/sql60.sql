/**
  按照salary的累计和running_total，其中running_total为前N个当前( to_date = '9999-01-01')员工的salary累计和，其他以此类推。 具体结果如下Demo展示。。
CREATE TABLE `salaries` ( `emp_no` int(11) NOT NULL,
`salary` int(11) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`from_date`));
 */

drop table if exists `salaries`;
CREATE TABLE `salaries`
(
    `emp_no`    int(11) NOT NULL,
    `salary`    int(11) NOT NULL,
    `from_date` date    NOT NULL,
    `to_date`   date    NOT NULL,
    PRIMARY KEY (`emp_no`, `from_date`)
);
INSERT INTO salaries
VALUES (10001, 60117, '1986-06-26', '1987-06-26');
INSERT INTO salaries
VALUES (10001, 62102, '1987-06-26', '1988-06-25');
INSERT INTO salaries
VALUES (10001, 66074, '1988-06-25', '1989-06-25');
INSERT INTO salaries
VALUES (10001, 66596, '1989-06-25', '1990-06-25');
INSERT INTO salaries
VALUES (10001, 66961, '1990-06-25', '1991-06-25');
INSERT INTO salaries
VALUES (10001, 71046, '1991-06-25', '1992-06-24');
INSERT INTO salaries
VALUES (10001, 74333, '1992-06-24', '1993-06-24');
INSERT INTO salaries
VALUES (10001, 75286, '1993-06-24', '1994-06-24');
INSERT INTO salaries
VALUES (10001, 75994, '1994-06-24', '1995-06-24');
INSERT INTO salaries
VALUES (10001, 76884, '1995-06-24', '1996-06-23');
INSERT INTO salaries
VALUES (10001, 80013, '1996-06-23', '1997-06-23');
INSERT INTO salaries
VALUES (10001, 81025, '1997-06-23', '1998-06-23');
INSERT INTO salaries
VALUES (10001, 81097, '1998-06-23', '1999-06-23');
INSERT INTO salaries
VALUES (10001, 84917, '1999-06-23', '2000-06-22');
INSERT INTO salaries
VALUES (10001, 85112, '2000-06-22', '2001-06-22');
INSERT INTO salaries
VALUES (10001, 85097, '2001-06-22', '2002-06-22');
INSERT INTO salaries
VALUES (10001, 88958, '2002-06-22', '9999-01-01');
INSERT INTO salaries
VALUES (10002, 72527, '1996-08-03', '1997-08-03');
INSERT INTO salaries
VALUES (10002, 72527, '1997-08-03', '1998-08-03');
INSERT INTO salaries
VALUES (10002, 72527, '1998-08-03', '1999-08-03');
INSERT INTO salaries
VALUES (10002, 72527, '1999-08-03', '2000-08-02');
INSERT INTO salaries
VALUES (10002, 72527, '2000-08-02', '2001-08-02');
INSERT INTO salaries
VALUES (10002, 72527, '2001-08-02', '9999-01-01');
INSERT INTO salaries
VALUES (10003, 40006, '1995-12-03', '1996-12-02');
INSERT INTO salaries
VALUES (10003, 43616, '1996-12-02', '1997-12-02');
INSERT INTO salaries
VALUES (10003, 43466, '1997-12-02', '1998-12-02');
INSERT INTO salaries
VALUES (10003, 43636, '1998-12-02', '1999-12-02');
INSERT INTO salaries
VALUES (10003, 43478, '1999-12-02', '2000-12-01');
INSERT INTO salaries
VALUES (10003, 43699, '2000-12-01', '2001-12-01');
INSERT INTO salaries
VALUES (10003, 43311, '2001-12-01', '9999-01-01');

select emp_no, salary, sum(salary) over (order by emp_no)
from salaries
where to_date = '9999-01-01'
;