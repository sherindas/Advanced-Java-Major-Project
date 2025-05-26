<%@ page import="java.sql.*" %>
<%@ page import="com.hospital.db.dbConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Patient</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: #f4f9ff;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        .card {
            background: white;
            padding: 40px 50px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .status-icon {
            font-size: 50px;
        }
        .success-icon { color: #27ae60; }
        .error-icon { color: #e74c3c; }
        h2 {
            margin: 20px 0 10px;
            color: #2c3e50;
        }
        p {
            font-size: 16px;
            color: #555;
        }
        .btn {
            margin-top: 25px;
            display: inline-block;
            background: #3498db;
            color: white;
            text-decoration: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: bold;
            transition: background 0.3s ease;
        }
        .btn:hover {
            background: #2980b9;
        }
    </style>
</head>
<body>
<div class="card">
<%
    String idStr = request.getParameter("id");
    int id = 0;
    if (idStr != null && !idStr.isEmpty()) {
        try {
            id = Integer.parseInt(idStr);
            Connection con = dbConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM Patients WHERE PatientID = ?");
            ps.setInt(1, id);
            int rows = ps.executeUpdate();

            if (rows > 0) {
%>
    <div class="status-icon success-icon">✅</div>
    <h2>Patient Record Deleted</h2>
    <p>The patient record with ID <strong><%= id %></strong> was successfully deleted.</p>
<%
            } else {
%>
    <div class="status-icon error-icon">❌</div>
    <h2>Patient Not Found</h2>
    <p>No record found with ID <strong><%= id %></strong> or it was already deleted.</p>
<%
            }
            ps.close();
            con.close();
        } catch (Exception e) {
%>
    <div class="status-icon error-icon">⚠️</div>
    <h2>Error Occurred</h2>
    <p><%= e.getMessage() %></p>
<%
        }
    } else {
%>
    <div class="status-icon error-icon">⚠️</div>
    <h2>Invalid ID</h2>
    <p>Patient ID was not provided or is invalid.</p>
<%
    }
%>
    <a href="PatientDisplay.jsp" class="btn">🔙 Back to Patient List</a>
</div>
</body>
</html>
