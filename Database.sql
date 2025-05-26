CREATE DATABASE IF NOT EXISTS hospitaldb;
USE hospitaldb;

CREATE TABLE patients (
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR(255),
    AdmissionDate DATE,
    Age INT NULL,
    Ailment VARCHAR(255),
    AssignedDoctor VARCHAR(255),
    Gender VARCHAR(50) NULL
);
