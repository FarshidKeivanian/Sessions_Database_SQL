-- Step 1: Create Genre table
CREATE TABLE Genre (
    Genre_ID INT PRIMARY KEY,
    Genre_Name VARCHAR(100) NOT NULL
);

-- Step 2: Create Book table
CREATE TABLE Book (
    Book_ID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    ISBN VARCHAR(13),
    Publish_Date DATE,
    Genre_ID INT,
    FOREIGN KEY (Genre_ID) REFERENCES Genre(Genre_ID)
);

-- Step 3: Insert sample data into Genre table
INSERT INTO Genre (Genre_ID, Genre_Name)
VALUES 
(1, 'Fiction'),
(2, 'Non-Fiction'),
(3, 'Classics');

-- Step 4: Insert sample data into Book table
INSERT INTO Book (Book_ID, Title, ISBN, Publish_Date, Genre_ID)
VALUES 
(1, 'The Great Gatsby', '9780743273565', '1925-04-10', 3),
(2, '1984', '9780451524935', '1949-06-08', 1),
(3, 'Sapiens', '9780062316110', '2011-01-01', 2);

-- Step 5: Create Book_Reviews table with VARCHAR(MAX) for Review_Text
CREATE TABLE Book_Reviews (
    Review_ID INT PRIMARY KEY,
    Book_ID INT,
    Reviewer_Name VARCHAR(100),
    Rating FLOAT,
    Review_Text VARCHAR(MAX), -- Changed from TEXT to VARCHAR(MAX)
    FOREIGN KEY (Book_ID) REFERENCES Book(Book_ID)
);
-- Step 6: Insert sample data into Book_Reviews table
INSERT INTO Book_Reviews (Review_ID, Book_ID, Reviewer_Name, Rating, Review_Text)
VALUES 
(1, 1, 'Alice', NULL, 'An amazing story!'),
(2, 1, 'Bob', 4.5, ''),
(3, 1, 'Charlie', 3.0, 'A good read.'),
(4, 2, 'David', 5.0, 'A masterpiece of dystopian fiction.'),
(5, 3, 'Eve', NULL, '');
