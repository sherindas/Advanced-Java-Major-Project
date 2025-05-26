<%@ page import="java.sql.*" %>
<%@ page import="com.hospital.db.dbConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>View Patients - Hospital Management System</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 30px;
        }
        h2 {
            color: #343a40;
            font-weight: 700;
            margin-bottom: 30px;
            text-align: center;
        }
        .table-wrapper {
            background: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgb(0 0 0 / 0.1);
        }
        table th {
            background-color: #0d6efd;
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            font-size: 0.9rem;
            text-align: center; /* center headers */
        }
        table td {
            vertical-align: middle;
            text-align: center; /* center data */
        }
        .btn-edit {
            background-color: #0d6efd;
            border: none;
        }
        .btn-edit:hover {
            background-color: #0b5ed7;
        }
        .btn-delete {
            background-color: #dc3545;
            border: none;
        }
        .btn-delete:hover {
            background-color: #bb2d3b;
        }
        @media (max-width: 767px) {
            .table-responsive {
                overflow-x: auto;
            }
        }
        .search-box {
            margin-bottom: 20px;
            text-align: center;
        }
        .search-box input[type="text"] {
            width: 300px;
            max-width: 100%;
            display: inline-block;
            padding: 8px 12px;
            font-size: 1rem;
            border: 1px solid #ced4da;
            border-radius: 4px 0 0 4px;
            outline: none;
        }
        .search-box button {
            padding: 8px 16px;
            font-size: 1rem;
            border: 1px solid #0d6efd;
            background-color: #0d6efd;
            color: white;
            border-radius: 0 4px 4px 0;
            cursor: pointer;
        }
        .search-box button:hover {
            background-color: #0b5ed7;
        }
    </style>
</head>
<body>

<div class="container table-wrapper">
    <h2>All Patients</h2>

    <!-- Search form -->
    <div class="search-box">
        <form method="get" action="PatientDisplay.jsp">
            <input type="text" name="search" placeholder="Search by patient or doctor name..." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>" />
            <button type="submit">Search</button>
        </form>
    </div>

    <div class="table-responsive">
        <table class="table table-hover align-middle">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Age</th>
                    <th>Gender</th>
                    <th>Admission Date</th>
                    <th>Ailment</th>
                    <th>Doctor</th>
                    <th class="text-center">Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
                String search = request.getParameter("search");
                try {
                    Connection con = dbConnection.getConnection();

                    String sql = "SELECT * FROM Patients";
                    if (search != null && !search.trim().isEmpty()) {
                        sql += " WHERE PatientName LIKE ? OR AssignedDoctor LIKE ?";
                    }
                    PreparedStatement ps = con.prepareStatement(sql);

                    if (search != null && !search.trim().isEmpty()) {
                        String param = "%" + search.trim() + "%";
                        ps.setString(1, param);
                        ps.setString(2, param);
                    }

                    ResultSet rs = ps.executeQuery();

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
                    <td class="text-center">
                        <a href="editPatient.jsp?id=<%= rs.getInt("PatientID") %>" class="btn btn-sm btn-edit me-2" title="Edit Patient">Edit</a>
                        <a href="PatientDelete.jsp?id=<%= rs.getInt("PatientID") %>" 
                           class="btn btn-sm btn-delete" 
                           onclick="return confirm('Are you sure you want to delete this patient?');"
                           title="Delete Patient">Delete</a>
                    </td>
                </tr>
            <%
                    }
                    if (!found) {
            %>
                <tr>
                    <td colspan="8" class="text-center">No 	Data Found.</td>
                </tr>
            <%
                    }
                    rs.close();
                    ps.close();
                    con.close();
                } catch (Exception e) {
            %>
                <tr>
                    <td colspan="8" class="text-danger text-center">Error: <%= e.getMessage() %></td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
