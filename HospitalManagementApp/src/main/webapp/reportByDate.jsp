<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Patients Admitted in Date Range</title>
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
        input[type="date"], button {
            padding: 10px 16px;
            margin: 5px 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
            transition: box-shadow 0.3s ease;
        }
        input[type="date"]:focus, button:hover {
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

        /* Date range display above table */
        .print-date-range {
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
            .print-date-range {
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
    <h2>Report: Patients Admitted Between Dates</h2>

    <form method="get" action="reportByDate.jsp">
        Start Date: <input type="date" name="startDate" required
                          value="<%= request.getParameter("startDate") != null ? request.getParameter("startDate") : "" %>">
        End Date: <input type="date" name="endDate" required
                        value="<%= request.getParameter("endDate") != null ? request.getParameter("endDate") : "" %>">
        <button type="submit">Search</button>
    </form>

<%
    String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");
    if (startDate != null && endDate != null) {
        java.sql.Date start = java.sql.Date.valueOf(startDate);
        java.sql.Date end = java.sql.Date.valueOf(endDate);

        if (start.after(end)) {
%>
            <p style="color:red; text-align:center; font-weight:bold;">Start date must be before or equal to end date.</p>
<%
        } else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                java.sql.Connection con = com.hospital.db.dbConnection.getConnection();

                String sql = "SELECT * FROM Patients WHERE AdmissionDate BETWEEN ? AND ?";
                java.sql.PreparedStatement ps = con.prepareStatement(sql);
                ps.setDate(1, start);
                ps.setDate(2, end);

                java.sql.ResultSet rs = ps.executeQuery();
%>

    <div class="print-date-range">
        <p><strong>From Date:</strong> <%= startDate %> &nbsp;&nbsp; <strong>To Date:</strong> <%= endDate %></p>
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
                <tr><td colspan="7" style="text-align:center; font-style:italic;">No patients found in this date range.</td></tr>
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
    }
%>
            </tbody>
        </table>
    </div>

<% if (startDate != null && endDate != null && !startDate.isEmpty() && !endDate.isEmpty()) { %>
    <button class="btn-print" onclick="window.print()">Print / Save as PDF</button>
<% } %>

</body>
</html>
