-- Drop existing tables in reverse order of dependencies
DROP TABLE IF EXISTS Tour CASCADE;
DROP TABLE IF EXISTS Facility CASCADE;
DROP TABLE IF EXISTS Park_Ranger CASCADE;
DROP TABLE IF EXISTS Visitor CASCADE; -- Assuming you need this
DROP TABLE IF EXISTS National_Park CASCADE;
-- Create National_Park table
CREATE TABLE National_Park (
    Park_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Location VARCHAR(255)
);
-- Create Visitor table
CREATE TABLE Visitor (
    Visitor_ID INT PRIMARY KEY,
    Visitor_Name VARCHAR(255)
);
-- Create Park_Ranger table
CREATE TABLE Park_Ranger (
    Ranger_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Park_ID INT,
    Intern_Ranger_ID INT,
    FOREIGN KEY (Park_ID) REFERENCES National_Park(Park_ID),
    FOREIGN KEY (Intern_Ranger_ID) REFERENCES Park_Ranger(Ranger_ID) -- Recursive relationship
);
-- Create Facility table
CREATE TABLE Facility (
    Facility_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Park_ID INT,
    FOREIGN KEY (Park_ID) REFERENCES National_Park(Park_ID)
);
-- Create Tour table
CREATE TABLE Tour (
    Tour_ID INT PRIMARY KEY,
    Description TEXT,
    Park_ID INT,
    Ranger_ID INT,
    Visitor_ID INT,
    FOREIGN KEY (Park_ID) REFERENCES National_Park(Park_ID),
    FOREIGN KEY (Ranger_ID) REFERENCES Park_Ranger(Ranger_ID),
    FOREIGN KEY (Visitor_ID) REFERENCES Visitor(Visitor_ID)
);