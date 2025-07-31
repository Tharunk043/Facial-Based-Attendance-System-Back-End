<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Attendance</title>
    
    <!-- Bootstrap and SweetAlert CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Orbitron', sans-serif;
            background-color: #0a0a0a;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            color: #00ffcc;
            overflow: hidden;
            position: relative;
        }

        /* Cursor Glow Effect */
        .cursor-light {
            position: absolute;
            width: 200px;
            height: 200px;
            background: radial-gradient(circle, rgba(0, 255, 204, 0.2) 0%, transparent 70%);
            border-radius: 50%;
            pointer-events: none;
            transition: transform 0.1s ease-out;
            z-index: 1;
            filter: blur(10px);
            animation: cursorGlow 2s infinite alternate;
        }

        @keyframes cursorGlow {
            0% { opacity: 0.8; transform: scale(1); }
            100% { opacity: 1; transform: scale(1.2); }
        }

        /* Form Container */
        .container {
            background: rgba(10, 10, 10, 0.8);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0, 255, 204, 0.5);
            width: 400px;
            text-align: center;
            backdrop-filter: blur(10px);
            border: 2px solid rgba(0, 255, 204, 0.3);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            animation: pulse 3s infinite alternate;
        }

        @keyframes pulse {
            0% { box-shadow: 0 0 20px rgba(0, 255, 204, 0.5); }
            100% { box-shadow: 0 0 40px rgba(0, 255, 204, 0.8); }
        }

        h2 {
            color: #00ffcc;
            text-shadow: 0 0 10px #00ffcc, 0 0 20px #00ffcc;
        }

        .form-control {
            background-color: rgba(20, 20, 20, 0.8);
            border: 2px solid rgba(0, 255, 204, 0.3);
            color: #00ffcc;
        }

        .btn-update {
            background: linear-gradient(45deg, #00ffcc, #00b3ff);
            color: #0a0a0a;
            border: none;
            padding: 12px;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            margin-top: 20px;
        }

        .btn-update:hover {
            box-shadow: 0 0 20px rgba(0, 255, 204, 0.8);
        }
    </style>
</head>
<body>
    <div class="cursor-light"></div>

    <div class="container">
        <h2>Update Attendance</h2>
        
        <form action="${pageContext.request.contextPath}/updateAttendance" method="post">
            <input type="hidden" name="id" value="${attendance.id}">

            <div class="mb-3">
                <label for="name" class="form-label">Name</label>
                <input type="text" id="name" name="name" class="form-control" value="${attendance.name}" required>
            </div>

            <div class="mb-3">
                <label for="timestamp" class="form-label">Timestamp</label>
                <input type="text" id="timestamp" name="timestamp" class="form-control" value="${attendance.timestamp}" readonly>
            </div>

            <button type="submit" class="btn btn-update" onclick="showAlert()">Update Attendance</button>
        </form>
    </div>

    <script>
        document.addEventListener("mousemove", function(e) {
            const cursorLight = document.querySelector(".cursor-light");
            cursorLight.style.transform = `translate(${e.clientX - 100}px, ${e.clientY - 100}px)`;
        });

        function showAlert() {
            Swal.fire({
                icon: 'success',
                title: 'Updated!',
                text: 'Attendance has been successfully updated.',
                showConfirmButton: false,
                timer: 5000,
                timerProgressBar: true
            });
        }
    </script>
</body>
</html>
