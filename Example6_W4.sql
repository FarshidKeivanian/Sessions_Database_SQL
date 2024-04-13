-- Drop existing tables in reverse order of dependencies
DROP TABLE IF EXISTS Employees CASCADE;
DROP TABLE IF EXISTS Marriage CASCADE;
DROP TABLE IF EXISTS Marriage_Participant CASCADE;
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(255),
    emp_spouse_id INT,
    FOREIGN KEY (emp_spouse_id) REFERENCES Employees(emp_id)
);
CREATE TABLE Marriage (
    mar_id INT PRIMARY KEY,
    mar_date DATE
);
CREATE TABLE Marriage_Participant (
    mar_id INT,
    emp_id INT,
    PRIMARY KEY (mar_id, emp_id),
    FOREIGN KEY (mar_id) REFERENCES Marriage(mar_id),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);