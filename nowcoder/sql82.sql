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
       (7, 557336, 'C++', 'completed', 0, '2025-10-25', 'Yes');

INSERT INTO client
VALUES (1, 'PC'),
       (2, 'Android'),
       (3, 'IOS'),
       (4, 'H5');

select a.id, a.is_group_buy, case a.client_id when 0 then null else c.name end
from (select id, is_group_buy, client_id
      from order_info
      where status = 'completed'
        and product_name in ('C++', 'Java', 'Python')
        and date > '2025-10-15'
        and user_id in (select user_id
                        from order_info
                        where status = 'completed'
                          and product_name in ('C++', 'Java', 'Python')
                          and date > '2025-10-15'
                        group by user_id
                        having count(user_id) > 1)
      order by id) a
         left join client c on a.client_id = c.id;



select t.id, t.is_group_buy, c.name as client_name
from (select id,
             is_group_buy,
             client_id,
             count(*) over (partition by user_id) as cnt
      from order_info
      where date > '2025-10-15'
        and product_name in ('C++', 'Python', 'Java')
        and status = 'completed') as t
         left join client as c
                   on c.id = t.client_id
where t.cnt >= 2
order by t.id
