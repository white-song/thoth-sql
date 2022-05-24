drop table if exists order_info;
CREATE TABLE order_info
(
    id           int(4)       NOT NULL,
    user_id      int(11)      NOT NULL,
    product_name varchar(256) NOT NULL,
    status       varchar(32)  NOT NULL,
    client_id    int(4)       NOT NULL,
    date         date         NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO order_info
VALUES (1, 557336, 'C++', 'no_completed', 1, '2025-10-10'),
       (2, 230173543, 'Python', 'completed', 2, '2025-10-12'),
       (3, 57, 'JS', 'completed', 3, '2025-10-23'),
       (4, 57, 'C++', 'completed', 3, '2025-10-23'),
       (5, 557336, 'Java', 'completed', 1, '2025-10-23'),
       (6, 57, 'Java', 'completed', 1, '2025-10-24'),
       (7, 557336, 'C++', 'completed', 1, '2025-10-25');

# 请你写出一个sql语句查询在2025-10-15以后，同一个用户下单2个以及2个以上状态为购买成功的C++课程或Java课程或Python课程的user_id，并且按照user_id升序排序，
select user_id
from order_info
where status = 'completed'
  and product_name in ('C++', 'Java', 'Python')
  and date > '2025-10-15'
group by user_id
having count(user_id) > 1
order by user_id;