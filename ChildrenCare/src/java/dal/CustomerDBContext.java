/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.User;
import org.eclipse.jdt.internal.compiler.ast.Statement;

/**
 *
 * @author FPTSHOP
 */
public class CustomerDBContext extends DBContext {

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

    public ArrayList<User> getUsersByName(String role, String name) {
        ArrayList<User> users = new ArrayList<>();
        String searchKeyword = "%" + name + "%";

        String sql = "SELECT u.user_id, u.fullname, u.gender, u.address, u.dob, u.avatar, u.phone, a.email, a.password, r.role_name FROM users u\n"
                + "JOIN accounts a ON u.user_id = a.user_id\n"
                + "JOIN userroles ur ON ur.email = a.email\n"
                + "JOIN roles r ON r.role_id = ur.role_id\n"
                + "WHERE r.role_name = ? AND u.fullname LIKE ?\n"
                + "ORDER BY u.user_id";

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

    public void addCustomer(User customer) {
        PreparedStatement stm_user = null;
        PreparedStatement stm_acc = null;
        PreparedStatement stm_getId = null;
        ResultSet rs = null;
        try {
            connection.setAutoCommit(false);

            String sql_user = "INSERT INTO swp391.users (fullname, address, dob, phone, avatar)\n"
                    + "VALUES (?, ?, ?, ?, ?)";

            stm_user = connection.prepareStatement(sql_user);

            stm_user.setString(1, customer.getFullname());
            stm_user.setString(2, customer.getAddress());
            stm_user.setDate(3, (Date) customer.getDob());
            stm_user.setString(4, customer.getPhone());
            stm_user.setString(5, customer.getAvatar());

            int affectedRows = stm_user.executeUpdate();
            int cid = -1;

            if (affectedRows > 0) {
                String sql_getId = "SELECT LAST_INSERT_ID() AS user_id";
                stm_getId = connection.prepareStatement(sql_getId);
                rs = stm_getId.executeQuery();

                if (rs.next()) {
                    cid = rs.getInt("user_id");
                }
            }

            if (cid != -1) {
                String sql_account = "INSERT INTO swp391.accounts (email, user_id)\n"
                        + "VALUES (?, ?)";

                stm_acc = connection.prepareStatement(sql_account);
                stm_acc.setString(1, customer.getAccount().getEmail());
                stm_acc.setInt(2, cid);

                stm_acc.executeUpdate();
            }

            connection.commit();

        } catch (SQLException e) {
        } finally {
            try {
                stm_user.close();
                stm_getId.close();
                stm_acc.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(CustomerDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
