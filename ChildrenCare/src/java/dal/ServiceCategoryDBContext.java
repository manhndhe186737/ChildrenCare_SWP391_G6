package dal;

import model.Service;
import model.ServiceCategory;
import java.sql.*;
import java.util.ArrayList;

public class ServiceCategoryDBContext extends DBContext {

    public ArrayList<ServiceCategory> getAllCategoriesWithServices() {
        ArrayList<ServiceCategory> categories = new ArrayList<>();
        try {
            String sql = "SELECT category_id, name, status, description FROM servicecategories";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            ServiceDBContext serviceDB = new ServiceDBContext();

            while (rs.next()) {
                ServiceCategory category = new ServiceCategory();
                category.setId(rs.getInt("category_id"));
                category.setCategoryname(rs.getString("name"));
                category.setStatus(rs.getBoolean("status"));
                category.setDescription(rs.getString("description")); // Lấy description từ DB

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
            String sql = "INSERT INTO servicecategories (name, description, status) VALUES (?, ?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, category.getCategoryname());
            stm.setString(2, category.getDescription());
            stm.setBoolean(3, category.isStatus());

            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateCategory(ServiceCategory category) {
        try {
            String sql = "UPDATE servicecategories SET name = ?, status = ?, description = ? WHERE category_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, category.getCategoryname());
            stm.setBoolean(2, category.isStatus());
            stm.setString(3, category.getDescription()); // Cập nhật description
            stm.setInt(4, category.getId());
            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<ServiceCategory> getCategoriesWithFilterAndPagination(String nameFilter, Boolean statusFilter, int page, int pageSize) {
        ArrayList<ServiceCategory> categories = new ArrayList<>();
        try {
            StringBuilder sql = new StringBuilder("SELECT category_id, name, status, description FROM servicecategories WHERE 1=1 ");

            if (nameFilter != null && !nameFilter.isEmpty()) {
                sql.append("AND name LIKE ? ");
            }
            if (statusFilter != null) {
                sql.append("AND status = ? ");
            }
            sql.append("LIMIT ?, ?");

            PreparedStatement stm = connection.prepareStatement(sql.toString());
            int paramIndex = 1;

            if (nameFilter != null && !nameFilter.isEmpty()) {
                stm.setString(paramIndex++, "%" + nameFilter + "%");
            }
            if (statusFilter != null) {
                stm.setBoolean(paramIndex++, statusFilter);
            }

            stm.setInt(paramIndex++, (page - 1) * pageSize);
            stm.setInt(paramIndex++, pageSize);

            ResultSet rs = stm.executeQuery();
            ServiceDBContext serviceDB = new ServiceDBContext();

            while (rs.next()) {
                ServiceCategory category = new ServiceCategory();
                category.setId(rs.getInt("category_id"));
                category.setCategoryname(rs.getString("name"));
                category.setStatus(rs.getBoolean("status"));
                category.setDescription(rs.getString("description"));

                ArrayList<Service> services = serviceDB.getServicesByCategoryId(category.getId());
                category.setServices(services);

                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    public int getTotalCategories(String nameFilter, Boolean statusFilter) {
        int total = 0;
        try {
            StringBuilder sql = new StringBuilder("SELECT COUNT(*) AS total FROM servicecategories WHERE 1=1 ");

            if (nameFilter != null && !nameFilter.isEmpty()) {
                sql.append("AND name LIKE ? ");
            }
            if (statusFilter != null) {
                sql.append("AND status = ? ");
            }

            PreparedStatement stm = connection.prepareStatement(sql.toString());
            int paramIndex = 1;

            if (nameFilter != null && !nameFilter.isEmpty()) {
                stm.setString(paramIndex++, "%" + nameFilter + "%");
            }
            if (statusFilter != null) {
                stm.setBoolean(paramIndex++, statusFilter);
            }

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public ServiceCategory getCategoryById(int id) {
        ServiceCategory category = null;
        try {
            String sql = "SELECT category_id, name, status, description FROM servicecategories WHERE category_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                category = new ServiceCategory();
                category.setId(rs.getInt("category_id"));
                category.setCategoryname(rs.getString("name"));
                category.setStatus(rs.getBoolean("status"));
                category.setDescription(rs.getString("description"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return category;
    }

    public void updateCategoryStatus(int id, boolean status) {
        try {
            String sql = "UPDATE servicecategories SET status = ? WHERE category_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setBoolean(1, status);
            stm.setInt(2, id);
            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
