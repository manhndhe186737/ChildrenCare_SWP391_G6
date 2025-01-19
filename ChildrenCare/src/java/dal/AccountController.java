/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Account;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.User;

/**
 *
 * @author FPTSHOP
 */
public class AccountController extends DBContext {

    public Account getAccount(String email, String password) {
        Account acc = null;
        String sql = "select email, password from swp391.accounts\n"
                    + "where email = ? and password = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)){
            stm.setString(1, email);
            stm.setString(2, password);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                acc = new Account();
                acc.setEmail(rs.getString("email"));
                acc.setPassword(rs.getString("password"));
            }
        } catch (Exception e) {
        }
        return acc;
    }
    
    public List<Account> getAccount1() {
        List<Account> list = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "select email, password from swp391.accounts";
            stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Account acc = null;
                acc.setEmail(rs.getString("email"));
                acc.setPassword(rs.getString("password"));
                
                list.add(acc);
            }
        } catch (Exception e) {
        }
        return list;
    }
    
    public List<User> getAllUsers(){
        List<User> users = new ArrayList<>();
        String query = "SELECT user_id, fullname FROM Users";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int userId = rs.getInt("user_id");
                String fullname = rs.getString("fullname");

                // Tạo đối tượng User và thêm vào danh sách
                users.add(new User(userId, fullname));
            }
        }catch(SQLException ex){
            
        }

        return users;
    }
}
