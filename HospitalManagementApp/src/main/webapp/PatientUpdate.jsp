<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Patient - Hospital Management System</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <style>
        body {
            background: linear-gradient(to right, #fdfbfb, #ebedee);
            font-family: 'Segoe UI', sans-serif;
        }
        .container {
            max-width: 500px;
            margin-top: 80px;
        }
        .card {
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            background-color: #ffc107;
            color: #212529;
            font-weight: bold;
            font-size: 20px;
            text-align: center;
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
        }
        .btn-warning, .btn-info {
            width: 100%;
            font-weight: bold;
            margin-top: 10px;
        }
        label {
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">
                🔍 Update Patient Record
            </div>
            <div class="card-body">
                <form action="editPatient.jsp" method="get">
                    <div class="form-group mb-3">
                        <label for="id">Enter Patient ID</label>
                        <input type="number" name="id" id="id" class="form-control" placeholder="Patient ID" required />
                    </div>
                    <small class="form-text text-muted mb-3">
                        Please enter Patient ID to search.
                    </small>
                    <button type="submit" class="btn btn-warning">Search Patient</button>
                </form>

                <form action="PatientDisplay.jsp" method="get">
                    <button type="submit" class="btn btn-info">View All Patients</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
