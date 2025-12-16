DROP TABLE IF EXISTS users;

DROP TABLE IF EXISTS wallet;

DROP TABLE IF EXISTS transactions;

CREATE TABLE users (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE wallet (
    user_id INT,
    balance NUMERIC(14,2) CHECK (balance >= 0),
    CONSTRAINT fkey_wallet_userid FOREIGN KEY (user_id) REFERENCES users(id)
);


CREATE TYPE txn_status AS ENUM ('PENDING', 'SUCCESS', 'FAILED');

CREATE TABLE transactions (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    amount INT CHECK (amount > 0),
    status txn_status,
    created_at TIMESTAMPTZ DEFAULT NOW()
);




INSERT INTO users (name) VALUES ('Vinod'), ('Pratap'), ('Dean Ambrose'), ('Miz');

INSERT INTO wallet (user_id, balance) VALUES (1, 1000), (2, 2000), (3, 3000), (4, 400);




BEGIN;

SELECT balance FROM wallet WHERE user_id = 1 FOR UPDATE;

SELECT balance FROM wallet WHERE user_id = 3 FOR UPDATE;

INSERT INTO transactions(sender_id, receiver_id, amount, status) VALUES (1, 3, 750, 'PENDING');

UPDATE wallet SET balance = balance - 750 WHERE user_id = 1;

UPDATE wallet SET balance = balance + 750 WHERE user_id = 3;

UPDATE transactions SET status = 'SUCCESS' WHERE id = currval('transactions_id_seq'::regclass);

COMMIT;



SELECT balance FROM wallet WHERE user_id = 1;
SELECT balance FROM wallet WHERE user_id = 3;













DROP TABLE IF EXISTS products;

DROP TABLE IF EXISTS orders;

DROP TABLE IF EXISTS users;


CREATE TABLE products (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL,
    stock INT NOT NULL CHECK (stock >= 0)
);



CREATE TABLE users (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL
);




CREATE TYPE order_status AS ENUM ('Processing', 'Placed', 'Rejected', 'Delivered');
CREATE TABLE orders (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INT,
    product_id INT,
    quantity INT NOT NULL,
    status order_status,
    CONSTRAINT fkey_user_orders FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fkey_product_orders FOREIGN KEY (product_id) REFERENCES products(id)
);




INSERT INTO users (name) VALUES ('Vinod'), ('Nani'), ('Anurag');

INSERT INTO products (name, stock) VALUES ('Iphone12', 100), ('DELL Alienware', 10),('D&G THE ONE', 8), ('White Pullover Men', 400);


BEGIN;

SELECT stock FROM products WHERE id = 1 FOR UPDATE;

INSERT INTO orders (user_id, product_id, quantity, status) 
VALUES 
(1, 1, 1, 'Processing');


UPDATE products SET stock = stock - 1 WHERE id = 1;

UPDATE orders SET status = 'Placed' WHERE id = 1;

COMMIT;

SELECT stock FROM products WHERE id = 1;



























CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    user_id INT,
    event_type TEXT,
    created_at TIMESTAMPTZ,
    metadata JSONB
);




CREATE INDEX idx_events_userid ON events(user_id);

CREATE INDEX idx_events_userid_created ON events(user_id, created_at DESC);

CREATE INDEX idx_event_event_type ON events(event_type, created_at) WHERE event_type = 'LOGIN' AND created_at > NOW() - INTERVAL '7 days';



CREATE INDEX idx_event_q5 ON events(user_id, event_type, created_at DESC);






































DROP TABLE IF EXISTS orderss;
CREATE TYPE order_type AS ENUM ('PENDING', 'SUCCESSFUL', 'FAILED');

CREATE TABLE orderss (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INT NOT NULL,
    amount NUMERIC (10,2) NOT NULL,
    status order_type,
    created_at TIMESTAMPTZ DEFAULT NOW()
);




INSERT INTO orderss (user_id, amount, status) 
VALUES 
(1, 10000, 'PENDING'),
(2, 13000, 'SUCCESSFUL'),
(3, 3000, 'SUCCESSFUL'),
(4, 30000, 'SUCCESSFUL'),
(5, 310000, 'SUCCESSFUL'),
(5, 200000, 'FAILED');


SELECT SUM(amount) AS daily_revenue FROM orderss;

SELECT SUM(amount), status FROM orderss WHERE status = 'SUCCESSFUL' GROUP BY status;

SELECT user_id FROM orderss WHERE amount > 10000 AND status = 'SUCCESSFUL';

SELECT user_id FROM orderss WHERE amount = (SELECT MAX(amount) FROM orderss) AND status = 'SUCCESSFUL';

SELECT status, AVG(amount) FROM orderss GROUP BY status;

