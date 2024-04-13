DROP TABLE IF EXISTS Professor CASCADE;

DROP TABLE IF EXISTS Course CASCADE;

DROP TABLE IF EXISTS Teaches CASCADE;


CREATE TABLE Professor (
    ProfessorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(100)
);

CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    Title VARCHAR(100),
    Credits INT,
    Department VARCHAR(100)
);

CREATE TABLE Teaches (
    ProfessorID INT,
    CourseID INT,
    CONSTRAINT FK_Professor FOREIGN KEY (ProfessorID) REFERENCES Professor(ProfessorID),
    CONSTRAINT FK_Course FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    CONSTRAINT PK_Teaches PRIMARY KEY (ProfessorID, CourseID)
);
