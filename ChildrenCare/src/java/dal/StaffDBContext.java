/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Profile;
import java.util.List;
import model.Reservation;
import model.User;
import model.Appointment;

/**
 *
 * @author FPTSHOP
 */
public class StaffDBContext extends DBContext {

    public ArrayList<User> getUsers(String role, String search, String sort, int page, int pageSize) {
        ArrayList<User> users = new ArrayList<>();

        String sql = "SELECT u.user_id, u.fullname, u.gender, u.address, u.dob, u.avatar, u.phone, u.email, u.password, u.is_verified, r.role_name FROM users u\n"
                + "JOIN userroles ur ON ur.email = u.email\n"
                + "JOIN roles r ON r.role_id = ur.role_id\n"
                + "WHERE r.role_name = ? ";

        if (search != null && !search.isEmpty()) {
            sql += "AND u.fullname LIKE ? ";
        }

        sql += "ORDER BY u.fullname " + (sort != null && sort.equals("desc") ? "DESC" : "ASC") + " "
                + "LIMIT ?, ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {

            stm.setString(1, role);

            int index = 2;
            if (search != null && !search.isEmpty()) {
                stm.setString(index++, "%" + search + "%");
            }

            stm.setInt(index++, (page - 1) * pageSize);
            stm.setInt(index, pageSize);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("user_id"));
                    u.setFullname(rs.getString("fullname"));
                    u.setDob(rs.getDate("dob"));
                    u.setAddress(rs.getString("address"));
                    u.setAvatar(rs.getString("avatar"));
                    u.setPhone(rs.getString("phone"));
                    u.setGender(rs.getBoolean("gender"));
                    u.setIsVerified(rs.getBoolean("is_verified"));

                    Account a = new Account();
                    a.setEmail(rs.getString("email"));
                    a.setPassword(rs.getString("password"));

