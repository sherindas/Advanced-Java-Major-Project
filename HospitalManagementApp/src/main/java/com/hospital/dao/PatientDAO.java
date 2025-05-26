package com.hospital.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import com.hospital.model.Patient;
import java.sql.ResultSet;
import java.sql.DriverManager;


public class PatientDAO {
    public static boolean insertPatient(Patient p) {
        boolean status = false;
        try {
            Connection con = dbConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO Patients(PatientName, Age, Gender, AdmissionDate, Ailment, AssignedDoctor) VALUES (?, ?, ?, ?, ?, ?)"
            );
            ps.setString(1, p.getName());
            ps.setInt(2, p.getAge());
            ps.setString(3, p.getGender());
            ps.setString(4, p.getAdmissionDate());
            ps.setString(5, p.getAilment());
            ps.setString(6, p.getDoctor());

            int rows = ps.executeUpdate();
            if (rows > 0) status = true;

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
    public static Patient getPatientById(int id) {
        Patient patient = null;
        try {
            Connection con = dbConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM Patients WHERE PatientID = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                patient = new Patient(
                    rs.getString("PatientName"),
                    rs.getInt("Age"),
                    rs.getString("Gender"),
                    rs.getString("AdmissionDate"),
                    rs.getString("Ailment"),
                    rs.getString("AssignedDoctor")
                );
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return patient;
    }

    public static boolean updatePatient(int id, Patient p) {
        boolean status = false;
        try {
            Connection con = dbConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE Patients SET PatientName=?, Age=?, Gender=?, AdmissionDate=?, Ailment=?, AssignedDoctor=? WHERE PatientID=?"
            );
            ps.setString(1, p.getName());
            ps.setInt(2, p.getAge());
            ps.setString(3, p.getGender());
            ps.setString(4, p.getAdmissionDate());
            ps.setString(5, p.getAilment());
            ps.setString(6, p.getDoctor());
            ps.setInt(7, id);

            int rows = ps.executeUpdate();
            if (rows > 0) status = true;

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

}
