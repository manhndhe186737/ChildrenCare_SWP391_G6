package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import model.Service;
import model.ServiceCategory;

public class ServiceDBContext extends DBContext {

    public ArrayList<Service> getServices(int page, int pageSize) {
        ArrayList<Service> services = new ArrayList<>();
        try {
            String sql = "SELECT s.service_id, s.name, s.description, s.price, c.category_id, c.name AS categoryname "
                    + "FROM services s INNER JOIN servicecategories c ON s.category_id = c.category_id "
                    + "LIMIT ? OFFSET ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, pageSize);
            stm.setInt(2, (page - 1) * pageSize);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                ServiceCategory category = new ServiceCategory();
                category.setId(rs.getInt("category_id"));
                category.setCategoryname(rs.getString("categoryname"));

                Service service = new Service();
                service.setId(rs.getInt("service_id"));
                service.setName(rs.getString("name"));
                service.setDescription(rs.getString("description"));
                service.setPrice(rs.getFloat("price"));
                service.setCategory(category);

                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
        return services;
    }

    // Lấy tổng số dịch vụ để phân trang
    public int getTotalServices() {
        try {
            String sql = "SELECT COUNT(*) AS total FROM services";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
        return 0;
    }

    public ArrayList<Service> getServicesByCategoryId(int categoryId) {
        ArrayList<Service> services = new ArrayList<>();
        try {
            String sql = "SELECT service_id, name, description, price FROM services WHERE category_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, categoryId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Service service = new Service();
                service.setId(rs.getInt("service_id"));
                service.setName(rs.getString("name"));
                service.setDescription(rs.getString("description"));
                service.setPrice(rs.getFloat("price"));

                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
        return services;
    }

    public ArrayList<Service> getFilteredServices(int page, int pageSize, String searchQuery, String[] selectedCategories) {
        ArrayList<Service> services = new ArrayList<>();
        try {
            String sql = "SELECT s.service_id, s.name, s.description, s.price, c.category_id, c.name AS categoryname "
                    + "FROM services s INNER JOIN servicecategories c ON s.category_id = c.category_id "
                    + "WHERE s.name LIKE ? ";

            if (selectedCategories != null && selectedCategories.length > 0) {
                sql += "AND c.category_id IN (" + String.join(",", Collections.nCopies(selectedCategories.length, "?")) + ") ";
            }

            sql += "LIMIT ? OFFSET ?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + searchQuery + "%");

            int index = 2;
            if (selectedCategories != null) {
                for (String category : selectedCategories) {
                    stm.setInt(index++, Integer.parseInt(category));
                }
            }

            stm.setInt(index++, pageSize);
            stm.setInt(index, (page - 1) * pageSize);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                ServiceCategory category = new ServiceCategory();
                category.setId(rs.getInt("category_id"));
                category.setCategoryname(rs.getString("categoryname"));

                Service service = new Service();
                service.setId(rs.getInt("service_id"));
                service.setName(rs.getString("name"));
                service.setDescription(rs.getString("description"));
                service.setPrice(rs.getFloat("price"));
                service.setCategory(category);

                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
        return services;
    }

    public int getTotalFilteredServices(String searchQuery, String[] selectedCategories) {
        try {
            String sql = "SELECT COUNT(*) AS total FROM services s INNER JOIN servicecategories c ON s.category_id = c.category_id WHERE s.name LIKE ? ";

            if (selectedCategories != null && selectedCategories.length > 0) {
                sql += "AND c.category_id IN (" + String.join(",", Collections.nCopies(selectedCategories.length, "?")) + ") ";
            }

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + searchQuery + "%");

            int index = 2;
            if (selectedCategories != null) {
                for (String category : selectedCategories) {
                    stm.setInt(index++, Integer.parseInt(category));
                }
            }

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
        return 0;
    }

}
