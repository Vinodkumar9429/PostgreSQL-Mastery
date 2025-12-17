CREATE TABLE customers (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(40) UNIQUE NOT NULL,
    age INT NOT NULL,
    CONSTRAINT age_check CHECK (age > 17)
);

CREATE TABLE orders (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INT NOT NULL,
    order_id BIGINT NOT NULL,
    CONSTRAINT cus_id_fk FOREIGN KEY (user_id) REFERENCES customers(id)
);

INSERT INTO customers (name, age)
VALUES ('Vinod', 21);

INSERT INTO orders (user_id, order_id)
VALUES (1, 12122290);
INSERT INTO orders (user_id, order_id)
VALUES (2, 3121122290); -- ERROR, user with ID 2 doesn't exist so





-- “Foreign keys enforce VALID relationships.
-- The referenced value must exist BEFORE inserting the child row.”




-- ONE TO ONE : 

CREATE TABLE users (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    age INT NOT NULL,
    CONSTRAINT age_check CHECK (age > 17)
);

CREATE TABLE user_settings (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INT UNIQUE,
    theme BOOLEAN DEFAULT TRUE,
    notifications_enabled BOOLEAN DEFAULT FALSE,
    CONSTRAINT user_id_fk FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO users (name, age) VALUES ('Vinod', 21);

INSERT INTO user_settings(user_id, theme, notifications_enabled) 
VALUES (1, FALSE, TRUE);
INSERT INTO user_settings(user_id, theme, notifications_enabled) 
VALUES (1, TRUE, TRUE);




-- ONE TO MANY : 

CREATE TABLE wwe_shows (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    show_name VARCHAR(40) UNIQUE NOT NULL
);

CREATE TABLE on_card_roster (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    wrestler_name VARCHAR(40),
    wrestler_id INT NOT NULL,
    CONSTRAINT wreslter_on_show FOREIGN KEY (wrestler_id) REFERENCES wwe_shows(id)
);


INSERT INTO wwe_shows (show_name)
VALUES
('WrestleMania 42'),
('RoyalRumble 2026'),
('Money In The Bank 2026')

INSERT INTO on_card_roster (wrestler_id, wrestler_name) 
VALUES
(1, 'Shinsuke Nakamura'),
(1, 'Finn Balor'),
(1, 'UnderTaker'),
(1, 'Roman Reigns'),
(1, 'Brock Lesnar'),
(2, 'GoldBerg'),
(2, 'Randy Orton'),
(2, 'Shawn Micheals'),
(3, 'Brawn Strowman'),
(3, 'AJ styles'),
(3, 'Seth Rollins'),
(3, 'Jon Jones');



-- Many To Many : 

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
    student_id INT,
    course_id INT,
    CONSTRAINT pkey_student_course PRIMARY KEY(student_id, course_id),
    CONSTRAINT fkey_students_studentid FOREIGN KEY(student_id) REFERENCES students(id),
    CONSTRAINT fkey_courses_courseid FOREIGN KEY (course_id) REFERENCES courses(id)
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