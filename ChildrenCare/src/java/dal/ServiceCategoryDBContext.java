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
}
