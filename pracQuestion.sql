CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    birth_year INT,
    country VARCHAR(50)
);

ALTER TABLE authors RENAME country TO nationality;

ALTER TABLE authors ADD COLUMN is_active BOOLEAN DEFAULT TRUE;

ALTER TABLE authors DROP COLUMN birth_year;

ALTER TABLE authors RENAME TO writers;

ALTER TABLE writers ADD COLUMN created_at TIMESTAMPTZ DEFAULT NOW();

DROP TABLE IF EXISTS writers;

--Phase 2 :

CREATE TABLE accounts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    username VARCHAR(50),
    bio TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

INSERT INTO accounts (username) VALUES('VINOD');

ALTER TABLE accounts ADD COLUMN metadata JSONB;

CREATE TYPE payment_status AS ENUM ('PENDING', 'FAILED')

CREATE TABLE payments (
    id BIGSERIAL PRIMARY KEY,
    amount NUMERIC(10, 2),
    fee FLOAT,
    status payment_status,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

INSERT INTO payments (amount, fee, status , created_at) 
VALUES 
(10000, 100.23, 'PENDING'),
(20000, 100.23, 'PAID');

CREATE TABLE products (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title TEXT,
    price NUMERIC(10, 2),
    weight FLOAT,
    expires_at TIMESTAMPTZ
);

ALTER TABLE products ADD COLUMN SKU UUID DEFAULT gen_random_uuid();


-- Phase 3

INSERT INTO products (title, price)
VALUES
('Iphone 12 Pro', 120000),
('DELL AlienWare', 130000),
('JPG ULTRA MALE', 8000),
('BLEU DE CHANEL', 12000),
('Logitech k120', 5000)

SELECT * FROM products ORDER BY price DESC;

SELECT title, price FROM products ORDER BY title ASC;

SELECT * FROM products LIMIT 3;

UPDATE products SET price = 500 WHERE price < 500;

UPDATE products 
SET price = CASE 
    WHEN title LIKE 'A%' THEN 1000
    WHEN title LIKE '%pro%' THEN 2000
    ELSE  price
END;

DELETE FROM products WHERE price > 1500;



-- Phase 4

SELECT * FROM products WHERE price BETWEEN 300 AND 700;

SELECT * FROM products WHERE title ILIKE '%pro%';

SELECT * FROM products WHERE price IN (300, 500, 700);

SELECT * FROM products WHERE expires_at IS NULL;

SELECT * FROM products WHERE (price < 500 OR title LIKE 'A%') AND weight IS NOT NULL;



-- Phase 5 : 

CREATE TABLE users (
    id SERIAL PRIMARY KEY, 
    email TEXT UNIQUE,
    username VARCHAR(50) UNIQUE,
    age INT NOT NULL,
    CONSTRAINT age_check CHECK (age > 17)
);

ALTER TABLE users ADD CONSTRAINT unique_email_user UNIQUE (email, username);

ALTER TABLE users DROP CONSTRAINT unique_email_user;

ALTER TABLE users ALTER COLUMN username SET NOT NULL;



-- Phase 6 : 

CREATE TABLE sessions (
    session_id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id INT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    CONSTRAINT order_item_pK PRIMARY KEY (order_id, product_id)
);

