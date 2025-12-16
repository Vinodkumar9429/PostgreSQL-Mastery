CREATE TABLE perfumes (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    price INT,
    CONSTRAINT price_check CHECK (price > 10)
);

CREATE TABLE reviews (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    review TEXT NOT NULL,
    rating NUMERIC(2, 1) NOT NULL CHECK (
        rating > 0
        AND rating <= 5
    ),
    perfume_id INT NOT NULL,
    CONSTRAINT fkey FOREIGN KEY (perfume_id) REFERENCES perfumes (id)
);

INSERT INTO
    perfumes (name, price)
VALUES ('CREED ROYAL SANTAL', 33000),
    ('PDM LAYTON EXCLUSIF', 30000),
    (
        'TOMFORD NOIR EXTREME PARFUM',
        20000
    );

INSERT INTO
    reviews (review, rating, perfume_id)
VALUES (
        'This is a nice perfume',
        5,
        1
    ),
    (
        'This costs more than my monthly salary',
        2,
        1
    ),
    (
        'Finally seduced my roommate 💋, Oh wait, its a boy tho 💀',
        5,
        3
    ),
    (
        'I thought its a gold bar but got a perfume 😭',
        4,
        3
    );

-- SELECT perfumes.name, reviews.review, reviews.rating, perfumes.price FROM perfumes INNER JOIN reviews ON perfumes.id = reviews.perfume_id;
SELECT perfumes.name, reviews.review, reviews.rating, perfumes.price
FROM perfumes
    LEFT JOIN reviews ON perfumes.id = reviews.perfume_id;

-- Practice set :

CREATE TABLE users (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE orders (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INT,
    total NUMERIC(10, 2),
    CONSTRAINT fkey FOREIGN KEY (user_id) REFERENCES users (id)
);

INSERT INTO
    users (name)
VALUES ('VINOD'),
    ('BROCK'),
    ('HHH'),
    ('BIN FALOR');

INSERT INTO
    orders (user_id, total)
VALUES (1, 1000),
    (1, 300),
    (1, 4000),
    (2, 4000),
    (2, 14000),
    (2, 23000),
    (3, 2000),
    (3, 1999);

SELECT users.id, users.name, orders.user_id, orders.total
FROM users
    INNER JOIN orders ON users.id = orders.user_id;

SELECT users.name, COUNT(orders.user_id),
GROUP BY
    orders.id DESC
FROM users
    LEFT JOIN orders ON users.id = orders.user_id;

CREATE TABLE students (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE courses (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title TEXT NOT NULL
);

CREATE TABLE enrollments (
    id INT GENERATED ALWAYS AS IDENTITY,
    students_id INT,
    courses_id INT,
    CONSTRAINT pkey PRIMARY KEY (students_id, courses_id)
);

INSERT INTO
    students (name)
VALUES ('VINOD'),
    ('Brock'),
    ('Finn balor'),
    ('Neil ARMSTRONG');

INSERT INTO
    courses (title)
VALUES ('Maths'),
    ('Physics'),
    ('Chemistry'),
    ('Computer Science'),
    ('Commerce');

INSERT INTO
    enrollments (students_id, courses_id)
VALUES (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (2, 5),
    (2, 3),
    (2, 2),
    (3, 1),
    (3, 2),
    (3, 3),
    (3, 4);

SELECT students.name, courses.title
FROM
    students
    LEFT JOIN enrollments ON students.id = enrollments.students_id
    LEFT JOIN courses ON courses.id = enrollments.courses_id;




SELECT students.name, courses.title 
FROM
    students
    LEFT JOIN enrollments ON students.id = enrollments.student_id
    LEFT JOIN courses ON students.id = courses.student_id;


