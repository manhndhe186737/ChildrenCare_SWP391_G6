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
        String sql = "SELECT service_id, name, description, price, img "
                   + "FROM services s INNER JOIN servicecategories c ON s.category_id = c.category_id "
                   + "WHERE s.isActive = 1 AND c.status = 1 AND s.category_id = ?";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, categoryId);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            Service service = new Service();
            service.setId(rs.getInt("service_id"));
            service.setName(rs.getString("name"));
            service.setDescription(rs.getString("description"));
            service.setPrice(rs.getFloat("price"));
            service.setImg(rs.getString("img"));
            services.add(service);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return services;
}

public ArrayList<Service> getFilteredServices(int page, int pageSize, String searchQuery, String[] selectedCategories, String[] selectedPriceRanges) {
    ArrayList<Service> services = new ArrayList<>();
    try {
        String sql = "SELECT s.service_id, s.name, s.description, s.price, c.category_id, s.img, c.name AS categoryname "
                   + "FROM services s INNER JOIN servicecategories c ON s.category_id = c.category_id "
                   + "WHERE s.isActive = 1 AND c.status = 1 AND s.name LIKE ? ";

        if (selectedCategories != null && selectedCategories.length > 0) {
            sql += "AND c.category_id IN (" + String.join(",", Collections.nCopies(selectedCategories.length, "?")) + ") ";
        }

        if (selectedPriceRanges != null && selectedPriceRanges.length > 0) {
            sql += "AND (";
            for (int i = 0; i < selectedPriceRanges.length; i++) {
                sql += "s.price BETWEEN ? AND ? ";
                if (i < selectedPriceRanges.length - 1) {
                    sql += "OR ";
                }
            }
            sql += ") ";
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

        if (selectedPriceRanges != null) {
            for (String priceRange : selectedPriceRanges) {
                String[] range = priceRange.split("-");
                stm.setDouble(index++, Double.parseDouble(range[0]));
                stm.setDouble(index++, Double.parseDouble(range[1]));
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
            service.setImg(rs.getString("img"));
            services.add(service);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return services;
}

public int getTotalFilteredServices(String searchQuery, String[] selectedCategories, String[] selectedPriceRanges) {
    try {
        String sql = "SELECT COUNT(*) AS total "
                   + "FROM services s INNER JOIN servicecategories c ON s.category_id = c.category_id "
                   + "WHERE s.isActive = 1 AND c.status = 1 AND s.name LIKE ? ";

        if (selectedCategories != null && selectedCategories.length > 0) {
            sql += "AND c.category_id IN (" + String.join(",", Collections.nCopies(selectedCategories.length, "?")) + ") ";
        }

        if (selectedPriceRanges != null && selectedPriceRanges.length > 0) {
            sql += "AND (";
            for (int i = 0; i < selectedPriceRanges.length; i++) {
                sql += "s.price BETWEEN ? AND ? ";
                if (i < selectedPriceRanges.length - 1) {
                    sql += "OR ";
                }
            }
            sql += ") ";
        }

        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setString(1, "%" + searchQuery + "%");

        int index = 2;
        if (selectedCategories != null) {
            for (String category : selectedCategories) {
                stm.setInt(index++, Integer.parseInt(category));
            }
        }

        if (selectedPriceRanges != null) {
            for (String priceRange : selectedPriceRanges) {
                String[] range = priceRange.split("-");
                stm.setDouble(index++, Double.parseDouble(range[0]));
                stm.setDouble(index++, Double.parseDouble(range[1]));
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

    public ArrayList<Service> getHomeServices() {
        ArrayList<Service> services = new ArrayList<>();
        try {
            String sql = "SELECT s.service_id, s.name, s.description, s.price, s.img, c.category_id, c.name AS categoryname "
                    + "FROM services s INNER JOIN servicecategories c ON s.category_id = c.category_id "
                    + "LIMIT 8";  // Chỉ lấy tối đa 8 dịch vụ
            PreparedStatement stm = connection.prepareStatement(sql);
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
                service.setImg(rs.getString("img"));
                service.setCategory(category);

                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    public Service getServiceById(int serviceId) {
        Service service = null;
        try {
            String sql = "SELECT s.service_id, s.name, s.description, s.price,s.img, c.category_id, c.name AS categoryname "
                    + "FROM services s "
                    + "INNER JOIN servicecategories c ON s.category_id = c.category_id "
                    + "WHERE s.service_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, serviceId);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                ServiceCategory category = new ServiceCategory();
                category.setId(rs.getInt("category_id"));
                category.setCategoryname(rs.getString("categoryname"));

                service = new Service();
                service.setId(rs.getInt("service_id"));
                service.setName(rs.getString("name"));
                service.setDescription(rs.getString("description"));
                service.setPrice(rs.getFloat("price"));
                service.setImg(rs.getString("img"));
                service.setCategory(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return service;
    }
    public static void main(String[] args) {
    ServiceDBContext serviceDBContext = new ServiceDBContext();

    // Test với các tham số (page: 1, pageSize: 6, searchQuery: null, selectedCategories: null, selectedPriceRanges: null)
    ArrayList<Service> services = serviceDBContext.getFilteredServices(1, 6, "", null, null);

    // In ra danh sách dịch vụ
    if (services.isEmpty()) {
        System.out.println("Không có dịch vụ nào.");
    } else {
        for (Service service : services) {
            System.out.println("Service ID: " + service.getId() +
                               ", Name: " + service.getName() +
                               ", Description: " + service.getDescription() +
                               ", Price: " + service.getPrice() +
                               ", Category: " + service.getCategory().getCategoryname());
        }
    }
}

}
