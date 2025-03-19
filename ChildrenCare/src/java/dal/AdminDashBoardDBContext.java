package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminDashBoardDBContext extends DBContext {

    // Thống kê số lượng đặt lịch theo trạng thái
    public int getReservationCountByStatus(String status, java.sql.Date startDate, java.sql.Date endDate) throws SQLException {
        String query = "SELECT COUNT(*) FROM reservations WHERE status = ? AND createDate BETWEEN ? AND ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, status);
            ps.setDate(2, startDate);
            ps.setDate(3, endDate);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
                return 0;
            }
        }
    }

    // Tính tổng doanh thu
    public double getTotalRevenue(java.sql.Date startDate, java.sql.Date endDate) throws SQLException {
        String query = "SELECT SUM(s.price) FROM reservations r JOIN services s ON r.service_id = s.service_id " +
                      "WHERE r.createDate BETWEEN ? AND ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getDouble(1);
                return 0.0;
            }
        }
    }

    // Doanh thu theo danh mục dịch vụ
    public Map<String, Double> getRevenueByServiceCategory(java.sql.Date startDate, java.sql.Date endDate) throws SQLException {
        String query = "SELECT sc.name, SUM(s.price) FROM reservations r " +
                      "JOIN services s ON r.service_id = s.service_id " +
                      "JOIN servicecategories sc ON s.category_id = sc.category_id " +
                      "WHERE r.createDate BETWEEN ? AND ? GROUP BY sc.name";
        Map<String, Double> revenueByService = new HashMap<>();
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    revenueByService.put(rs.getString(1), rs.getDouble(2));
                }
            }
        }
        return revenueByService;
    }


    // Số khách hàng đặt lịch mới
    public int getNewlyReservedCustomers(java.sql.Date startDate, java.sql.Date endDate) throws SQLException {
        String query = "SELECT COUNT( r.user_id) FROM reservations r WHERE r.createDate BETWEEN ? AND ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
                return 0;
            }
        }
    }

    // Điểm trung bình phản hồi
    public double getAverageStarFeedback(java.sql.Date startDate, java.sql.Date endDate) throws SQLException {
        String query = "SELECT AVG(rating) FROM feedbacks WHERE date BETWEEN ? AND ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getDouble(1);
                return 0.0;
            }
        }
    }

    // Điểm trung bình phản hồi theo dịch vụ
    public Map<String, Double> getAverageStarByService(java.sql.Date startDate, java.sql.Date endDate) throws SQLException {
        String query = "SELECT s.name, AVG(f.rating) FROM feedbacks f " +
                      "JOIN reservations r ON f.reserv_id = r.reserv_id " +
                      "JOIN services s ON r.service_id = s.service_id " +
                      "WHERE f.date BETWEEN ? AND ? GROUP BY s.name";
        Map<String, Double> avgStarByService = new HashMap<>();
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    avgStarByService.put(rs.getString(1), rs.getDouble(2));
                }
            }
        }
        return avgStarByService;
    }

    // Xu hướng đặt lịch
    public List<Map<String, Object>> getReservationTrend(java.sql.Date startDate, java.sql.Date endDate) throws SQLException {
        String query = "SELECT DATE(createDate) as date, " +
                      "SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END) as completed, " +
                      "COUNT(*) as total " +
                      "FROM reservations WHERE createDate BETWEEN ? AND ? GROUP BY DATE(createDate)";
        List<Map<String, Object>> trend = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> dayData = new HashMap<>();
                    dayData.put("date", rs.getDate("date"));
                    dayData.put("completed", rs.getInt("completed"));
                    dayData.put("total", rs.getInt("total"));
                    trend.add(dayData);
                }
            }
        }
        return trend;
    }
}
