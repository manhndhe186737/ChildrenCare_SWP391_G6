package dal;

import model.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDBContext extends DBContext {

   public List<Post> getPaginatedPosts(int page, int pageSize, String category, String author, String status, String search, String sortBy, String order) {
    List<Post> posts = new ArrayList<>();
    String sql = "SELECT p.*, u.fullname AS author_name FROM posts p "
            + "LEFT JOIN users u ON p.author_id = u.user_id WHERE 1=1 ";

    // Bộ lọc dữ liệu
    if (category != null && !category.isEmpty()) {
        sql += " AND p.category = ? ";
    }
    if (author != null && !author.isEmpty()) {
        sql += " AND p.author_id = ? ";
    }
    if (status != null && !status.isEmpty()) {
        sql += " AND p.status = ? ";
    }
    if (search != null && !search.isEmpty()) {
        sql += " AND p.title LIKE ? ";
    }

    // Kiểm tra cột sắp xếp hợp lệ
    String validSortColumns = "p.title, p.category, author_name, p.status";
    if (sortBy == null || !validSortColumns.contains(sortBy)) {
        sortBy = "p.updatedate"; // Mặc định sắp xếp theo ngày cập nhật
    }
    if (!"ASC".equalsIgnoreCase(order) && !"DESC".equalsIgnoreCase(order)) {
        order = "DESC"; // Mặc định giảm dần
    }
    sql += " ORDER BY " + sortBy + " " + order;

    // Giới hạn phân trang
    sql += " LIMIT ?, ?";

    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        int paramIndex = 1;
        if (category != null && !category.isEmpty()) {
            stmt.setString(paramIndex++, category);
        }
        if (author != null && !author.isEmpty()) {
            stmt.setInt(paramIndex++, Integer.parseInt(author));
        }
        if (status != null && !status.isEmpty()) {
            stmt.setString(paramIndex++, status);
        }
        if (search != null && !search.isEmpty()) {
            stmt.setString(paramIndex++, "%" + search + "%");
        }
        stmt.setInt(paramIndex++, (page - 1) * pageSize);
        stmt.setInt(paramIndex, pageSize);

        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            posts.add(new Post(
                    rs.getInt("post_id"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getDate("updatedate"),
                    rs.getDate("createdate"),
                    rs.getString("status"),
                    rs.getString("image"),
                    rs.getString("category"),
                    rs.getString("author_name")
            ));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return posts;
}


    // Đếm tổng số bài viết theo điều kiện
    public int getTotalPosts(String category, String author, String status, String search) {
        String sql = "SELECT COUNT(*) FROM posts WHERE 1=1 ";
        if (category != null && !category.isEmpty()) {
            sql += " AND category = ? ";
        }
        if (author != null && !author.isEmpty()) {
            sql += " AND author_id = ? ";
        }
        if (status != null && !status.isEmpty()) {
            sql += " AND status = ? ";
        }
        if (search != null && !search.isEmpty()) {
            sql += " AND title LIKE ? ";
        }

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            if (category != null && !category.isEmpty()) {
                stmt.setString(paramIndex++, category);
            }
            if (author != null && !author.isEmpty()) {
                stmt.setInt(paramIndex++, Integer.parseInt(author));
            }
            if (status != null && !status.isEmpty()) {
                stmt.setString(paramIndex++, status);
            }
            if (search != null && !search.isEmpty()) {
                stmt.setString(paramIndex++, "%" + search + "%");
            }

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
        return 0;
    }

    // Lấy chi tiết bài viết theo ID
    public Post getPostById(int id) {
        String sql = "SELECT p.*, u.fullname AS author_name FROM posts p "
                + "LEFT JOIN users u ON p.author_id = u.user_id WHERE p.post_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Post(
                        rs.getInt("post_id"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getDate("updatedate"),
                        rs.getDate("createdate"),
                        rs.getString("status"),
                        rs.getString("image"),
                        rs.getString("category"),
                        rs.getString("author_name")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
        return null;
    }

    // Thêm bài viết mới
    public void addPost(Post post) {
        String sql = "INSERT INTO posts (title, content, updatedate, createdate, status, image, category, author_id) "
                + "VALUES (?, ?, NOW(), NOW(), ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, post.getTitle());
            stmt.setString(2, post.getContent());
            stmt.setString(3, post.getStatus());
            stmt.setString(4, post.getImg());
            stmt.setString(5, post.getCategory());
            stmt.setInt(6, Integer.parseInt(post.getAuthor()));
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();

        }
    }

    // Cập nhật bài viết
    public void updatePost(Post post) {
        String sql = "UPDATE posts SET title = ?, content = ?, updatedate = NOW(), status = ?, image = ?, category = ?, author_id = ? "
                + "WHERE post_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, post.getTitle());
            stmt.setString(2, post.getContent());
            stmt.setString(3, post.getStatus());
            stmt.setString(4, post.getImg());
            stmt.setString(5, post.getCategory());
            stmt.setInt(6, Integer.parseInt(post.getAuthor()));
            stmt.setInt(7, post.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();

        }
    }

    // Xóa bài viết
    public void deletePost(int id) {
        String sql = "DELETE FROM posts WHERE post_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();

        }
    }

    // Cập nhật trạng thái bài viết (Ẩn/Hiện)
    public void updatePostStatus(int id, String status) {
        String sql = "UPDATE posts SET status = ? WHERE post_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();

        }
    }

    // Lấy danh sách tất cả các danh mục có trong bảng posts
    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT category FROM posts";
        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
        } catch (SQLException e) {
            System.err.println("Error fetching categories: " + e.getMessage());
        }
        return categories;
    }

public List<String[]> getAllAuthors() {
    List<String[]> authors = new ArrayList<>();
    String sql = "SELECT u.user_id, u.fullname " +
                 "FROM users u " +
                 "JOIN accounts a ON u.user_id = a.user_id " +
                 "JOIN userroles ur ON a.email = ur.email " +
                 "JOIN roles r ON ur.role_id = r.role_id " +
                 "WHERE r.role_name = ?";  

    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setString(1, "Marketing Staff"); 

        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                authors.add(new String[]{rs.getString("user_id"), rs.getString("fullname")});
            }
        }
    } catch (SQLException e) {
        System.err.println("Error fetching marketing authors: " + e.getMessage());
    }
    return authors;
}


}
