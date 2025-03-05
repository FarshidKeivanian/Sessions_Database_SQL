-- Create Database
CREATE DATABASE IF NOT EXISTS MedicalClinicDB;
USE MedicalClinicDB;

-- Patient Table
CREATE TABLE IF NOT EXISTS Patient (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    Address VARCHAR(255),
    ContactInfo VARCHAR(100),
    MedicalHistory TEXT
);

-- Insert Sample Data into Patient Table
INSERT INTO Patient (FirstName, LastName, DateOfBirth, Gender, Address, ContactInfo, MedicalHistory)
VALUES 
('John', 'Doe', '1990-05-12', 'Male', '123 Main St, Sydney', 'johndoe@gmail.com', 'Diabetic'),
('Sarah', 'Smith', '1985-07-25', 'Female', '456 Queen St, Melbourne', 'sarahsmith@gmail.com', 'No known allergies');

-- Doctor Table
CREATE TABLE IF NOT EXISTS Doctor (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialization VARCHAR(100),
    ContactInfo VARCHAR(100)
);

-- Insert Sample Data into Doctor Table
INSERT INTO Doctor (FirstName, LastName, Specialization, ContactInfo)
VALUES 
('Dr. James', 'Wilson', 'Cardiology', 'drwilson@clinic.com'),
('Dr. Lisa', 'Cuddy', 'Endocrinology', 'drcuddy@clinic.com');

-- Appointment Table
CREATE TABLE IF NOT EXISTS Appointment (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATETIME NOT NULL,
    Status ENUM('Scheduled', 'Unscheduled') DEFAULT 'Scheduled',
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID) ON DELETE CASCADE,
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID) ON DELETE CASCADE
);

-- Insert Sample Data into Appointment Table
INSERT INTO Appointment (PatientID, DoctorID, AppointmentDate, Status)
VALUES 
(1, 1, '2025-03-10 10:30:00', 'Scheduled'),
(2, 2, '2025-03-12 11:00:00', 'Scheduled');

-- Visit Table
CREATE TABLE IF NOT EXISTS Visit (
    VisitID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT UNIQUE NOT NULL,  
    VisitDate DATETIME NOT NULL,
    Notes TEXT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID) ON DELETE CASCADE
);

-- Insert Sample Data into Visit Table
INSERT INTO Visit (AppointmentID, VisitDate, Notes)
VALUES 
(1, '2025-03-10 10:35:00', 'Patient reported chest pain'),
(2, '2025-03-12 11:05:00', 'Routine check-up');

-- Diagnosis Table
CREATE TABLE IF NOT EXISTS Diagnosis (
    DiagnosisID INT AUTO_INCREMENT PRIMARY KEY,
    VisitID INT NOT NULL,
    DiagnosisDetails TEXT NOT NULL,
    FOREIGN KEY (VisitID) REFERENCES Visit(VisitID) ON DELETE CASCADE
);

-- Treatment Table
CREATE TABLE IF NOT EXISTS Treatment (
    TreatmentID INT AUTO_INCREMENT PRIMARY KEY,
    VisitID INT NOT NULL,
    TreatmentDetails TEXT NOT NULL,
    FOREIGN KEY (VisitID) REFERENCES Visit(VisitID) ON DELETE CASCADE
);

-- Bill Table
CREATE TABLE IF NOT EXISTS Bill (
    BillID INT AUTO_INCREMENT PRIMARY KEY,
    VisitID INT NOT NULL UNIQUE,
    Amount DECIMAL(10,2) NOT NULL,
    Status ENUM('Pending', 'Paid', 'Partially Paid') DEFAULT 'Pending',
    FOREIGN KEY (VisitID) REFERENCES Visit(VisitID) ON DELETE CASCADE
);

-- Payment Table
CREATE TABLE IF NOT EXISTS Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    PaymentDate DATETIME NOT NULL,
    AmountPaid DECIMAL(10,2) NOT NULL,
    PaymentMethod ENUM('Cash', 'Credit Card', 'Bank Transfer', 'Insurance') NOT NULL
);

-- Junction Table (Many-to-Many for Payments & Bills)
CREATE TABLE IF NOT EXISTS PaymentBill (
    PaymentID INT NOT NULL,
    BillID INT NOT NULL,
    AmountPaid DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (PaymentID, BillID),
    FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID) ON DELETE CASCADE,
    FOREIGN KEY (BillID) REFERENCES Bill(BillID) ON DELETE CASCADE
);
