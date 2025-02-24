package dal;

import model.Service;
import model.ServiceCategory;
import java.sql.*;
import java.util.ArrayList;

public class ServiceCategoryDBContext extends DBContext {

    public ArrayList<ServiceCategory> getAllCategoriesWithServices() {
        ArrayList<ServiceCategory> categories = new ArrayList<>();
        try {
            String sql = "SELECT category_id, name FROM servicecategories";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            ServiceDBContext serviceDB = new ServiceDBContext();

            while (rs.next()) {
                ServiceCategory category = new ServiceCategory();
                category.setId(rs.getInt("category_id"));
                category.setCategoryname(rs.getString("name"));

                ArrayList<Service> services = serviceDB.getServicesByCategoryId(category.getId());
                category.setServices(services);

                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
        return categories;
    }

    public void addCategory(ServiceCategory category) {
        try {
            String sql = "INSERT INTO servicecategories (name) VALUES (?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, category.getCategoryname());
            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteCategory(int id) {
        try {
            String sql = "DELETE FROM servicecategories WHERE category_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<ServiceCategory> getAllCategoriesWithServices(int page, int pageSize) {
        ArrayList<ServiceCategory> categories = new ArrayList<>();
        try {
            String sql = "SELECT category_id, name FROM servicecategories LIMIT ?, ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, (page - 1) * pageSize); // Tính toán offset
            stm.setInt(2, pageSize); // Số mục trên mỗi trang
            ResultSet rs = stm.executeQuery();
            ServiceDBContext serviceDB = new ServiceDBContext();

            while (rs.next()) {
                ServiceCategory category = new ServiceCategory();
                category.setId(rs.getInt("category_id"));
                category.setCategoryname(rs.getString("name"));

                ArrayList<Service> services = serviceDB.getServicesByCategoryId(category.getId());
                category.setServices(services);

                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    public int getTotalCategories() {
        int total = 0;
        try {
            String sql = "SELECT COUNT(*) AS total FROM servicecategories";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }
}
