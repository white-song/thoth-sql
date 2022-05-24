drop table if exists order_info;
drop table if exists client;
CREATE TABLE order_info
(
    id           int(4)       NOT NULL,
    user_id      int(11)      NOT NULL,
    product_name varchar(256) NOT NULL,
    status       varchar(32)  NOT NULL,
    client_id    int(4)       NOT NULL,
    date         date         NOT NULL,
    is_group_buy varchar(32)  NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE client
(
    id   int(4)      NOT NULL,
    name varchar(32) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO order_info
VALUES (1, 557336, 'C++', 'no_completed', 1, '2025-10-10', 'No'),
       (2, 230173543, 'Python', 'completed', 2, '2025-10-12', 'No'),
       (3, 57, 'JS', 'completed', 0, '2025-10-23', 'Yes'),
       (4, 57, 'C++', 'completed', 3, '2025-10-23', 'No'),
       (5, 557336, 'Java', 'completed', 0, '2025-10-23', 'Yes'),
       (6, 57, 'Java', 'completed', 1, '2025-10-24', 'No'),
       (7, 557336, 'C++', 'completed', 0, '2025-10-25', 'Yes'),
       (8, 557336, 'Python', 'completed', 0, '2025-10-26', 'Yes'),
       (9, 1, 'Python', 'completed', 4, '2025-10-25', 'No');



INSERT INTO client
VALUES (1, 'PC'),
       (2, 'Android'),
       (3, 'IOS'),
       (4, 'H5');

# 请你写出一个sql语句查询在2025-10-15以后，同一个用户下单2个以及2个以上状态为购买成功的C++课程或Java课程或Python课程的来源信息，
# 第一列是显示的是客户端名字，如果是拼团订单则显示GroupBuy，
# 第二列显示这个客户端(或者是拼团订单)有多少订单，
# 最后结果按照第一列(source)升序排序，


select tt.source, count(*)
from (select case is_group_buy when 'No' then c.name else 'GroupBuy' end as source, t.cnt
      from (select id,
                   is_group_buy,
                   client_id,
                   count(*) over (partition by user_id) as cnt
            from order_info
            where date > '2025-10-15'
              and product_name in ('C++', 'Python', 'Java')
              and status = 'completed') as t
               left join client as c
                         on c.id = t.client_id) tt
where cnt > 1
group by source
order by source