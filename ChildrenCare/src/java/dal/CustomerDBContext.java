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

/**
 *
 * @author FPTSHOP
 */
public class CustomerDBContext extends DBContext {

    public ArrayList<User> getUsers(String role) {
        PreparedStatement stm = null;
        ArrayList<User> users = new ArrayList<>();
        try {
            String sql = "SELECT u.user_id, u.fullname, u.address, u.dob, u.avatar, u.phone, a.email, a.password, r.role_name FROM users u\n"
                    + "JOIN accounts a\n"
                    + "ON u.user_id = a.user_id\n"
                    + "JOIN userroles ur\n"
                    + "ON ur.email = a.email\n"
                    + "JOIN roles r\n"
                    + "ON r.role_id = ur.role_id\n"
                    + "WHERE r.role_name = ?";

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
}
