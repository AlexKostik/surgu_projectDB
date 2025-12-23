CREATE TABLE clients (
    client_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    reg_date DATE NOT NULL DEFAULT CURRENT_DATE
);
CREATE TABLE cars (
    car_id SERIAL PRIMARY KEY,
    client_id INT NOT NULL,
    car_brand VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    year INT,
    vin VARCHAR(20) UNIQUE NOT NULL,
    license_plate VARCHAR(15) UNIQUE,

    CONSTRAINT cars_client
        FOREIGN KEY (client_id)
        REFERENCES clients(client_id)
        ON DELETE CASCADE
);
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    position VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    hire_date DATE NOT NULL
);

CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    service_price NUMERIC(10,2) NOT NULL,
    duration_minutes INT
);

CREATE TABLE parts (
    part_id SERIAL PRIMARY KEY,
    part_name VARCHAR(100) NOT NULL,
    part_brand VARCHAR(50),
    part_price NUMERIC(10,2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    car_id INT NOT NULL,
    employee_id INT NOT NULL,
    client_id INT NOT NULL,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(30) NOT NULL,
    total_price NUMERIC(10,2),

    CONSTRAINT orders_car
        FOREIGN KEY (car_id)
        REFERENCES cars(car_id),

    CONSTRAINT orders_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees(emp_id),

    CONSTRAINT orders_client
        FOREIGN KEY (client_id)
        REFERENCES clients(client_id)
);

CREATE TABLE order_services (
    order_services_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    service_id INT NOT NULL,
    service_quantity INT NOT NULL DEFAULT 1,
    service_price NUMERIC(10,2) NOT NULL,

    CONSTRAINT order_services_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT order_services_service
        FOREIGN KEY (service_id)
        REFERENCES services(service_id)
);

CREATE TABLE order_parts (
    order_parts_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    part_id INT NOT NULL,
    part_quantity INT NOT NULL DEFAULT 1,
    order_part_price NUMERIC(10,2) NOT NULL,

    CONSTRAINT order_parts_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT order_parts_part
        FOREIGN KEY (part_id)
        REFERENCES parts(part_id)
);