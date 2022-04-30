# 创建触发器
create trigger audit_log
    after insert
    on employees_test
    for each row
begin
    insert into audit values (NEW.ID, NEW.NAME);
end;

# 删除emp_no重复的记录，只保留最小的id对应的记录。
drop table if exists titles_test;
CREATE TABLE titles_test
(
    id        int(11)     not null primary key,
    emp_no    int(11)     NOT NULL,
    title     varchar(50) NOT NULL,
    from_date date        NOT NULL,
    to_date   date DEFAULT NULL
);

insert into titles_test
values ('1', '10001', 'Senior Engineer', '1986-06-26', '9999-01-01'),
       ('2', '10002', 'Staff', '1996-08-03', '9999-01-01'),
       ('3', '10003', 'Senior Engineer', '1995-12-03', '9999-01-01'),
       ('4', '10004', 'Senior Engineer', '1995-12-03', '9999-01-01'),
       ('5', '10001', 'Senior Engineer', '1986-06-26', '9999-01-01'),
       ('6', '10002', 'Staff', '1996-08-03', '9999-01-01'),
       ('7', '10003', 'Senior Engineer', '1995-12-03', '9999-01-01');

delete
from titles_test
where id not in (
    select *
    from (
             select min(id)
             from titles_test
             group by emp_no
         ) as t
);
select *
from titles_test;


# 将所有to_date为9999-01-01的全部更新为NULL,且 from_date更新为2001-01-01。
drop table if exists titles_test;
CREATE TABLE titles_test
(
    id        int(11)     not null primary key,
    emp_no    int(11)     NOT NULL,
    title     varchar(50) NOT NULL,
    from_date date        NOT NULL,
    to_date   date DEFAULT NULL
);

insert into titles_test
values ('1', '10001', 'Senior Engineer', '1986-06-26', '9999-01-01'),
       ('2', '10002', 'Staff', '1996-08-03', '9999-01-01'),
       ('3', '10003', 'Senior Engineer', '1995-12-03', '9999-01-01'),
       ('4', '10004', 'Senior Engineer', '1995-12-03', '9999-01-01'),
       ('5', '10001', 'Senior Engineer', '1986-06-26', '9999-01-01'),
       ('6', '10002', 'Staff', '1996-08-03', '9999-01-01'),
       ('7', '10003', 'Senior Engineer', '1995-12-03', '9999-01-01');
update titles_test
set to_date   = null,
    from_date = '2001-01-01'
where to_date = '9999-01-01';
select *
from titles_test;

# 将id=5以及emp_no=10001的行数据替换成id=5以及emp_no=10005,其他数据保持不变，使用replace实现，直接使用update会报错。
drop table if exists titles_test;
CREATE TABLE titles_test
(
    id        int(11)     not null primary key,
    emp_no    int(11)     NOT NULL,
    title     varchar(50) NOT NULL,
    from_date date        NOT NULL,
    to_date   date DEFAULT NULL
);

insert into titles_test
values ('1', '10001', 'Senior Engineer', '1986-06-26', '9999-01-01'),
       ('2', '10002', 'Staff', '1996-08-03', '9999-01-01'),
       ('3', '10003', 'Senior Engineer', '1995-12-03', '9999-01-01'),
       ('4', '10004', 'Senior Engineer', '1995-12-03', '9999-01-01'),
       ('5', '10001', 'Senior Engineer', '1986-06-26', '9999-01-01'),
       ('6', '10002', 'Staff', '1996-08-03', '9999-01-01'),
       ('7', '10003', 'Senior Engineer', '1995-12-03', '9999-01-01');
select *
from titles_test;
update titles_test
set emp_no = replace(emp_no, '10001', '10005')
where id = 5;

# 将titles_test表名修改为titles_2017。
select *
from titles_2017;
alter table titles_test rename to titles_2017;

# 在audit表上创建外键约束，其emp_no对应employees_test表的主键id。
drop table if exists audit;
drop table if exists employees_test;
CREATE TABLE employees_test
(
    ID      INT PRIMARY KEY NOT NULL,
    NAME    TEXT            NOT NULL,
    AGE     INT             NOT NULL,
    ADDRESS CHAR(50),
    SALARY  REAL
);

CREATE TABLE audit
(
    EMP_no      INT      NOT NULL,
    create_date datetime NOT NULL
);

alter table audit
    add constraint foreign key (EMP_no) references employees_test (ID);

