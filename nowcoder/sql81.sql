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
       (7, 557336, 'C++', 'completed', 1, '2025-10-25'),
       (8, 557336, 'Python', 'completed', 1, '2025-10-26');


# 请你写出一个sql语句查询在2025-10-15以后，如果有一个用户下单2个以及2个以上状态为购买成功的C++课程或Java课程或Python课程，那么输出这个用户的user_id，
# 以及满足前面条件的第一次购买成功的C++课程或Java课程或Python课程的日期first_buy_date，
# 以及满足前面条件的第二次购买成功的C++课程或Java课程或Python课程的日期second_buy_date，
# 以及购买成功的C++课程或Java课程或Python课程的次数cnt，
# 并且输出结果按照user_id升序排序，

select a.user_id,
       max(case when a.rank_no = 1 then a.date else 0 end) as first_buy_date,
       max(case when a.rank_no = 2 then a.date else 0 end) as second_buy_date,
       a.cnt
from (select user_id,
             date,
             row_number() over (partition by user_id order by date) as rank_no,
             count(*) over (partition by user_id)                   as cnt
      from order_info
      where date >= '2025-10-16'
        and status = 'completed'
        and product_name in ('C++', 'Java', 'Python')) a
where a.rank_no <= 2
  and a.cnt >= 2
group by a.user_id, a.cnt
order by a.user_id;