select user_id, min(date), count(user_id) as c
from order_info
where status = 'completed'
  and product_name in ('C++', 'Java', 'Python')
  and date > '2025-10-15'
group by user_id
having c > 1
order by user_id;