package com.faceattend.faceattend.Attendance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.faceattend.faceattend.Attendance.repository.AttendanceRepository;

@Service
public class AttendanceService {

    @Autowired
    private AttendanceRepository attendanceRepository;

    public long getAttendanceCount(String name) {
    	
        return attendanceRepository.countByNameIgnoreCase(name);
        
    }
}
