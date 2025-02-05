package dal;

import model.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDBContext extends DBContext {

    // Lấy danh sách bài viết với phân trang, lọc, tìm kiếm, sắp xếp
    public List<Post> getPaginatedPosts(int page, int pageSize, String category, String author, String status, String search, String sortBy, String order) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.fullname AS author_name FROM posts p " +
                     "LEFT JOIN users u ON p.author_id = u.user_id WHERE 1=1 ";

        if (category != null && !category.isEmpty()) sql += " AND p.category = ? ";
        if (author != null && !author.isEmpty()) sql += " AND p.author_id = ? ";
        if (status != null && !status.isEmpty()) sql += " AND p.status = ? ";
        if (search != null && !search.isEmpty()) sql += " AND p.title LIKE ? ";
        if (sortBy != null && !sortBy.isEmpty()) sql += " ORDER BY " + sortBy + " " + order;
        else sql += " ORDER BY p.updatedate DESC ";
        sql += " LIMIT ?, ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            if (category != null && !category.isEmpty()) stmt.setString(paramIndex++, category);
            if (author != null && !author.isEmpty()) stmt.setInt(paramIndex++, Integer.parseInt(author));
            if (status != null && !status.isEmpty()) stmt.setString(paramIndex++, status);
            if (search != null && !search.isEmpty()) stmt.setString(paramIndex++, "%" + search + "%");
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
                    rs.getString("author_name") // Lấy tên tác giả từ bảng users
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
        if (category != null && !category.isEmpty()) sql += " AND category = ? ";
        if (author != null && !author.isEmpty()) sql += " AND author_id = ? ";
        if (status != null && !status.isEmpty()) sql += " AND status = ? ";
        if (search != null && !search.isEmpty()) sql += " AND title LIKE ? ";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            if (category != null && !category.isEmpty()) stmt.setString(paramIndex++, category);
            if (author != null && !author.isEmpty()) stmt.setInt(paramIndex++, Integer.parseInt(author));
            if (status != null && !status.isEmpty()) stmt.setString(paramIndex++, status);
            if (search != null && !search.isEmpty()) stmt.setString(paramIndex++, "%" + search + "%");

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Lấy chi tiết bài viết theo ID
    public Post getPostById(int id) {
        String sql = "SELECT p.*, u.fullname AS author_name FROM posts p " +
                     "LEFT JOIN users u ON p.author_id = u.user_id WHERE p.post_id = ?";
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
        String sql = "INSERT INTO posts (title, content, updatedate, createdate, status, image, category, author_id) " +
                     "VALUES (?, ?, NOW(), NOW(), ?, ?, ?, ?)";
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
        String sql = "UPDATE posts SET title = ?, content = ?, updatedate = NOW(), status = ?, image = ?, category = ?, author_id = ? " +
                     "WHERE post_id = ?";
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
}
