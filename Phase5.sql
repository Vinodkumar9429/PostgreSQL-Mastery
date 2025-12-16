--UNIQUE :
--When you want a particular column value to be unique across rows, like phone numbers, emails, userIDs etc.

CREATE TABLE user (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    email TEXT UNIQUE,
    phone_number INT UNIQUE
);

-- Composite Unique :
-- When you want that one column can have same value and the other column is also allowed to have same value but both combined can't have same value across the rows of a table

CREATE TABLE user_v2 (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    email TEXT,
    phone_number INT,
    -- this is how to do it : UNIQUE(name, email, phone_number), but this is not a good practice, here is a production safe way : 
    -- CONSTRAINT unique_user_constraint UNIQUE(name, email, phone_number)
);

-- If you later want to add the constraint, You do :
ALTER TABLE user_v2
ADD CONSTRAINT one_more_constraint UNIQUE (name, email, phone_number);

-- If you want to remove that constraint, You do : 
ALTER TABLE user_v2 
DROP CONSTRAINT one_more_constraint;





-- NOT NULL : It's like saying that this column can't be NULL : 

CREATE TABLE something (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email TEXT
);

ALTER TABLE something 
ALTER COLUMN email SET NULL;
ADD CONSTRAINT email_unique UNIQUE (email);

ALTER TABLE something 
ALTER COLUMN email DROP NOT NULL;
ALTER TABLE something
DROP CONSTRAINT email_unique;





-- CHECK : Adding validation at column level : 

CREATE TABLE some (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    email UNIQUE NOT NULL,
    price INT,
    rating FLOAT PRECISION,
    CONSTRAINT price_validation CHECK (price > 0),
    CONSTRAINT rating_validation CHECK (rating > 0)
);

-- ALTER TABLE some 
-- DROP CONSTRAINT price_validation, 
-- DROP CONSTRAINT rating_validation

