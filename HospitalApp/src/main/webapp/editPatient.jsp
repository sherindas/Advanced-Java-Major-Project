<%@ page import="com.hospital.model.Patient, com.hospital.dao.PatientDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    Patient patient = PatientDAO.getPatientById(id);
    if (patient == null) {
%>
    <div class="container mt-5">
        <div class="alert alert-danger" role="alert">
            <h4 class="alert-heading">Patient Not Found</h4>
            <p>No patient record found for ID <%= id %>.</p>
        </div>
    </div>
<%
    } else {
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Patient</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <style>
        body {
            background: #f8f9fa;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.15);
        }
        .form-control {
            border-radius: 10px;
        }
        .btn {
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="card mx-auto" style="max-width: 600px;">
            <div class="card-header bg-primary text-white text-center">
                <h3><i class="fas fa-user-edit"></i> Edit Patient Details</h3>
            </div>
            <div class="card-body">
                <form action="UpdatePatientServlet" method="post">
                    <input type="hidden" name="id" value="<%= id %>" />
                    
                    <div class="form-group">
                        <label><i class="fas fa-user"></i> Patient Name</label>
                        <input type="text" name="name" value="<%= patient.getName() %>" class="form-control" required />
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-sort-numeric-up"></i> Age</label>
                        <input type="number" name="age" value="<%= patient.getAge() %>" class="form-control" required />
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-venus-mars"></i> Gender</label>
                        <select name="gender" class="form-control" required>
                            <option <%= patient.getGender().equals("Male") ? "selected" : "" %>>Male</option>
                            <option <%= patient.getGender().equals("Female") ? "selected" : "" %>>Female</option>
                            <option <%= patient.getGender().equals("Other") ? "selected" : "" %>>Other</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-calendar-alt"></i> Admission Date</label>
                        <input type="date" name="admissionDate" value="<%= patient.getAdmissionDate() %>" class="form-control" required />
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-stethoscope"></i> Ailment</label>
                        <input type="text" name="ailment" value="<%= patient.getAilment() %>" class="form-control" required />
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-user-md"></i> Assigned Doctor</label>
                        <input type="text" name="doctor" value="<%= patient.getDoctor() %>" class="form-control" required />
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-success px-4">
                            <i class="fas fa-save"></i> Update Patient
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Optional JavaScript -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%
    }
%>
