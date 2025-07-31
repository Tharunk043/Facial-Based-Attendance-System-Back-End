package com.faceattend.faceattend.imageRegister;

import org.springframework.web.bind.annotation.*;
import java.io.*;
import java.nio.charset.StandardCharsets;

@RestController
@RequestMapping("/python")
public class GiveAttendance {

	@GetMapping("/run")
	public String runPythonScript() {
	    String pythonScript = "/home/velamakuru/Downloads/faceattend/program.py";  
	    String pythonInterpreter = "python3"; 

	    ProcessBuilder processBuilder = new ProcessBuilder(pythonInterpreter, pythonScript);
	    processBuilder.redirectErrorStream(true); // Capture errors in output

	    // ✅ Fix for Wayland GUI issues
	    processBuilder.environment().put("QT_QPA_PLATFORM", "xcb");

	    try {
	        Process process = processBuilder.start();

	        try (BufferedReader reader = new BufferedReader(
	                new InputStreamReader(process.getInputStream(), StandardCharsets.UTF_8))) {
	            
	            StringBuilder output = new StringBuilder();
	            String line;
	            while ((line = reader.readLine()) != null) {
	                output.append(line).append("\n");
	            }

	            int exitCode = process.waitFor();
	            if (exitCode == 0) {
	                return "✅ Python script executed successfully:\n" + output;
	            } else {
	                return "❌ Python script execution failed (Exit Code " + exitCode + "):\n" + output;
	            }
	        }
	    } catch (IOException | InterruptedException e) {
	        Thread.currentThread().interrupt();
	        return "❌ Error running Python script: " + e.getMessage();
	    }
	}

}
