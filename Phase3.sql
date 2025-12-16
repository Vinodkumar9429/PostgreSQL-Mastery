CREATE TABLE movies (
    id SERIAL PRIMARY KEY,
    title VARCHAR(50),
    year_released INTEGER,
    rating FLOAT
);

INSERT INTO movies (title, year_released) VALUES 
('Mahumali', '2018'),
('Closenheimer', '2024'),
('KALKERPUNK 2077', '2025')

SELECT title from movies;

SELECT title, rating from movies;

SELECT title, rating + 1 AS boosted_rating;

SELECT * from movies ORDER BY rating ASC;

SELECT * from movies ORDER BY year_released DESC;

SELECT title, rating + 1 AS boosted ORDER BY boosted DESC;

SELECT * from movies ORDER BY rating DESC, year_released DESC;

-- PAGINATION

SELECT * from movies LIMIT 2;

SELECT * from movies LIMIT 10 OFFSET 10;

SELECT * from movies LIMIT page_size OFFSET (page_number - 1)* page_size;

-- Task : 
SELECT * from movies LIMIT 1;

SELECT * from movies ORDER BY year_released DESC LIMIT 2;

SELECT * from movies LIMIT 2 OFFSET 1;

SELECT * from movies ORDER BY rating DESC LIMIT 3;



-- Update : 

UPDATE movies 
SET rating = 7.4
WHERE title = 'Mahumali';

UPDATE movies 
SET year_released = 2025
WHERE title = 'Closenheimer';

UPDATE movies 
SET 
    rating = 9.5,
    year_released = 2077
WHERE title = 'KALKERPUNK 2077';

-- Update COMPLEX : 

UPDATE movies 
SET rating = 10
WHERE year_released > 2020;

UPDATE movies 
SET year_released = 3000
WHERE title IN ('2077');

UPDATE movies 
SET rating = CASE 
    WHEN title = 'Mahumali' THEN 9
    WHEN title = 'Closenheimer' THEN 8
    WHEN title = 'KALKERPUNK 2077' THEN 9.9
    ELSE rating
END;


-- Delete :

DELETE FROM movies 
WHERE title = 'Closenheimer';

DELETE FROM movies 
WHERE rating > 9;

DELETE FROM movies 
WHERE year_released < 2022;

DELETE FROM movies;