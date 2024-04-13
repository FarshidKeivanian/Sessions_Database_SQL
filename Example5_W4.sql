-- Drop existing tables in reverse order of dependencies
DROP TABLE IF EXISTS Authors_Books CASCADE;
DROP TABLE IF EXISTS Books CASCADE;
DROP TABLE IF EXISTS Authors CASCADE;
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    Name VARCHAR(100),
    DOB DATE,
    Nationality VARCHAR(50)
);
CREATE TABLE Books (
    ISBN VARCHAR(13) PRIMARY KEY,
    Title VARCHAR(100),
    Year INTEGER,  -- Changed YEAR to INTEGER
    Genre VARCHAR(50)
);
CREATE TABLE Authors_Books (
    AuthorID INT,
    ISBN VARCHAR(13),
    Role VARCHAR(50),
    PRIMARY KEY (AuthorID, ISBN),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (ISBN) REFERENCES Books(ISBN)
);