-- Ensure any existing 'Enrollment' table is deleted
DROP TABLE IF EXISTS Enrollment CASCADE;

-- Ensure any existing 'Student' table is deleted
DROP TABLE IF EXISTS Student CASCADE;

-- Ensure any existing 'Course' table is deleted
DROP TABLE IF EXISTS Course CASCADE;

-- Create Students table
CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Major VARCHAR(50)
);

-- Create Courses table
CREATE TABLE Course (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(100) NOT NULL,
    Department VARCHAR(50) NOT NULL
);

-- Create Enrollment table
CREATE TABLE Enrollment (
    Enroll_ID INT PRIMARY KEY,
    Student_ID INT,
    Course_ID INT,
    Enrollment_Date DATE NOT NULL,
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

-- Insert Students
INSERT INTO Student (Student_ID, Student_Name, Email, Major) VALUES 
(1, 'Alice Smith', 'alice.smith@university.edu.au', 'Computer Science'),
(2, 'Bob Jones', 'bob.jones@university.edu.au', 'Mathematics');

-- Insert Courses
INSERT INTO Course (Course_ID, Course_Name, Department) VALUES 
(101, 'Introduction to Programming', 'Computer Science'),
(102, 'Calculus I', 'Mathematics');

-- Insert Enrollments
INSERT INTO Enrollment (Enroll_ID, Student_ID, Course_ID, Enrollment_Date) VALUES 
(1, 1, 101, '2024-02-01'),
(2, 2, 102, '2024-02-01');

-- Sample query to display Students and their Courses
SELECT s.Student_Name, c.Course_Name 
FROM Enrollment e
JOIN Student s ON e.Student_ID = s.Student_ID
JOIN Course c ON e.Course_ID = c.Course_ID;
