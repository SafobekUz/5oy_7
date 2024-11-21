CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_date DATE,
    country VARCHAR(100)
);

CREATE TABLE publishers (
    publisher_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100),
    established_year INTEGER
);

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author_id INTEGER REFERENCES authors(author_id) ON DELETE SET NULL,
    publisher_id INTEGER REFERENCES publishers(publisher_id) ON DELETE SET NULL,
    genre VARCHAR(50),
    publish_date DATE,
    price NUMERIC(10, 2)
);

CREATE TABLE book_reviews (
    review_id SERIAL PRIMARY KEY,
    book_id INTEGER REFERENCES books(book_id) ON DELETE CASCADE,
    review_text TEXT,
    rating INTEGER CHECK (rating BETWEEN 1 AND 5),
    review_date DATE DEFAULT CURRENT_DATE
);

INSERT INTO authors (name, birth_date, country) VALUES
('George Orwell', '1903-06-25', 'UK'),
('J.K. Rowling', '1965-07-31', 'UK'),
('Ernest Hemingway', '1899-07-21', 'USA'),
('Gabriel Garcia Marquez', '1927-03-06', 'Colombia'),
('Fyodor Dostoevsky', '1821-11-11', 'Russia');

INSERT INTO publishers (name, city, established_year) VALUES
('Penguin Random House', 'New York', 1927),
('HarperCollins', 'London', 1817),
('Simon & Schuster', 'New York', 1924),
('Macmillan Publishers', 'London', 1843),
('Bloomsbury', 'London', 1986);


INSERT INTO books (title, author_id, publisher_id, genre, publish_date, price) VALUES
('1984', 1, 1, 'Dystopian', '1949-06-08', 19.99),
('Animal Farm', 1, 1, 'Satire', '1945-08-17', 9.99),
('Harry Potter and the Sorcerer''s Stone', 2, 5, 'Fantasy', '1997-06-26', 29.99),
('Harry Potter and the Chamber of Secrets', 2, 5, 'Fantasy', '1998-07-02', 24.99),
('The Old Man and the Sea', 3, 3, 'Fiction', '1952-09-01', 14.99),
('A Farewell to Arms', 3, 2, 'Fiction', '1929-09-27', 19.99),
('One Hundred Years of Solitude', 4, 4, 'Magical Realism', '1967-05-30', 24.99),
('Love in the Time of Cholera', 4, 4, 'Romance', '1985-09-05', 18.99),
('Crime and Punishment', 5, 2, 'Psychological Fiction', '1866-01-01', 29.99),
('The Brothers Karamazov', 5, 2, 'Philosophical Fiction', '1880-01-01', 34.99);

INSERT INTO book_reviews (book_id, review_text, rating) VALUES
(1, 'An amazing book with deep insights on society.', 5),
(2, 'A clever and engaging satire.', 4),
(3, 'A magical journey through Hogwarts.', 5),
(5, 'An inspirational tale of perseverance.', 4),
(10, 'A profound exploration of faith and morality.', 5);


SELECT * FROM books;

SELECT title AS "Kitob nomi", price AS "Narxi" FROM books;

SELECT * FROM books ORDER BY price DESC;

SELECT * FROM books WHERE genre = 'Fantasy';
SELECT * FROM books LIMIT 3;
SELECT * FROM books WHERE genre IN ('Fantasy', 'Dystopian');

SELECT * FROM books WHERE price BETWEEN 15 AND 30;

SELECT * FROM books WHERE title LIKE '%Harry%';

SELECT * FROM books WHERE publisher_id IS NULL;

SELECT genre, COUNT(*) AS "Kitoblar soni" FROM books GROUP BY genre;



SELECT b.title, a.name AS "Author", p.name AS "Publisher", b.price
FROM books b
JOIN authors a ON b.author_id = a.author_id
JOIN publishers p ON b.publisher_id = p.publisher_id;

SELECT p.name AS "Publisher", COUNT(b.book_id) AS "Number of Books"
FROM publishers p
LEFT JOIN books b ON p.publisher_id = b.publisher_id
GROUP BY p.name;
SELECT AVG(price) AS "Average Price" FROM books;

SELECT SUM(price) AS "Total Price of All Books" FROM books;
