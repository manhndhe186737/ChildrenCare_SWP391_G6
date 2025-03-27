package dal;

import model.Post;
import model.PostCategory;
import java.sql.*;
import java.util.ArrayList;

public class PostCategoryDBContext extends DBContext {

    public ArrayList<PostCategory> getAllCategoriesWithPosts() {
        ArrayList<PostCategory> categories = new ArrayList<>();
        try {
            String sql = "SELECT category_id, name, status, description FROM postcategories "
                    + "WHERE status = 1";

            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            PostDBContext postDB = new PostDBContext();

            while (rs.next()) {
                PostCategory category = new PostCategory();
                category.setId(rs.getInt("category_id"));
                category.setName(rs.getString("name"));
                category.setStatus(rs.getBoolean("status"));
                category.setDescription(rs.getString("description"));

                ArrayList<Post> posts = postDB.getPostsByCategoryId(category.getId());
                category.setPosts(posts);

                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    public void addCategory(PostCategory category) {
        try {
            String sql = "INSERT INTO postcategories (name, description, status) VALUES (?, ?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, category.getName());
            stm.setString(2, category.getDescription());
            stm.setBoolean(3, category.isStatus());

            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateCategory(PostCategory category) {
        try {
            String sql = "UPDATE postcategories SET name = ?, status = ?, description = ? WHERE category_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, category.getName());
            stm.setBoolean(2, category.isStatus());
            stm.setString(3, category.getDescription());
            stm.setInt(4, category.getId());
            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<PostCategory> getCategoriesWithFilterAndPagination(String nameFilter, Boolean statusFilter, int page, int pageSize) {
        ArrayList<PostCategory> categories = new ArrayList<>();
        try {
            StringBuilder sql = new StringBuilder("SELECT category_id, name, status, description FROM postcategories WHERE 1=1 ");

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
            PostDBContext postDB = new PostDBContext();

            while (rs.next()) {
                PostCategory category = new PostCategory();
                category.setId(rs.getInt("category_id"));
                category.setName(rs.getString("name"));
                category.setStatus(rs.getBoolean("status"));
                category.setDescription(rs.getString("description"));

                ArrayList<Post> posts = postDB.getPostsByCategoryId(category.getId());
                category.setPosts(posts);

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
            StringBuilder sql = new StringBuilder("SELECT COUNT(*) AS total FROM postcategories WHERE 1=1 ");

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

    public PostCategory getCategoryById(int id) {
        PostCategory category = null;
        try {
            String sql = "SELECT category_id, name, status, description FROM postcategories WHERE category_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                category = new PostCategory();
                category.setId(rs.getInt("category_id"));
                category.setName(rs.getString("name"));
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
            String sql = "UPDATE postcategories SET status = ? WHERE category_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setBoolean(1, status);
            stm.setInt(2, id);
            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}