package com.faceattend.faceattend.imageupload;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.IOException;

@RestController
@RequestMapping("/upload")
public class ImageUploadController {

    private static final String SAVE_DIR = "/home/velamakuru/Downloads/OS_Lab/exam/";

    @PostMapping("/capture")
    public String handleFileUpload(@RequestParam("image") MultipartFile file,
                                   @RequestParam("name") String name) {
        try {
            // Ensure directory exists
            File directory = new File(SAVE_DIR);
            if (!directory.exists()) {
                directory.mkdirs(); // Create directory if not exist
            }

            // Save file with given name
            String filePath = SAVE_DIR + name + ".jpg";
            File destFile = new File(filePath);
            file.transferTo(destFile);

            return "Image saved successfully as " + filePath;
        } catch (IOException e) {
            return "Error saving image: " + e.getMessage();
        }
    }
}
