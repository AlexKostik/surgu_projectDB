TRUNCATE TABLE
    order_parts,
    order_services,
    orders,
    cars,
    parts,
    services,
    employees,
    clients
RESTART IDENTITY
CASCADE;

INSERT INTO clients (full_name, phone, email)
SELECT
    'Клиент ' || i,
    '+7-900-' || LPAD((random()*9999999)::int::text, 7, '0'),
    'client' || i || '@mail.ru'
FROM generate_series(1, 1000) AS s(i);

INSERT INTO employees (full_name, position, phone, hire_date)
SELECT
    'Сотрудник ' || i,
    'Должность ' || (random()*5)::int,
    '+7-901-' || LPAD((random()*9999999)::int::text, 7, '0'),
    CURRENT_DATE - (random()*2000)::int
FROM generate_series(1, 1000) AS s(i);

INSERT INTO services (service_name, service_price, duration_minutes)
SELECT
    'Услуга ' || i,
    (random()*10000 + 500)::numeric(10,2),
    (random()*180 + 15)::int
FROM generate_series(1, 1000) AS s(i);
INSERT INTO parts (part_name, part_brand, part_price, stock_quantity)
SELECT
    'Запчасть ' || i,
    'Бренд ' || (random()*20)::int,
    (random()*20000 + 300)::numeric(10,2),
    (random()*50)::int
FROM generate_series(1, 1000) AS s(i);

INSERT INTO cars (client_id, car_brand, model, year, vin, license_plate)
SELECT
    i,
    'Brand_' || (random()*10)::int,
    'Model_' || (random()*20)::int,
    (1995 + random()*30)::int,
    'VIN' || i,
    'A' || i || 'BC'
FROM generate_series(1, 1000) AS s(i);

INSERT INTO orders (car_id, employee_id, client_id, status, total_price)
SELECT
    i,
    (random()*999 + 1)::int,
    i,
    (ARRAY['Новый','В работе','Завершён','Отменён'])[ (random()*3)::int + 1 ],
    (random()*50000 + 2000)::numeric(10,2)
FROM generate_series(1, 1000) AS s(i);

INSERT INTO order_services (order_id, service_id, service_quantity, service_price)
SELECT
    (random()*999 + 1)::int,
    (random()*999 + 1)::int,
    (random()*3 + 1)::int,
    (random()*10000 + 500)::numeric(10,2)
FROM generate_series(1, 1000);

INSERT INTO order_parts (order_id, part_id, part_quantity, order_part_price)
SELECT
    (random()*999 + 1)::int,
    (random()*999 + 1)::int,
    (random()*5 + 1)::int,
    (random()*20000 + 300)::numeric(10,2)
FROM generate_series(1, 1000);

SELECT 'clients', COUNT(*) FROM clients
UNION ALL
SELECT 'cars', COUNT(*) FROM cars
UNION ALL
SELECT 'employees', COUNT(*) FROM employees
UNION ALL
SELECT 'services', COUNT(*) FROM services
UNION ALL
SELECT 'parts', COUNT(*) FROM parts
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_services', COUNT(*) FROM order_services
UNION ALL
SELECT 'order_parts', COUNT(*) FROM order_parts;