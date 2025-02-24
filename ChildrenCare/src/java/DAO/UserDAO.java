package DAO;

import dal.DBContext;
import dal.DBContext;
import model.User;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Account;
import model.Role;

public class UserDAO extends DBContext {

    public int registerUser(User user, String email, String password) {
        String sqlUser = "INSERT INTO users (fullname, address, dob, phone, avatar, is_verified, email, password) VALUES (?, ?, ?, ?, ?, false, ?, ?)";
        String sqlUserRole = "INSERT INTO userroles (role_id, email) VALUES (?, ?)";

        try {
            // Thêm user vào bảng users
            PreparedStatement psUser = connection.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS);
            psUser.setString(1, user.getFullname());
            psUser.setString(2, user.getAddress());
            psUser.setDate(3, new java.sql.Date(user.getDob().getTime()));
            psUser.setString(4, user.getPhone());
            psUser.setString(5, user.getAvatar());
            psUser.setString(6, email);
            psUser.setString(7, password);
            psUser.executeUpdate();

            // Lấy user_id vừa tạo
            ResultSet rs = psUser.getGeneratedKeys();
            if (rs.next()) {
                int userId = rs.getInt(1);

                // Thêm user vào bảng userroles với role_id mặc định là 4
                PreparedStatement psUserRole = connection.prepareStatement(sqlUserRole);
                psUserRole.setInt(1, 4); // Giả sử role_id mặc định là 4
                psUserRole.setString(2, email);
                psUserRole.executeUpdate();

                System.out.println("UserID created: " + userId);
                return userId;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public User getUserByEmail(String email) {
        User user = null;
        String sql = "SELECT user_id, fullname, address, dob, bio, phone, avatar, is_verified, email, password\n"
                + "FROM users\n"
                + "WHERE email = ?;";
        try (
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getInt("user_id"));
                    user.setFullname(rs.getString("fullname"));
                    user.setAddress(rs.getString("address"));
                    user.setDob(rs.getDate("dob"));
                    user.setPhone(rs.getString("phone"));
                    user.setAvatar(rs.getString("avatar"));
                    user.setIsVerified(rs.getBoolean("is_verified"));
                    user.setBio(rs.getString("bio"));
                    Account account = new Account();
                    account.setEmail(email);
                    account.setPassword(rs.getString("password"));
                    user.setAccount(account);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public Account getUserRoles(String email) {
        ArrayList<Role> roles = new ArrayList<>();
        Account acc = new Account();
        String sql = "SELECT r.role_id, r.role_name, u.email, u.password\n"
                + "FROM users u\n"
                + "JOIN userroles ur ON ur.email = u.email\n"
                + "JOIN roles r ON r.role_id = ur.role_id\n"
                + "WHERE ur.email = ?;";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, email);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Role r = new Role();
                r.setRid(rs.getInt("role_id"));
                r.setRname(rs.getString("role_name"));

                acc.setEmail(rs.getString("email"));
                acc.setPassword(rs.getString("password"));

                roles.add(r);
            }
            acc.setRoles(roles);
        } catch (Exception e) {
        }
        return acc;
    }

    public void verifyUser(String email) {

        String sql = "UPDATE users u\n"
                + "SET is_verified = TRUE\n"
                + "WHERE email = ?;";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
