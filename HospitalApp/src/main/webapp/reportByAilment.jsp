<%@ page import="java.sql.*" %>
<%@ page import="com.hospital.db.dbConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Patients with Specific Ailment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f9f9f9;
            color: #333;
        }
        h2 {
            color: #2c3e50;
            margin-bottom: 20px;
            text-align: center;
            font-size: 24px;
            font-weight: 700;
            letter-spacing: 1px;
        }
        form {
            margin-bottom: 20px;
            text-align: center;
        }
        input[type="text"], button {
            padding: 10px 16px;
            margin: 5px 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
            transition: box-shadow 0.3s ease;
        }
        input[type="text"]:focus, button:hover {
            box-shadow: 0 0 8px #007bff;
            outline: none;
        }
        button {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            font-weight: 600;
            border-radius: 6px;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #0056b3;
        }
        /* Scrollable container for table on screen */
        .table-container {
            overflow-x: auto;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            background: white;
            border-radius: 8px;
            padding: 10px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            min-width: 800px; /* ensure minimum width for wide table */
            font-size: 15px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px 18px;
            text-align: left;
            white-space: nowrap; /* no wrap on screen */
        }
        th {
            background-color: #f2f6fc;
            color: #34495e;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        tr:nth-child(even) {
            background-color: #fafafa;
        }
        tr:hover {
            background-color: #f1f8ff;
        }
        /* Search criteria display above table */
        .search-criteria {
            text-align: center;
            margin-bottom: 15px;
            font-weight: 600;
            font-size: 16px;
            color: #2c3e50;
        }
        /* Print styles */
        @media print {
            @page {
                size: landscape;
                margin: 10mm;
            }
            body {
                background: white;
                color: black;
                margin: 0;
                padding: 0;
                font-size: 10pt;
                font-family: Arial, sans-serif;
            }
            h2 {
                font-size: 14pt;
                text-align: center;
                margin-bottom: 12px;
                color: black;
            }
            form, .btn-print {
                display: none !important;
            }
            .table-container {
                overflow: visible !important;
                box-shadow: none !important;
                padding: 0 !important;
                margin: 0 !important;
            }
            table {
                width: 100% !important;
                min-width: auto !important;
                border-collapse: collapse !important;
                border: 1px solid black !important;
                table-layout: fixed;
                word-wrap: break-word;
                font-size: 9pt !important;
            }
            th, td {
                border: 1px solid black !important;
                padding: 6px 8px !important;
                white-space: normal !important;
                vertical-align: top;
                word-break: break-word;
            }
            tr {
                background: none !important;
            }
            .search-criteria {
                font-size: 12pt;
                margin-bottom: 10px;
                color: black;
            }
        }
        /* Print button styling */
        .btn-print {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            display: block;
            margin: 0 auto 40px auto;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(40,167,69,0.5);
            transition: background-color 0.3s ease;
        }
        .btn-print:hover {
            background-color: #1e7e34;
            box-shadow: 0 6px 14px rgba(30,126,52,0.7);
        }
    </style>
</head>
<body>
    <h2>Report: Patients with Specific Ailment</h2>
    <form method="post" action="reportByAilment.jsp">
        Enter Ailment: 
        <input type="text" name="ailment" required
               value="<%= request.getParameter("ailment") != null ? request.getParameter("ailment") : "" %>">
        <button type="submit">Search</button>
    </form>

<%
    String ailment = request.getParameter("ailment");
    if (ailment != null && !ailment.trim().isEmpty()) {
        try {
            Connection con = dbConnection.getConnection();
            String sql = "SELECT * FROM Patients WHERE Ailment LIKE ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + ailment.trim() + "%");
            ResultSet rs = ps.executeQuery();
%>

    <div class="search-criteria">
        <p><strong>Ailment:</strong> <%= ailment.trim() %></p>
    </div>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>ID</th><th>Name</th><th>Age</th><th>Gender</th>
                    <th>Admission Date</th><th>Ailment</th><th>Doctor</th>
                </tr>
            </thead>
            <tbody>
<%
            boolean found = false;
            while (rs.next()) {
                found = true;
%>
                <tr>
                    <td><%= rs.getInt("PatientID") %></td>
                    <td><%= rs.getString("PatientName") %></td>
                    <td><%= rs.getInt("Age") %></td>
                    <td><%= rs.getString("Gender") %></td>
                    <td><%= rs.getDate("AdmissionDate") %></td>
                    <td><%= rs.getString("Ailment") %></td>
                    <td><%= rs.getString("AssignedDoctor") %></td>
                </tr>
<%
            }
            if (!found) {
%>
                <tr><td colspan="7" style="text-align:center; font-style: italic;">No patients found with this ailment.</td></tr>
<%
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
%>
            <tr><td colspan="7" style="color:red; text-align:center;">Error: <%= e.getMessage() %></td></tr>
<%
        }
    }
%>
            </tbody>
        </table>
    </div>

<% if (ailment != null && !ailment.trim().isEmpty()) { %>
    <button class="btn-print" onclick="window.print()">Print / Save as PDF</button>
<% } %>

</body>
</html>
