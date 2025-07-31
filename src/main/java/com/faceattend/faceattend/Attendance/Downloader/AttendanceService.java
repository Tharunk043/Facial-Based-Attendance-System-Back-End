package com.faceattend.faceattend.Attendance.Downloader;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.faceattend.faceattend.Attendance.Attendance;
import com.faceattend.faceattend.Attendance.repository.AttendanceRepository;

import java.util.List;

@Service("downloaderAttendanceService")
public class AttendanceService {

    @Autowired
    private AttendanceRepository attendanceRepository;

    public List<Attendance> getAttendanceRecords(String date) {
        if (date != null && !date.isEmpty()) {
            return attendanceRepository.findByDate(date); // Fetch records for the given date
        } else {
            return attendanceRepository.findAll(); // Fetch all records
        }
    }
}