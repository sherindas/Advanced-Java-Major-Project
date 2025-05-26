package com.hospital.controller;

import com.hospital.dao.PatientDAO;
import com.hospital.model.Patient;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/UpdatePatientServlet")  // <- This is what Tomcat uses to match URL
public class UpdatePatientServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String date = request.getParameter("admissionDate");
        String ailment = request.getParameter("ailment");
        String doctor = request.getParameter("doctor");

        Patient p = new Patient(name, age, gender, date, ailment, doctor);
        boolean updated = PatientDAO.updatePatient(id, p);

        if (updated) {
            response.setContentType("text/html");
            response.getWriter().println("<!DOCTYPE html>");
            response.getWriter().println("<html><head><title>Update Success</title>");
            response.getWriter().println("<link href='https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap' rel='stylesheet'>");
            response.getWriter().println("<style>");
            response.getWriter().println("body { font-family: 'Roboto', sans-serif; background: #f0f8ff; display: flex; align-items: center; justify-content: center; height: 100vh; margin: 0; }");
            response.getWriter().println(".card { background: #ffffff; padding: 40px; border-radius: 12px; box-shadow: 0 8px 20px rgba(0,0,0,0.1); text-align: center; }");
            response.getWriter().println(".success-icon { font-size: 48px; color: #27ae60; }");
            response.getWriter().println("h2 { color: #2c3e50; margin-top: 20px; }");
            response.getWriter().println("a.button { display: inline-block; margin-top: 20px; padding: 12px 24px; background: #3498db; color: white; border-radius: 8px; text-decoration: none; font-weight: bold; transition: background 0.3s ease; }");
            response.getWriter().println("a.button:hover { background: #2980b9; }");
            response.getWriter().println("</style></head><body>");
            response.getWriter().println("<div class='card'>");
            response.getWriter().println("<div class='success-icon'></div>");
            response.getWriter().println("<h2>Patient Updated Successfully!</h2>");
            response.getWriter().println("<a class='button' href='PatientDisplay.jsp'>View All Patients</a>");
            response.getWriter().println("</div></body></html>");
        } else {
            response.setContentType("text/html");
            response.getWriter().println("<!DOCTYPE html><html><head><title>Update Failed</title></head><body style='font-family:Arial; text-align:center; color:red;'>");
            response.getWriter().println("<h3>Error updating patient. Please try again.</h3>");
            response.getWriter().println("<a href='PatientDisplay.jsp'>Back to Patient List</a>");
            response.getWriter().println("</body></html>");
        }

    }
}
