package dal;

import model.Post;
import model.PostCategory;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.User;

public class PostDBContext extends DBContext {

    public List<Post> getPaginatedPosts(int page, int pageSize, String categoryId, String author, String status, String search, String sortBy, String order, boolean includeInactiveCategories) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.fullname AS author_name, pc.name AS category_name FROM posts p "
                + "LEFT JOIN users u ON p.author_id = u.user_id "
                + "INNER JOIN postcategories pc ON p.category_id = pc.category_id "
                + "WHERE 1=1 ";

        // Thêm điều kiện lọc theo trạng thái danh mục nếu cần
        if (!includeInactiveCategories) {
            sql += " AND pc.status = 1 ";
        }

        // Bộ lọc dữ liệu
        if (categoryId != null && !categoryId.isEmpty()) {
            sql += " AND p.category_id = ? ";
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
        String validSortColumns = "p.title, category_name, author_name, p.status";
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
            if (categoryId != null && !categoryId.isEmpty()) {
                stmt.setInt(paramIndex++, Integer.parseInt(categoryId));
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
                Post post = new Post(
                        rs.getInt("post_id"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getDate("updatedate"),
                        rs.getDate("createdate"),
                        rs.getString("status"),
                        rs.getString("image"),
                        rs.getString("category_name"),
                        rs.getString("author_name")
                );
                post.setCategoryId(rs.getInt("category_id"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    // Tạo phiên bản overload có tham số mặc định
    public List<Post> getPaginatedPosts(int page, int pageSize, String categoryId, String author, String status, String search, String sortBy, String order) {
        // Mặc định là chỉ bao gồm các danh mục active khi hiển thị cho người dùng
        return getPaginatedPosts(page, pageSize, categoryId, author, status, search, sortBy, order, false);
    }

    // Đếm tổng số bài viết theo điều kiện
    public int getTotalPosts(String categoryId, String author, String status, String search, boolean includeInactiveCategories) {
        String sql = "SELECT COUNT(*) FROM posts p "
                + "INNER JOIN postcategories pc ON p.category_id = pc.category_id "
                + "WHERE 1=1 ";

        // Thêm điều kiện lọc theo trạng thái danh mục nếu cần
        if (!includeInactiveCategories) {
            sql += " AND pc.status = 1 ";
        }
        if (categoryId != null && !categoryId.isEmpty()) {
            sql += " AND p.category_id = ? ";
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

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            if (categoryId != null && !categoryId.isEmpty()) {
                stmt.setInt(paramIndex++, Integer.parseInt(categoryId));
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

            // In ra câu SQL để debug
            System.out.println("SQL: " + sql);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("Total posts count: " + count);
                return count;
            }
        } catch (SQLException e) {
            System.err.println("Error in getTotalPosts: " + e.getMessage());
            e.printStackTrace();
        } catch (NumberFormatException e) {
            System.err.println("Invalid number format in getTotalPosts: " + e.getMessage());
        }
        return 0;
    }

    // Tạo overload có tham số mặc định
    public int getTotalPosts(String categoryId, String author, String status, String search) {
        // Mặc định là chỉ đếm các bài viết có danh mục active
        return getTotalPosts(categoryId, author, status, search, false);
    }

    public Post getPostById(int id, boolean includeInactiveCategory) {
        String sql = "SELECT p.*, u.fullname AS author_name, u.avatar AS author_avatar, pc.name AS category_name, pc.status AS category_status "
                + "FROM posts p "
                + "LEFT JOIN users u ON p.author_id = u.user_id "
                + "INNER JOIN postcategories pc ON p.category_id = pc.category_id "
                + "WHERE p.post_id = ? ";

        // Thêm điều kiện lọc theo trạng thái danh mục nếu cần
        if (!includeInactiveCategory) {
            sql += " AND pc.status = 1 ";
        }
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Post post = new Post(
                        rs.getInt("post_id"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getDate("updatedate"),
                        rs.getDate("createdate"),
                        rs.getString("status"),
                        rs.getString("image"),
                        rs.getString("category_name"),
                        rs.getString("author_name")
                );
                post.setAuthorAvatar(rs.getString("author_avatar"));
                post.setCategoryId(rs.getInt("category_id"));

                // Create PostCategory object
                if (rs.getObject("category_id") != null) {
                    PostCategory category = new PostCategory();
                    category.setId(rs.getInt("category_id"));
                    category.setName(rs.getString("category_name"));
                    post.setPostCategory(category);
                }

                return post;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm bài viết mới
    public void addPost(Post post) {
        String sql = "INSERT INTO posts (title, content, updatedate, createdate, status, image, category_id, author_id) "
                + "VALUES (?, ?, NOW(), NOW(), ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, post.getTitle());
            stmt.setString(2, post.getContent());
            stmt.setString(3, post.getStatus());
            stmt.setString(4, post.getImg());
            stmt.setInt(5, post.getCategoryId());
            stmt.setInt(6, post.getAuthorId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Cập nhật bài viết
    public void updatePost(Post post) {
        String sql = "UPDATE posts SET title = ?, content = ?, updatedate = NOW(), status = ?, image = ?, category_id = ?, author_id = ? "
                + "WHERE post_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, post.getTitle());
            stmt.setString(2, post.getContent());
            stmt.setString(3, post.getStatus());
            stmt.setString(4, post.getImg());
            stmt.setInt(5, post.getCategoryId());
            stmt.setInt(6, post.getAuthorId());
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

    // Overload có tham số mặc định
    public Post getPostById(int id) {
        // Admin có thể xem tất cả các bài viết kể cả thuộc danh mục không active
        return getPostById(id, true);
    }

    // Phiên bản hiển thị cho người dùng - chỉ hiển thị bài viết thuộc danh mục active
    public Post getPublicPostById(int id) {
        return getPostById(id, false);
    }

    // Lấy danh sách các bài viết theo category_id
    public ArrayList<Post> getPostsByCategoryId(int categoryId, boolean includeInactiveStatuses) {
        ArrayList<Post> posts = new ArrayList<>();
        try {
            String sql = "SELECT p.*, u.fullname AS author_name, pc.name AS category_name "
                    + "FROM posts p "
                    + "LEFT JOIN users u ON p.author_id = u.user_id "
                    + "INNER JOIN postcategories pc ON p.category_id = pc.category_id "
                    + "WHERE p.category_id = ? ";

            if (!includeInactiveStatuses) {
                sql += " AND p.status = 1 AND pc.status = 1 ";
            }

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, categoryId);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Post post = new Post(
                        rs.getInt("post_id"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getDate("updatedate"),
                        rs.getDate("createdate"),
                        rs.getString("status"),
                        rs.getString("image"),
                        rs.getString("category_name"),
                        rs.getString("author_name")
                );
                post.setCategoryId(categoryId);
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    // Overload có tham số mặc định
    public ArrayList<Post> getPostsByCategoryId(int categoryId) {
        // Mặc định hiển thị cả các bài viết không active (dành cho admin)
        return getPostsByCategoryId(categoryId, true);
    }

    // Phiên bản cho người dùng - chỉ hiển thị bài viết active và thuộc danh mục active
    public ArrayList<Post> getPublicPostsByCategoryId(int categoryId) {
        return getPostsByCategoryId(categoryId, false);
    }

    // Lấy danh sách tất cả các danh mục từ bảng postcategories
    public ArrayList<PostCategory> getAllCategories(boolean includeInactive) {
        ArrayList<PostCategory> categories = new ArrayList<>();
        String sql = "SELECT category_id, name, description, status FROM postcategories";

        if (!includeInactive) {
            sql += " WHERE status = 1";
        }

        // Thêm ORDER BY để hiển thị danh mục theo thứ tự alphabet
        sql += " ORDER BY name ASC";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                PostCategory category = new PostCategory();
                category.setId(rs.getInt("category_id"));
                category.setName(rs.getString("name"));
                category.setDescription(rs.getString("description"));
                category.setStatus(rs.getBoolean("status"));
                categories.add(category);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching categories: " + e.getMessage());
        }
        return categories;
    }

    public List<String[]> getAllAuthors() {
        List<String[]> authors = new ArrayList<>();
        String sql = "SELECT u.user_id, u.fullname "
                + "FROM users u "
                + "JOIN userroles ur ON u.email = ur.email "
                + "JOIN roles r ON ur.role_id = r.role_id "
                + "WHERE r.role_name = ?";

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

    public ArrayList<Post> getHomePosts() {
        ArrayList<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.fullname AS author_name, pc.name AS category_name "
                + "FROM posts p "
                + "INNER JOIN postcategories pc ON p.category_id = pc.category_id "
                + "LEFT JOIN users u ON p.author_id = u.user_id "
                + "WHERE p.status = 1 AND pc.status = 1 "
                + "ORDER BY p.createdate DESC";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Post post = new Post();
                post.setId(rs.getInt("post_id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setImg(rs.getString("image"));
                post.setCreatedate(rs.getDate("createdate"));
                post.setUpdatedate(rs.getDate("updatedate"));
                post.setStatus(rs.getString("status"));
                post.setAuthor(String.valueOf(rs.getInt("author_id")));
                post.setCategoryId(rs.getInt("category_id"));
                post.setCategoryName(rs.getString("category_name"));
                posts.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return posts;
    }

    // Tìm kiếm bài viết có phân trang
    public List<Post> searchPosts(String searchQuery, int currentPage, int itemsPerPage) {
        List<Post> posts = new ArrayList<>();
        try {
            String sql = "SELECT p.*, u.fullname AS author_name, pc.name AS category_name "
                    + "FROM posts p "
                    + "INNER JOIN postcategories pc ON p.category_id = pc.category_id "
                    + "LEFT JOIN users u ON p.author_id = u.user_id "
                    + "WHERE (p.title LIKE ? OR p.content LIKE ?) AND p.status = 1 AND pc.status = 1 "
                    + "ORDER BY p.updatedate DESC LIMIT ? OFFSET ?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + searchQuery + "%");
            stm.setString(2, "%" + searchQuery + "%");
            stm.setInt(3, itemsPerPage);
            stm.setInt(4, (currentPage - 1) * itemsPerPage);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Post post = new Post();
                post.setId(rs.getInt("post_id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setCreatedate(rs.getDate("createdate"));
                post.setUpdatedate(rs.getDate("updatedate"));
                post.setStatus(rs.getString("status"));
                post.setImg(rs.getString("image"));
                post.setAuthor(String.valueOf(rs.getInt("author_id")));
                post.setCategoryId(rs.getInt("category_id"));
                post.setCategoryName(rs.getString("category_name"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    // Đếm tổng số bài viết theo từ khóa tìm kiếm
    public int getTotalSearchPosts(String searchQuery) {
        try {
            String sql = "SELECT COUNT(*) FROM posts p "
                    + "INNER JOIN postcategories pc ON p.category_id = pc.category_id "
                    + "WHERE (p.title LIKE ? OR p.content LIKE ?) AND p.status = 1 AND pc.status = 1";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + searchQuery + "%");
            stm.setString(2, "%" + searchQuery + "%");

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