# 查找字符串中逗号出现的次数
drop table if exists strings;
CREATE TABLE strings
(
    id     int(5)      NOT NULL PRIMARY KEY,
    string varchar(45) NOT NULL
);
insert into strings
values (1, '10,A,B'),
       (2, 'A,B,C,D'),
       (3, 'A,11,B,C,D,E');

select id, length(string) - length(replace(string, ',', '')) as cut
from strings;

# 获取employees中的first_name
drop table if exists `employees`;
CREATE TABLE `employees`
(
    `emp_no`     int(11)     NOT NULL,
    `birth_date` date        NOT NULL,
    `first_name` varchar(14) NOT NULL,
    `last_name`  varchar(16) NOT NULL,
    `gender`     char(1)     NOT NULL,
    `hire_date`  date        NOT NULL,
    PRIMARY KEY (`emp_no`)
);
INSERT INTO employees
VALUES (10001, '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');
INSERT INTO employees
VALUES (10002, '1964-06-02', 'Bezalel', 'Simmel', 'F', '1985-11-21');
INSERT INTO employees
VALUES (10003, '1959-12-03', 'Parto', 'Bamford', 'M', '1986-08-28');
INSERT INTO employees
VALUES (10004, '1954-05-01', 'Chirstian', 'Koblick', 'M', '1986-12-01');
INSERT INTO employees
VALUES (10005, '1955-01-21', 'Kyoichi', 'Maliniak', 'M', '1989-09-12');
INSERT INTO employees
VALUES (10006, '1953-04-20', 'Anneke', 'Preusig', 'F', '1989-06-02');
INSERT INTO employees
VALUES (10007, '1957-05-23', 'Tzvetan', 'Zielinski', 'F', '1989-02-10');
INSERT INTO employees
VALUES (10008, '1958-02-19', 'Saniya', 'Kalloufi', 'M', '1994-09-15');
INSERT INTO employees
VALUES (10009, '1952-04-19', 'Sumant', 'Peac', 'F', '1985-02-18');
INSERT INTO employees
VALUES (10010, '1963-06-01', 'Duangkaew', 'Piveteau', 'F', '1989-08-24');
INSERT INTO employees
VALUES (10011, '1953-11-07', 'Mary', 'Sluis', 'F', '1990-01-22');

select *
from employees
order by right(first_name, 2);

# 按照dept_no进行汇总
drop table if exists `dept_emp`;
CREATE TABLE `dept_emp`
(
    `emp_no`    int(11) NOT NULL,
    `dept_no`   char(4) NOT NULL,
    `from_date` date    NOT NULL,
    `to_date`   date    NOT NULL,
    PRIMARY KEY (`emp_no`, `dept_no`)
);
INSERT INTO dept_emp
VALUES (10001, 'd001', '1986-06-26', '9999-01-01');
INSERT INTO dept_emp
VALUES (10002, 'd001', '1996-08-03', '9999-01-01');
INSERT INTO dept_emp
VALUES (10003, 'd004', '1995-12-03', '9999-01-01');
INSERT INTO dept_emp
VALUES (10004, 'd004', '1986-12-01', '9999-01-01');
INSERT INTO dept_emp
VALUES (10005, 'd003', '1989-09-12', '9999-01-01');
INSERT INTO dept_emp
VALUES (10006, 'd002', '1990-08-05', '9999-01-01');
INSERT INTO dept_emp
VALUES (10007, 'd005', '1989-02-10', '9999-01-01');
INSERT INTO dept_emp
VALUES (10008, 'd005', '1998-03-11', '2000-07-31');
INSERT INTO dept_emp
VALUES (10009, 'd006', '1985-02-18', '9999-01-01');
INSERT INTO dept_emp
VALUES (10010, 'd005', '1996-11-24', '2000-06-26');
INSERT INTO dept_emp
VALUES (10010, 'd006', '2000-06-26', '9999-01-01');
select dept_no, group_concat(distinct emp_no order by emp_no separator ',')
from dept_emp
group by dept_no;

# 平均工资
drop table if exists  `salaries` ;
CREATE TABLE `salaries` (
`emp_no` int(11) NOT NULL,
`salary` float(11,3) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`from_date`));
INSERT INTO salaries VALUES(10001,85097,'2001-06-22','2002-06-22');
INSERT INTO salaries VALUES(10001,88958,'2002-06-22','9999-01-01');
INSERT INTO salaries VALUES(10002,72527,'2001-08-02','9999-01-01');
INSERT INTO salaries VALUES(10003,43699,'2000-12-01','2001-12-01');
INSERT INTO salaries VALUES(10003,43311,'2001-12-01','9999-01-01');
INSERT INTO salaries VALUES(10004,70698,'2000-11-27','2001-11-27');
INSERT INTO salaries VALUES(10004,74057,'2001-11-27','9999-01-01');

