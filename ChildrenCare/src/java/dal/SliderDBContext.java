/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author DELL
 */
import java.sql.*;
import model.Slider;
import java.util.ArrayList;

public class SliderDBContext extends DBContext {

    public ArrayList<Slider> getPaginatedSliders(String status, String search, int page, int pageSize) {
        ArrayList<Slider> sliders = new ArrayList<>();
        try {
            String sql = "SELECT * FROM sliders WHERE 1=1";
            if (status != null && !status.isEmpty()) {
                sql += " AND status = ?";
            }
            if (search != null && !search.isEmpty()) {
                sql += " AND (title LIKE ? OR image LIKE ?)";
            }
            sql += " LIMIT ?, ?";

            PreparedStatement stm = connection.prepareStatement(sql);
            int paramIndex = 1;
            if (status != null && !status.isEmpty()) {
                stm.setString(paramIndex++, status);
            }
            if (search != null && !search.isEmpty()) {
                stm.setString(paramIndex++, "%" + search + "%");
                stm.setString(paramIndex++, "%" + search + "%");
            }
            stm.setInt(paramIndex++, (page - 1) * pageSize);
            stm.setInt(paramIndex++, pageSize);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Slider slider = new Slider(
                        rs.getInt("slider_id"),
                        rs.getString("title"),
                        rs.getString("image"),
                        rs.getString("status"),
                        rs.getDate("createdate"),
                        rs.getDate("updatedate"),
                        rs.getBoolean("visibility"),
                        null
                );
                sliders.add(slider);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sliders;
    }

    public int getTotalSliders(String status, String search) {
        int total = 0;
        try {
            String sql = "SELECT COUNT(*) FROM sliders WHERE 1=1";
            if (status != null && !status.isEmpty()) {
                sql += " AND status = ?";
            }
            if (search != null && !search.isEmpty()) {
                sql += " AND (title LIKE ? OR image LIKE ?)";
            }
            PreparedStatement stm = connection.prepareStatement(sql);
            int paramIndex = 1;
            if (status != null && !status.isEmpty()) {
                stm.setString(paramIndex++, status);
            }
            if (search != null && !search.isEmpty()) {
                stm.setString(paramIndex++, "%" + search + "%");
                stm.setString(paramIndex++, "%" + search + "%");
            }
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public void toggleSliderVisibility(int id, boolean newStatus) {
        try {
            String sql = "UPDATE sliders SET status = ? WHERE slider_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setBoolean(1, newStatus);
            stm.setInt(2, id);
            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Slider getSliderById(int id) {
        Slider slider = null;
        try {
            String sql = "SELECT * FROM sliders WHERE slider_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                slider = new Slider(
                        rs.getInt("slider_id"),
                        rs.getString("title"),
                        rs.getString("image"),
                        rs.getString("status"),
                        rs.getDate("createdate"),
                        rs.getDate("updatedate"),
                        rs.getBoolean("visibility"),
                        null
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slider;
    }

    public void updateSlider(Slider slider) {
        try {
            String sql = "UPDATE sliders SET title = ?, image = ?, status = ?, updatedate = NOW() WHERE slider_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, slider.getTitle());
            stm.setString(2, slider.getImg());
            stm.setString(3, slider.getStatus());
            stm.setInt(4, slider.getId());
            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
