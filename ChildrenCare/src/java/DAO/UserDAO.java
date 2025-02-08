package DAO;

import dal.DBContext;
import dal.DBContext;
import model.User;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import model.Account;

public class UserDAO extends DBContext {

    public int registerUser(User user, String email, String password) {
        String sqlUser = "INSERT INTO users (fullname, address, dob, phone, avatar, is_verified) VALUES (?, ?, ?, ?, ?, false)";
        String sqlAccount = "INSERT INTO accounts (email, password, user_id) VALUES (?, ?, ?)";
        String sqlUserRole = "INSERT INTO userroles (role_id, email) VALUES (?, ?)";
        try {
            PreparedStatement psUser = connection.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS);
            psUser.setString(1, user.getFullname());
            psUser.setString(2, user.getAddress());
            psUser.setDate(3, new java.sql.Date(user.getDob().getTime()));
            psUser.setString(4, user.getPhone());
            psUser.setString(5, user.getAvatar());
            psUser.executeUpdate();

            ResultSet rs = psUser.getGeneratedKeys();
            if (rs.next()) {
                int userId = rs.getInt(1);

                PreparedStatement psAccount = connection.prepareStatement(sqlAccount);
                psAccount.setString(1, email);
                psAccount.setString(2, password);
                psAccount.setInt(3, userId);
                psAccount.executeUpdate();

                PreparedStatement psUserRole = connection.prepareStatement(sqlUserRole);
                psUserRole.setInt(1, 4);
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
        String sql = "SELECT u.user_id, u.fullname, u.address, u.dob, u.phone, u.avatar, u.is_verified, a.password "
                + "FROM accounts a JOIN users u ON a.user_id = u.user_id WHERE a.email = ?";
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

    public void verifyUser(String email) {

        String sql = "UPDATE users u "
                + "JOIN accounts a ON u.user_id = a.user_id "
                + "SET u.is_verified = true "
                + "WHERE a.email = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
