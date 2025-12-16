CREATE TABLE perfumes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price INTEGER
);

CREATE TABLE users(
    id SERIAL PRIMARY KEY, 
    name VARCHAR(100),
    email VARCHAR(100),
    age INTEGER
);

CREATE TABLE orders(
    id SERIAL PRIMARY KEY,
    user_id INTEGER,
    total INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE perfumes 
ADD COLUMN brand VARCHAR(100);

ALTER TABLE perfumes
DROP COLUMN brand;

ALTER TABLE perfumes
ADD COLUMN niche BOOLEAN;

ALTER TABLE perfumes
RENAME COLUMN niche TO is_niche;

ALTER TABLE users 
RENAME TO customers;

ALTER TABLE customers 
ADD COLUMN created_at TIMESTAMPTZ DEFAULT NOW();

ALTER TABLE perfumes
ADD COLUMN is_designer BOOLEAN DEFAULT TRUE;

ALTER TABLE customers 
ADD COLUMN is_active BOOLEAN DEFAULT FALSE;

DROP TABLE IF EXISTS orders;























