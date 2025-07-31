package com.faceattend.faceattend.GoogleController;

import com.faceattend.faceattend.User.*;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api")
public class GoogleAuthController {

    private static final String CLIENT_ID = "57739503068-bcos64b4srof5itkcr9l3l9t8fb9p9ji.apps.googleusercontent.com";

    @Autowired
    private UserRepository userRepository;

    @PostMapping("/google-auth")
    public Map<String, String> googleAuth(@RequestBody Map<String, String> requestBody) {
        Map<String, String> response = new HashMap<>();
        String idTokenString = requestBody.get("idToken");

        if (idTokenString == null || idTokenString.isEmpty()) {
            response.put("status", "error");
            response.put("message", "ID token is missing or empty.");
            return response;
        }

        GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), new GsonFactory())
                .setAudience(Collections.singletonList(CLIENT_ID))
                .build();

        try {
            GoogleIdToken idToken = verifier.verify(idTokenString);
            if (idToken != null) {
                GoogleIdToken.Payload payload = idToken.getPayload();

                String googleId = payload.getSubject();
                String email = payload.getEmail();
                String name = (String) payload.get("name");
                String profilePicture = (String) payload.get("picture");

                // Check if user already exists
                Optional<User> existingUser = Optional.ofNullable(userRepository.findByEmail(email));

                if (existingUser.isPresent()) {
                    System.out.println("User already exists: " + email);
                } else {
                    // Save new user in database
                    User newUser = new User(googleId, email, name, profilePicture);
                    userRepository.save(newUser);
                    System.out.println("New user saved: " + email);
                }

                response.put("status", "success");
                response.put("message", "Google Sign-In Successful!");
                response.put("redirectUrl", "http://localhost:8080/");
                return response;
            } else {
                response.put("status", "error");
                response.put("message", "Invalid ID token.");
                return response;
            }
        } catch (GeneralSecurityException | IOException e) {
            e.printStackTrace();
            response.put("status", "error");
            response.put("message", "Error verifying ID token.");
            return response;
        }
    }
}
