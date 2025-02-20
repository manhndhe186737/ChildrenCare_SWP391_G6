/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Service;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.User;

/**
 *
 * @author FPTSHOP
 */
public class ReservationDBContext extends DBContext {

    public ArrayList<Service> getServices() {
        ArrayList<Service> services = new ArrayList<>();
        String sql = "select * from Services";
        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery();) {

            while (rs.next()) {
                Service s = new Service();
                s.setId(rs.getInt("service_id"));
                s.setName(rs.getString("name"));
                s.setPrice(rs.getFloat("price"));
                s.setDescription(rs.getString("description"));

                services.add(s);
            }
        } catch (Exception e) {
        }
        return services;
    }

    public Service getServicesById(int id) {
        String sql = "select * from Services where service_id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Service s = new Service();
                s.setId(rs.getInt("service_id"));
                s.setName(rs.getString("name"));
                s.setPrice(rs.getFloat("price"));
                s.setDescription(rs.getString("description"));
                
                return s;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public ArrayList<Service> getServicesInCart(int userId) {
        ArrayList<Service> services = new ArrayList<>();
        String sql = "select s.* from users u\n"
                + "join cart c\n"
                + "on u.user_id = c.user_id\n"
                + "join services s\n"
                + "on c.service_id = s.service_id\n"
                + "where u.user_id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setInt(1, userId);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Service s = new Service();
                s.setId(rs.getInt("service_id"));
                s.setName(rs.getString("name"));
                s.setPrice(rs.getFloat("price"));
                s.setDescription(rs.getString("description"));

                services.add(s);
            }
        } catch (Exception e) {
        }
        return services;
    }

    public ArrayList<User> getStaff() {
        ArrayList<User> staff = new ArrayList<>();
        String sql = "select * from users u\n"
                + "join userroles ur\n"
                + "on ur.email = u.email\n"
                + "join roles r\n"
                + "on r.role_id = ur.role_id\n"
                + "where r.role_name = 'Staff'";
        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery();) {

            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("user_id"));
                u.setFullname(rs.getString("fullname"));

                staff.add(u);
            }
        } catch (Exception e) {
        }
        return staff;
    }

    public ArrayList<User> getAvailableStaff(String date, String startTime, String endTime) {
        ArrayList<User> staff = new ArrayList<>();
        String sql = "SELECT * FROM users usr\n"
                + "JOIN userroles ur ON ur.email = usr.email\n"
                + "JOIN roles r ON r.role_id = ur.role_id\n"
                + "WHERE r.role_name = 'Staff' AND usr.user_id NOT IN(\n"
                + "SELECT staff_id\n"
                + "FROM users u\n"
                + "JOIN userroles ur ON ur.email = u.email\n"
                + "JOIN roles r ON r.role_id = ur.role_id\n"
                + "JOIN reservations res ON res.staff_id = u.user_id\n"
                + "AND res.datebook = ? \n"
                + "WHERE r.role_name = 'Staff'\n"
                + "AND (\n"
                + "    res.starttime <= ? AND res.endtime >= ? \n"
                + "))";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, date);  // Ngày được chọn
            stm.setString(2, endTime);  // Thời gian bắt đầu
            stm.setString(3, startTime);    // Thời gian kết thúc

            int currentId = -1;

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("user_id"));
                    u.setFullname(rs.getString("fullname"));
                    u.setAvatar(rs.getString("avatar"));

                    if (currentId != u.getId()) {
                        staff.add(u);
                        currentId = u.getId();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return staff;
    }

    public User getStaffById(int id) {
        String sql = "SELECT user_id, fullname FROM users WHERE user_id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("user_id"));
                u.setFullname(rs.getString("fullname"));

                return u;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public boolean addToCart(int userId, int serviceId) {
        String sql = "INSERT INTO Cart (user_id, service_id) VALUES (?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, serviceId);

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (Exception e) {
            return false;
        }
    }
    
    public void deleteCart(int user_id, int cart_id){
        String sql = "delete from cart where user_id = ? and service_id = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, user_id);
            stm.setInt(2, cart_id);
            
            stm.executeUpdate();
            
        } catch (Exception e) {
        }
    }

}