                    u.setAccount(a);
                    users.add(u);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }

    public int getTotalUsers(String role, String search) {
        PreparedStatement stm = null;
        int total = 0;
        try {
            String sql = "SELECT COUNT(*) FROM users u\n"
                    + "JOIN userroles ur ON ur.email = u.email\n"
                    + "JOIN roles r ON r.role_id = ur.role_id\n"
                    + "WHERE r.role_name = ?";

            if (search != null && !search.isEmpty()) {
                sql += " AND u.fullname LIKE ?";
            }

            stm = connection.prepareStatement(sql);
            stm.setString(1, role);

            if (search != null && !search.isEmpty()) {
                stm.setString(2, "%" + search + "%");
            }

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(CustomerDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return total;
    }

    public User getProfileStaff(int id) {
        User staff = new User();
        ArrayList<Profile> profiles = new ArrayList<>();
        String sql = "SELECT u.user_id, u.fullname, u.address, u.dob, u.phone, u.is_verified, u.avatar, u.gender, sp.staff_profile_id, sp.experience, sp.certification, sp.specialties, sp.exp_start, sp.exp_end, u.email, u.bio FROM users u \n"
                + "JOIN staffprofiles sp ON u.user_id = sp.staff_id \n"
                + "WHERE u.user_id = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();

            staff.setId(-1);
            int currentId = id;

            while (rs.next()) {
                if (currentId != staff.getId()) {
                    staff.setId(id);
                    staff.setFullname(rs.getString("fullname"));
                    staff.setAddress(rs.getString("address"));
                    staff.setDob(rs.getDate("dob"));
                    staff.setPhone(rs.getString("phone"));
                    staff.setAvatar(rs.getString("avatar"));
                    staff.setGender(rs.getBoolean("gender"));
                    staff.setBio(rs.getString("bio"));
                    staff.setIsVerified(rs.getBoolean("is_verified"));
                    Account a = new Account();
                    a.setEmail(rs.getString("email"));

                    staff.setAccount(a);
                }
                Profile p = new Profile();
                p.setId(rs.getInt("staff_profile_id"));
                p.setCertification(rs.getString("certification"));
                p.setExperience(rs.getString("experience"));
                p.setSpecialties(rs.getString("specialties"));
                p.setExp_start(rs.getString("exp_start"));
                p.setExp_end(rs.getString("exp_end"));
                p.setStaff(staff);

                profiles.add(p);
            }
            staff.setProfiles(profiles);
        } catch (Exception e) {
        }
        return staff;
    }

    public ArrayList<Reservation> getStaffReserv(int id) {
        User staff = new User();
        ArrayList<Reservation> reserv = new ArrayList<>();
        String sql = "select rsv.staff_id, a.email, u.fullname, u.address, u.dob, u.phone, u.avatar, u.gender, rsv.reserv_id, rsv.dateBook, rsv.user_id, rsv.service_id, rsv.status, rsv.createDate, rsv.updateDate, rsv.note, rsv.starttime, rsv.endtime  from users u\n"
                + "join reservations rsv\n"
                + "on u.user_id = rsv.staff_id\n"
                + "join users a\n"
                + "on a.user_id = rsv.staff_id\n"
                + "where u.user_id = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Reservation rsv = new Reservation();
                rsv.setId(rs.getInt("reserv_id"));
                rsv.setBookdate(rs.getDate("dateBook"));
                rsv.setCreatedate(rs.getDate("createDate"));
                rsv.setNote(rs.getString("note"));
                rsv.setStart(rs.getTime("starttime"));
                rsv.setEnd(rs.getTime("endtime"));

                reserv.add(rsv);
            }

        } catch (Exception e) {
        }
        return reserv;
    }

    public void updateStaff(User staff) {
        String sql = "UPDATE users SET fullname = ?, phone = ?, bio = ?, dob = ?, address = ?, avatar = ? WHERE user_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, staff.getFullname());
            stmt.setString(2, staff.getPhone());
            stmt.setString(3, staff.getBio());
            stmt.setDate(4, new java.sql.Date(staff.getDob().getTime()));
            stmt.setString(5, staff.getAddress());
            stmt.setString(6, staff.getAvatar());
            stmt.setInt(7, staff.getId());

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteStaff(int id) {
        String sql = "UPDATE users SET isActive = 0, is_verified = 0 WHERE user_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, id);

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void activeStaff(int id) {
        String sql = "UPDATE users SET isActive = 1, is_verified = 1 WHERE user_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, id);

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

//     public int registerStaff(User user, String email, String password) {
//        String sqlUser = "INSERT INTO users (fullname, address, dob, phone, avatar, is_verified, email, password, isActive) VALUES (?, ?, ?, ?, ?, false, ?, ?, ?)";
//        String sqlUserRole = "INSERT INTO userroles (role_id, email) VALUES (?, ?)";
//
//        try {
//            // Thêm user vào bảng users
//            PreparedStatement psUser = connection.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS);
//            psUser.setString(1, user.getFullname());
//            psUser.setString(2, user.getAddress());
//            psUser.setDate(3, new java.sql.Date(user.getDob().getTime()));
//            psUser.setString(4, user.getPhone());
//            psUser.setString(5, "uploads/default.jpg");
//            psUser.setString(6, email);
//            psUser.setString(7, password);
//            psUser.setBoolean(8, true);
//            psUser.executeUpdate();
//
//            // Lấy user_id vừa tạo
//            ResultSet rs = psUser.getGeneratedKeys();
//            if (rs.next()) {
//                int userId = rs.getInt(1);
//
//                // Thêm user vào bảng userroles với role_id mặc định là 4
//                PreparedStatement psUserRole = connection.prepareStatement(sqlUserRole);
//                psUserRole.setInt(1, 3); // Giả sử role_id mặc định là 4
//                psUserRole.setString(2, email);
//                psUserRole.executeUpdate();
//
//                System.out.println("UserID created: " + userId);
//                return userId;
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return -1;
//    }
    public int registerStaff(User user, String email, String password) {
        String sqlUser = "INSERT INTO users (fullname, address, dob, phone, avatar, is_verified, email, password, isActive) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String sqlUserRole = "INSERT INTO userroles (role_id, email) VALUES (?, ?)";

        try {
            // Thêm user vào bảng users
            PreparedStatement psUser = connection.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS);
            psUser.setString(1, user.getFullname());
            psUser.setString(2, user.getAddress());
            psUser.setDate(3, new java.sql.Date(user.getDob().getTime()));
            psUser.setString(4, user.getPhone());
            psUser.setString(5, "uploads/default.jpg");
            psUser.setBoolean(6, true);  // isActive = true
            psUser.setString(7, email);
            psUser.setString(8, password);
            psUser.setBoolean(9, true);
            psUser.executeUpdate();

            // Lấy user_id vừa tạo
            ResultSet rs = psUser.getGeneratedKeys();
            if (rs.next()) {
                int userId = rs.getInt(1);

                // Thêm user vào bảng userroles với role_id mặc định là 3
                PreparedStatement psUserRole = connection.prepareStatement(sqlUserRole);
                psUserRole.setInt(1, 3); // Giả sử role_id mặc định là 3
                psUserRole.setString(2, email);
                psUserRole.executeUpdate();

                System.out.println("UserID created: " + userId);
                return userId;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int registerStaffWithProfile(User user, String email, String password) {
        String sqlUser = "INSERT INTO users (fullname, address, dob, phone, avatar, is_verified, email, password, isActive) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String sqlUserRole = "INSERT INTO userroles (role_id, email) VALUES (?, ?)";
        String sqlStaffProfile = "INSERT INTO staffprofiles (staff_id) VALUES (?)"; // Lệnh INSERT vào bảng staffprofiles

        try {
            // Thêm user vào bảng users
            PreparedStatement psUser = connection.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS);
            psUser.setString(1, user.getFullname());
            psUser.setString(2, user.getAddress());
            psUser.setDate(3, new java.sql.Date(user.getDob().getTime()));
            psUser.setString(4, user.getPhone());
            psUser.setString(5, "uploads/default.jpg");
            psUser.setBoolean(6, true);  // isActive = true
            psUser.setString(7, email);
            psUser.setString(8, password);
            psUser.setBoolean(9, true);
            psUser.executeUpdate();

            // Lấy user_id vừa tạo
            ResultSet rs = psUser.getGeneratedKeys();
            if (rs.next()) {
                int userId = rs.getInt(1);

                // Thêm user vào bảng userroles với role_id mặc định là 3
                PreparedStatement psUserRole = connection.prepareStatement(sqlUserRole);
                psUserRole.setInt(1, 3); // Giả sử role_id mặc định là 3
                psUserRole.setString(2, email);
                psUserRole.executeUpdate();

                // Thêm thông tin vào bảng staffprofiles
                PreparedStatement psStaffProfile = connection.prepareStatement(sqlStaffProfile);
                psStaffProfile.setInt(1, userId); // Sử dụng user_id để insert vào staffprofiles
                psStaffProfile.executeUpdate();

                System.out.println("UserID created: " + userId);
                return userId;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public ArrayList<User> getAllStaff() {
        ArrayList<User> staffList = new ArrayList<>();
        String sql = "SELECT u.user_id, u.fullname, u.gender, u.address, u.dob, u.avatar, u.phone, u.email, u.is_verified, u.avatar "
                + "FROM users u "
                + "JOIN userroles ur ON ur.email = u.email "
                + "WHERE ur.role_id = 3 AND u.isActive = 1"; // Chỉ lấy nhân viên đang hoạt động

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("user_id"));
                user.setFullname(rs.getString("fullname"));
                user.setGender(rs.getBoolean("gender"));
                user.setAddress(rs.getString("address"));
                user.setDob(rs.getDate("dob"));
                user.setAvatar(rs.getString("avatar"));
                user.setPhone(rs.getString("phone"));
                user.setIsVerified(rs.getBoolean("is_verified"));
                user.setAvatar(rs.getString("avatar"));

                Account account = new Account();
                account.setEmail(rs.getString("email"));
                user.setAccount(account);

                staffList.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return staffList;
    }

    public ArrayList<Appointment> getAppointmentsByStaffId(int staffId, int page, int pageSize) {
        ArrayList<Appointment> appointmentList = new ArrayList<>();

        String sql = "SELECT u.user_id AS staff_id, rsv.reserv_id, rsv.dateBook, rsv.user_id, rsv.status rStatus, s.service_id, "
                + "rsv.starttime, rsv.endtime, rsv.customer_name, rsv.customer_address, p.payment_id, p.amount, "
                + "p.method, p.status "
                + "FROM users u "
                + "JOIN userroles ur ON u.email = ur.email "
                + "JOIN reservations rsv ON rsv.staff_id = u.user_id "
                + "JOIN services s ON s.service_id = rsv.service_id "
                + "JOIN payment p ON p.reserv_id = rsv.reserv_id "
                + "WHERE ur.role_id = 3 AND u.isActive = 1 AND u.user_id = ? "
                + "LIMIT ? OFFSET ?"; // Thêm phân trang vào SQL

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, staffId);
            stm.setInt(2, pageSize);
            stm.setInt(3, (page - 1) * pageSize); // Tính toán OFFSET

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Appointment appointment = new Appointment();
                appointment.setStaffId(rs.getInt("staff_id"));
                appointment.setReservId(rs.getInt("reserv_id"));
                appointment.setDateBook(rs.getString("dateBook"));
                appointment.setCustomerId(rs.getInt("user_id"));
                appointment.setServiceId(rs.getInt("service_id"));
                appointment.setStatus(rs.getString("rStatus"));
                appointment.setStartTime(rs.getString("starttime"));
                appointment.setEndTime(rs.getString("endtime"));
                appointment.setCustomerName(rs.getString("customer_name"));
                appointment.setCustomerAddress(rs.getString("customer_address"));
                appointment.setPaymentId(rs.getInt("payment_id"));
                appointment.setAmount(rs.getDouble("amount"));
                appointment.setPaymentMethod(rs.getString("method"));
                appointment.setPaymentStatus(rs.getString("status"));

                appointmentList.add(appointment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointmentList;
    }

    public User getUserById(int id) {
        User user = null;
        String sql = "SELECT user_id, fullname, address, dob, bio, phone, avatar, is_verified, email, password "
                + "FROM users "
                + "WHERE user_id = ?;";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getInt("user_id"));
                    user.setFullname(rs.getString("fullname"));
                    user.setAddress(rs.getString("address"));
                    user.setDob(rs.getDate("dob"));
                    user.setPhone(rs.getString("phone"));
                    user.setAvatar(rs.getString("avatar"));
                    user.setIsVerified(rs.getBoolean("is_verified"));
                    user.setBio(rs.getString("bio"));
                    Account account = new Account();
                    account.setEmail(rs.getString("email")); // Lấy email từ ResultSet
                    account.setPassword(rs.getString("password"));
                    user.setAccount(account);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public int getTotalAppointmentsByStaffId(int staffId) {
        int totalAppointments = 0;
        String sql = "SELECT COUNT(*) AS total FROM reservations WHERE staff_id = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, staffId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                totalAppointments = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalAppointments;
    }

    public boolean updateReservationStatus(int reservId) {
        String updateReservationSQL = "UPDATE reservations SET status = 'Completed' WHERE reserv_id = ?";
        String updatePaymentSQL = "UPDATE payment SET status = 'Paid' WHERE reserv_id = ?";

        try {
            connection.setAutoCommit(false); // Bắt đầu transaction

            try (PreparedStatement reservationStmt = connection.prepareStatement(updateReservationSQL); PreparedStatement paymentStmt = connection.prepareStatement(updatePaymentSQL)) {

                // Cập nhật status trong bảng reservations
                reservationStmt.setInt(1, reservId);
                int reservationUpdated = reservationStmt.executeUpdate();

                // Cập nhật status trong bảng payment
                paymentStmt.setInt(1, reservId);
                int paymentUpdated = paymentStmt.executeUpdate();

                if (reservationUpdated > 0 && paymentUpdated > 0) {
                    connection.commit(); // Nếu cả hai thành công, commit transaction
                    return true;
                } else {
                    connection.rollback(); // Nếu có lỗi, rollback lại
                    return false;
                }
            }
        } catch (SQLException e) {
            try {
                connection.rollback(); // Rollback nếu có lỗi
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                connection.setAutoCommit(true); // Bật lại AutoCommit
            } catch (SQLException autoCommitEx) {
                autoCommitEx.printStackTrace();
            }
        }
    }

    public List<Appointment> getAppointmentsByStaffIdAndDateRange(int staffId, String startDate, String endDate, int page, int pageSize) {
        List<Appointment> appointmentList = new ArrayList<>();

        String sql = "SELECT rsv.reserv_id, rsv.dateBook, rsv.user_id, rsv.status, "
                + "rsv.service_id, rsv.starttime, rsv.endtime, rsv.customer_name, rsv.customer_address, "
                + "p.payment_id, p.amount, p.method, p.status "
                + "FROM reservations rsv "
                + "JOIN payment p ON p.reserv_id = rsv.reserv_id "
                + "WHERE rsv.staff_id = ? AND rsv.dateBook BETWEEN ? AND ? "
                + "LIMIT ? OFFSET ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, staffId);
            stm.setString(2, startDate);
            stm.setString(3, endDate);
            stm.setInt(4, pageSize);
            stm.setInt(5, (page - 1) * pageSize);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Appointment appointment = new Appointment();
                appointment.setReservId(rs.getInt("reserv_id"));
                appointment.setDateBook(rs.getString("dateBook"));
                appointment.setCustomerId(rs.getInt("user_id"));
                appointment.setServiceId(rs.getInt("service_id"));
                appointment.setStatus(rs.getString("status"));
                appointment.setStartTime(rs.getString("starttime"));
                appointment.setEndTime(rs.getString("endtime"));
                appointment.setCustomerName(rs.getString("customer_name"));
                appointment.setCustomerAddress(rs.getString("customer_address"));
                appointment.setPaymentId(rs.getInt("payment_id"));
                appointment.setAmount(rs.getDouble("amount"));
                appointment.setPaymentMethod(rs.getString("method"));
                appointment.setPaymentStatus(rs.getString("status"));

                appointmentList.add(appointment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointmentList;
    }

    public int getTotalAppointmentsByStaffIdAndDateRange(int staffId, String startDate, String endDate) {
        String sql = "SELECT COUNT(*) FROM reservations "
                + "WHERE staff_id = ? AND dateBook BETWEEN ? AND ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, staffId);
            stm.setString(2, startDate);
            stm.setString(3, endDate);

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Appointment> searchAppointments(String keyword, int page, int pageSize) {
        List<Appointment> appointmentList = new ArrayList<>();

        // Câu lệnh SQL hỗ trợ tìm kiếm
        String sql = "SELECT rsv.reserv_id, rsv.dateBook, rsv.user_id, rsv.status, "
                + "rsv.service_id, rsv.starttime, rsv.endtime, rsv.customer_name, rsv.customer_address, "
                + "p.payment_id, p.amount, p.method, p.status PaymentStatus "
                + "FROM reservations rsv "
                + "JOIN payment p ON p.reserv_id = rsv.reserv_id "
                + "WHERE rsv.customer_name LIKE ? OR rsv.customer_address LIKE ? OR rsv.reserv_id LIKE ? "
                + "LIMIT ? OFFSET ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            stm.setString(1, searchPattern); // Tìm theo tên khách hàng
            stm.setString(2, searchPattern); // Tìm theo địa chỉ khách hàng
            stm.setString(3, searchPattern); // Tìm theo mã đặt chỗ
            stm.setInt(4, pageSize);
            stm.setInt(5, (page - 1) * pageSize);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Appointment appointment = new Appointment();
                appointment.setReservId(rs.getInt("reserv_id"));
                appointment.setDateBook(rs.getString("dateBook"));
                appointment.setCustomerId(rs.getInt("user_id"));
                appointment.setServiceId(rs.getInt("service_id"));
                appointment.setStatus(rs.getString("status"));
                appointment.setStartTime(rs.getString("starttime"));
                appointment.setEndTime(rs.getString("endtime"));
                appointment.setCustomerName(rs.getString("customer_name"));
                appointment.setCustomerAddress(rs.getString("customer_address"));
                appointment.setPaymentId(rs.getInt("payment_id"));
                appointment.setAmount(rs.getDouble("amount"));
                appointment.setPaymentMethod(rs.getString("method"));
                appointment.setPaymentStatus(rs.getString("PaymentStatus"));

                appointmentList.add(appointment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointmentList;
    }

    public List<Appointment> getAppointmentsByFilter(int staffId, String startDate, String endDate, String searchKeyword, int page, int pageSize) {
        List<Appointment> appointmentList = new ArrayList<>();

        // Xây dựng câu lệnh SQL với các điều kiện lọc
        StringBuilder sql = new StringBuilder("SELECT rsv.reserv_id, rsv.dateBook, rsv.user_id, rsv.status, "
                + "rsv.service_id, rsv.starttime, rsv.endtime, rsv.customer_name, rsv.customer_address, "
                + "p.payment_id, p.amount, p.method, p.status PaymentStatus "
                + "FROM reservations rsv "
                + "JOIN payment p ON p.reserv_id = rsv.reserv_id "
                + "WHERE rsv.staff_id = ? ");

        // Nếu startDate và endDate có giá trị thì thêm vào điều kiện SQL
        if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
            sql.append("AND rsv.dateBook BETWEEN ? AND ? ");
        }

        // Nếu searchKeyword có giá trị thì thêm vào điều kiện tìm kiếm
        if (searchKeyword != null && !searchKeyword.isEmpty()) {
            sql.append("AND (rsv.customer_name LIKE ? OR rsv.customer_address LIKE ?) ");
        }

        sql.append("ORDER BY rsv.dateBook DESC LIMIT ? OFFSET ? ");

        try (PreparedStatement stm = connection.prepareStatement(sql.toString())) {
            stm.setInt(1, staffId);

            // Thiết lập tham số cho startDate và endDate nếu có
            int paramIndex = 2;
            if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
                stm.setString(paramIndex++, startDate);
                stm.setString(paramIndex++, endDate);
            }

            // Thiết lập tham số cho searchKeyword nếu có
            if (searchKeyword != null && !searchKeyword.isEmpty()) {
                stm.setString(paramIndex++, "%" + searchKeyword + "%");
                stm.setString(paramIndex++, "%" + searchKeyword + "%");
            }

            // Thiết lập tham số cho phân trang
            stm.setInt(paramIndex++, pageSize);
            stm.setInt(paramIndex++, (page - 1) * pageSize);

            // Thực thi truy vấn và lấy kết quả
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Appointment appointment = new Appointment();
                appointment.setReservId(rs.getInt("reserv_id"));
                appointment.setDateBook(rs.getString("dateBook"));
                appointment.setCustomerId(rs.getInt("user_id"));
                appointment.setServiceId(rs.getInt("service_id"));
                appointment.setStatus(rs.getString("status"));
                appointment.setStartTime(rs.getString("starttime"));
                appointment.setEndTime(rs.getString("endtime"));
                appointment.setCustomerName(rs.getString("customer_name"));
                appointment.setCustomerAddress(rs.getString("customer_address"));
                appointment.setPaymentId(rs.getInt("payment_id"));
                appointment.setAmount(rs.getDouble("amount"));
                appointment.setPaymentMethod(rs.getString("method"));
                appointment.setPaymentStatus(rs.getString("PaymentStatus"));

                appointmentList.add(appointment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointmentList;
    }

    public int getTotalAppointmentsByFilter(int staffId, String startDate, String endDate, String searchKeyword) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM reservations WHERE staff_id = ? ");

        // Nếu startDate và endDate có giá trị thì thêm vào điều kiện SQL
        if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
            sql.append("AND dateBook BETWEEN ? AND ? ");
        }

        // Nếu searchKeyword có giá trị thì thêm vào điều kiện tìm kiếm
        if (searchKeyword != null && !searchKeyword.isEmpty()) {
            sql.append("AND (customer_name LIKE ? OR customer_address LIKE ?) ");
        }

        try (PreparedStatement stm = connection.prepareStatement(sql.toString())) {
            stm.setInt(1, staffId);

            // Thiết lập tham số cho startDate và endDate nếu có
            int paramIndex = 2;
            if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
                stm.setString(paramIndex++, startDate);
                stm.setString(paramIndex++, endDate);
            }

            // Thiết lập tham số cho searchKeyword nếu có
            if (searchKeyword != null && !searchKeyword.isEmpty()) {
                stm.setString(paramIndex++, "%" + searchKeyword + "%");
                stm.setString(paramIndex++, "%" + searchKeyword + "%");
            }

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

}
