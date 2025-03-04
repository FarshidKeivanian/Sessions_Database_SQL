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

-- Doctor Table
CREATE TABLE IF NOT EXISTS Doctor (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialization VARCHAR(100),
    ContactInfo VARCHAR(100)
);

-- Appointment Table (1 Patient : M Appointments, 1 Doctor : M Appointments)
CREATE TABLE IF NOT EXISTS Appointment (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATETIME NOT NULL,
    Status ENUM('Scheduled', 'Unscheduled') DEFAULT 'Scheduled',
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID) ON DELETE CASCADE,
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID) ON DELETE CASCADE
);

-- Visit Table (Each appointment yields a visit)
CREATE TABLE IF NOT EXISTS Visit (
    VisitID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT UNIQUE NOT NULL,  
    VisitDate DATETIME NOT NULL,
    Notes TEXT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID) ON DELETE CASCADE
);

-- Diagnosis Table (1 Visit : M Diagnoses)
CREATE TABLE IF NOT EXISTS Diagnosis (
    DiagnosisID INT AUTO_INCREMENT PRIMARY KEY,
    VisitID INT NOT NULL,
    DiagnosisDetails TEXT NOT NULL,
    FOREIGN KEY (VisitID) REFERENCES Visit(VisitID) ON DELETE CASCADE
);

-- Treatment Table (1 Visit : M Treatments)
CREATE TABLE IF NOT EXISTS Treatment (
    TreatmentID INT AUTO_INCREMENT PRIMARY KEY,
    VisitID INT NOT NULL,
    TreatmentDetails TEXT NOT NULL,
    FOREIGN KEY (VisitID) REFERENCES Visit(VisitID) ON DELETE CASCADE
);

-- Bill Table (1 Visit : 1 Bill)
CREATE TABLE IF NOT EXISTS Bill (
    BillID INT AUTO_INCREMENT PRIMARY KEY,
    VisitID INT NOT NULL UNIQUE,
    Amount DECIMAL(10,2) NOT NULL,
    Status ENUM('Pending', 'Paid', 'Partially Paid') DEFAULT 'Pending',
    FOREIGN KEY (VisitID) REFERENCES Visit(VisitID) ON DELETE CASCADE
);

-- Payment Table (M Bills : M Payments Handled Separately)
CREATE TABLE IF NOT EXISTS Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    PaymentDate DATETIME NOT NULL,
    AmountPaid DECIMAL(10,2) NOT NULL,
    PaymentMethod ENUM('Cash', 'Credit Card', 'Bank Transfer', 'Insurance') NOT NULL
);

-- Junction Table for M:N Relationship (Payment covers multiple Bills)
CREATE TABLE IF NOT EXISTS PaymentBill (
    PaymentID INT NOT NULL,
    BillID INT NOT NULL,
    AmountPaid DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (PaymentID, BillID),
    FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID) ON DELETE CASCADE,
    FOREIGN KEY (BillID) REFERENCES Bill(BillID) ON DELETE CASCADE
);

-- Insurance Table (Each patient may have one insurance policy)
CREATE TABLE IF NOT EXISTS Insurance (
    InsuranceID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    ProviderName VARCHAR(100) NOT NULL,
    PolicyNumber VARCHAR(50) UNIQUE NOT NULL,
    CoverageDetails TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID) ON DELETE CASCADE
);

-- Insurance Claims Table (1 Bill : 1 Insurance Claim)
CREATE TABLE IF NOT EXISTS InsuranceClaim (
    ClaimID INT AUTO_INCREMENT PRIMARY KEY,
    BillID INT NOT NULL,
    InsuranceID INT NOT NULL,
    ClaimAmount DECIMAL(10,2) NOT NULL,
    Deductible DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (BillID) REFERENCES Bill(BillID) ON DELETE CASCADE,
    FOREIGN KEY (InsuranceID) REFERENCES Insurance(InsuranceID) ON DELETE CASCADE
);
