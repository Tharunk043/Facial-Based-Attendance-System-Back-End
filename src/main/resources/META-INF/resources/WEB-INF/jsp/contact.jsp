<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Contact Us</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet" />
  <style>
    body {
      font-family: 'Inter', sans-serif;
      background-color: #f3f4f6;
      margin: 0;
      padding: 0;
    }

    .container {
      padding: 80px 20px;
    }

    .header-title {
      color: #007bff;
      font-weight: 700;
      transition: color 0.3s;
    }

    .header-title:hover {
      color: #0056b3;
    }

    .card-custom {
      background: white;
      border-radius: 15px;
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
      padding: 30px;
      transition: transform 0.3s, box-shadow 0.3s;
      cursor: pointer;
    }

    .card-custom:hover {
      transform: translateY(-8px);
      box-shadow: 0 15px 25px rgba(0, 0, 0, 0.15);
    }

    .icon-custom {
      font-size: 50px;
      color: #007bff;
      margin-bottom: 15px;
      transition: color 0.3s;
    }

    .card-custom:hover .icon-custom {
      color: #0056b3;
    }

    #chat-section {
      margin-top: 60px;
      padding: 40px;
      background-color: #007bff;
      color: white;
      border-radius: 15px;
      transition: background-color 0.3s;
    }

    #chat-section:hover {
      background-color: #0056b3;
    }

    textarea {
      width: 100%;
      border-radius: 8px;
      padding: 12px;
      border: none;
      margin-top: 10px;
    }

    .btn-custom {
      background-color: #0056b3;
      border-radius: 20px;
      padding: 12px 30px;
      color: white;
      border: none;
      transition: background-color 0.3s;
    }

    .btn-custom:hover {
      background-color: #003d80;
    }

    .chat-icon {
      font-size: 60px;
      color: #fff;
      margin-bottom: 20px;
      transition: transform 0.3s;
    }

    #chat-section:hover .chat-icon {
      transform: scale(1.1);
    }

    .btn-light {
      transition: background-color 0.3s, color 0.3s;
    }

    .btn-light:hover {
      background-color: white;
      color: #007bff;
    }
  </style>
</head>
<body>
  <div class="container text-center">
    <h1 class="header-title">Get in Touch</h1>
    <p class="text-muted">We are here to help you. Reach out to us anytime!</p>

    <div class="row mt-5">
      <div class="col-md-4">
        <div class="card-custom">
          <i class="bi bi-envelope-fill icon-custom"></i>
          <h5>Email Us</h5>
          <p>support@example.com</p>
        </div>
      </div>

      <div class="col-md-4">
        <div class="card-custom">
          <i class="bi bi-telephone-fill icon-custom"></i>
          <h5>Call Us</h5>
          <p>+123 456 7890</p>
        </div>
      </div>

      <div class="col-md-4">
        <div class="card-custom">
          <i class="bi bi-geo-alt-fill icon-custom"></i>
          <h5>Visit Us</h5>
          <p>456 Park Avenue, City, Country</p>
        </div>
      </div>
    </div>

    <button class="btn btn-custom mt-4" onclick="window.location.href='mailto:support@example.com'">Contact Us Now</button>

    <!-- Chat Section -->
    <div id="chat-section" class="mt-5">
      <i class="bi bi-chat-dots-fill chat-icon"></i>
      <h3>Chat With Us</h3>
      <p>Need instant help? Send us a message.</p>

	  <button class="btn btn-light mt-3" onclick="window.location.href='/chat'">Start Chat</button>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>