/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Profile;
import model.Reservation;
import model.Role;
import model.User;

/**
 *
 * @author FPTSHOP
 */
public class StaffDBContext extends DBContext {

    public ArrayList<User> getUsers(String role) {
        PreparedStatement stm = null;
        ArrayList<User> users = new ArrayList<>();
        try {
            String sql = "SELECT u.user_id, u.fullname, u.gender, u.address, u.dob, u.avatar, u.phone, a.email, a.password, r.role_name FROM users u\n"
                    + "JOIN accounts a\n"
                    + "ON u.user_id = a.user_id\n"
                    + "JOIN userroles ur\n"
                    + "ON ur.email = a.email\n"
                    + "JOIN roles r\n"
                    + "ON r.role_id = ur.role_id\n"
                    + "WHERE r.role_name = ?\n"
                    + "ORDER BY u.user_id";

            stm = connection.prepareStatement(sql);
            stm.setString(1, role);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("user_id"));
                u.setFullname(rs.getString("fullname"));
                u.setDob(rs.getDate("dob"));
                u.setAddress(rs.getString("address"));
                u.setAvatar(rs.getString("avatar"));
                u.setPhone(rs.getString("phone"));
                u.setGender(rs.getBoolean("gender"));

                Account a = new Account();
                a.setEmail(rs.getString("email"));
                a.setPassword(rs.getString("password"));

                u.setAccount(a);

                users.add(u);
            }

        } catch (Exception e) {
        } finally {
            try {
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(CustomerDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return users;
    }

    public User getProfileStaff(int id) {
        User staff = new User();
        ArrayList<Profile> profiles = new ArrayList<>();
        String sql = "SELECT u.user_id, u.fullname, u.address, u.dob, u.phone, u.avatar, u.gender, sp.staff_profile_id, sp.experience, sp.certification, sp.specialties, sp.exp_start, sp.exp_end, a.email, u.bio FROM users u \n"
                + "JOIN staffprofiles sp ON u.user_id = sp.staff_id \n"
                + "JOIN accounts a ON a.user_id = u.user_id \n"
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
                + "join accounts a\n"
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

    public ArrayList<User> getFilteredStaff(String searchTerm, String sortColumn, String sortDirection, int pageIndex, int pageSize) {
        ArrayList<User> staffList = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT u.user_id, u.fullname, u.gender, u.address, u.dob, u.avatar, u.phone, a.email, a.password, r.role_name "
                    + "FROM users u "
                    + "JOIN accounts a ON u.user_id = a.user_id "
                    + "JOIN userroles ur ON ur.email = a.email "
                    + "JOIN roles r ON r.role_id = ur.role_id "
                    + "WHERE r.role_name = 'Staff' ";

            // Nếu có searchTerm, thêm điều kiện tìm kiếm
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                sql += " AND u.fullname LIKE ? ";
            }

            // Thêm sắp xếp theo cột được chọn
            sql += " ORDER BY " + sortColumn + " " + sortDirection;

            // Áp dụng phân trang
            sql += " LIMIT ? OFFSET ? ";

            stm = connection.prepareStatement(sql);
            int paramIndex = 1;

            // Nếu có searchTerm, đặt giá trị cho parameter
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                stm.setString(paramIndex++, "%" + searchTerm + "%");
            }

            // Đặt giá trị LIMIT và OFFSET
            stm.setInt(paramIndex++, pageSize);
            stm.setInt(paramIndex, (pageIndex - 1) * pageSize);

            rs = stm.executeQuery();

            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("user_id"));
                u.setFullname(rs.getString("fullname"));
                u.setDob(rs.getDate("dob"));
                u.setAddress(rs.getString("address"));
                u.setAvatar(rs.getString("avatar"));
                u.setPhone(rs.getString("phone"));
                u.setGender(rs.getBoolean("gender"));

                Account a = new Account();
                a.setEmail(rs.getString("email"));
                a.setPassword(rs.getString("password"));
                u.setAccount(a);

                staffList.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return staffList;
    }

    public int getTotalStaffCount(String searchTerm) {
        int total = 0;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT COUNT(*) AS total FROM users u "
                    + "JOIN accounts a ON u.user_id = a.user_id "
                    + "JOIN userroles ur ON ur.email = a.email "
                    + "JOIN roles r ON r.role_id = ur.role_id "
                    + "WHERE r.role_name = 'Staff' ";

            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                sql += " AND u.fullname LIKE ? ";
            }

            stm = connection.prepareStatement(sql);
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                stm.setString(1, "%" + searchTerm + "%");
            }

            rs = stm.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return total;
    }

}
