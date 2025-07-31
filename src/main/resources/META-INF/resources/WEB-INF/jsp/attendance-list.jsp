<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.faceattend.faceattend.Attendance.Attendance" %>
<!DOCTYPE html>
<html>
<head>
    <title>Attendance Records</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
	<link rel="stylesheet" href="https://unpkg.com/aos@2.3.1/dist/aos.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


	<style>
	    /* General Styling */
		<style>
		    /* General Styling */
		    body {
		        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		        background-color: #f8f9fa;
		        margin: 0;
		        padding: 20px;
		    }

		    h2 {
		        color: #2c3e50;
		        margin-bottom: 20px;
		        font-size: 2.5em;
		        text-align: center;
		        font-weight: 700;
		        letter-spacing: -1px;
		    }

		    /* Search Container */
		    .search-container {
		        margin-bottom: 20px;
		        display: flex;
		        gap: 10px;
		        justify-content: center;
		        align-items: center;
		    }

		    .search-container input {
		        padding: 10px;
		        border-radius: 8px;
		        border: 1px solid #ced4da;
		        width: 300px;
		        transition: border-color 0.3s ease, box-shadow 0.3s ease;
		    }

		    .search-container input:focus {
		        border-color: #6c757d;
		        box-shadow: 0 0 8px rgba(108, 117, 125, 0.3);
		        outline: none;
		    }

		    .search-container button {
		        padding: 10px 20px;
		        border-radius: 8px;
		        border: none;
		        background-color: #6c757d;
		        color: white;
		        cursor: pointer;
		        transition: background-color 0.3s ease, transform 0.2s ease;
		    }

		    .search-container button:hover {
		        background-color: #5a6268;
		        transform: scale(1.05);
		    }

		    .search-container button:active {
		        transform: scale(0.95);
		    }

		    /* Percentage Display */
		    #percentageResult {
		        display: none;
		        margin: 20px auto;
		        padding: 15px;
		        border-radius: 8px;
		        background-color: #e9ecef;
		        border: 1px solid #6c757d;
		        color: #2c3e50;
		        max-width: 600px;
		        text-align: center;
		        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		    }

		    /* Attendance Table */
		    table {
		        width: 100%;
		        border-collapse: collapse;
		        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		        border-radius: 10px;
		        overflow: hidden;
		        background-color: white;
		        margin-bottom: 20px;
		        transition: box-shadow 0.3s ease;
		    }

		    table:hover {
		        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
		    }

		    th, td {
		        padding: 15px;
		        text-align: center;
		        border-bottom: 1px solid #dee2e6;
		    }

		    th {
		        background-color: #30b0c9;
		        color: white;
		        font-weight: bold;
		        text-transform: uppercase;
		        letter-spacing: 1px;
		    }

		    tr:nth-child(even) {
		        background-color: #f8f9fa;
		    }

		    tr:hover {
		        background-color: #e9ecef;
		        transition: background-color 0.3s ease;
		    }

		    /* Buttons */
		    .btn {
		        padding: 8px 15px;
		        text-decoration: none;
		        color: white;
		        border-radius: 8px;
		        font-size: 0.9em;
		        transition: all 0.3s ease;
		        margin: 0 5px;
		    }

		    .btn-delete {
		        background-color: #dc3545;
		    }

		    .btn-delete:hover {
		        background-color: #c82333;
		        transform: scale(1.05);
		    }

		    .btn-update {
		        background-color: #007bff;
		    }

		    .btn-update:hover {
		        background-color: #0056b3;
		        transform: scale(1.05);
		    }

		    /* No Records Message */
		    .no-records {
		        color: #dc3545;
		        font-size: 1.2em;
		        margin-top: 20px;
		        text-align: center;
		    }

		    /* Actions Column */
		    .actions {
		        display: flex;
		        justify-content: center;
		    }

		    /* Chart Container */
		    .chart-container {
		        width: 80%;
		        margin: 20px auto;
		        background-color: white;
		        padding: 20px;
		        border-radius: 10px;
		        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		        transition: box-shadow 0.3s ease;
		    }

		    .chart-container:hover {
		        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
		    }

		    /* Responsive Design */
		    @media (max-width: 768px) {
		        h2 {
		            font-size: 2rem;
		        }

		        .search-container {
		            flex-direction: column;
		        }

		        .search-container input {
		            width: 100%;
		        }

		        .chart-container {
		            width: 100%;
		        }
		    }

		    @media (max-width: 480px) {
		        h2 {
		            font-size: 1.5rem;
		        }

		        th, td {
		            padding: 10px;
		        }

		        .btn {
		            padding: 6px 12px;
		            font-size: 0.8em;
		        }
		    }
			/* Download Button */
			.search-container button.download-btn {
			    background-color: #28a745; /* Green */
				
			}

			.search-container button.download-btn:hover {
			    background-color: #218838; /* Darker Green */
				transform: scale(1.2);
			}

			/* Calculate Percentage Button */
			.search-container button.percentage-btn {
			    background-color: #17a2b8; /* Teal */
			}

			.search-container button.percentage-btn:hover {
			    background-color: #138496; /* Darker Teal */
				transform: scale(1.2);
			}

	</style>
