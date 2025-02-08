/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import dal.DBContext;
import dal.DBContext;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
/**
 *
 * @author Tuấn Anh
 */
public class VerificationTokenDAO extends DBContext{

    public void saveVerificationToken(String email, String token, Timestamp expiryTime) {
        String sql = "INSERT INTO verification_tokens (email, token, expiry_time) VALUES (?, ?, ?)";

        try (
            PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, email);    
            ps.setString(2, token);    
            ps.setTimestamp(3, expiryTime); 
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
     public String getEmailByToken(String token) {
        String email = null;
        String sql = "SELECT email FROM verification_tokens WHERE token = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                email = rs.getString("email");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return email;
    }
    public boolean isTokenExpired(String token) {
        boolean expired = false;
        String sql = "SELECT expiry_time FROM verification_tokens WHERE token = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Timestamp expiryTime = rs.getTimestamp("expiry_time");
                if (expiryTime != null && expiryTime.before(new Timestamp(System.currentTimeMillis()))) {
                    expired = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return expired;
    }
    public void deleteToken(String token) {
        String sql = "DELETE FROM verification_tokens WHERE token = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, token);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
}
