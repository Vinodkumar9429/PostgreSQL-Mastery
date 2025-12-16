-- Phase 1

CREATE TABLE brands (
    id SERIAL PRIMARY KEY,
    name VARCHAR(80) NOT NULL UNIQUE,
    country VARCHAR(50)
);

CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(120),
    sku VARCHAR(50),
    price INT DEFAULT 0
);

ALTER TABLE items ADD COLUMN brand_id INTEGER;

ALTER TABLE items RENAME sku TO products_sku;

ALTER TABLE brands DROP COLUMN country;

ALTER TABLE items RENAME TO catalog;

DROP TABLE IF EXISTS catalog;



--Phase 2 : 

CREATE TABLE analytics (
    id BIGSERIAL PRIMARY KEY,
    hits BIGINT,
    ratio DOUBLE PRECISION,
    meta JSONB,
    collected_at TIMESTAMPTZ DEFAULT NOW()
);


CREATE TABLE sessions2 (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_agent TEXT,
    started_at TIMESTAMP
);

CREATE TYPE env AS ENUM ('DEV', 'STAGE', 'PROD');

CREATE TABLE deploys (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type env
);

CREATE TABLE money_test (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    amount NUMERIC (10, 2)
);

INSERT INTO money_test (amount) 
VALUES
(1000.20),
(10021.50);

CREATE TABLE measure (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    val FLOAT,
    val2 DOUBLE PRECISION
);

INSERT INTO measure (val) VALUES (1000.1112);

INSERT INTO measure (val2) VALUES (1000.12121212);




-- Phase 3 : 

INSERT INTO brands (name) 
VALUES
('DIOR'),
('CHANEL'),
('YSL'),
('HERMES'),
('CARTIER')


INSERT INTO catalog (name, product_sku, price)
VALUES
('something1', 'prod sku1' 10021),
('something2', 'prod sku2' 10022),
('something3', 'prod sku3' 10023),
('something4', 'prod sku4' 10024),
('something5', 'prod sku5' 10025),
('something6', 'prod sku6' 10026),
('something7', 'prod sku7' 10027),
('something8', 'prod sku8' 10028)

SELECT name, price FROM catalog ORDER BY price DESC LIMIT 3;

UPDATE catalog 
SET price = price * 2
WHERE price < 100;


INSERT INTO catalog (name, product_sku, price)
VALUES
('something9', 'prod sku9' 10029),
('something10', 'prod sku10' 100210),
('something11', 'prod sku11' 100211)


DELETE FROM catalog 
WHERE product_sku IS NULL;


-- Phase 4 : 

SELECT * FROM catalog WHERE (price BETWEEN 200 AND 1000) AND name LIKE '%pro%';

SELECT * FROM catalog WHERE name LIKE '_____';

INSERT INTO catalog (name, product_sku, price) VALUES ('something12', 'prod sku12', NULL);

SELECT * FROM catalog WHERE price IS NULL OR price > 500;

SELECT * FROM catalog 
WHERE price > (
    SELECT AVG(price) FROM catalog
);


-- Phase 5 : 

CREATE TABLE members (
    id SERIAL PRIMARY KEY,
    email TEXT NOT NULL,
    org_id INT NOT NULL,
    CONSTRAINT unique_org UNIQUE(email, org_id)
);

ALTER TABLE members ADD CONSTRAINT check_members CHECK (org_id > 0);

ALTER TABLE members ADD COLUMN phone VARCHAR(20);
ALTER TABLE members ALTER COLUMN phone SET NOT NULL;

ALTER TABLE members ADD CONSTRAINT uq_members_phone_org UNIQUE(phone, org_id);

ALTER TABLE members DROP CONSTRAINT uq_members_phone_org;



-- Phase 6 : 
CREATE TABLE favorites (
    user_id INT,
    product_id INt, 
    CONSTRAINT user_pk PRIMARY KEY (user_id, product_id),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

INSERT INTO favorites (user_id, product_id)
VALUES('1', '1'),
VALUES('1', '1')



CREATE TABLE orders_seq (
    id SERIAL PRIMARY KEY,
    name INT
);

INSERT INTO orders_seq (name) 
VALUES
(1),
(2),
(3)

ALTER SEQUENCE order_seq RESTART WITH 1;

-- // ERROR: duplicate key value violates unique constraint



