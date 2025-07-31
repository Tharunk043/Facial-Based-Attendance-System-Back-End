<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Face Recognition Attendance</title>
    <style>
        /* General Styling */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            color: #333;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        h2 {
            margin-top: 20px;
            font-size: 2.5rem;
            color: #2c3e50;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* ✅ Original Loader Styling */
        .loader-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 70vh;
        }

        .loader {
            position: relative;
            width: 2.5em;
            height: 2.5em;
            transform: rotate(165deg);
        }

        .loader:before, .loader:after {
            content: "";
            position: absolute;
            top: 50%;
            left: 50%;
            display: block;
            width: 0.5em;
            height: 0.5em;
            border-radius: 0.25em;
            transform: translate(-50%, -50%);
        }

        .loader:before {
            animation: before8 2s infinite;
        }

        .loader:after {
            animation: after6 2s infinite;
        }

        @keyframes before8 {
            0% { width: 0.5em; box-shadow: 1em -0.5em rgba(225, 20, 98, 0.75), -1em 0.5em rgba(111, 202, 220, 0.75); }
            35% { width: 2.5em; box-shadow: 0 -0.5em rgba(225, 20, 98, 0.75), 0 0.5em rgba(111, 202, 220, 0.75); }
            70% { width: 0.5em; box-shadow: -1em -0.5em rgba(225, 20, 98, 0.75), 1em 0.5em rgba(111, 202, 220, 0.75); }
            100% { box-shadow: 1em -0.5em rgba(225, 20, 98, 0.75), -1em 0.5em rgba(111, 202, 220, 0.75); }
        }

        @keyframes after6 {
            0% { height: 0.5em; box-shadow: 0.5em 1em rgba(61, 184, 143, 0.75), -0.5em -1em rgba(233, 169, 32, 0.75); }
            35% { height: 2.5em; box-shadow: 0.5em 0 rgba(61, 184, 143, 0.75), -0.5em 0 rgba(233, 169, 32, 0.75); }
            70% { height: 0.5em; box-shadow: 0.5em -1em rgba(61, 184, 143, 0.75), -0.5em 1em rgba(233, 169, 32, 0.75); }
            100% { box-shadow: 0.5em 1em rgba(61, 184, 143, 0.75), -0.5em -1em rgba(233, 169, 32, 0.75); }
        }

        /* Video Feed Styling */
        .video-container {
            display: none;
            justify-content: center;
            align-items: center;
            height: 80vh;
            width: 100%;
            max-width: 900px;
            margin: 20px auto;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            overflow: hidden;
            background: #fff;
        }

        #video-feed {
            width: 100%;
            height: auto;
            border-radius: 10px;
        }

        /* Responsive Design */
        @media (max-width: 762px) {
            h2 {
                font-size: 2rem;
            }

            .video-container {
                height: 50vh;
            }
        }

        @media (max-width: 480px) {
            h2 {
                font-size: 1.5rem;
            }

            .video-container {
                height: 40vh;
            }
        }
    </style>
</head>
<body>
    <h2>Face Recognition Attendance System</h2>

    <!-- ✅ Loader (Visible on Page Load) -->
    <div id="loader-container" class="loader-container">
        <div class="loader"></div>
    </div>

    <!-- Video Feed (Initially Hidden) -->
    <div id="video-container" class="video-container">
        <img id="video-feed" src="http://localhost:5001/video_feed" alt="Video Feed" />
    </div>

    <script>
        // ✅ Increase Load Time by 5 Seconds (5000ms)
        document.getElementById("video-feed").onload = function () {
            setTimeout(() => {
                document.getElementById("loader-container").style.display = "none";
                document.getElementById("video-container").style.display = "flex";
            }, 4000); // ⏳ Extra 4s delay
        };

        // ✅ Auto Shutdown Flask When Tab Closes
        window.addEventListener("beforeunload", function () {
            navigator.sendBeacon("http://localhost:5001/shutdown");
        });
    </script>
</body>
</html>