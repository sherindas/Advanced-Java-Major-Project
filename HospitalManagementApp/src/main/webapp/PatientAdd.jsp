<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Patient - Hospital Management System</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>
    <style>
        body {
            background: linear-gradient(135deg, #e0f7fa, #ffffff);
            font-family: 'Segoe UI', sans-serif;
        }
        .container {
            max-width: 650px;
            margin-top: 60px;
        }
        .card {
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            background-color: #007bff;
            color: white;
            font-size: 22px;
            font-weight: 600;
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
        }
        .form-group label {
            font-weight: 600;
        }
        .btn-primary {
            width: 100%;
            font-weight: bold;
        }
    </style>
    <script>
        function validateForm() {
            const form = document.forms["patientForm"];
            if (!form.name.value.trim() || !form.age.value || !form.gender.value || !form.admissionDate.value || !form.ailment.value.trim() || !form.doctor.value.trim()) {
                alert("All fields are required.");
                return false;
            }
            if (isNaN(form.age.value) || form.age.value <= 0) {
                alert("Age must be a positive number.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header text-center">
                📝 Register New Patient
            </div>
            <div class="card-body">
                <form name="patientForm" method="post" action="AddPatientServlet" onsubmit="return validateForm()">
                    <div class="form-group">
                        <label for="name">Patient Name</label>
                        <input type="text" name="name" id="name" class="form-control" placeholder="Enter full name">
                    </div>
                    <div class="form-group">
                        <label for="age">Age</label>
                        <input type="number" name="age" id="age" class="form-control" placeholder="Enter age">
                    </div>
                    <div class="form-group">
                        <label for="gender">Gender</label>
                        <select name="gender" id="gender" class="form-control">
                            <option value="">-- Select Gender --</option>
                            <option>Male</option>
                            <option>Female</option>
                            <option>Other</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="admissionDate">Admission Date</label>
                        <input type="date" name="admissionDate" id="admissionDate" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="ailment">Ailment</label>
                        <input type="text" name="ailment" id="ailment" class="form-control" placeholder="Describe ailment">
                    </div>
                    <div class="form-group">
                        <label for="doctor">Assigned Doctor</label>
                        <input type="text" name="doctor" id="doctor" class="form-control" placeholder="Enter doctor's name">
                    </div>
                    <button type="submit" class="btn btn-primary mt-3">➕ Add Patient</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
