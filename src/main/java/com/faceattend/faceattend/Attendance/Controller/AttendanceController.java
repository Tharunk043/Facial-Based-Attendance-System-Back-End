package com.faceattend.faceattend.Attendance.Controller;

import com.faceattend.faceattend.Attendance.Attendance;
import com.faceattend.faceattend.Attendance.AttendanceService;
import com.faceattend.faceattend.Attendance.repository.AttendanceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@CrossOrigin(origins = "http://localhost:8080")
public class AttendanceController {

    @Autowired
    private AttendanceRepository attendanceRepository;
    @Autowired
    private AttendanceService attendanceService;
    // Show Attendance List
    @GetMapping("/attendance")
    public String showAttendance(Model model) {
        List<Attendance> attendanceList = attendanceRepository.findAll();
        model.addAttribute("attendanceList", attendanceList);
        return "attendance-list"; // JSP Page
    }

    // Delete Attendance
    @GetMapping("/deleteAttendance")
    public String deleteAttendance(@RequestParam("id") Long id) {
        attendanceRepository.deleteById(id);
        return "redirect:/attendance"; // Redirect to attendance list
    }

    // Show Update Form
    @GetMapping("/updateAttendance")
    public String showUpdateForm(@RequestParam("id") Long id, Model model) {
        Optional<Attendance> attendance = attendanceRepository.findById(id);
        if (attendance.isPresent()) {
            model.addAttribute("attendance", attendance.get());
            return "update-attendance"; // Redirects to update JSP form
        }
        return "redirect:/attendance"; // If not found, go back to list
    }

    // Process Update Form
    @PostMapping("/updateAttendance")
    public String updateAttendance(@RequestParam("id") Long id,
                                   @RequestParam("name") String name) {
        Optional<Attendance> attendanceOptional = attendanceRepository.findById(id);
        if (attendanceOptional.isPresent()) {
            Attendance attendance = attendanceOptional.get();
            attendance.setName(name); // Updating the name
            attendanceRepository.save(attendance);
        }
        return "redirect:/attendance"; // Redirect to list
    }
    @PostMapping("/percentage")
    public ResponseEntity<?> getAttendancePercentage(@RequestBody Map<String, String> requestBody) {
        String name = requestBody.get("name");

        if (name == null || name.trim().isEmpty()) {
            return ResponseEntity.badRequest().body("❌ Error: Name parameter is missing!");
        }

        double percentage = calculateAttendance(name);
        return ResponseEntity.ok(percentage);
    }

    private double calculateAttendance(String name) {
        // Simulated count, replace with actual DB query
        long count = attendanceService.getAttendanceCount(name);
        return ((double) count / 25) * 100;
    }
    @GetMapping("/camera")
    public String camera() {
    	return "cameraview";
    }
   @GetMapping("/contact")
   public String contact() {
	   return "contact";
   }

}
