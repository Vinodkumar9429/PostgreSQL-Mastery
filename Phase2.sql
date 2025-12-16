-- INT is used to determine that the storage is of integer type, You can also use INTEGER, both are same.

-- SERIAL is just INT, but with auto increment.

-- BIGINT is for very large numbers to be stored in. Like, if you have multi-million of rows to have IDs. (from -9 quantillion to 9 quantillion).

CREATE TABLE numbers_test (
    id SERIAL PRIMARY KEY,
    small_number INTEGER,
    big_number BIGINT
);

ALTER TABLE numbers_test DROP COLUMN big_number;

ALTER TABLE numbers_test ADD COLUMN big_number BIGINT;

INSERT INTO
    numbers_test (small_number, big_number)
VALUES (100, 9999999999);

SELECT * FROM numbers_test;




----- VARCHAR VS TEXT -------------

-- VARCHAR and TEXT both are same (are treated similar internally by postgres), No performance difference, We use VARCHAR to enforce characters length and use TEXT where we don't want to enforce any data discipline or limit.

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    title VARCHAR(50),
    content TEXT
);

INSERT INTO posts (title, content) 
VALUES ('Title', 'This is the content page where you can rant whatever you want about your step sister.');

SELECT * FROM posts;

INSERT INTO posts (title, content) 
VALUES ('Title is something that wont be able to fit here, but with much much and alot much more text here than VARCHAR(50) can handle', 'This is the content page where you can rant whatever you want about your step sister.');


-- BOOLEAN --

CREATE TABLE features_test (
    id SERIAL PRIMARY KEY,
    title VARCHAR(50),
    is_enabled BOOLEAN DEFAULT TRUE,
    is_archived BOOLEAN DEFAULT FALSE
);

INSERT INTO features_test (title, is_enabled, is_archived) 
VALUES ('Feature 1', FALSE, TRUE);
INSERT INTO features_test (title) 
VALUES ('Feature 2');
INSERT INTO features_test (title, is_enabled, is_archived) 
VALUES ('Feature 3', DEFAULT, DEFAULT);

SELECT * FROM features_test;



-- DATE --

 -- Date only stores the date. funny but confusing the first time, unlike the js date it doesn't store timezone time etc, so...
 -- It stores date in yy-mm-dd format.
 -- if you insert something in the format, even if the data type is text or something else, postgers auto converts into date.

 CREATE TABLE holidays (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    holiday_date DATE
 );

INSERT INTO holidays (name, holiday_date) 
VALUES ('Bellman Ford', '2025-12-7');
INSERT INTO holidays (name, holiday_date) 
VALUES ('Prims', '2025-12-3');
INSERT INTO holidays (name, holiday_date) 
VALUES ('Krushkal', '2023-12-1');

DELETE FROM holidays 
WHERE id = 3;

ALTER TABLE holidays 
ADD COLUMN is_public BOOLEAN DEFAULT TRUE;

SELECT * FROM holidays;




CREATE TABLE all_datatypes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    price DECIMAL(7,2),
    description TEXT,
    is_in_stock BOOLEAN DEFAULT TRUE,
    in_stock_from DATE,
    last_bought TIMESTAMPTZ,
    testimonials FLOAT,
    ratings_reviews JSONB,
    time TIME
);






CREATE TABLE accounts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username VARCHAR(50),
    bio TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

INSERT INTO accounts (username, bio) 
VALUES('Vinod', 'Hello this is my bio');

INSERT INTO accounts (username, bio) 
VALUES('Pratap', 'hello this is also my bio');

CREATE TABLE transactions (
    id BIGSERIAL PRIMARY KEY,
    account_id UUID DEFAULT gen_random_uuid(),
    amount DECIMAL(10, 2),
    fee NUMERIC(5,2),
    exchange_rate FLOAT,
    metadata JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

INSERT INTO transactions (amount, fee, exchange_rate, metadata)
VALUES (10000, 300, 10.1203, '{"name" : "vinod"}');

INSERT INTO transactions (amount, fee, exchange_rate, metadata) 
VALUES (2000, 10, 13.32432, '{"name":"pratap"}')


CREATE TYPE payment_status AS ENUM ('PENDING', 'PROCESSING', 'PAID', 'FAILED');

CREATE TABLE payments (
    id SERIAL PRIMARY KEY, BIGINT
    amount NUMERIC(10, 2),
    status payment_status,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

INSERT INTO payments (amount, status) 
VALUES(10000, 'PENDING');
INSERT INTO payments (amount, status) 
VALUES(20000, 'PROCESSING');
INSERT INTO payments (amount, status) 
VALUES(23000, 'PAID');
INSERT INTO payments (amount, status) 
VALUES(53000, 'FAILED');



CREATE TABLE products (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT,
    price NUMERIC(10, 2),
    weight FLOAT,
    tags JSONB,
    manufactured_date DATE,
    manufactured_time TIME,
    expires_at TIMESTAMPTZ
);


INSERT INTO products (name, price, weight, tags, manufactured_date, manufactured_time, expires_at) 
VALUES('ANGICAM-BETA', 120, '{"data":"some data"}', '2025-10-11', '10:00:00', '2025-12-30 10:00:00+05:30');

ALTER TABLE products 
ADD COLUMN is_active BOOLEAN DEFAULT TRUE,
ADD COLUMN sku UUID DEFAULT gen_random_uuid(),
RENAME price TO unit_price;

ALTER TABLE products 
DROP COLUMN tags;

DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS products;