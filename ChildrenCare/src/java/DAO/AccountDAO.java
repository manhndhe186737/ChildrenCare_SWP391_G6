/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import dal.DBContext;
import config.PasswordUtil;
import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

public class AccountDAO extends DBContext {

    public boolean updatePassword(String email, String newPassword) {
        String hashedPassword;
        try {
            hashedPassword = PasswordUtil.hashPassword(newPassword);  
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        String sql = "UPDATE users SET password = ? WHERE email = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, hashedPassword);  
            stmt.setString(2, email);          
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;  
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
