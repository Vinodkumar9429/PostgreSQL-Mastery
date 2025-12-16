CREATE TABLE users (
    id INT ,
    name TEXT ,
    email TEXT ,
    is_active BOOLEAN,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE posts (
    id UUID DEFAULT gen_random_uuid(),
    title TEXT,
    content TEXT,
    published BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE users ADD COLUMN age INT;

ALTER TABLE users RENAME COLUMN name TO full_name;

ALTER TABLE posts DROP COLUMN content;
ALTER TABLE posts RENAME TO articles;



--Phase 2: 

CREATE TABLE products (
    id INT,
    name VARCHAR(40),
    price NUMERIC(10,2),
    in_stock BOOLEAN
);

CREATE TABLE events (
    id UUID DEFAULT gen_random_uuid(),
    event_name TEXT,
    starts_at TIMESTAMPTZ
);

CREATE TABLE payments (
    id BIGINT,
    amount DECIMAL(10, 2),
    metadata JSONB
);

CREATE TYPE user_role AS ENUM ('ADMIN', 'USER', 'MODERATOR');

ALTER TABLE users ADD COLUMN role user_role;


-- Phase 3 :

INSERT INTO users (id, name, email, age, created_at) 
VALUES(12123, 'VINOD', 'email@gmail.com', 22, '2025-12-15T10:00:00+05:30');

INSERT INTO users (name, email) VALUES ('Lesnar', 'beth@2121gmail.com');

INSERT INTO users (id, name, email, age, created_at) 
VALUES
(231, 'Reigns', 'leethe@gmail.com', 42, '2025-12-12T10:00:12-10:00'),
(232, 'Bobby Lashley', 'lanathe@gmail.com', 44, '2025-11-12T10:00:12-10:00'),
(233, 'Undertaker', 'cenathe@gmail.com', 55, '2023-11-12T4:00:12-10:00');


SELECT * FROM users;

SELECT name, email FROM users ORDER BY created_at DESC LIMIT 5;

UPDATE users 
SET age = 50
WHERE id = 233;

UPDATE users 
set age = CASE 
    WHEN id = 231 THEN 44
    WHEN id = 232 THEN 45
    WHEN id = 233 THEN 60
    ELSE  age
END;

DELETE FROM users
WHERE id = 233;

DELETE FROM users;


--Phase 4 :
SELECT * FROM users WHERE age > 18;

SELECT * FROM users WHERE age > 18 AND age <= 30;

SELECT * FROM users WHERE name LIKE '%vin%';

SELECT * FROM users WHERE age IN (18, 21, 25);

SELECT * FROM users WHERE email IS NOT NULL AND age IS NULL;


--Phase 5 : 
CREATE TABLE users (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    name VARCHAR(40) UNIQUE NOT NULL
);

CREATE TABLE products (
    product_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    price NUMERIC(7,2),
    CONSTRAINT price_check CHECK (price > 0)
);


ALTER TABLE products ADD CONSTRAINT unq_username UNIQUE(username);

ALTER TABLE products DROP CONSTRAINT unq_username;

-- postgres will throw an error

CREATE TABLE users (
    id SERIAL PRIMARY KEY
);

CREATE TABLE orders (
    id INT GENERATED ALWAYS AS IDENTITY,
    -- CONSTRAINT pkey PRIMARY KEY(id)
);

CREATE TABLE sessions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY
);

ALTER TABLE orders ADD CONSTRAINT pkey PRIMARY KEY(id);

-- I would choose UUID over SERIAL if I want an ID user can't predict for better security and later want to merge data to other data and SERIAL when I want normal auto incrementing.







-- Phase 7 : 
CREATE TABLE users (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    age INT,
    CONSTRAINT age_check CHECK(age > 17)
);

CREATE TYPE profile_type AS ENUM ('USER', 'ADMIN', 'SUPERADMIN');
CREATE TABLE profiles (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INT UNIQUE,
    profile_type profile_type,
    CONSTRAINT fkey FOREIGN KEY (user_id) REFERENCES users(id)
);


INSERT INTO users (name, email, age) VALUES ('Vinod', 'email@232gmail.com', 21);

INSERT INTO profile (user_id, profile_type)
VALUES 
(1, 'USER');
-- (1, 'ADMIN') this is not possible because user_id is unique, which strictly enforces one to one relationships.

-- I couldn't do Q5,


CREATE TABLE users (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    age INT,
    CONSTRAINT age_check CHECK(age > 17)
);

CREATE TABLE posts (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    post_id INT,
    post_comment TEXT NOT NULL,
    CONSTRAINT fkey FOREIGN KEY (post_id) REFERENCES users(id)
);

INSERT INTO users (name, email, age) VALUES ('Vinod', 'email@232gmail.com', 21);
INSERT INTO posts (post_id, post_comment)
VALUES 
(1, 'Nice Video'),
(1, 'LAAMO'),
(1, 'Undertake is a nice guy'),
(2, 'If you try to insert into a user that doesnt exist yet, postgre will taunt you with an error');



CREATE TABLE student (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE courses (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    course_name TEXT NOT NULL
);

CREATE TABLE student_courses (
    student_id INT,
    course_id INT,
    CONSTRAINT pkey PRIMARY KEY(student_id, course_id),
    CONSTRAINT fkey1 FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    CONSTRAINT fkey2 FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);


INSERT INTO student (name) VALUES ('Vinod'), ('Lesnar'),('Khabib'),('Cagnus Marlsen');

INSERT INTO courses (course_name) VALUES ('MMA'), ('CHESS'),('Wrestling'),('Coding');

INSERT INTO student_courses (student_id, course_id) 
VALUES 
(1, 1),
(1,2),
(1,3),
(2,1),
(2,4),
(4,1),
(4,3),
(4,4);