select (sum(salary) - max(salary) - min(salary)) / (count(1) - 2) as avg_salary from salaries where to_date = '9999-01-01';

# 分页查询
drop table if exists  `employees` ;
CREATE TABLE `employees` (
  `emp_no` int(11) NOT NULL,
  `birth_date` date NOT NULL,
  `first_name` varchar(14) NOT NULL,
  `last_name` varchar(16) NOT NULL,
  `gender` char(1) NOT NULL,
  `hire_date` date NOT NULL,
  PRIMARY KEY (`emp_no`));
INSERT INTO employees VALUES(10001,'1953-09-02','Georgi','Facello','M','1986-06-26');
INSERT INTO employees VALUES(10002,'1964-06-02','Bezalel','Simmel','F','1985-11-21');
INSERT INTO employees VALUES(10003,'1959-12-03','Parto','Bamford','M','1986-08-28');
INSERT INTO employees VALUES(10004,'1954-05-01','Chirstian','Koblick','M','1986-12-01');
INSERT INTO employees VALUES(10005,'1955-01-21','Kyoichi','Maliniak','M','1989-09-12');
INSERT INTO employees VALUES(10006,'1953-04-20','Anneke','Preusig','F','1989-06-02');
INSERT INTO employees VALUES(10007,'1957-05-23','Tzvetan','Zielinski','F','1989-02-10');
INSERT INTO employees VALUES(10008,'1958-02-19','Saniya','Kalloufi','M','1994-09-15');
INSERT INTO employees VALUES(10009,'1952-04-19','Sumant','Peac','F','1985-02-18');
INSERT INTO employees VALUES(10010,'1963-06-01','Duangkaew','Piveteau','F','1989-08-24');
INSERT INTO employees VALUES(10011,'1953-11-07','Mary','Sluis','F','1990-01-22');

select * from employees limit 5, 5;

# 使用含有关键字exists查找未分配具体部门的员工的所有信息。
drop table if exists employees;
drop table if exists dept_emp;
CREATE TABLE `employees` (
  `emp_no` int(11) NOT NULL,
  `birth_date` date NOT NULL,
  `first_name` varchar(14) NOT NULL,
  `last_name` varchar(16) NOT NULL,
  `gender` char(1) NOT NULL,
  `hire_date` date NOT NULL,
  PRIMARY KEY (`emp_no`));
CREATE TABLE `dept_emp` (
`emp_no` int(11) NOT NULL,
`dept_no` char(4) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`dept_no`));
INSERT INTO employees VALUES(10001,'1953-09-02','Georgi','Facello','M','1986-06-26');
INSERT INTO employees VALUES(10002,'1964-06-02','Bezalel','Simmel','F','1985-11-21');
INSERT INTO employees VALUES(10003,'1959-12-03','Parto','Bamford','M','1986-08-28');
INSERT INTO employees VALUES(10004,'1954-05-01','Chirstian','Koblick','M','1986-12-01');
INSERT INTO employees VALUES(10005,'1955-01-21','Kyoichi','Maliniak','M','1989-09-12');
INSERT INTO employees VALUES(10006,'1953-04-20','Anneke','Preusig','F','1989-06-02');
INSERT INTO employees VALUES(10007,'1957-05-23','Tzvetan','Zielinski','F','1989-02-10');
INSERT INTO employees VALUES(10008,'1958-02-19','Saniya','Kalloufi','M','1994-09-15');
INSERT INTO employees VALUES(10009,'1952-04-19','Sumant','Peac','F','1985-02-18');
INSERT INTO employees VALUES(10010,'1963-06-01','Duangkaew','Piveteau','F','1989-08-24');
INSERT INTO employees VALUES(10011,'1953-11-07','Mary','Sluis','F','1990-01-22');
INSERT INTO dept_emp VALUES(10001,'d001','1986-06-26','9999-01-01');
INSERT INTO dept_emp VALUES(10002,'d001','1996-08-03','9999-01-01');
INSERT INTO dept_emp VALUES(10003,'d004','1995-12-03','9999-01-01');
INSERT INTO dept_emp VALUES(10004,'d004','1986-12-01','9999-01-01');
INSERT INTO dept_emp VALUES(10005,'d003','1989-09-12','9999-01-01');
INSERT INTO dept_emp VALUES(10006,'d002','1990-08-05','9999-01-01');
INSERT INTO dept_emp VALUES(10007,'d005','1989-02-10','9999-01-01');
INSERT INTO dept_emp VALUES(10008,'d005','1998-03-11','2000-07-31');
INSERT INTO dept_emp VALUES(10009,'d006','1985-02-18','9999-01-01');
INSERT INTO dept_emp VALUES(10010,'d005','1996-11-24','2000-06-26');
INSERT INTO dept_emp VALUES(10010,'d006','2000-06-26','9999-01-01');

