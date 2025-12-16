DROP TABLE IF EXISTS books;

CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    price INTEGER,
    rating FLOAT,
    year_published INTEGER
);

INSERT INTO books (title, price, rating, year_published) VALUES
('Atomic Habits', 499, 4.7, 2018),
('Deep Work', 350, 4.6, 2016),
('The 48 Laws of Power', 799, 4.4, 1998),
('Ego Is the Enemy', 399, 4.5, 2016),
('The Subtle Art', 450, 4.2, 2014);


SELECT * FROM books 
WHERE price > 400;

SELECT * FROM books 
WHERE year_published < 2015;

SELECT * FROM books 
WHERE rating != 4.5;

SELECT * FROM books 
WHERE price >= 300 AND price <= 600;
-- WHERE price BETWEEN 300 AND 600;

SELECT * FROM books 
WHERE year_published = 2016;


-- Logical : 
SELECT * FROM books 
WHERE price > 400 AND year_published > 2015;

SELECT * FROM books 
WHERE rating = 4.5 OR rating = 4.2;

SELECT * FROM books 
WHERE NOT (year_published = 2016);

SELECT * FROM books 
WHERE (price < 500 OR rating > 4.5) AND year_published < 2018;


-- LIKE & ILIKE

SELECT * FROM books 
WHERE title LIKE 'The%';

SELECT * FROM books 
WHERE title LIKE '%Work';

SELECT * FROM books 
WHERE title ILIKE '%art%';

SELECT * FROM books 
WHERE title LIKE '_____';


-- IN / NOT IN : 

SELECT * FROM books 
WHERE rating IN (4.7, 4.4);

SELECT * FROM books 
WHERE year_published NOT IN (2014, 2016, 2018);

SELECT * FROM books 
WHERE price IN (350, 450, 399);

-- NOTE : If a list has NULL value, and you want to get it using IN or NOT IN like this : IN (4.8, NULL), IT won't work, because IN will internally be treated as rating = 4.8 or rating = NULL, and NULL is unknown, you can't compare something that is unknown to another unknown thing just because they are same DATA TYPE, It's like assuming 2 and 20 are same because they are integers.


-- IS NULL / IS NOT NULL : 
-- Refer to the example above for more detail as to how NULL behaves.

SELECT * FROM books 
WHERE rating IS NULL;

SELECT * FROM books 
WHERE rating IS NOT NULL;

SELECT * FROM books 
WHERE price IS NULL;

SELECT * FROM books 
WHERE price IS NOT NULL AND year_published < 2017;


-- COMBINATION : 

SELECT * FROM books 
WHERE (title ILIKE '%the%' AND rating NOT IN (4.4, 4.5));

SELECT * FROM books 
WHERE (year_published > 2010 OR price < 400 ) AND rating IS NOT NULL;

SELECT * FROM books 
WHERE (price BETWEEN 300 AND 500) AND (rating > 4.5 OR title LIKE 'E%');

SELECT * FROM books 
WHERE (year_published NOT IN (2014, 2016)) AND (title LIKE '%work%' OR rating < 4.5);


-- COMBINATION MASTERY : 

SELECT * FROM books 
WHERE (title ILIKE '%the%') AND (price BETWEEN 300 AND 700) AND (NOT (year_published = 2016));

SELECT * FROM books 
WHERE price > (
    SELECT AVG(price) FROM books
);

SELECT * FROM books 
WHERE (year_published BETWEEN 2010 AND 2020) AND (NOT(rating IS NULL OR rating < 4.5) );

SELECT * FROM books 
WHERE (title LIKE 'A%' OR title LIKE '%k') AND (price NOT IN (350, 450));

SELECT * FROM books 
WHERE (price > 300) AND
        (rating IS NOT NULL) AND 
        (title LIKE '%art%' OR title LIKE '%work%') AND
        NOT (year_published < 2015);