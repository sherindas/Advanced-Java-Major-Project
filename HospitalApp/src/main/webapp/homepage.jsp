<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hospital Management System - Home</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #e0f7fa, #ffffff);
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1000px;
            margin: 60px auto;
            padding: 40px;
            background: #ffffff;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            border-radius: 16px;
        }
        h1 {
            text-align: center;
            color: #2c3e50;
            font-size: 36px;
            margin-bottom: 40px;
        }
        ul.menu {
            list-style: none;
            padding: 0;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
        }
        ul.menu li {
            background-color: #3498db;
            color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            transition: transform 0.3s ease, background 0.3s ease;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        ul.menu li:hover {
            background-color: #2980b9;
            transform: translateY(-5px);
        }
        ul.menu li a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            font-weight: bold;
            display: block;
        }
        .footer {
            text-align: center;
            margin-top: 60px;
            color: #777;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏥 Hospital Management System</h1>
        <ul class="menu">
            <li><a href="PatientAdd.jsp">➕ Add New Patient</a></li>
            <li><a href="PatientUpdate.jsp">✏️ Update Patient Info</a></li>
            <li><a href="PatientDisplay.jsp">❌ Delete Patient Records</a></li>
            <li><a href="PatientDisplay.jsp">📋 View All Patients</a></li>
            <li><a href="reportByDate.jsp">📆 Report by Admission Date</a></li>
            <li><a href="reportByAilment.jsp">💉 Report by Ailment</a></li>
            <li><a href="reportByDoctor.jsp">👨‍⚕️ Report by Doctor</a></li>
        </ul>
        <div class="footer">
            &copy; <%= java.time.Year.now() %> Hospital Management System. All rights reserved.
        </div>
    </div>
</body>
</html>
