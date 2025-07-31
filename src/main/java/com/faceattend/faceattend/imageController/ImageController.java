package com.faceattend.faceattend.imageController;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
@RequestMapping("/images")
public class ImageController {

    private final String imagePath = "/home/velamakuru/Downloads/OS_Lab/exam";

    // Serve images to the JSP
    @GetMapping("/{filename:.+}")
    public ResponseEntity<Resource> getImage(@PathVariable String filename) {
        try {
            Path file = Paths.get(imagePath).resolve(filename);
            Resource resource = new UrlResource(file.toUri());
            if (resource.exists() || resource.isReadable()) {
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_TYPE, "image/jpeg")
                        .body(resource);
            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }

    // Delete image
    @DeleteMapping("/deleteImage")
    public ResponseEntity<String> deleteImage(@RequestParam("filename") String filename) {
        File file = new File(imagePath + File.separator + filename);

        if (file.exists() && file.isFile()) {
            if (file.delete()) {
                return ResponseEntity.ok("Image deleted successfully.");
            } else {
                return ResponseEntity.status(500).body("Failed to delete the image.");
            }
        } else {
            return ResponseEntity.status(404).body("Image not found.");
        }
    }
}
