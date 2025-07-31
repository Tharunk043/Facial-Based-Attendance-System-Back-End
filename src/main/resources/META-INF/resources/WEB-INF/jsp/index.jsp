<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Facial Recognition Attendance System</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
	<!-- AOS Library CSS -->
	<link rel="stylesheet" href="https://unpkg.com/aos@2.3.1/dist/aos.css">
	<script src="https://unpkg.com/gsap@3.12.2/dist/gsap.min.js"></script>
	<script src="https://unpkg.com/gsap@3.12.2/dist/ScrollTrigger.min.js"></script>


    <!-- Custom CSS -->
    <style>
        /* Custom Styles */
		body {
		    font-family: 'Poppins', sans-serif;
		}

		/* Custom Navbar Styles */
		.navbar {
		    background: linear-gradient(135deg, #4B0082, #8A2BE2); /* Violet gradient */
		    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2); /* Subtle shadow */
		    padding: 10px 0;
			position: sticky; /* Make the navbar sticky */
			top: 0; /* Stick to the top of the page */
			z-index: 1000; 
		}

		.navbar-brand {
		    display: flex;
		    align-items: center;
		    font-size: 24px;
		    font-weight: 600;
		    color: #fff !important;
		    transition: transform 0.3s ease;
		}

		.navbar-brand:hover {
		    transform: scale(1.05); /* Slight scale on hover */
		}

		.brand-logo {
		    margin-right: 10px;
		    border-radius: 50%; /* Rounded logo */
		    border: 2px solid #fff; /* White border */
		    transition: transform 0.3s ease;
		}

		.brand-logo:hover {
		    transform: rotate(360deg); /* Rotate logo on hover */
		}

		.brand-text {
		    color: #fff;
		}

		.navbar-nav .nav-item {
		    margin: 0 10px;
		}

		.navbar-nav .nav-link {
		    color: #fff !important;
		    font-size: 16px;
		    font-weight: 500;
		    display: flex;
		    align-items: center;
		    padding: 10px 15px;
		    border-radius: 25px; /* Rounded links */
		    transition: all 0.3s ease;
		}

		.navbar-nav .nav-link i {
		    margin-right: 8px;
		    font-size: 20px;
		    transition: transform 0.3s ease;
		}

		.navbar-nav .nav-link:hover {
		    background: rgba(255, 255, 255, 0.1); /* Light background on hover */
		    transform: translateY(-5px);
			
		}

		.navbar-nav .nav-link:hover i {
		    transform: scale(1.2); 
			transform: rotate(360deg); /* spin effect *//* Enlarge icon on hover */
		}
		.nav-link::after {
		  content: '';
		  position: absolute;
		  width: 0;
		  height: 2px;
		  background-color: white;
		  left: 50%;
		  bottom: 0;
		  transition: all 0.4s ease;
		  transform: translateX(-50%);
		}

		.nav-link:hover::after {
		  width: 100%;
		}
		.navbar-toggler {
		    border: none;
		    outline: none;
		}

		.navbar-toggler-icon {
		    background-image: url("data:image/svg+xml;charset=utf8,%3Csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath stroke='rgba(255, 255, 255, 1)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E");
		}

		/* Responsive Adjustments */
		@media (max-width: 992px) {
		    .navbar-nav .nav-link {
		        padding: 10px;
		        margin: 5px 0;
		        text-align: center;
		    }

		    .navbar-nav .nav-link i {
		        margin-right: 0;
		        margin-bottom: 5px;
		    }
		}

		.carousel-container {
		    max-height: 600px; /* Adjust height as needed */
		    overflow: hidden;
		    border-radius: 2px; /* Rounded corners */
		    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2); /* Subtle shadow */
		}

		.carousel-item {
		    position: relative;
		    transition: transform 0.5s ease, opacity 0.5s ease;
		}

		.carousel-item img {
		    width: 100%;
		    height: 600px; /* Fixed height for consistency */
		    object-fit: cover; /* Ensure images cover the area */
		    filter: brightness(0.7); /* Darken images for better text visibility */
		    transition: filter 0.5s ease;
		}

		.carousel-item:hover img {
		    filter: brightness(0.5); /* Darken further on hover */
		}

		.carousel-caption {
		    position: absolute;
		    bottom: 20%;
		    left: 50%;
		    transform: translateX(-50%);
		    text-align: center;
		    background: rgba(75, 0, 130, 0.7); /* Semi-transparent violet background */
		    padding: 20px;
		    border-radius: 10px;
		    width: 80%;
		    max-width: 600px;
		    transition: opacity 0.6s ease, transform 0.6s ease;
		}

		.carousel-caption h2 {
		    font-size: 36px;
		    margin-bottom: 10px;
		    color: #fff;
		    animation: fadeInUp 1s ease;
		}

		.carousel-caption p {
		    font-size: 18px;
		    color: #E6E6FA; /* Light violet text */
		    animation: fadeInUp 1.5s ease;
		}

		.carousel-control-prev,
		.carousel-control-next {
		    width: 50px;
		    height: 50px;
		    background: rgba(75, 0, 130, 0.7); /* Semi-transparent violet background */
		    border-radius: 50%;
		    top: 50%;
		    transform: translateY(-50%);
		    opacity: 0.7;
		    transition: opacity 0.3s ease, background 0.3s ease;
		}

		.carousel-control-prev:hover,
		.carousel-control-next:hover {
		    opacity: 1;
		    background: #8A2BE2; /* Bright violet on hover */
		}

		.carousel-control-prev-icon,
		.carousel-control-next-icon {
		    filter: invert(1); /* White arrows */
		}

		.carousel-indicators button {
		    background-color: #8A2BE2; /* Bright violet */
		    border: none;
		    width: 10px;
		    height: 10px;
		    border-radius: 50%;
		    margin: 0 5px;
		    opacity: 0.7;
		    transition: opacity 0.3s ease, transform 0.3s ease;
		}

		.carousel-indicators button.active {
		    opacity: 1;
		    transform: scale(1.5); /* Enlarge active indicator */
		}

		/* Animations */
		@keyframes fadeInUp {
		    from {
		        opacity: 0;
		        transform: translateY(20px);
		    }
		    to {
		        opacity: 1;
		        transform: translateY(0);
		    }
		}
		.features,
		#how-it-works,
		.pricing {
		    padding: 80px 0;
		    text-align: center;
		}

		.features h2,
		.how-it-works h2,
		.pricing h2 {
		    font-size: 36px;
		    margin-bottom: 40px;
		    color: #4B0082; /* Dark violet for headings */
		}

		.feature-card,
		.step-card,
		.price-card {
		    background: linear-gradient(135deg, #ffffff, #E6E6FA); /* White to light violet gradient */
		    padding: 30px;
		    border-radius: 15px;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		    margin-bottom: 20px;
		    text-align: center;
		    transition: transform 0.3s ease, box-shadow 0.3s ease, background 0.3s ease;
		}

		.feature-card:hover,
		.step-card:hover,
		.price-card:hover {
		    transform: translateY(-20px);
		    box-shadow: 0 12px 24px rgba(75, 0, 130, 0.2); /* Violet shadow */
		    background: linear-gradient(135deg, #9400D3, #FFD700); /* Violet gradient on hover */
		    color: #fff;
		}

		.feature-card:hover h3,
		.step-card:hover h3,
		.price-card:hover h3 {
		    color: #fff;
		}

		.feature-card:hover p,
		.step-card:hover p,
		.price-card:hover p {
		    color: #fff;
		}

		.feature-card img,
		.step-card img {
		    width: 50px;
		    margin-bottom: 20px;
		}

		.price-card h3 {
		    font-size: 24px;
		    margin-bottom: 20px;
		    color: #4B0082; /* Dark violet for card headings */
		}

		.price-card p {
		    font-size: 20px;
		    font-weight: 600;
		    color: #8A2BE2; /* Bright violet for price text */
		}

		.price-card ul {
		    list-style: none;
		    padding: 0;
		    margin: 20px 0;
		}

		.price-card ul li {
		    margin-bottom: 10px;
		    color: #333; /* Dark text for list items */
		}

		footer {
		    background-color: #4B0082; /* Dark violet background */
		    color: #fff;
		    padding: 60px 0 20px;
		    font-family: 'Poppins', sans-serif;
		}

		.footer-container {
		    display: flex;
		    flex-wrap: wrap;
		    justify-content: space-between;
		    max-width: 1200px;
		    margin: 0 auto;
		    padding: 0 20px;
		}

		.footer-column {
		    flex: 1;
		    min-width: 200px;
		    margin-bottom: 40px;
		}

		.footer-column h3 {
		    font-size: 20px;
		    margin-bottom: 20px;
		    color: #fff;
		    position: relative;
		}

		.footer-column h3::after {
		    content: '';
		    position: absolute;
		    left: 0;
		    bottom: -10px;
		    width: 50px;
		    height: 2px;
		    background-color: #8A2BE2; /* Bright violet accent */
		}

		.footer-column p {
		    font-size: 14px;
		    line-height: 1.6;
		    color: #E6E6FA; /* Light violet text */
		}

		.footer-column ul {
		    list-style: none;
		    padding: 0;
		}

		.footer-column ul li {
		    margin-bottom: 10px;
		}

		.footer-column ul li a {
		    color: #E6E6FA; /* Light violet text */
		    text-decoration: none;
		    transition: color 0.3s ease;
		}

		.footer-column ul li a:hover {
		    color: #8A2BE2; /* Bright violet on hover */
		}

		.footer-bottom {
		    text-align: center;
		    padding: 20px 0;
		    border-top: 1px solid rgba(255, 255, 255, 0.1);
		    margin-top: 40px;
		}

		.footer-bottom p {
		    font-size: 14px;
		    color: #E6E6FA; /* Light violet text */
		    margin: 0;
		}

		/* Social Media Icons */
		.wrapper {
		    display: inline-flex;
		    list-style: none;
		    height: 120px;
		    width: 100%;
		    padding-top: 20px;
		    font-family: "Poppins", sans-serif;
		    justify-content: flex-start;
		}

		.wrapper .icon {
		    position: relative;
		    background: black;
		    border-radius: 50%;
		    margin: 10px;
		    width: 50px;
		    height: 50px;
		    font-size: 18px;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    flex-direction: column;
		    box-shadow: 0 10px 10px rgba(0, 0, 0, 0.1);
		    cursor: pointer;
		    transition: all 0.2s cubic-bezier(0.68, -0.55, 0.265, 1.55);
		}

		.wrapper .tooltip {
		    position: absolute;
		    top: 0;
		    font-size: 14px;
		    background: #fff;
		    color: #fff;
		    padding: 5px 8px;
		    border-radius: 5px;
		    box-shadow: 0 10px 10px rgba(0, 0, 0, 0.1);
		    opacity: 0;
		    pointer-events: none;
		    transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
		}

		.wrapper .tooltip::before {
		    position: absolute;
		    content: "";
		    height: 8px;
		    width: 8px;
		    background: #fff;
		    bottom: -3px;
		    left: 50%;
		    transform: translate(-50%) rotate(45deg);
		    transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
		}

		.wrapper .icon:hover .tooltip {
		    top: -45px;
		    opacity: 1;
		    visibility: visible;
		    pointer-events: auto;
		}

		.wrapper .icon:hover span,
		.wrapper .icon:hover .tooltip {
		    text-shadow: 0px -1px 0px rgba(0, 0, 0, 0.1);
		}

		.wrapper .facebook:hover,
		.wrapper .facebook:hover .tooltip,
		.wrapper .facebook:hover .tooltip::before {
		    background: #1877f2;
		    color: #fff;
		}

		.wrapper .twitter:hover,
		.wrapper .twitter:hover .tooltip,
		.wrapper .twitter:hover .tooltip::before {
		    background: #1da1f2;
		    color: #fff;
		}

		.wrapper .instagram:hover,
		.wrapper .instagram:hover .tooltip,
		.wrapper .instagram:hover .tooltip::before {
		    background: #e4405f;
		    color: #fff;
		}

		/* How It Works Section */
		.how-it-works {
		    padding: 80px 0;
		    background-color: #f5f5f5; /* Light gray background for contrast */
		    text-align: center;
		}

		.how-it-works h2 {
		    font-size: 36px;
		    margin-bottom: 40px;
		    color: #4B0082; /* Dark violet for headings */
		}

		.step-card {
		    background: linear-gradient(135deg, #ffffff, #E6E6FA); /* White to light violet gradient */
		    padding: 30px;
		    border-radius: 15px;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		    margin-bottom: 20px;
		    text-align: center;
		    transition: transform 0.3s ease, box-shadow 0.3s ease, background 0.3s ease;
		}

		.step-card:hover {
		    transform: translateY(-20px);
		    box-shadow: 0 12px 24px rgba(75, 0, 130, 0.2); /* Violet shadow */
		    background: linear-gradient(135deg, #9400D3, #FFD700); /* Violet gradient on hover */
		    color: #fff;
		}

		.step-card i {
		    color: #8A2BE2; /* Bright violet for icons */
		    margin-bottom: 20px;
		    transition: color 0.3s ease;
		}

		.step-card:hover i {
		    color: #fff; /* White on hover */
		}

		.step-card h3 {
		    font-size: 24px;
		    margin-bottom: 15px;
		    color: #4B0082; /* Dark violet for headings */
		    transition: color 0.3s ease;
		}

		.step-card:hover h3 {
		    color: #fff; /* White on hover */
		}

		.step-card p {
		    font-size: 16px;
		    color: #666; /* Gray text */
		    transition: color 0.3s ease;
		}

		.step-card:hover p {
		    color: #fff; /* White on hover */
		}

		/* Additional Animations */
		@keyframes fadeIn {
		    from {
		        opacity: 0;
		        transform: translateY(20px);
		    }
		    to {
		        opacity: 1;
		        transform: translateY(0);
		    }
		}

		.feature-card,
		.step-card,
		.price-card {
		    animation: fadeIn 0.5s ease-out;
		}
		/* Main container for the slider */
		.slider-container {
		  display: flex;
		  align-items: center;
		  justify-content: center;
		  width: 100%;
		  height: 100vh;
		  overflow: hidden;
		}

		/* Wrapper for the slider items */
		.slider-wrapper {
		  display: flex;
		  width: 80vw;
		  height: 80vh;
		  transition: transform 0.5s ease-in-out;
		}

		/* Individual slider items */
		.slider-item {
		  position: relative;
		  flex: 1;
		  overflow: hidden;
		  transition: all 0.5s ease-in-out;
		}

		/* Style for images inside slider items */
		.slider-item img {
		  width: 100%;
		  height: 100%;
		  object-fit: cover;
		  transition: filter 0.5s ease-in-out;
		}

		/* Blur effect for non-hovered images */
		.slider-wrapper:hover .slider-item:not(:hover) img {
		  filter: blur(3px); /* Apply blur to all images except the hovered one */
		}

		/* Remove blur and expand the hovered item */
		.slider-item:hover {
		  flex: 5;
		}

		.slider-item:hover img {
		  filter: blur(0); /* Remove blur for the hovered image */
		}
		/* Style for captions */
		.caption {
		  position: absolute;
		  bottom: 20px; /* Position at the bottom of the slide */
		  left: 50%;
		  transform: translateX(-50%); /* Center the caption horizontally */
		  color: white;
		  background: rgba(0, 0, 0, 0.6); /* Semi-transparent black background */
		  padding: 10px 20px;
		  border-radius: 5px;
		  font-size: 18px;
		  font-family: Arial, sans-serif;
		  text-align: center;
		  opacity: 0; /* Initially hidden */
		  transition: opacity 0.5s ease-in-out; /* Smooth fade-in effect */
		}

		/* Show caption on hover */
		.slider-item:hover .caption {
		  opacity: 1; /* Make caption visible */
		}
		
	</style>
</head>

<body>

	<script src='https://cdn.jotfor.ms/s/umd/latest/for-embedded-agent.js'></script>
	<script>
	  window.addEventListener("DOMContentLoaded", function() {
	    window.AgentInitializer.init({
	      agentRenderURL: "https://agent.jotform.com/0195ad43ca2574048a77d553aa3cf704e65d",
	      rootId: "JotformAgent-0195ad43ca2574048a77d553aa3cf704e65d",
	      formID: "0195ad43ca2574048a77d553aa3cf704e65d",
	      queryParams: ["skipWelcome=1", "maximizable=1"],
	      domain: "https://www.jotform.com",
	      isDraggable: false,
	      background: "linear-gradient(180deg, #4252da 0%, #6C73A8 100%)",
	      buttonBackgroundColor: "#0066C3",
	      buttonIconColor: "#FFFFFF",
	      variant: false,
	      customizations: {
	        "greeting": "Yes",
	        "greetingMessage": "Hi! How can I assist you?",
	        "pulse": "Yes",
	        "position": "right"
	      },
	      isVoice: undefined
	    });
	  });
	</script>
    <!-- Navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-violet" data-aos="flip-left" data-aos-delay="500">
	    <div class="container">
	        <!-- Brand Logo -->
	        <a class="navbar-brand" href="/faceAttend">
	            <img src="https://t4.ftcdn.net/jpg/10/69/75/35/240_F_1069753576_nSzuLk7KL2y3wSR8fm08jcCovxOf6mkJ.jpg" height="60px" width="60px" class="brand-logo">
	            <span class="brand-text">FaceAttend</span>
	        </a>

	        <!-- Toggle Button -->
	        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	            <span class="navbar-toggler-icon"></span>
	        </button>

	        <!-- Navbar Links -->
	        <div class="collapse navbar-collapse" id="navbarNav">
	            <ul class="navbar-nav ms-auto">
	                <li class="nav-item">
	                    <a class="nav-link" href="#features">
	                        <i class="fas fa-trophy"></i> Features
	                    </a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="#how-it-works">
	                        <i class="fas fa-cog"></i> How It Works?
	                    </a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="/register">
	                        <i class="fas fa-user-plus"></i> Register
	                    </a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="/contact">
	                        <i class="fas fa-phone-alt"></i> Contact
	                    </a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="/attendance">
	                        <i class="fa fa-list"></i> Attendance
	                    </a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="python/run">
	                        <i class="fas fa-smile"></i> Mark Attendance
	                    </a>
	                </li>
	            </ul>
	        </div>
	    </div>
	</nav>

    <!-- Carousel -->
	<div id="carouselExampleCaptions" class="carousel slide carousel-container" data-bs-ride="carousel" data-aos="fade-up" data-aos-delay="300">
	    <div class="carousel-indicators">
	        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
	        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
	        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
	    </div>
	    <div class="carousel-inner">
	        <div class="carousel-item active">
	            <img src="https://empmonitor.com/blog/wp-content/uploads/2024/11/What-Is-a-Facial-Recognition-Attendance-System-1024x576.webp" class="d-block w-100" alt="Image 1">
	            <div class="carousel-caption">
	                <h2>Effortless Attendance Tracking</h2>
	                <p>Say goodbye to manual attendance with our facial recognition system.</p>
	            </div>
	        </div>
	        <div class="carousel-item">
	            <img src="https://img.freepik.com/free-photo/facial-recognition-software_52683-104208.jpg" class="d-block w-100" alt="Image 2">
	            <div class="carousel-caption">
	                <h2>Real-Time Data</h2>
	                <p>Get instant updates on attendance with our advanced dashboard.</p>
	            </div>
	        </div>
	        <div class="carousel-item">
	            <img src="https://png.pngtree.com/thumb_back/fh260/background/20230702/pngtree-revolutionary-technology-advanced-facial-recognition-system-with-cutting-edge-3d-scanning-image_3726614.jpg" class="d-block w-100" alt="Image 3">
	            <div class="carousel-caption">
	                <h2>Secure and Reliable</h2>
	                <p>Your data is safe with our encrypted storage system.</p>
	            </div>
	        </div>
	    </div>
	    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
	        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	        <span class="visually-hidden">Previous</span>
	    </button>
	    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
	        <span class="carousel-control-next-icon" aria-hidden="true"></span>
	        <span class="visually-hidden">Next</span>
	    </button>
	</div>

    <!-- Features Section -->
	<section id="features" class="features">
	  <div class="container">
	    <h2>Why Choose Our System?</h2>
	    <div class="row">
	      <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
	        <div class="feature-card">
	          <i class="fas fa-clock fa-3x"></i>
	          <h3>Real-Time Tracking</h3>
	          <p>Record attendance with facial scans.</p>
	        </div>
	      </div>
	      <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
	        <div class="feature-card">
	          <i class="fas fa-bullseye fa-3x"></i>
	          <h3>High Accuracy</h3>
	          <p>Advanced AI ensures 99.9% accuracy.</p>
	        </div>
	      </div>
	      <div class="col-md-4" data-aos="fade-up" data-aos-delay="500">
	        <div class="feature-card">
	          <i class="fas fa-hand-paper fa-3x"></i>
	          <h3>Contactless Solution</h3>
	          <p>Hygienic and safe for all environments.</p>
	        </div>
	      </div>
	    </div>
	  </div>
	</section>
<!-- How It Works Section -->
<section id="how-it-works" class="how-it-works">
  <div class="container">
    <h2>How It Works</h2>
    <div class="row">
      <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
        <a href="/setup" style="text-decoration: none; color: inherit;">
          <div class="step-card">
            <i class="fas fa-upload fa-3x"></i>
            <h3>1. Setup</h3>
            <p>Upload your photos.</p>
          </div>
        </a>
      </div>
      <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
        <a href="/register" style="text-decoration: none; color: inherit;">
          <div class="step-card">
            <i class="fas fa-camera fa-3x"></i>
            <h3>2. Scan</h3>
            <p>Scan your face.</p>
          </div>
        </a>
      </div>
      <div class="col-md-4" data-aos="fade-up" data-aos-delay="500">
        <a href="/attendance" style="text-decoration: none; color: inherit;">
          <div class="step-card">
            <i class="fas fa-chart-line fa-3x"></i>
            <h3>3. Track</h3>
            <p>Track real-time attendance.</p>
          </div>
        </a>
      </div>
    </div>
  </div>
</section>
	<div class="slider-container" data-aos="fade-up" data-aos-delay="300">
	  <div class="slider-wrapper">
	    <div class="slider-item">
	      <img src="https://img.freepik.com/free-photo/retinal-biometrics-technology-with-man-s-eye-digital-remix_53876-108518.jpg?ga=GA1.1.1201697762.1742112181&semt=ais_hybrid" alt="Image 1">
		  <div class="caption">Employee Check-In</div>
	    </div>
	    <div class="slider-item">
	      <img src="https://img.freepik.com/free-photo/face-recognition-personal-identification-collage_23-2150165608.jpg?ga=GA1.1.1201697762.1742112181&semt=ais_hybrid" alt="Image 2">
		  <div class="caption">Facial Recognition</div>
	  </div>
	    <div class="slider-item">
	      <img src="https://img.freepik.com/free-photo/facial-recognition-collage-concept_23-2150038898.jpg?ga=GA1.1.1201697762.1742112181&semt=ais_hybrid" alt="Image 3">
		  <div class="caption">Attendance Tracking</div>
	  </div>
	    <div class="slider-item">
	      <img src="https://img.freepik.com/premium-photo/modern-biometric-door-lock_462685-12982.jpg?ga=GA1.1.1201697762.1742112181&semt=ais_hybrid" alt="Image 4">
		  <div class="caption">Office Entrance</div>  
	  </div>
	    <div class="slider-item">
	      <img src="https://img.freepik.com/free-photo/face-recognition-personal-identification-collage_23-2150165615.jpg?t=st=1742112682~exp=1742116282~hmac=5adf67bff35a80aa1a463c385bc8568df002d3ca2a0b45d51d149f6069c53516&w=996" alt="Image 5">
		  <div class="caption">Team Collaboration</div>  
	  </div>
	  </div>
	</div>
	<div class="name-box" id="nameBox"></div>

    <!-- Footer -->
	<footer>
	    <div class="footer-container" data-aos="flip-left" data-aos-delay="50">
	        <!-- Footer Columns -->
	        <div class="footer-column">
	            <h3>About Us</h3>
	            <p>We are a creative team dedicated to building amazing products and experiences for our users.</p>
	        </div>
	        <div class="footer-column">
	            <h3>Quick Links</h3>
	            <ul>
	                <li><a href="#">Home</a></li>
	                <li><a href="#">Features</a></li>
	                <li><a href="#">How It Works</a></li>
	                <li><a href="#">Pricing</a></li>
	                <li><a href="#">Contact</a></li>
	            </ul>
	        </div>
	        <div class="footer-column">
	            <h3>Contact Us</h3>
	            <p>Email: info@example.com</p>
	            <p>Phone: +123 456 7890</p>
	            <p>Address: 123 Violet Lane, City, Country</p>
	        </div>
	        <div class="footer-column">
	            <h3>Follow Us</h3>
	            <!-- Social Media Icons -->
	            <ul class="wrapper">
	                <li class="icon facebook">
	                    <span class="tooltip">Facebook</span>
	                    <svg
	                        viewBox="0 0 320 512"
	                        height="1.2em"
	                        fill="currentColor"
	                        xmlns="http://www.w3.org/2000/svg"
	                    >
	                        <path
	                            d="M279.14 288l14.22-92.66h-88.91v-60.13c0-25.35 12.42-50.06 52.24-50.06h40.42V6.26S260.43 0 225.36 0c-73.22 0-121.08 44.38-121.08 124.72v70.62H22.89V288h81.39v224h100.17V288z"
	                        ></path>
	                    </svg>
	                </li>
	                <li class="icon twitter">
	                    <span class="tooltip">Twitter</span>
	                    <svg
	                        height="1.8em"
	                        fill="currentColor"
	                        viewBox="0 0 48 48"
	                        xmlns="http://www.w3.org/2000/svg"
	                        class="twitter"
	                    >
	                        <path
	                            d="M42,12.429c-1.323,0.586-2.746,0.977-4.247,1.162c1.526-0.906,2.7-2.351,3.251-4.058c-1.428,0.837-3.01,1.452-4.693,1.776C34.967,9.884,33.05,9,30.926,9c-4.08,0-7.387,3.278-7.387,7.32c0,0.572,0.067,1.129,0.193,1.67c-6.138-0.308-11.582-3.226-15.224-7.654c-0.64,1.082-1,2.349-1,3.686c0,2.541,1.301,4.778,3.285,6.096c-1.211-0.037-2.351-0.374-3.349-0.914c0,0.022,0,0.055,0,0.086c0,3.551,2.547,6.508,5.923,7.181c-0.617,0.169-1.269,0.263-1.941,0.263c-0.477,0-0.942-0.054-1.392-0.135c0.94,2.902,3.667,5.023,6.898,5.086c-2.528,1.96-5.712,3.134-9.174,3.134c-0.598,0-1.183-0.034-1.761-0.104C9.268,36.786,13.152,38,17.321,38c13.585,0,21.017-11.156,21.017-20.834c0-0.317-0.01-0.633-0.025-0.945C39.763,15.197,41.013,13.905,42,12.429"
	                        ></path>
	                    </svg>
	                </li>
	                <li class="icon instagram">
	                    <span class="tooltip">Instagram</span>
	                    <svg
	                        xmlns="http://www.w3.org/2000/svg"
	                        height="1.2em"
	                        fill="currentColor"
	                        class="bi bi-instagram"
	                        viewBox="0 0 16 16"
	                    >
	                        <path
	                            d="M8 0C5.829 0 5.556.01 4.703.048 3.85.088 3.269.222 2.76.42a3.917 3.917 0 0 0-1.417.923A3.927 3.927 0 0 0 .42 2.76C.222 3.268.087 3.85.048 4.7.01 5.555 0 5.827 0 8.001c0 2.172.01 2.444.048 3.297.04.852.174 1.433.372 1.942.205.526.478.972.923 1.417.444.445.89.719 1.416.923.51.198 1.09.333 1.942.372C5.555 15.99 5.827 16 8 16s2.444-.01 3.298-.048c.851-.04 1.434-.174 1.943-.372a3.916 3.916 0 0 0 1.416-.923c.445-.445.718-.891.923-1.417.197-.509.332-1.09.372-1.942C15.99 10.445 16 10.173 16 8s-.01-2.445-.048-3.299c-.04-.851-.175-1.433-.372-1.941a3.926 3.926 0 0 0-.923-1.417A3.911 3.911 0 0 0 13.24.42c-.51-.198-1.092-.333-1.943-.372C10.443.01 10.172 0 7.998 0h.003zm-.717 1.442h.718c2.136 0 2.389.007 3.232.046.78.035 1.204.166 1.486.275.373.145.64.319.92.599.28.28.453.546.598.92.11.281.24.705.275 1.485.039.843.047 1.096.047 3.231s-.008 2.389-.047 3.232c-.035.78-.166 1.203-.275 1.485a2.47 2.47 0 0 1-.599.919c-.28.28-.546.453-.92.598-.28.11-.704.24-1.485.276-.843.038-1.096.047-3.232.047s-2.39-.009-3.233-.047c-.78-.036-1.203-.166-1.485-.276a2.478 2.478 0 0 1-.92-.598 2.48 2.48 0 0 1-.6-.92c-.109-.281-.24-.705-.275-1.485-.038-.843-.046-1.096-.046-3.233 0-2.136.008-2.388.046-3.231.036-.78.166-1.204.276-1.486.145-.373.319-.64.599-.92.28-.28.546-.453.92-.598.282-.11.705-.24 1.485-.276.738-.034 1.024-.044 2.515-.045v.002zm4.988 1.328a.96.96 0 1 0 0 1.92.96.96 0 0 0 0-1.92zm-4.27 1.122a4.109 4.109 0 1 0 0 8.217 4.109 4.109 0 0 0 0-8.217zm0 1.441a2.667 2.667 0 1 1 0 5.334 2.667 2.667 0 0 1 0-5.334z"
	                        ></path>
	                    </svg>
	                </li>
	            </ul>
	        </div>
	    </div>

	    <!-- Footer Bottom -->
	    <div class="footer-bottom">
	        <p>&copy; 2023 Your Company. All Rights Reserved.</p>
	    </div>
	</footer>

    <!-- Bootstrap JS and Dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
	<!-- AOS Library JS -->
	<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
	<script>
	  AOS.init();
	</script>
	

</body>

</html>