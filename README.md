# surgu_projectDB

Проект "surgu_projectDB" — учебный проект по проектированию и реализации реляционной базы данных для СТО (сервис технического обслуживания автомобилей).

Кратко
- Тема: управление записями клиентов, их автомобилей, сотрудников, перечнем услуг и запчастей.
- Цель: создать ER‑схему и реализовать структуру в PostgreSQL (DDL в `SQL/projectDB.sql`).

Содержание репозитория
- `ER/` — файлы с диаграммой ER (Draw.io / PNG).
- `SQL/projectDB.sql` — скрипт создания таблиц, индексов и внешних ключей.
- `README.md` — этот файл с описанием и инструкциями.

Ключевые сущности и назначение таблиц
- `clients` — данные клиентов (ФИО, телефон, e‑mail, дата регистрации).
- `cars` — автомобили клиентов (марка, модель, VIN, госномер), связь с `clients`.
- `employees` — сотрудники сервисной станции (должность, контакт, дата приёма).
- `services` — виды услуг с ценой и ориентировочной продолжительностью.
- `parts` — запчасти на складе с ценой и количеством на складе.
- `orders` — карточки заказов (автомобиль, сотрудник, клиент, статус, итоговая стоимость).
- `order_services`, `order_parts` — состав заказа: какие услуги и какие запчасти были использованы.

Статус и дальнейшая работа
- Текущий статус: прототип (DDL готов, ER‑схема в папке `ER`).
- Рекомендации: добавить миграции, seed‑скрипты, REST API и тесты.

Быстрый старт (локально)
1. Установите PostgreSQL.
2. Создайте базу и импортируйте схему:

```bash
createdb surgu_projectdb
psql -d surgu_projectdb -f SQL/projectDB.sql
```

3. Рекомендуется затем заполнить несколько записей для тестирования (пример ниже).

Пример простого seed‑скрипта (мини‑выдержка)
```sql
INSERT INTO clients (full_name, phone, email) VALUES ('Иванов Иван', '+7 912 0000000', 'ivanov@example.com');
INSERT INTO cars (client_id, car_brand, model, year, vin, license_plate) VALUES (1, 'Toyota', 'Corolla', 2015, 'JTDBU4EE9B9123456', 'A123BC');
INSERT INTO employees (full_name, position, phone, hire_date) VALUES ('Петров Пётр', 'Мастер', '+7 900 1112233', '2023-08-01');
INSERT INTO services (service_name, service_price, duration_minutes) VALUES ('Замена масла', 1200.00, 30);
INSERT INTO parts (part_name, part_brand, part_price, stock_quantity) VALUES ('Масляный фильтр', 'Bosch', 300.00, 10);
```

Примеры запросов для проверки
- Посмотреть таблицы: `\dt` в `psql`.
- Получить историю заказов клиента:
```sql
SELECT o.order_id, o.order_date, o.status, o.total_price
FROM orders o
JOIN clients c ON o.client_id = c.client_id
WHERE c.client_id = 1;
```

Идеи для развития
- Добавить миграции (Flyway/pg_migrate) и полноценный `seed.sql`.
- Реализовать REST API (Node.js / Express или Python / FastAPI) для CRUD операций.
- Внедрить систему учёта складских остатков при создании заказов.

Автор и контакт
- Учебный проект, автор: Костин Александр Константинович (группа 607-52).

Изображение ER‑диаграммы (файл в репозитории):

![ER-diagram](ER/ER-схема%20СТО.png)

