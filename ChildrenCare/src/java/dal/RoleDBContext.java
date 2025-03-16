/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Service;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Feature;
import model.Role;

/**
 *
 * @author FPTSHOP
 */
public class RoleDBContext extends DBContext {

    public ArrayList<Role> getRoles() {
        ArrayList<Role> roles = new ArrayList<>();
        String sql = "select r.role_id, r.role_name, f.fid, f.fname, f.url, f.active from roles r\n"
                + "join rolefeatures rf on r.role_id = rf.role_id\n"
                + "join features f on f.fid = rf.fid";

        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {

            Role currentRole = null;

            while (rs.next()) {
                int rid = rs.getInt("role_id");

                // Kiểm tra xem có phải role mới không
                if (currentRole == null || rid != currentRole.getRid()) {
                    // Nếu có role mới, tạo role mới và thêm vào danh sách roles
                    if (currentRole != null) {
                        roles.add(currentRole);  // Thêm role cũ vào danh sách
                    }

                    // Tạo mới role
                    currentRole = new Role();
                    currentRole.setRid(rid);
                    currentRole.setRname(rs.getString("role_name"));
                    currentRole.setFeatures(new ArrayList<>());  // Khởi tạo danh sách features
                }

                // Thêm feature vào role hiện tại
                Feature feature = new Feature();
                feature.setFid(rs.getInt("fid"));
                feature.setFname(rs.getString("fname"));
                feature.setUrl(rs.getString("url"));
                feature.setStatus(rs.getBoolean("active"));
                currentRole.getFeatures().add(feature);  // Thêm feature vào role

            }

            // Đảm bảo thêm role cuối cùng vào danh sách
            if (currentRole != null) {
                roles.add(currentRole);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return roles;
    }
    
    public void activeFeatureStatus(int fid, boolean status){
        String sql = "update features set active = ? where fid = ?";
        
        try(PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setBoolean(1, !status);
            stm.setInt(2, fid);
            
            stm.executeUpdate();
            
        } catch (Exception e) {
        }
    }
    
    public ArrayList<Role> getAllRoles(){
        String sql = "select * from roles";
        ArrayList<Role> roles = new ArrayList<>();
        try(PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            
            while (rs.next()) {                
                Role r = new Role();
                r.setRid(rs.getInt("role_id"));
                r.setRname(rs.getString("role_name"));
            }
        } catch (Exception e) {
        }
        return roles;
    }
    
    public void insertFeatureAndRoleFeature(String featureName, String featureUrl, int roleId) {
    String insertFeatureSQL = "INSERT INTO features (fname, url, active) VALUES (?, ?, ?)";
    String insertRoleFeatureSQL = "INSERT INTO rolefeatures (fid, role_id) VALUES (?, ?)";
    
    try (PreparedStatement featureStmt = connection.prepareStatement(insertFeatureSQL, PreparedStatement.RETURN_GENERATED_KEYS);
         PreparedStatement roleFeatureStmt = connection.prepareStatement(insertRoleFeatureSQL)) {

        // Insert vào bảng features
        featureStmt.setString(1, featureName);
        featureStmt.setString(2, featureUrl);
        featureStmt.setBoolean(3, true);
        featureStmt.executeUpdate();

        ResultSet generatedKeys = featureStmt.getGeneratedKeys();
        if (generatedKeys.next()) {
            int fid = generatedKeys.getInt(1); 

            roleFeatureStmt.setInt(1, fid); 
            roleFeatureStmt.setInt(2, roleId); 
            roleFeatureStmt.executeUpdate();
        }
        
    } catch (Exception e) {
    }
}


}
