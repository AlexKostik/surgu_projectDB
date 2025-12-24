-- Задание 1: Посчитать выручку от начала текущего месяца до сегоняшнего дня (через current_date)
SELECT
    SUM(o.total_price) AS revenue_month
FROM orders o
WHERE date_trunc('month', o.order_date) = date_trunc('month', current_date);

-- Задание 2: Нужно вывести ID заказа, Имя клиента и запчасти
-- (запчасти в виде массива запчастей JSON AGGREGATE, JSON BUILD OBJECT)
SELECT
    o.order_id,
    c.full_name,
    JSON_AGG(JSON_BUILD_OBJECT('part_id', p.part_id, 'part_name', p.part_name, 'part_price', p.part_price)) AS parts
FROM orders o, clients c, order_parts op, parts p
WHERE o.client_id = c.client_id
  AND o.order_id = op.order_id
  AND op.part_id = p.part_id
GROUP BY o.order_id, c.full_name;

-- Задание 3: самый дорогой заказ именно по запчастям (без учёта работ)
SELECT
    o.order_id,
    SUM(op.part_quantity * op.order_part_price) AS parts_total_price
FROM orders o
JOIN order_parts op ON o.order_id = op.order_id
GROUP BY o.order_id
ORDER BY parts_total_price DESC
LIMIT 1;