package com.hospital.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.hospital.db.dbConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/AddPatientServlet")
public class AddPatientServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            int age = Integer.parseInt(request.getParameter("age"));
            String gender = request.getParameter("gender");
            String admissionDate = request.getParameter("admissionDate");
            String ailment = request.getParameter("ailment");
            String doctor = request.getParameter("doctor");

            // Generate PatientID — you may want to use auto-increment in DB ideally
            int patientId = (int) (Math.random() * 100000);

            Connection con = dbConnection.getConnection();

            String sql = "INSERT INTO Patients (PatientID, PatientName, Age, Gender, AdmissionDate, Ailment, AssignedDoctor) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, patientId);
            ps.setString(2, name);
            ps.setInt(3, age);
            ps.setString(4, gender);
            ps.setString(5, admissionDate);
            ps.setString(6, ailment);
            ps.setString(7, doctor);

            int rowsInserted = ps.executeUpdate();

            response.setContentType("text/html");
            if (rowsInserted > 0) {
                response.setContentType("text/html");
                response.getWriter().println("<!DOCTYPE html>");
                response.getWriter().println("<html><head><title>Success</title>");
                response.getWriter().println("<link href='https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap' rel='stylesheet'>");
                response.getWriter().println("<style>");
                response.getWriter().println("body { font-family: 'Roboto', sans-serif; background: #eafaf1; display: flex; align-items: center; justify-content: center; height: 100vh; margin: 0; }");
                response.getWriter().println(".card { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 8px 20px rgba(0,0,0,0.1); text-align: center; }");
                response.getWriter().println(".success-icon { font-size: 48px; color: #27ae60; }");
                response.getWriter().println("h2 { color: #2c3e50; margin-top: 20px; }");
                response.getWriter().println(".patient-id { font-size: 20px; color: #16a085; margin: 10px 0; }");
                response.getWriter().println("a { display: inline-block; margin-top: 20px; padding: 10px 20px; background: #27ae60; color: white; border-radius: 8px; text-decoration: none; font-weight: bold; }");
                response.getWriter().println("a:hover { background: #219150; }");
                response.getWriter().println("</style></head><body>");
                response.getWriter().println("<div class='card'>");
                response.getWriter().println("<div class='success-icon'></div>");
                response.getWriter().println("<h2>Patient Added Successfully</h2>");
                response.getWriter().println("<div class='patient-id'>Patient ID: <strong>" + patientId + "</strong></div>");
                response.getWriter().println("<a href='homepage.jsp'> Back to Home</a>");
                response.getWriter().println("</div></body></html>");
            } else {
                response.setContentType("text/html");
                response.getWriter().println("<h3 style='color:red; text-align:center;'>❌ Failed to add patient.</h3>");
            }


            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }
}
