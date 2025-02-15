/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Feature;
import model.Role;
import java.sql.Connection;
import model.Account;

/**
 *
 * @author FPTSHOP
 */
public class AccountDBContext extends DBContext {

    public ArrayList<Role> getRoles(String username) {
        PreparedStatement stm = null;
        ArrayList<Role> roles = new ArrayList<>();
        try {
            String sql = "SELECT r.role_id, r.role_name, f.fid, f.fname, f.url\n"
                    + "FROM Users u\n"
                    + "JOIN UserRoles ur ON u.email = ur.email\n"
                    + "JOIN Roles r ON r.role_id = ur.role_id\n"
                    + "JOIN RoleFeatures rf ON rf.role_id = r.role_id\n"
                    + "JOIN Features f ON f.fid = rf.fid\n"
                    + "WHERE u.email = ?;";

            stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();
            Role crole = new Role();
            crole.setRid(-1);

            while (rs.next()) {
                int rid = rs.getInt("role_id");
                if (rid != crole.getRid()) {
                    crole = new Role();
                    crole.setRid(rid);
                    crole.setRname(rs.getString("role_name"));
                    roles.add(crole);
                }

                Feature feature = new Feature();
                feature.setFid(rs.getInt("fid"));
                feature.setFname(rs.getString("fname"));
                feature.setUrl(rs.getString("url"));
                feature.setRoles(roles);
                crole.getFeatures().add(feature);
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            try {
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return roles;
    }

    public Account getAccount(String email, String password) {
        PreparedStatement stm = null;
        try {
            String sql = "SELECT email, password FROM users\n"
                    + "WHERE email = ? AND password = ?";

            stm = connection.prepareStatement(sql);
            stm.setString(1, email);
            stm.setString(2, password);

            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                Account a = new Account();
                a.setEmail(rs.getString("email"));
                a.setPassword(rs.getString("password"));

                return a;
            }
        } catch (Exception e) {
        } finally {
            try {
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }
}