</head>
<body>

    <h2>Attendance Records</h2>
	<script src="https://static.elfsight.com/platform/platform.js" async></script>
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
	
    <!-- Search Bar -->
	<div class="search-container">
	    <input type="text" id="searchInput" placeholder="Enter student name..." onkeyup="filterTable()">
	    <input type="date" id="searchDate" onchange="filterTable()">
	    <button onclick="calculatePercentage()" class="percentage-btn">Calculate Percentage</button>
		<button onclick="downloadExcel()" class="download-btn">Download <i class="fas fa-download"></i></button> 
	</div>

    <!-- Percentage Display -->
    <div id="percentageResult" class="alert alert-info" style="display: none;"></div>

    <!-- Attendance Table -->
    <%
        List<Attendance> attendanceList = (List<Attendance>) request.getAttribute("attendanceList");
        if (attendanceList == null || attendanceList.isEmpty()) {
    %>
        <p class="no-records">No attendance records found.</p>
    <%
        } else {
    %>
    <table id="attendanceTable" >
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Timestamp</th>
            <th>Actions</th>
        </tr>
        <% for (Attendance attendance : attendanceList) { %>
        <tr>
            <td><%= attendance.getId() %></td>
            <td><%= attendance.getName() %></td>
            <td><%= attendance.getTimestamp() %></td>
            <td class="actions">
                <a href="deleteAttendance?id=<%= attendance.getId() %>" class="btn btn-delete">Delete</a>
                <a href="updateAttendance?id=<%= attendance.getId() %>" class="btn btn-update">Update</a>
            </td>
        </tr>
        <% } %>
    </table>
    <% } %>

    <!-- Graph Container -->
	<div class="chart-container">
	       <canvas id="attendanceChart"></canvas>
	   </div>

	<script>
		function downloadExcel() {
		    const dateInput = document.getElementById("searchDate").value; // Get the selected date
		    console.log("Selected date:", dateInput); // Debugging: Log the selected date

		    // Send a POST request to the backend
		    fetch("/downloadExcel", {
		        method: "POST",
		        headers: {
		            "Content-Type": "application/json",
		        },
		        body: JSON.stringify({ date: dateInput }), // Send the date as JSON
		    })
		    .then(response => {
		        if (response.ok) {
		            return response.blob(); // Convert the response to a Blob
		        } else {
		            throw new Error("Failed to download Excel file");
		        }
		    })
		    .then(blob => {
		        // Create a temporary link to trigger the download
		        const url = window.URL.createObjectURL(blob);
		        const a = document.createElement("a");
		        a.href = url;
		        a.download = dateInput ? `${dateInput}.xlsx` : "attendance_records.xlsx"; // Set the file name
		        document.body.appendChild(a);
		        a.click();
		        document.body.removeChild(a);
		        window.URL.revokeObjectURL(url);
		    })
		    .catch(error => {
		        console.error("Error:", error);
		        alert("Failed to download Excel file. Please try again.");
		    });
		}
	    // Filter Table by Name
		function filterTable() {
		    const nameInput = document.getElementById("searchInput").value.toLowerCase();
		    const dateInput = document.getElementById("searchDate").value; // Date in YYYY-MM-DD format
		    const rows = document.querySelectorAll("#attendanceTable tr");

		    rows.forEach((row, index) => {
		        if (index !== 0) { // Skip header row
		            const name = row.cells[1].textContent.toLowerCase();
		            const timestamp = row.cells[2].textContent; // Full timestamp (e.g., "2025-03-17T15:53:50")
		            const date = timestamp.split("T")[0]; // Extract date part (e.g., "2025-03-17")

		            // Check if the name matches and (if date is provided) the date matches
		            const nameMatch = name.includes(nameInput);
		            const dateMatch = dateInput ? date === dateInput : true;

		            row.style.display = nameMatch && dateMatch ? "" : "none";
		        }
		    });
		}
	    // Fetch Attendance Percentage from Backend
		async function calculatePercentage() {
		    const inputField = document.getElementById("searchInput");
		    const resultDiv = document.getElementById("percentageResult");

		    if (!inputField || !resultDiv) {
		        console.error("❌ ERROR: Input field or result div not found!");
		        return;
		    }

		    const studentName = inputField.value.trim();
		    if (studentName === "") {
		        alert("❌ Please enter a student name.");
		        return;
		    }

		    const requestData = { name: studentName };
		    const url = "http://localhost:8080/percentage";

		    console.log("🔍 Sending Request to:", url, "with data:", requestData);

		    try {
		        const response = await fetch(url, {
		            method: "POST",
		            headers: { "Content-Type": "application/json" },
		            body: JSON.stringify(requestData),
		        });

		        console.log("📥 Response received:", response);

		        if (!response.ok) {
		            const errorText = await response.text();
		            console.error(`❌ HTTP Error ${response.status}:`, errorText);
		            alert(`Server error! Status: ${response.status}\n${errorText}`);
		            return;
		        }

		        const data = await response.json();
		        console.log("✅ Data received:", data);

		        // Clear previous results
		        resultDiv.innerHTML = "";

		        if (!isNaN(data)) {
		            // Create a table to display the result
		            const table = document.createElement("table");
		            table.style.borderCollapse = "collapse";
		            table.style.width = "100%";
		            table.style.marginTop = "10px";

		            // Create table rows
		            const row1 = document.createElement("tr");
		            const row2 = document.createElement("tr");

		            // Add headers
		            const header1 = document.createElement("th");
		            header1.textContent = "Student Name";
		            header1.style.border = "1px solid black";
		            header1.style.padding = "8px";
		            header1.style.backgroundColor = "#4CAF50";

		            const header2 = document.createElement("th");
		            header2.textContent = "Attendance Percentage";
		            header2.style.border = "1px solid black";
		            header2.style.padding = "8px";
		            header2.style.backgroundColor = "#4CAF50";

		            row1.appendChild(header1);
		            row1.appendChild(header2);

		            // Add data
		            const cell1 = document.createElement("td");
		            cell1.textContent = studentName;
		            cell1.style.border = "1px solid black";
		            cell1.style.padding = "8px";

		            const cell2 = document.createElement("td");
		            cell2.textContent = data+"%";
		            cell2.style.border = "1px solid black";
		            cell2.style.padding = "8px";

		            row2.appendChild(cell1);
		            row2.appendChild(cell2);

		            // Append rows to the table
		            table.appendChild(row1);
		            table.appendChild(row2);

		            // Append the table to the resultDiv
		            resultDiv.appendChild(table);
		            resultDiv.style.display = "block";
		        } else {
		            resultDiv.textContent = `❌ No records found for ${studentName}.`;
		            resultDiv.style.display = "block";
		            resultDiv.style.color = "red";
		            resultDiv.style.fontWeight = "bold";
		            resultDiv.style.padding = "10px";
		            resultDiv.style.border = "2px solid red";
		        }
		    } catch (error) {
		        console.error("❌ Fetch Error:", error);
		        alert(`Error fetching attendance percentage: ${error.message}`);
		    }
		}
		
	</script>
	<script>
	    // Get Canvas Context
		// Get Canvas Context
		const ctx = document.getElementById('attendanceChart').getContext('2d');

		// Create Gradient Fill
		let gradient = ctx.createLinearGradient(0, 0, 0, 400);
		gradient.addColorStop(0, 'rgba(54, 162, 235, 0.6)');  // Blue
		gradient.addColorStop(1, 'rgba(255, 206, 86, 0.3)');  // Yellow

		// Different colors for each star
		const starColors = [
		    'rgba(255, 99, 132, 1)',  // Red
		    'rgba(54, 162, 235, 1)',  // Blue
		    'rgba(255, 206, 86, 1)',  // Yellow
		    'rgba(75, 192, 192, 1)',  // Teal
		    'rgba(153, 102, 255, 1)', // Purple
		    'rgba(255, 159, 64, 1)',  // Orange
		    'rgba(0, 200, 81, 1)'     // Green
		];

		// Create Chart
		const attendanceChart = new Chart(ctx, {
		    type: 'line',
		    data: {
		        labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
		        datasets: [{
		            label: 'Attendance',
		            data: [12, 19, 3, 5, 2, 3, 10],
		            backgroundColor: gradient, // Gradient Fill
		            borderColor: 'rgba(54, 162, 235, 1)', // Border Color
		            borderWidth: 2,
		            fill: true, // Enable Area Chart
		            pointStyle: 'star', // Star Labels
		            pointRadius: 8, // Size of Stars
		            pointBackgroundColor: starColors, // Array of colors for stars
		            pointBorderColor: 'black', // Border for Stars
		            pointBorderWidth: 2
		        }]
		    },
		    options: {
		        responsive: true,
		        scales: {
		            y: {
		                beginAtZero: true
		            }
		        },
		        plugins: {
		            legend: {
		                labels: {
		                    font: {
		                        size: 14,
		                        weight: 'bold'
		                    }
		                }
		            }
		        }
		    }
		});

	</script>
	<!-- Elfsight AI Chatbot | Untitled AI Chatbot -->
	

</body>
</html>