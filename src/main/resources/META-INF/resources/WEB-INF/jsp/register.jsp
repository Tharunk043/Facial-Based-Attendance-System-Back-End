<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register & Capture Image</title>

    <!-- Bootstrap & FontAwesome CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/js/all.min.js" crossorigin="anonymous"></script>

    <style>
        body {
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        
        .container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
            position: relative;
        }

        .video-wrapper {
            position: relative;
            display: inline-block;
        }

        video {
            width: 100%;
            max-width: 430px;
			height:400;
            border-radius: 10px;
            border: 3px solid #007bff;
            box-shadow: 0px 4px 10px rgba(0, 123, 255, 0.5);
        }

        .face-frame {
            position: absolute;
            top: 20%;
            left: 50%;
            transform: translate(-50%, 0);
            width: 150px;
            height: 200px;
            border: 4px dotted green;
            border-radius: 50%;
            z-index: 2;
        }

        .instruction-text {
            position: absolute;
            top: 5%;
            left: 50%;
            transform: translateX(-50%);
            color: red;
            font-weight: bold;
            background: rgba(255, 255, 255, 0.8);
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 16px;
        }

        .capture-btn {
            background: #007bff;
            color: white;
            border: none;
            padding: 15px 20px;
            border-radius: 50%;
            font-size: 24px;
            box-shadow: 0px 4px 10px rgba(0, 123, 255, 0.5);
            transition: 0.3s;
        }

        .capture-btn:hover {
            background: #0056b3;
            box-shadow: 0px 6px 15px rgba(0, 123, 255, 0.7);
        }

        .hidden {
            display: none;
        }
    </style>
    
    <script>
        let faceDetected = false;

        function captureImage() {
            if (!faceDetected) {
                alert("Align your face in the frame first!");
                return;
            }

            let video = document.querySelector("#videoElement");
            let canvas = document.createElement("canvas");
            let ctx = canvas.getContext("2d");
            canvas.width = video.videoWidth;
            canvas.height = video.videoHeight;
            ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
            
            canvas.toBlob(blob => {
                let formData = new FormData();
                let name = document.querySelector("#name").value;
                formData.append("image", blob, name + ".jpg");
                formData.append("name", name);

                fetch("/upload/capture", {
                    method: "POST",
                    body: formData
                })
                .then(response => response.text())
                .then(data => alert(data))
                .catch(error => alert("Error: " + error));
            }, "image/jpeg");
        }

        function startCamera() {
            navigator.mediaDevices.getUserMedia({ video: true })
                .then(stream => {
                    document.querySelector("#videoElement").srcObject = stream;
                    detectFace();
                })
                .catch(error => console.error("Camera access error:", error));
        }

        function detectFace() {
            let video = document.querySelector("#videoElement");
            let instructionText = document.querySelector(".instruction-text");

            setInterval(() => {
                // Simulating face detection by checking if user is present in the center
                let randomFacePresence = Math.random() > 0.5; // Mock face detection (Replace with real face detection)
                
                if (randomFacePresence) {
                    instructionText.innerText = "Ready to Go!";
                    instructionText.style.color = "green";
                    faceDetected = true;
                } else {
                    instructionText.innerText = "Put your face in the frame";
                    instructionText.style.color = "red";
                    faceDetected = false;
                }
            }, 1000); // Checking every second
        }
    </script>
</head>
<body onload="startCamera()">
    <div class="container">
        <h2 class="mb-3 text-primary">Register & Capture Image</h2>
        
        <div class="mb-3">
            <input type="text" id="name" class="form-control" placeholder="Enter Name" required>
        </div>
        
        <div class="video-wrapper">
            <video id="videoElement" autoplay></video>
            <div class="face-frame"></div>
            <div class="instruction-text">Put your face in the frame</div>
        </div>

        <br><br>

        <button type="button" class="capture-btn" onclick="captureImage()">
			<i class="fas fa-camera-retro fa-2x"></i>
		</button>
    </div>
</body>
</html> 