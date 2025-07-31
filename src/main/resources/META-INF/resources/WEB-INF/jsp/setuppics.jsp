<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>IMAGE SETUP</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

    <style>
        body {
            background: linear-gradient(135deg, #f6d365, #fda085);
            min-height: 100vh;
            padding: 20px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .card {
            background: linear-gradient(145deg, #ffffff, #e6e9f0);
            border-radius: 15px;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
        }

        .card-img-top {
            height: 200px;
            object-fit: cover;
            cursor: pointer;
        }

        .preview-container img {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) scale(1.5);
            z-index: 9999;
            border-radius: 20px;
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.4);
            display: none;
            max-width: 80vw;
            max-height: 80vh;
            animation: fadeIn 0.4s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translate(-50%, -50%) scale(1.3); }
            to { opacity: 1; transform: translate(-50%, -50%) scale(1.5); }
        }

        .btn-danger {
            background-color: #ff6b81;
            border: none;
        }

        .btn-danger:hover {
            background-color: #ff4757;
        }
    </style>

    <script>
    function showPreview(imageSrc) {
        const previewImg = document.getElementById('previewImage');
        previewImg.src = imageSrc;
        previewImg.style.display = 'block';
    }

    function hidePreview(event) {
        const previewImg = document.getElementById('previewImage');
        if (!previewImg.contains(event.relatedTarget)) {
            previewImg.style.display = 'none';
        }
    }

    function deleteImage(filename) {
        if (confirm('Are you sure you want to delete ' + filename + '?')) {
            const encodedFilename = encodeURIComponent(filename);
            fetch('/images/deleteImage?filename=' + encodedFilename, { method: 'DELETE' })
                .then(response => {
                    if (response.ok) {
                        alert('Image deleted successfully');
                        location.reload();
                    } else {
                        return response.text().then(text => {
                            alert('Failed to delete image: ' + text);
                        });
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred while deleting the image.');
                });
        }
    }
    </script>
</head>
<body>
    <div class="container mt-5">
        <h1 class="mb-4 text-white">Registered Images</h1>
        <div class="row">
            <% 
                File downloadsDir = new File("/home/velamakuru/Downloads/OS_Lab/exam");
                if (downloadsDir.exists() && downloadsDir.isDirectory()) {
                    File[] files = downloadsDir.listFiles((dir, name) -> name.toLowerCase().endsWith(".jpg") || name.toLowerCase().endsWith(".jpeg"));
                    if (files != null && files.length > 0) {
                        for (File file : files) {
            %>
                            <div class="col-md-3 mb-4">
                                <div class="card">
                                    <img src="/images/<%= file.getName() %>" class="card-img-top" alt="Image not available" 
                                    onmouseenter="showPreview('/images/<%= file.getName() %>')" onmouseleave="hidePreview(event)">
                                    <div class="card-body d-flex justify-content-between">
                                        <p class="card-text text-truncate" title="<%= file.getName() %>"><%= file.getName() %></p>
                                        <button class="btn btn-danger btn-sm" onclick="deleteImage('<%= file.getName() %>')">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
            <%
                        }
                    } else {
            %>
                        <p>No JPG or JPEG images found in OS_Lab.</p>
            <%
                    }
                } else {
            %>
                    <p>OS_Lab folder not found.</p>
            <%
                }
            %>
        </div>
    </div>
    
    <div class="preview-container">
        <img id="previewImage" alt="Preview Image">
    </div>
</body>
</html>
