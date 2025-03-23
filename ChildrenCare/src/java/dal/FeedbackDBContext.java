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
        String query = "SELECT f.feedback_id, f.date AS feedback_date, f.rating, f.comment, f.img, f.status, f.reply, " +
                       "r.reserv_id, r.user_id AS customer_id, r.customer_name, r.customer_address, " +
                       "r.service_id, s.name AS service_name, r.staff_id, u.fullname AS staff_name " +
                       "FROM feedbacks f " +
                       "JOIN reservations r ON f.reserv_id = r.reserv_id " +
                       "JOIN services s ON r.service_id = s.service_id " +
                       "JOIN users u ON r.staff_id = u.user_id " +
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
        String query = "SELECT f.feedback_id, f.date AS feedback_date, f.rating, f.comment, f.img, f.status, f.reply, " +
                       "r.reserv_id, r.user_id AS customer_id, r.customer_name, r.customer_address, " +
                       "r.service_id, s.name AS service_name, r.staff_id, u.fullname AS staff_name " +
                       "FROM feedbacks f " +
                       "JOIN reservations r ON f.reserv_id = r.reserv_id " +
                       "JOIN services s ON r.service_id = s.service_id " +
                       "JOIN users u ON r.staff_id = u.user_id " +
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
        String query = "INSERT INTO feedbacks (date, rating, comment, img, reserv_id, status, reply) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setDate(1, new java.sql.Date(feedback.getDate().getTime()));
            stmt.setString(2, feedback.getRating());
            stmt.setString(3, feedback.getComment());
            stmt.setString(4, feedback.getImg());
            stmt.setInt(5, feedback.getReservation().getId());
            stmt.setInt(6, feedback.getStatus());
            stmt.setString(7, feedback.getReply() != null ? feedback.getReply() : null);

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

    // Update an existing feedback
    public void updateFeedback(Feedback feedback) throws SQLException {
        checkConnection();
        if (feedback == null || feedback.getId() <= 0) {
            throw new IllegalArgumentException("Invalid feedback or feedback ID.");
        }
        String query = "UPDATE feedbacks SET date = ?, rating = ?, comment = ?, img = ?, status = ?, reply = ? WHERE feedback_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setDate(1, new java.sql.Date(feedback.getDate().getTime()));
            stmt.setString(2, feedback.getRating());
            stmt.setString(3, feedback.getComment());
            stmt.setString(4, feedback.getImg());
            stmt.setInt(5, feedback.getStatus());
            stmt.setString(6, feedback.getReply() != null ? feedback.getReply() : null);
            stmt.setInt(7, feedback.getId());

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

   // Get feedbacks for a specific page with filtering
    public List<Feedback> getFeedbacksByPage(int offset, int pageSize, String rating, String serviceName, String staffName, String search) throws SQLException {
        checkConnection();
        List<Feedback> feedbackList = new ArrayList<>();
        StringBuilder query = new StringBuilder(
            "SELECT f.feedback_id, f.date AS feedback_date, ctm.avatar, f.rating, f.comment, f.img, f.status, f.reply, " +
            "r.reserv_id, r.user_id AS customer_id, r.customer_name, r.customer_address, " +
            "r.service_id, s.name AS service_name, r.staff_id, u.fullname AS staff_name " +
            "FROM feedbacks f " +
            "JOIN reservations r ON f.reserv_id = r.reserv_id " +
            "JOIN services s ON r.service_id = s.service_id " +
            "JOIN users u ON r.staff_id = u.user_id " +
            "JOIN users ctm ON r.user_id = ctm.user_id "
        );

        List<String> conditions = new ArrayList<>();
        List<Object> parameters = new ArrayList<>();

        if (rating != null && !rating.isEmpty() && rating.matches("[1-5]")) {
            conditions.add("f.rating = ?");
            parameters.add(rating);
        }
        if (serviceName != null && !serviceName.isEmpty()) {
            conditions.add("s.name = ?");
            parameters.add(serviceName);
        }
        if (staffName != null && !staffName.isEmpty()) {
            conditions.add("u.fullname = ?");
            parameters.add(staffName);
        }
        if (search != null && !search.isEmpty()) {
            conditions.add("(f.comment LIKE ? OR s.name LIKE ?)");
            parameters.add("%" + search + "%");
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
        String query = "SELECT f.feedback_id, f.date AS feedback_date, f.rating, f.comment, f.img, f.status, f.reply, " +
                       "r.reserv_id, r.user_id AS customer_id, r.customer_name, r.customer_address, " +
                       "r.service_id, s.name AS service_name, r.staff_id, u.fullname AS staff_name " +
                       "FROM feedbacks f " +
                       "JOIN reservations r ON f.reserv_id = r.reserv_id " +
                       "JOIN services s ON r.service_id = s.service_id " +
                       "JOIN users u ON r.staff_id = u.user_id " +
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
        String query = "SELECT f.feedback_id, f.date AS feedback_date, f.rating, f.comment, f.img, f.status, f.reply, " +
                       "r.reserv_id, r.user_id AS customer_id, r.customer_name, r.customer_address, " +
                       "r.service_id, s.name AS service_name, r.staff_id, u.fullname AS staff_name " +
                       "FROM feedbacks f " +
                       "JOIN reservations r ON f.reserv_id = r.reserv_id " +
                       "JOIN services s ON r.service_id = s.service_id " +
                       "JOIN users u ON r.staff_id = u.user_id " +
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
    public int getTotalFeedbacks(String rating, String serviceName, String staffName, String search) throws SQLException {
        checkConnection();
        StringBuilder query = new StringBuilder("SELECT COUNT(*) FROM feedbacks f ");
        query.append("JOIN reservations r ON f.reserv_id = r.reserv_id ");
        query.append("JOIN services s ON r.service_id = s.service_id ");
        query.append("JOIN users u ON r.staff_id = u.user_id ");

        List<String> conditions = new ArrayList<>();
        List<Object> parameters = new ArrayList<>();

        if (rating != null && !rating.isEmpty() && rating.matches("[1-5]")) {
            conditions.add("f.rating = ?");
            parameters.add(rating);
        }
        if (serviceName != null && !serviceName.isEmpty()) {
            conditions.add("s.name = ?");
            parameters.add(serviceName);
        }
        if (staffName != null && !staffName.isEmpty()) {
            conditions.add("u.fullname = ?");
            parameters.add(staffName);
        }
        if (search != null && !search.isEmpty()) {
            conditions.add("(f.comment LIKE ? OR s.name LIKE ?)");
            parameters.add("%" + search + "%");
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

    // Update only the status of a feedback by feedback ID
    public void updateFeedbackStatus(int feedbackId, int status) throws SQLException {
        checkConnection();
        if (feedbackId <= 0) {
            throw new IllegalArgumentException("Invalid feedback ID.");
        }
        String query = "UPDATE feedbacks SET status = ? WHERE feedback_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, status);
            stmt.setInt(2, feedbackId);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated == 0) {
                throw new SQLException("No feedback found to update for feedback_id = " + feedbackId);
            }
            System.out.println("Feedback status updated successfully for feedback_id = " + feedbackId);
        } catch (SQLException e) {
            System.err.println("Error updating feedback status: " + e.getMessage());
            throw e;
        }
    }

    // Update only the reply of a feedback by feedback ID
    public void updateFeedbackReply(int feedbackId, String reply) throws SQLException {
        checkConnection();
        if (feedbackId <= 0) {
            throw new IllegalArgumentException("Invalid feedback ID.");
        }
        String query = "UPDATE feedbacks SET reply = ? WHERE feedback_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, reply != null ? reply : null);
            stmt.setInt(2, feedbackId);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated == 0) {
                throw new SQLException("No feedback found to update for feedback_id = " + feedbackId);
            }
            System.out.println("Feedback reply updated successfully for feedback_id = " + feedbackId);
        } catch (SQLException e) {
            System.err.println("Error updating feedback reply: " + e.getMessage());
            throw e;
        }
    }

    // Get all services for filter dropdown
    public List<Service> getAllServices() throws SQLException {
        checkConnection();
        List<Service> serviceList = new ArrayList<>();
        String query = "SELECT DISTINCT name FROM services ORDER BY name";

        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Service service = new Service();
                service.setName(rs.getString("name"));
                serviceList.add(service);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching services: " + e.getMessage());
            throw new SQLException("Failed to fetch services: " + e.getMessage(), e);
        }
        return serviceList;
    }

    // Get all staff for filter dropdown
    public List<User> getAllStaff() throws SQLException {
        checkConnection();
        List<User> staffList = new ArrayList<>();
        String query = "SELECT DISTINCT u.fullname " +
                       "FROM users u " +
                       "JOIN reservations r ON u.user_id = r.staff_id " +
                       "ORDER BY u.fullname";

        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                User staff = new User();
                staff.setFullname(rs.getString("fullname"));
                staffList.add(staff);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching staff: " + e.getMessage());
            throw new SQLException("Failed to fetch staff: " + e.getMessage(), e);
        }
        return staffList;
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
            feedback.setReply(rs.getString("reply") != null ? rs.getString("reply") : "");

            User customer = new User();
            customer.setId(rs.getInt("customer_id"));
            customer.setFullname(rs.getString("customer_name") != null ? rs.getString("customer_name") : "Unknown");
            customer.setAddress(rs.getString("customer_address") != null ? rs.getString("customer_address") : "");
            customer.setAvatar(rs.getString("avatar"));

            User staff = new User();
            staff.setId(rs.getInt("staff_id"));
            staff.setFullname(rs.getString("staff_name") != null ? rs.getString("staff_name") : "Unknown");

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
        System.out.println("Service Name: " + (feedback.getReservation().getService() != null ? feedback.getReservation().getService().getName() : "N/A"));
        System.out.println("Staff Name: " + (feedback.getReservation().getStaff() != null ? feedback.getReservation().getStaff().getFullname() : "N/A"));
        System.out.println("Status: " + feedback.getStatus());
        System.out.println("Reply: " + (feedback.getReply() != null ? feedback.getReply() : "No reply"));
        System.out.println("-------------------");
    }

    // Main method for testing
    public static void main(String[] args) {
        FeedbackDBContext db = new FeedbackDBContext();
        int testStaffId = 10; // Thay bằng staff_id thực tế
        int testReservId = 34; // Thay bằng reserv_id thực tế

        try {
            // Test getAllFeedbacks
            System.out.println("=== Test Get All Feedbacks ===");
            List<Feedback> allFeedbacks = db.getAllFeedbacks();
            for (Feedback feedback : allFeedbacks) {
                printFeedbackDetails(feedback);
            }

            // Test getFeedbacksByPage with filters
            System.out.println("\n=== Test Feedbacks by Page ===");
            List<Feedback> filteredFeedbacks = db.getFeedbacksByPage(0, 6, "3", "Massage", "John Doe", "good");
            for (Feedback feedback : filteredFeedbacks) {
                printFeedbackDetails(feedback);
            }

            // Test getAllServices
            System.out.println("\n=== Test Get All Services ===");
            List<Service> services = db.getAllServices();
            for (Service service : services) {
                System.out.println("Service Name: " + service.getName());
            }

            // Test getAllStaff
            System.out.println("\n=== Test Get All Staff ===");
            List<User> staff = db.getAllStaff();
            for (User s : staff) {
                System.out.println("Staff Name: " + s.getFullname());
            }
        } catch (SQLException e) {
            System.err.println("Error in main method: " + e.getMessage());
            e.printStackTrace();
        }
    }
}