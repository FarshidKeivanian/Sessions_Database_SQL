DROP TABLE IF EXISTS Student CASCADE;

DROP TABLE IF EXISTS Course CASCADE;

DROP TABLE IF EXISTS Registration CASCADE;

CREATE TABLE Student (
  Student_ID INT PRIMARY KEY,
  Name VARCHAR(255),
  Email VARCHAR(255)
);

CREATE TABLE Course (
  Course_ID INT PRIMARY KEY,
  Course_Name VARCHAR(255),
  Department VARCHAR(255)
);

CREATE TABLE Registration (
  Reg_ID INT PRIMARY KEY,
  Student_ID INT,
  Course_ID INT,
  Semester VARCHAR(50),
  FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
  FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);
