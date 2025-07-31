package com.faceattend.faceattend.LoginController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@RestController
@RequestMapping("/api")
public class LoginController {

    @Autowired
    private JavaMailSender mailSender;

    private final Map<String, String> otpStorage = new HashMap<>();

    @PostMapping("/send-otp")
    public Map<String, String> sendOtp(@RequestParam String email) {
        Map<String, String> response = new HashMap<>();
        
        if (!email.contains("@")) {
            response.put("status", "error");
            response.put("message", "Invalid email address!");
            return response;
        }

        String otp = generateOtp();
        otpStorage.put(email, otp); // Store OTP for verification

        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("Your OTP Code");
            message.setText("Your OTP is: " + otp + ". Please use this to complete your authentication."); // Add this line

            mailSender.send(message);

            response.put("status", "success");
            response.put("message", "OTP sent successfully to " + email);
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Failed to send OTP: " + e.getMessage());
        }

        return response;
    }

    @PostMapping("/verify-otp")
    public Map<String, String> verifyOtp(@RequestParam String email, @RequestParam String otp) {
        Map<String, String> response = new HashMap<>();

        if (otpStorage.containsKey(email) && otpStorage.get(email).equals(otp)) {
            response.put("status", "success");
            response.put("message", "OTP verified successfully!");
            otpStorage.remove(email); // Remove OTP after successful verification
        } else {
            response.put("status", "error");
            response.put("message", "Invalid OTP or expired OTP.");
        }

        return response;
    }

    private String generateOtp() {
        return String.valueOf(100000 + new Random().nextInt(900000));
    }
}
