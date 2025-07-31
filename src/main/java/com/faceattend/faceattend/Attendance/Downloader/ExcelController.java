package com.faceattend.faceattend.Attendance.Downloader;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.faceattend.faceattend.Attendance.Attendance;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@RestController
public class ExcelController {

    @Autowired
    private AttendanceService attendanceService;

    @PostMapping("/downloadExcel")
    public ResponseEntity<byte[]> downloadExcel(@RequestBody Map<String, String> request) throws IOException {
        System.out.println("Received Request Body: " + request); // ✅ Log the full request

        String date = request.get("date"); // Get the date from the request body

        if (date != null && !date.isEmpty()) {
            System.out.println("Received date parameter: " + date); // ✅ Log the date received
        } else {
            System.out.println("No date provided, fetching all attendance records.");
        }

        // Fetch attendance records based on the date (null means fetch all)
        List<Attendance> attendanceList = attendanceService.getAttendanceRecords(date);
        System.out.println("Fetched records: " + attendanceList.size()); // ✅ Log the number of records fetched

        // Create an Excel workbook
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Attendance Records");

        // Create header row
        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("ID");
        headerRow.createCell(1).setCellValue("Name");
        headerRow.createCell(2).setCellValue("Timestamp");

        // Populate data rows
        int rowNum = 1;
        for (Attendance attendance : attendanceList) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(attendance.getId());
            row.createCell(1).setCellValue(attendance.getName());
            row.createCell(2).setCellValue(attendance.getTimestamp().toString());
        }

        // Write the workbook to a byte array
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        workbook.write(outputStream);
        workbook.close();

        // ✅ Set filename based on whether a date is provided
        String fileName = (date != null && !date.isEmpty()) ? date + ".xlsx" : "attendance_records.xlsx";

        System.out.println("Generated Filename: " + fileName); // ✅ Log the generated filename

        // Set response headers for Excel file download
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
     // ✅ Set filename with proper encoding
        headers.setContentDispositionFormData("attachment", "filename=\"" + fileName + "\"");


        // Return the Excel file as a byte array
        return ResponseEntity.ok()
                .headers(headers)
                .body(outputStream.toByteArray());
    }
}
