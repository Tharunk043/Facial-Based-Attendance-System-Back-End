package com.faceattend.faceattend.Attendance.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.faceattend.faceattend.Attendance.Attendance;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

@Repository
public interface AttendanceRepository extends JpaRepository<Attendance, Long> {

    // Existing method
    long countByNameIgnoreCase(String name);

    // New method to fetch records by date
    @Query(value = "SELECT * FROM attendance WHERE DATE(timestamp) = :date", nativeQuery = true)
    List<Attendance> findByDate(@Param("date") String date);
}