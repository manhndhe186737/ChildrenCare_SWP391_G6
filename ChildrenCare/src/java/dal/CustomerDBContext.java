/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.User;
import java.sql.Date;

/**
 *
 * @author FPTSHOP
 */
public class CustomerDBContext extends DBContext {

    public ArrayList<User> getUsersByName(String role, String name, String sortBy) {
        ArrayList<User> users = new ArrayList<>();
        String searchKeyword = "%" + name + "%";

        String orderByClause = "ORDER BY u.user_id";

        if ("Name".equalsIgnoreCase(sortBy)) {
            orderByClause = "ORDER BY u.fullname ASC";
        } else if ("Email".equalsIgnoreCase(sortBy)) {
            orderByClause = "ORDER BY u.email ASC";
        } else if ("Dob".equalsIgnoreCase(sortBy)) {
            orderByClause = "ORDER BY u.dob ASC";
        }

        String sql = "SELECT u.user_id, u.fullname, u.gender, u.address, u.dob, u.bio, u.avatar, u.phone, u.email, u.password, r.role_name FROM users u\n"
                + "JOIN userroles ur ON ur.email = u.email\n"
                + "JOIN roles r ON r.role_id = ur.role_id\n"
                + "WHERE r.role_name = ? AND u.fullname LIKE ?\n"
                + orderByClause;

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, role);
            stm.setString(2, searchKeyword);

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
                    u.setBio(rs.getString("bio"));
                    Account a = new Account();
                    a.setEmail(rs.getString("email"));
                    a.setPassword(rs.getString("password"));

                    u.setAccount(a);
                    users.add(u);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(CustomerDBContext.class.getName()).log(Level.SEVERE, "Database error", e);
        }

        return users;
    }

    //Paging customer list
    public ArrayList<User> getUsersByNameWithPagination(String role, String name, String sortBy, int page, int pageSize) {
        ArrayList<User> users = new ArrayList<>();
        String searchKeyword = "%" + name + "%";

        String orderByClause = "ORDER BY u.user_id"; // Default sorting
        if ("name".equalsIgnoreCase(sortBy)) {
            orderByClause = "ORDER BY u.fullname ASC";
        } else if ("dob".equalsIgnoreCase(sortBy)) {
            orderByClause = "ORDER BY u.dob ASC";
        } else if ("email".equalsIgnoreCase(sortBy)) {
            orderByClause = "ORDER BY u.email ASC";
        }

        int offset = (page - 1) * pageSize; // Tính vị trí bắt đầu của dữ liệu

        String sql = "SELECT u.user_id, u.fullname, u.gender, u.address, u.dob, u.avatar, u.phone, u.email, u.password, r.role_name, u.isActive, u.is_verified FROM users u\n"
                + "JOIN userroles ur ON ur.email = u.email\n"
                + "JOIN roles r ON r.role_id = ur.role_id\n"
                + "WHERE r.role_name = ? AND (u.fullname LIKE ? OR u.phone LIKE ? OR u.email LIKE ?)\n"
                + orderByClause + " LIMIT ? OFFSET ?"; // Thêm LIMIT và OFFSET

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, role);
            stm.setString(2, searchKeyword);
            stm.setString(3, searchKeyword);
            stm.setString(4, searchKeyword);
            stm.setInt(5, pageSize);
            stm.setInt(6, offset);

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
            Logger.getLogger(CustomerDBContext.class.getName()).log(Level.SEVERE, "Database error", e);
        }

        return users;
    }

    public int getTotalUsersCount(String role, String name) {
        int total = 0;
        String searchKeyword = "%" + name + "%";
        String sql = "SELECT COUNT(*) FROM users u\n"
                + "JOIN userroles ur ON ur.email = u.email\n"
                + "JOIN roles r ON r.role_id = ur.role_id\n"
                + "WHERE r.role_name = ? AND u.fullname LIKE ? AND u.isActive = 1";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, role);
            stm.setString(2, searchKeyword);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(CustomerDBContext.class.getName()).log(Level.SEVERE, "Database error", e);
        }

        return total;
    }

    public void editCustomer(User customer) {
        StringBuilder sql = new StringBuilder("UPDATE users SET ");
        ArrayList<Object> params = new ArrayList<>();

        if (customer.getFullname() != null && customer.getFullname().length() != 0) {
            sql.append("fullname = ?, ");
            params.add(customer.getFullname());
        }
        if (customer.getAddress() != null && customer.getAddress().length() != 0) {
            sql.append("address = ?, ");
            params.add(customer.getAddress());
        }
        if (customer.getDob() != null) {
            sql.append("dob = ?, ");
            params.add(new java.sql.Date(customer.getDob().getTime()));
        }
        if (customer.getBio() != null && customer.getBio().length() != 0) {
            sql.append("bio = ?, ");
            params.add(customer.getBio());
        }
        if (customer.getPhone() != null && customer.getPhone().length() != 0) {
            sql.append("phone = ?, ");
            params.add(customer.getPhone());
        }
        if (customer.getAvatar() != null && customer.getAvatar().length() != 0) {
            sql.append("avatar = ?, ");
            params.add(customer.getAvatar());
        }
        if (customer.getGender() != null) {
            sql.append("gender = ?, ");
            params.add(customer.getGender());
        }

        // Xóa dấu "," cuối cùng
        if (sql.toString().endsWith(", ")) {
            sql.setLength(sql.length() - 2);
        }

        sql.append(" WHERE user_id = ?");
        params.add(customer.getId());

        try (PreparedStatement stm = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stm.setObject(i + 1, params.get(i));
            }

            int rowsAffected = stm.executeUpdate();
            if (rowsAffected == 0) {
                System.out.println("No customer was updated. Check user_id.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void removeCustomer(int id) {
        String sql = "UPDATE users\n"
                + "SET isActive = false, is_verified = false\n"
                + "WHERE user_id = ?;";
        ;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void activeCustomer(int id) {
        String sql = "UPDATE users\n"
                + "SET isActive = true, is_verified = true\n"
                + "WHERE user_id = ?;";
        ;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
