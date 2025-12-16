DROP TABLE IF EXISTS orders1;

CREATE TABLE orders1 (
    id SERIAL PRIMARY KEY,
    user_id INT,
    total NUMERIC(10,2)
);

INSERT INTO orders1 (user_id, total) VALUES
(1, 1000),
(1, 500),
(1, 2200),
(2, 3000),
(2, 1500),
(3, 600);



SELECT SUM(total) FROM orders1 WHERE user_id=2;

SELECT AVG(total) FROM orders1;

SELECT MIN(total) FROM orders1;

SELECT MAX(total) FROM orders1;

SELECT COUNT(*) FROM orders1 WHERE total > 1000;

SELECT user_id, SUM(total) AS total_spent 
FROM orders1 
GROUP BY user_id;



CREATE TABLE orders (
  id          INT,
  customer    TEXT,
  city        TEXT,
  amount      INT,
  status      TEXT
);


INSERT INTO orders VALUES
(1, 'Alice', 'NYC', 100, 'completed'),
(2, 'Bob',   'NYC', 50,  'completed'),
(3, 'Alice', 'NYC', 70,  'cancelled'),
(4, 'Alice', 'LA',  200, 'completed'),
(5, 'Bob',   'LA',  30,  'completed'),
(6, 'Bob',   'NYC', 20,  'cancelled'),
(7, 'Cara',  'NYC', 90,  'completed');


SELECT COUNT(*) FROM orders;

SELECT COUNT(*) FROM orders WHERE status = 'completed';

SELECT customer, COUNT(*) FROM orders GROUP BY customer;

SELECT customer, SUM(amount) AS total_amount FROM orders GROUP BY customer;

SELECT customer, city, COUNT(*) AS count FROM orders GROUP BY customer, city;

SELECT city, SUM(amount) AS total_amount FROM orders WHERE status = 'completed' GROUP BY city;

SELECT customer, COUNT(*) AS completed_orders FROM orders WHERE status = 'completed' GROUP BY customer HAVING COUNT(*) > 1;
