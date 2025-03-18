package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Feedback;
import model.Reservation;
import model.Service;
import model.User;

public class FeedbackDBContext extends DBContext {

    // Get all feedbacks
    public List<Feedback> getAllFeedbacks() throws SQLException {
        checkConnection();
        List<Feedback> feedbackList = new ArrayList<>();
        String query = "SELECT f.feedback_id, f.date AS feedback_date, f.rating, f.comment, f.img, f.status, " +
                       "r.reserv_id, r.user_id AS customer_id, r.customer_name, r.customer_address, " +
                       "r.service_id, s.name AS service_name, r.staff_id " +
                       "FROM feedbacks f " +
                       "JOIN reservations r ON f.reserv_id = r.reserv_id " +
                       "JOIN services s ON r.service_id = s.service_id " +
                       "ORDER BY f.date DESC";

        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Feedback feedback = buildFeedbackFromResultSet(rs);
                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching all feedbacks: " + e.getMessage());
            throw new SQLException("Failed to fetch all feedbacks: " + e.getMessage(), e);
        }
        return feedbackList;
    }

    // Check if feedback exists for a reservation
    public boolean hasFeedback(int reservId) throws SQLException {
        checkConnection();
        if (reservId <= 0) {
            return false;
        }
        String query = "SELECT COUNT(*) FROM feedbacks WHERE reserv_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, reservId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking feedback for reserv_id = " + reservId + ": " + e.getMessage());
            throw new SQLException("Failed to check feedback for reserv_id = " + reservId + ": " + e.getMessage(), e);
        }
        return false;
    }

    // Get feedback by reservation ID
    public Feedback getFeedbackByReservId(int reservId) throws SQLException {
        checkConnection();
        if (reservId <= 0) {
            return null;
        }
        String query = "SELECT f.feedback_id, f.date AS feedback_date, f.rating, f.comment, f.img, f.status, " +
                       "r.reserv_id, r.user_id AS customer_id, r.customer_name, r.customer_address, " +
                       "r.service_id, s.name AS service_name, r.staff_id " +
                       "FROM feedbacks f " +
                       "JOIN reservations r ON f.reserv_id = r.reserv_id " +
                       "JOIN services s ON r.service_id = s.service_id " +
                       "WHERE f.reserv_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, reservId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return buildFeedbackFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching feedback for reserv_id = " + reservId + ": " + e.getMessage());
            throw new SQLException("Failed to fetch feedback for reserv_id = " + reservId + ": " + e.getMessage(), e);
        }
        return null;
    }

    // Add a new feedback
    public void addFeedback(Feedback feedback) throws SQLException {
        checkConnection();
        if (feedback == null || feedback.getReservation() == null || feedback.getReservation().getId() <= 0) {
            throw new IllegalArgumentException("Invalid feedback or reservation ID.");
        }
        String query = "INSERT INTO feedbacks (date, rating, comment, img, reserv_id, status) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setDate(1, new java.sql.Date(feedback.getDate().getTime()));
            stmt.setString(2, feedback.getRating());
            stmt.setString(3, feedback.getComment());
            stmt.setString(4, feedback.getImg());
            stmt.setInt(5, feedback.getReservation().getId());
            stmt.setInt(6, feedback.getStatus());

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted <= 0) {
                throw new SQLException("Failed to add feedback for reserv_id = " + feedback.getReservation().getId());
            }
            System.out.println("Feedback added successfully for reserv_id = " + feedback.getReservation().getId());
        } catch (SQLException e) {
            System.err.println("Error adding feedback: " + e.getMessage());
            throw e;
        }
    }

    // Update an existing feedback (Sửa để dùng feedback_id thay vì reserv_id)
    public void updateFeedback(Feedback feedback) throws SQLException {
        checkConnection();
        if (feedback == null || feedback.getId() <= 0) {
            throw new IllegalArgumentException("Invalid feedback or feedback ID.");
        }
        String query = "UPDATE feedbacks SET date = ?, rating = ?, comment = ?, img = ?, status = ? WHERE feedback_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setDate(1, new java.sql.Date(feedback.getDate().getTime()));
            stmt.setString(2, feedback.getRating());
            stmt.setString(3, feedback.getComment());
            stmt.setString(4, feedback.getImg());
            stmt.setInt(5, feedback.getStatus());
            stmt.setInt(6, feedback.getId());

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated == 0) {
                throw new SQLException("No feedback found to update for feedback_id = " + feedback.getId());
            }
            System.out.println("Feedback updated successfully for feedback_id = " + feedback.getId());
        } catch (SQLException e) {
            System.err.println("Error updating feedback: " + e.getMessage());
            throw e;
        }
    }

    // Delete feedback by feedback ID
    public void deleteFeedback(int feedbackId) throws SQLException {
        checkConnection();
        if (feedbackId <= 0) {
            throw new IllegalArgumentException("Invalid feedback ID.");
        }
        String query = "DELETE FROM feedbacks WHERE feedback_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, feedbackId);

            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted <= 0) {
                throw new SQLException("No feedback found to delete for feedback_id = " + feedbackId);
            }
            System.out.println("Feedback deleted successfully for feedback_id = " + feedbackId);
        } catch (SQLException e) {
            System.err.println("Error deleting feedback: " + e.getMessage());
            throw e;
        }
    }

    // Get feedbacks for a specific page with filtering (MySQL compatible)
    public List<Feedback> getFeedbacksByPage(int offset, int pageSize, String rating, String search) throws SQLException {
        checkConnection();
        List<Feedback> feedbackList = new ArrayList<>();
        StringBuilder query = new StringBuilder(
            "SELECT f.feedback_id, f.date AS feedback_date, f.rating, f.comment, f.img, f.status, " +
            "r.reserv_id, r.user_id AS customer_id, r.customer_name, r.customer_address, " +
            "r.service_id, s.name AS service_name, r.staff_id " +
            "FROM feedbacks f " +
            "JOIN reservations r ON f.reserv_id = r.reserv_id " +
            "JOIN services s ON r.service_id = s.service_id "
        );

        List<String> conditions = new ArrayList<>();
        List<Object> parameters = new ArrayList<>();

        if (rating != null && !rating.isEmpty() && rating.matches("[1-5]")) {
            conditions.add("f.rating = ?");
            parameters.add(rating);
        }
        if (search != null && !search.isEmpty()) {
            conditions.add("f.comment LIKE ?");
            parameters.add("%" + search + "%");
        }

        if (!conditions.isEmpty()) {
            query.append("WHERE ").append(String.join(" AND ", conditions));
        }

        query.append(" ORDER BY f.date DESC LIMIT ? OFFSET ?");

        try (PreparedStatement stmt = connection.prepareStatement(query.toString())) {
            int paramIndex = 1;
            for (Object param : parameters) {
                stmt.setObject(paramIndex++, param);
            }
            stmt.setInt(paramIndex++, pageSize);
            stmt.setInt(paramIndex, offset);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Feedback feedback = buildFeedbackFromResultSet(rs);
                    feedbackList.add(feedback);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching feedbacks by page: " + e.getMessage());
            throw new SQLException("Failed to fetch feedbacks by page: " + e.getMessage(), e);
        }
        return feedbackList;
    }

    // Get feedback by Feedback ID
    public Feedback getFeedbackById(int feedbackId) throws SQLException {
        checkConnection();
        if (feedbackId <= 0) {
            return null;
        }
        String query = "SELECT f.feedback_id, f.date AS feedback_date, f.rating, f.comment, f.img, f.status, " +
                       "r.reserv_id, r.user_id AS customer_id, r.customer_name, r.customer_address, " +
                       "r.service_id, s.name AS service_name, r.staff_id " +
                       "FROM feedbacks f " +
                       "JOIN reservations r ON f.reserv_id = r.reserv_id " +
                       "JOIN services s ON r.service_id = s.service_id " +
                       "WHERE f.feedback_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, feedbackId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return buildFeedbackFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching feedback for feedback_id = " + feedbackId + ": " + e.getMessage());
            throw new SQLException("Failed to fetch feedback for feedback_id = " + feedbackId + ": " + e.getMessage(), e);
        }
        return null;
    }

    // Get feedbacks by staff ID
    public List<Feedback> getFeedbacksByStaffId(int staffId) throws SQLException {
        checkConnection();
        if (staffId <= 0) {
            return new ArrayList<>();
        }
        List<Feedback> feedbackList = new ArrayList<>();
        String query = "SELECT f.feedback_id, f.date AS feedback_date, f.rating, f.comment, f.img, f.status, " +
                       "r.reserv_id, r.user_id AS customer_id, r.customer_name, r.customer_address, " +
                       "r.service_id, s.name AS service_name, r.staff_id " +
                       "FROM feedbacks f " +
                       "JOIN reservations r ON f.reserv_id = r.reserv_id " +
                       "JOIN services s ON r.service_id = s.service_id " +
                       "WHERE r.staff_id = ? " +
                       "ORDER BY f.date DESC";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, staffId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Feedback feedback = buildFeedbackFromResultSet(rs);
                    feedbackList.add(feedback);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching feedbacks for staff_id = " + staffId + ": " + e.getMessage());
            throw new SQLException("Failed to fetch feedbacks for staff_id = " + staffId + ": " + e.getMessage(), e);
        }
        return feedbackList;
    }

    // Get total number of feedbacks with filtering
    public int getTotalFeedbacks(String rating, String search) throws SQLException {
        checkConnection();
        StringBuilder query = new StringBuilder("SELECT COUNT(*) FROM feedbacks f ");
        query.append("JOIN reservations r ON f.reserv_id = r.reserv_id ");
        query.append("JOIN services s ON r.service_id = s.service_id ");

        List<String> conditions = new ArrayList<>();
        List<Object> parameters = new ArrayList<>();

        if (rating != null && !rating.isEmpty() && rating.matches("[1-5]")) {
            conditions.add("f.rating = ?");
            parameters.add(rating);
        }
        if (search != null && !search.isEmpty()) {
            conditions.add("f.comment LIKE ?");
            parameters.add("%" + search + "%");
        }

        if (!conditions.isEmpty()) {
            query.append(" WHERE ").append(String.join(" AND ", conditions));
        }

        try (PreparedStatement stmt = connection.prepareStatement(query.toString())) {
            int paramIndex = 1;
            for (Object param : parameters) {
                stmt.setObject(paramIndex++, param);
            }
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching total feedbacks: " + e.getMessage());
            throw new SQLException("Failed to fetch total feedbacks: " + e.getMessage(), e);
        }
        return 0;
    }

    // Helper method to build Feedback object from ResultSet
    private Feedback buildFeedbackFromResultSet(ResultSet rs) throws SQLException {
        Feedback feedback = new Feedback();
        try {
            feedback.setId(rs.getInt("feedback_id"));
            feedback.setDate(rs.getDate("feedback_date"));
            feedback.setRating(rs.getString("rating") != null ? rs.getString("rating") : "");
            feedback.setComment(rs.getString("comment") != null ? rs.getString("comment") : "");
            feedback.setImg(rs.getString("img"));
            feedback.setStatus(rs.getInt("status"));

            User customer = new User();
            customer.setId(rs.getInt("customer_id"));
            customer.setFullname(rs.getString("customer_name") != null ? rs.getString("customer_name") : "Unknown");
            customer.setAddress(rs.getString("customer_address") != null ? rs.getString("customer_address") : "");

            User staff = new User();
            staff.setId(rs.getInt("staff_id"));

            Service service = new Service();
            service.setId(rs.getInt("service_id"));
            service.setName(rs.getString("service_name") != null ? rs.getString("service_name") : "Unknown");

            Reservation reservation = new Reservation();
            reservation.setId(rs.getInt("reserv_id"));
            reservation.setCustomer(customer);
            reservation.setStaff(staff);
            reservation.setService(service);

            feedback.setReservation(reservation);
        } catch (SQLException e) {
            System.err.println("Error building feedback from ResultSet: " + e.getMessage());
            throw e;
        }
        return feedback;
    }

    // Helper method to check database connection
    private void checkConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            throw new SQLException("Database connection is not available.");
        }
    }

    // Helper method to print feedback details
    private static void printFeedbackDetails(Feedback feedback) {
        if (feedback == null) {
            System.out.println("Feedback is null.");
            return;
        }
        System.out.println("Feedback ID: " + feedback.getId());
        System.out.println("Date: " + feedback.getDate());
        System.out.println("Rating: " + feedback.getRating());
        System.out.println("Comment: " + feedback.getComment());
        System.out.println("Image Path: " + (feedback.getImg() != null ? feedback.getImg() : "No image"));
        System.out.println("Reservation ID: " + feedback.getReservation().getId());
        System.out.println("Service Name: " + (feedback.getReservation().getService() != null ? feedback.getReservation().getService().getName() : "N/A"));
        System.out.println("Customer Name: " + (feedback.getReservation().getCustomer() != null ? feedback.getReservation().getCustomer().getFullname() : "N/A"));
        System.out.println("Staff ID: " + (feedback.getReservation().getStaff() != null ? feedback.getReservation().getStaff().getId() : "N/A"));
        System.out.println("Status: " + feedback.getStatus());
        System.out.println("-------------------");
    }

    // Main method for testing
    public static void main(String[] args) {
        FeedbackDBContext db = new FeedbackDBContext();
        int testStaffId = 7; // Thay bằng staff_id thực tế
        int testReservId = 34; // Thay bằng reserv_id thực tế

        try {
            // 1. Test getAllFeedbacks
            System.out.println("=== Test Get All Feedbacks ===");
            List<Feedback> allFeedbacks = db.getAllFeedbacks();
            if (allFeedbacks.isEmpty()) {
                System.out.println("No feedback found in the database.");
            } else {
                for (Feedback feedback : allFeedbacks) {
                    printFeedbackDetails(feedback);
                }
            }

            // 2. Test getFeedbacksByStaffId
            System.out.println("\n=== Test Feedbacks by Staff ID ===");
            List<Feedback> staffFeedbacks = db.getFeedbacksByStaffId(testStaffId);
            if (staffFeedbacks.isEmpty()) {
                System.out.println("No feedback found for staff_id = " + testStaffId);
            } else {
                System.out.println("Feedbacks for staff_id = " + testStaffId + ":");
                for (Feedback feedback : staffFeedbacks) {
                    printFeedbackDetails(feedback);
                }
            }

            // 3. Test hasFeedback and getFeedbackByReservId
            System.out.println("\n=== Test Feedback by Reservation ID ===");
            boolean hasFeedback = db.hasFeedback(testReservId);
            System.out.println("Reservation ID " + testReservId + " has feedback? " + hasFeedback);
            if (hasFeedback) {
                Feedback feedback = db.getFeedbackByReservId(testReservId);
                printFeedbackDetails(feedback);
            }

        } catch (SQLException e) {
            System.err.println("Error in main method: " + e.getMessage());
            e.printStackTrace();
        }
    }
}