package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Service;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.List;
import model.Service;
import dal.DBContext;
import model.ServiceCategory;

public class ServiceDAO extends DBContext {

    public ArrayList<Service> getAllServices() {
        ArrayList<Service> services = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {

            String sql = "SELECT service_id, name, description, price, category_id, isActive, img FROM services";
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery(); // THÊM DÒNG NÀY ĐỂ LẤY DỮ LIỆU

            while (rs.next()) {
                Service service = new Service();
                service.setId(rs.getInt("service_id"));
                service.setName(rs.getString("name"));
                service.setDescription(rs.getString("description"));
                service.setPrice(rs.getFloat("price"));
                service.setCategoryId(rs.getInt("category_id"));
                service.setImg(rs.getString("img"));
                service.setIsActive(rs.getBoolean("isActive"));

                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    public Service getServiceById(int id) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Service service = null;

        try {
            String sql = "SELECT service_id, name, description, price, category_id, isActive , img FROM services WHERE service_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();

            if (rs.next()) {
                service = new Service();
                service.setId(rs.getInt("service_id"));
                service.setName(rs.getString("name"));
                service.setDescription(rs.getString("description"));
                service.setPrice(rs.getFloat("price"));
                service.setCategoryId(rs.getInt("category_id"));
                service.setImg(rs.getString("img"));
                service.setIsActive(rs.getBoolean("isActive"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return service;
    }

    public boolean updateProduct(int id, String name, float price, String description, String img) {
        String sql = "UPDATE services SET name = ?, price = ?, description = ?, img = ? WHERE service_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setFloat(2, price);
            stmt.setString(3, description);
            stmt.setString(4, img);
            stmt.setInt(5, id);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateStatus(int id, boolean status) {
        String sql = "UPDATE services SET isActive = ? WHERE service_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            // Nếu status là true thì set là 1, nếu là false thì set là 0
            stmt.setInt(1, status ? 1 : 0);
            stmt.setInt(2, id);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0; // Nếu cập nhật thành công, trả về true
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; 
    }


    
    public boolean addService(Service service) {
    String sql = "INSERT INTO services (name, price, description, category_id, isActive, img) VALUES (?, ?, ?, ?, ?, ?)";
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setString(1, service.getName());
        stmt.setFloat(2, service.getPrice());
        stmt.setString(3, service.getDescription());
        stmt.setInt(4, service.getCategoryId()); // Nếu bạn cần lấy Category ID từ đâu đó
        stmt.setBoolean(5, service.getIsActive());
        // Nếu imgUrl là null, bạn có thể set nó là null trong SQL
        if (service.getImg() != null) {
            stmt.setString(6, service.getImg());
        } else {
            stmt.setNull(6, java.sql.Types.NULL);
        }

        int rowsInserted = stmt.executeUpdate();
        return rowsInserted > 0; // Trả về true nếu thêm thành công
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false; // Nếu thất bại, trả về false
}


    public List<ServiceCategory> getCategoryNames() {
        List<ServiceCategory> categories = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT name , category_id FROM servicecategories";
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery(); // Thực thi truy vấn lấy tất cả các tên

            while (rs.next()) {
                ServiceCategory s = new ServiceCategory();
                s.setId(rs.getInt("category_id"));
                s.setCategoryname(rs.getString("name"));
                
                categories.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }
    
   public List<Service> searchCategories(String searchQuery) {
    List<Service> services = new ArrayList<>();
    PreparedStatement stm = null;
    ResultSet rs = null;

    try {
        // Câu lệnh SQL tìm kiếm dịch vụ theo tên
        String sql = "SELECT service_id, name, category_id FROM swp391_fix.services WHERE name LIKE ?";
        stm = connection.prepareStatement(sql);
        stm.setString(1, "%" + searchQuery + "%");  // Thêm dấu "%" để tìm kiếm theo phần của từ khóa

        rs = stm.executeQuery();  // Thực thi truy vấn và lấy kết quả

        while (rs.next()) {
            // Tạo đối tượng Service và gán giá trị từ resultSet
            Service service = new Service();
            service.setId(rs.getInt("service_id"));
            service.setName(rs.getString("name"));
            service.setCategoryId(rs.getInt("category_id"));
            services.add(service);  // Thêm vào danh sách dịch vụ
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Đóng kết nối và resultSet
        try {
            if (rs != null) rs.close();
            if (stm != null) stm.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    return services;  // Trả về danh sách các dịch vụ tìm được
}


}
