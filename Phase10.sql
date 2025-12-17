-- so, single column index is just indexing using a value of a column that can be very unique across the rows which you call cardinality.
-- composite indexing is (customer_id, status, created_at) but here, only the column from the left take advantage of indexing, like customer, customer+status..., but not status alone or created_at alone)
-- and I can also do composite indexing like (customer_id, created_at DESC) it is called sort-order indexes, this means, that the created_at column in customer_id is sorted in DESC order whcih help for the query even.

-- and partial indexing sounds scary but it's either a single column indexing or a composite indexing with a WHERE condition 💀


-- Here is how indexing works internally : 
-- Let's understand the problem indexing solves, 
-- Without indexing, the data (rows) had to be stored in a memory block on a disk, either one record (single row) or two records in a single memory block, and when there is a read request, this data is completely loaded into the memory (RAM) from where you'd read it row by row (Linear search, If you know DSA, it's O(n) time complexity which is obviously bad if the dataset is huge), not only doing a linear search is bad, but loading this huge dataset from bytes into the memory itself is costly.

-- With indexing, you select the row with high cardinality to index let's say email, index will form a reference table that consists of the memory address of that particular value in that disk and also this value, email, will be sorted. So, it's now nothing but binary search. Because the email is sorted in alphabetical order, postgres goes to the middle of that reference table to check if this requeried email value is before or after in that sorted table, if email starts with a, then it will completely eliminates the another half of the table and moves towards the starting of the table, now it's the middle of the middle of the reference table and starting point, and this goes on until you find the actual value. it's O(log n) time complexity which is less than half of the usual search without indexing. what could've been 100 times search becomes less than 10.




-- SINGLE INDEXING : 

CREATE TABLE users (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE,
    phone BIGINT UNIQUE NOT NULL
);

INSERT INTO users (name, email, phone) 
VALUES 
('Vinod1', 'Kvinod90191@gmail.com', 2098203),
('Vinod2', 'Kvinod90192@gmail.com', 2098201),
('Vinod3', 'Kvinod90192@gmail.com', 2098202);

CREATE INDEX idx_users_email ON users(email);

DROP INDEX idx_users_email;


-- Composite indexing : 
CREATE INDEX idx_users_email_phone ON users(name, email, phone);

-- There is a rule here that email and phone are not sorted and not indexed standalone, but indexed in relation to and within name reference table which is the left prefix, the starter value in the indexing, like if a query contains name it is indexed, if a query contains name and email, it is indexed. If a query contains all ot the three, indexed. but if there is no starter value (name), then they are not indexed.


-- Partial indexing : 
    -- This is simple, you just either use single indexing or composite indexing but with a where condition :

    CREATE INDEX idx_users_phone ON users(phone) WHERE phone > 6000000000 AND phone < 9999999999; -- in the indian mobile numbers context, while it might not make sense because there won't be no number below that range at all but we are trying to eliminate indexing for spam numbers.


-- Unique Indexing : 

    -- Unique indexing is when you want the indexed column (or values in that reference table that gets created on indexing, to be unique) to be unique.

    CREATE UNIQUE idx_users_phones ON users(phone);