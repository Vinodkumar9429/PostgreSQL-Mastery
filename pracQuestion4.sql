--1

DROP TABLE IF EXISTS users;

DROP TABLE IF EXISTS posts;

CREATE TYPE user_role AS ENUM ('ADMIN', 'USER', 'MODERATOR');
CRATE TABLE users (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    age INT NOT NULL CHECK (age > 17),
    is_active BOOLEAN DEFAULT TRUE,
    user_role user_role
);

CREATE TABLE posts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id INT,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE posts2 (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id INT UNIQUE,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);


ALTER TABLE users ADD COLUMN created_at DEFAULT NOW();

ALTER TABLE users RENAME COLUMN name TO blog_posts;

ALTER TABLE users DROP COLUMN is_active;

ALTER TABLE posts RENAME TO blog_posts;

-- DROP TABLE IF EXISTS blog_posts;   // I don't want to drop this for the furthur usage, but for the sake of 'I solved it'.



--2
CREATE TABLE products (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    price NUMERIC(10, 2) NOT NULL,
    metadata JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);


CREATE TABLE sessions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    product_id INT UNIQUE,
    expires_at TIMESTAMPTZ
);



--3 : 

INSERT INTO users (name, email, age) VALUES ('Brock Lenzar', 'bethphenix143@gmail.com', 48);

INSERT INTO users (name, email) VALUES ('Fransvademashi', 'miorlauvage@gmail.com');

INSERT INTO users (name, email, age) 
VALUES 
('Vinod', 'kvinod19201@gmail.com', 21),
('Ramesh', 'ramesh19201@gmail.com', 12),
('banjay', 'banjay19201@gmail.com', 23),
('big show', 'bigshow19201@gmail.com', 31);



SELECT * FROM users;

SELECT name, email FROM users;

SELECT * FROM users ORDER BY age DESC;

SELECT * FROM users LIMIT 5 OFFSET 10;

UPDATE users SET email = 'kvinod911@gmail.com' WHERE id = 3;

UPDATE users SET age = age + 1 WHERE age > 30;

DELETE FROM users WHERE id = 5;

DELETE FROM users WHERE age < 18;

DELETE FROM users;



--4 : 


SELECT * FROM usres WHERE age > 25;

SELECT * FROM users WHERE age BETWEEN 18 AND 30 AND (name IS NOT NULL);

SELECT * FROM users WHERE name ILIKE '%vin%';

SELECT * FROM users WHERE email LIKE '%@gmail.com';

SELECT * FROM users WHERE id IN (1, 3, 7, 10);

SELECT * FROM users WHERE email IS NULL;

SELECT * FROM users WHERE NOT (age > 40);





--5 : 

CREATE TABLE accounts (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL
);

ALTER TABLE accounts ADD CONSTRAINT unq_username UNIQUE (username);


ATLER TABLE products ADD CONSTRAINT price_check CHECK(price > 0);


ALTER TABLE products DROP CONSTRAINT price_check;

-- Postgre throws an error if you try to insert duplicates on a UNIQUE column;


--6 : 

-- I've done done phase 6 indirectly in these previous ones, but here is the difference between SERIAL and IDENTITY, SERIAL is a bit older and not recommended nowaways, IDENTITY is a bit newer and recommended and it is internally used by prisma rn.


-- 7 : 

ALTER TABLE blog_posts ADD CONSTRAINT fkey_users_userid FOREIGN KEY (user_id) REFERENCES users(id);  -- one to many;



ALTER TABLE posts2 ADD CONSTRAINT fkey_users_userid FOREIGN KEY (user_id) REFERENCES users(id); -- one to one;


CREATE TABLE students (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL,
    age INT CHECK (age > 16)
);

CREATE TABLE courses (
    id INT GENERATED ALWAYS AS INDENTITY PRIMARY KEY,
    course_name TEXT NOT NULL
);


CREATE TABLE enrollments (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    CONSTRAINT pkey_student_course PRIMARY KEY(student_id, course_id),
    CONSTRAINT fkey_students_studentid FOREIGN KEY(student_id) REFERENCES students(id) ON DELETE CASCADE,
    CONSTRAINT fkey_courses_courseid FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE SET NULL
);


INSERT INTO students (name, age) VALUES ('Vinod', 21), ('jacquiline', 18), ('Yeshodha', 20);

INSERT INTO courses (course_name) VALUES ('Maths'), ('Physics'), ('Chemistry'), ('Botany'), ('zoology'), ('commerce'), ('Computer science');

INSERT INTO enrollments (student_id, course_id) 
VALUES 
(1,1),
(1,2),
(1,3),
(1,5),
(2,1),
(2,5),
(3,5);



ALTER TABLE enrollments DROP CONSTRAINT fkey_courses_courseid;


-- 8:

CREATE INDEX idx_user_email ON users(email);

CREATE UNIQUE INDEX idx_accounts_username ON accounts(username);

CREATE INDEX idx_first_last ON users(firstname, lastname); -- on a hypothetical table.




--9 : 

BEGIN;

SELECT * FROM users FOR UPDATE;
INSERT INTO users (name, email) VALUES ('something', 'somethingtoo@gmail.com');

INSERT INTO posts (user_id, title, content) 
VALUES (5, 'prisma is hard', 'prisma is hard if you didnt do postgresql before, sorry for clickbait 😅.');


COMMIT;




















-- joins : 

SELECT users.name, posts.title FROM users INNER JOIN posts ON users.id = posts.users_id;

SELECT posts.title, users.name FROM posts INNER JOIN users ON posts.users_id = users.id;

SELECT users.name, orders.totals FROM users INNER JOIN orders ON users.id = orders.user_id;

SELECT users.name, posts.title FROM users INNER JOIN posts ON users.id = posts.user_id WHERE posts.title = 'Hello World';



SELECT users.name, posts.title FROM users LEFT JOIN posts ON users.id = posts.user_id;

SELECT users.name, orders.id AS order_ids FROm users LEFT JOIN orders ON users.id = orders.users_id;

SELECT users.name, COUNT(posts.id) AS no_of_posts FROM users LEFT JOIN posts ON users.id = posts.user_id GROUP BY users.id, users.name;

SELECT users.name, posts.id FROM users LEFT JOIN posts ON users.id = posts.user_id AND posts.user_id IS NULL;

