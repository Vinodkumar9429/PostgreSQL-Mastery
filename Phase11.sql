--Transactions 👑😤 Final GOD MODE TOPIC in Databases: 

-- If we want to do multiple operations, and those operators should either collectively fail or be successful, like money transfer, either fail or success, no in between, then we should should use transactions.

-- BASIC SYNTAX :

        -- BEGIN


        -- OPERATIONS (CRUD or whatever you'd like to do)
        -- OPERATIONS (CRUD or whatever you'd like to do)
        -- OPERATIONS (CRUD or whatever you'd like to do)


        -- COMMIT





------------------------- Let's simulate PhonePe money transfer backend : 
    
    
    
    -- And before doing so, we need to understand what race conditions are :
        -- When two operators are performed at the same time, that case is called a race condition. Example, if a user vinod transfers money to brock, and vinod also transfers money again to brock thinking that the money didn't debit, then if he has 400 and he tried to send it twice, then vinod would have -400 which is illegal (not in ethical sense but in terms of software and money), so we need to lock a user's wallet so that other transaction couldn't read it before the first one is completed/fulfilled.

    




DROP TABLE IF EXISTS users;

DROP TABLE IF EXISTS wallet;

DROP TABLE IF EXISTS transactions;

CREATE TABLE users (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name TEXT NOT NULL
);


CREATE TABLE wallet (
    user_id INT PRIMARY KEY,
    balance NUMERIC(16,2) NOT NULL CHECK (balance >= 0),
    CONSTRAINT fkey_user_wallet FOREIGN KEY (user_id) REFERENCES users(id)
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


INSERT INTO users (name) VALUES ('Vinod'), ('Pratap'), ('Lesnar');

INSERT INTO wallet (user_id, balance) 
VALUES 
(1, 1000),
(2, 1000),
(3, 1000);


BEGIN;

SELECT balance FROM wallet WHERE user_id = 1 FOR UPDATE;

SELECT balance FROM wallet WHERE user_id = 2 FOR UPDATE;

INSERT INTO transactions(sender_id, receiver_id, amount, status) 
VALUES (1, 2, 400, 'PENDING');

UPDATE wallet SET balance = balance - 400 WHERE user_id = 1;
UPDATE wallet SET balance = balance + 400 WHERE user_id = 2;

UPDATE transactions SET status = 'SUCCESS' WHERE id = currval('transactions_id_seq'::regclass);

COMMIT;

SELECT balance FROM wallet WHERE user_id = 1;
SELECT balance FROM wallet WHERE user_id = 2;