select * from employees e where not exists (
    select emp_no from dept_emp as d where d.emp_no = e.emp_no
    ) ;

# 获取有奖金的员工相关信息。
drop table if exists  `employees` ;
drop table if exists  emp_bonus;
drop table if exists  `salaries` ;
CREATE TABLE `employees` (
  `emp_no` int(11) NOT NULL,
  `birth_date` date NOT NULL,
  `first_name` varchar(14) NOT NULL,
  `last_name` varchar(16) NOT NULL,
  `gender` char(1) NOT NULL,
  `hire_date` date NOT NULL,
  PRIMARY KEY (`emp_no`));
 create table emp_bonus(
emp_no int not null,
recevied datetime not null,
btype smallint not null);
CREATE TABLE `salaries` (
`emp_no` int(11) NOT NULL,
`salary` int(11) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`from_date`));
insert into emp_bonus values
(10001, '2010-01-01',1),
(10002, '2010-10-01',2);
INSERT INTO employees VALUES(10001,'1953-09-02','Georgi','Facello','M','1986-06-26');
INSERT INTO employees VALUES(10002,'1964-06-02','Bezalel','Simmel','F','1985-11-21');

INSERT INTO salaries VALUES(10001,60117,'1986-06-26','1987-06-26');
INSERT INTO salaries VALUES(10001,62102,'1987-06-26','1988-06-25');
INSERT INTO salaries VALUES(10001,66074,'1988-06-25','1989-06-25');
INSERT INTO salaries VALUES(10001,66596,'1989-06-25','1990-06-25');
INSERT INTO salaries VALUES(10001,66961,'1990-06-25','1991-06-25');
INSERT INTO salaries VALUES(10001,71046,'1991-06-25','1992-06-24');
INSERT INTO salaries VALUES(10001,74333,'1992-06-24','1993-06-24');
INSERT INTO salaries VALUES(10001,75286,'1993-06-24','1994-06-24');
INSERT INTO salaries VALUES(10001,75994,'1994-06-24','1995-06-24');
INSERT INTO salaries VALUES(10001,76884,'1995-06-24','1996-06-23');
INSERT INTO salaries VALUES(10001,80013,'1996-06-23','1997-06-23');
INSERT INTO salaries VALUES(10001,81025,'1997-06-23','1998-06-23');
INSERT INTO salaries VALUES(10001,81097,'1998-06-23','1999-06-23');
INSERT INTO salaries VALUES(10001,84917,'1999-06-23','2000-06-22');
INSERT INTO salaries VALUES(10001,85112,'2000-06-22','2001-06-22');
INSERT INTO salaries VALUES(10001,85097,'2001-06-22','2002-06-22');
INSERT INTO salaries VALUES(10001,88958,'2002-06-22','9999-01-01');
INSERT INTO salaries VALUES(10002,72527,'1996-08-03','1997-08-03');
INSERT INTO salaries VALUES(10002,72527,'1997-08-03','1998-08-03');
INSERT INTO salaries VALUES(10002,72527,'1998-08-03','1999-08-03');
INSERT INTO salaries VALUES(10002,72527,'1999-08-03','2000-08-02');
INSERT INTO salaries VALUES(10002,72527,'2000-08-02','2001-08-02');
INSERT INTO salaries VALUES(10002,72527,'2001-08-02','9999-01-01');


select e.emp_no,
       e.first_name,
       e.last_name,
       eb.btype,
       s.salary,
       (
           case eb.btype
               when 1 then s.salary * 0.1
               when 2 then s.salary * 0.2
               else s.salary * 0.3
               end
           ) bonus
from employees e
         left outer join salaries s on e.emp_no = s.emp_no and s.to_date = '9999-01-01'
         left outer join emp_bonus eb on e.emp_no = eb.emp_no and eb.btype
order by e.emp_no;
