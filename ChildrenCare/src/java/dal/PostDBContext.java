package dal;

import model.Post;
import model.PostCategory;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PostDBContext extends DBContext {

    private static final Logger LOGGER = Logger.getLogger(PostDBContext.class.getName());

    /**
     * Lấy danh sách bài viết với các tiêu chí lọc và sắp xếp (Thay thế getPostsWithSorting)
     */
    public List<Post> getPostsWithFiltersAndSorting(String searchQuery, String categoryId, java.sql.Date fromDate, 
            java.sql.Date toDate, String sortBy, String sortOrder, int page, int pageSize) {
        List<Post> posts = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT p.*, u.fullname AS author_name, pc.name AS category_name " +
            "FROM posts p " +
            "LEFT JOIN users u ON p.author_id = u.user_id " +
            "INNER JOIN postcategories pc ON p.category_id = pc.category_id " +
            "WHERE p.status = 1 AND pc.status = 1 "
        );
        List<Object> params = new ArrayList<>();

        // Xử lý tìm kiếm
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            sql.append("AND (p.title LIKE ? OR p.content LIKE ?) ");
            params.add("%" + searchQuery + "%");
            params.add("%" + searchQuery + "%");
        }

        // Xử lý categoryId
        if (categoryId != null && !categoryId.trim().isEmpty()) {
            try {
                int categoryIdInt = Integer.parseInt(categoryId);
                sql.append("AND p.category_id = ? ");
                params.add(categoryIdInt);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid categoryId: " + categoryId, e);
            }
        }

        // Xử lý fromDate và toDate
        if (fromDate != null) {
            sql.append("AND p.createdate >= ? ");
            params.add(fromDate);
        }
        if (toDate != null) {
            sql.append("AND p.createdate <= ? ");
            params.add(toDate);
        }

        // Xử lý sắp xếp
        Set<String> validSortColumns = Set.of("p.createdate", "pc.name");
        String validSortOrder = "DESC".equalsIgnoreCase(sortOrder) ? "DESC" : "ASC";
        String sortColumn = (sortBy != null && validSortColumns.contains(sortBy)) ? sortBy : "p.createdate";
        sql.append("ORDER BY ").append(sortColumn).append(" ").append(validSortOrder);

        // Thêm phân trang
        sql.append(" LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add((page - 1) * pageSize);

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            setParameters(stmt, params);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                posts.add(extractPostFromResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getPostsWithFiltersAndSorting: " + e.getMessage(), e);
        }
        return posts;
    }

    /**
     * Lấy tổng số bài viết dựa trên các tiêu chí lọc (Thay thế getTotalSearchPosts)
     */
    public int getTotalPostsWithFilters(String searchQuery, String categoryId, java.sql.Date fromDate, java.sql.Date toDate) {
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) FROM posts p " +
            "INNER JOIN postcategories pc ON p.category_id = pc.category_id " +
            "WHERE p.status = 1 AND pc.status = 1 "
        );
        List<Object> params = new ArrayList<>();

        // Xử lý tìm kiếm
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            sql.append("AND (p.title LIKE ? OR p.content LIKE ?) ");
            params.add("%" + searchQuery + "%");
            params.add("%" + searchQuery + "%");
        }

        // Xử lý categoryId
        if (categoryId != null && !categoryId.trim().isEmpty()) {
            try {
                int categoryIdInt = Integer.parseInt(categoryId);
                sql.append("AND p.category_id = ? ");
                params.add(categoryIdInt);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid categoryId: " + categoryId, e);
            }
        }

        // Xử lý fromDate và toDate
        if (fromDate != null) {
            sql.append("AND p.createdate >= ? ");
            params.add(fromDate);
        }
        if (toDate != null) {
            sql.append("AND p.createdate <= ? ");
            params.add(toDate);
        }

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            setParameters(stmt, params);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getTotalPostsWithFilters: " + e.getMessage(), e);
        }
        return 0;
    }

    /**
     * Lấy danh sách bài viết với phân trang và các tiêu chí lọc (dành cho quản lý bài viết)
     */
  public List<Post> getPaginatedPosts(int page, int pageSize, String categoryId, String author, String status,
                                    String search, String sortBy, String order, boolean includeInactiveCategories) {
    List<Post> posts = new ArrayList<>();
    StringBuilder sql = new StringBuilder(
        "SELECT p.*, u.fullname AS author_name, pc.name AS category_name " +
        "FROM posts p " +
        "LEFT JOIN users u ON p.author_id = u.user_id " +
        "INNER JOIN postcategories pc ON p.category_id = pc.category_id " +
        "WHERE 1=1 "
    );
    List<Object> params = new ArrayList<>();

    if (!includeInactiveCategories) {
        sql.append("AND pc.status = 1 ");
    }

    // Xử lý categoryId
    if (categoryId != null && !categoryId.trim().isEmpty()) {
        try {
            int categoryIdInt = Integer.parseInt(categoryId);
            sql.append("AND p.category_id = ? ");
            params.add(categoryIdInt);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid categoryId in getPaginatedPosts: " + categoryId, e);
        }
    }

    // Xử lý author
    if (author != null && !author.trim().isEmpty()) {
        try {
            int authorIdInt = Integer.parseInt(author);
            sql.append("AND p.author_id = ? ");
            params.add(authorIdInt);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid authorId in getPaginatedPosts: " + author, e);
        }
    }

    // Xử lý status
    if (status != null && !status.trim().isEmpty()) {
        sql.append("AND p.status = ? ");
        params.add(status);
    }

    // Xử lý tìm kiếm
    if (search != null && !search.trim().isEmpty()) {
        sql.append("AND p.title LIKE ? ");
        params.add("%" + search + "%");
    }

    // Xử lý sắp xếp
    Set<String> validSortColumns = Set.of("p.title", "pc.name", "u.fullname", "p.status", "p.updatedate");
    String validSortOrder = "ASC".equalsIgnoreCase(order) ? "ASC" : "DESC";
    String sortColumn = validSortColumns.contains(sortBy) ? sortBy : "p.updatedate";
    sql.append("ORDER BY ").append(sortColumn).append(" ").append(validSortOrder);

    // Thêm phân trang
    sql.append(" LIMIT ? OFFSET ?");
    params.add(pageSize);
    params.add((page - 1) * pageSize);

    try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
        setParameters(stmt, params);
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
            //post.setAuthor(String.valueOf(rs.getInt("author_id")));
            posts.add(post);
        }
    } catch (SQLException e) {
        LOGGER.log(Level.SEVERE, "Error in getPaginatedPosts: " + e.getMessage(), e);
    }
    return posts;
}
    /**
     * Phương thức tiện ích: Lấy danh sách bài viết với phân trang (không bao gồm danh mục không hoạt động)
     */
    public List<Post> getPaginatedPosts(int page, int pageSize, String categoryId, String author, String status,
                                        String search, String sortBy, String order) {
        return getPaginatedPosts(page, pageSize, categoryId, author, status, search, sortBy, order, false);
    }

    /**
     * Lấy tổng số bài viết dựa trên các tiêu chí lọc (dành cho quản lý bài viết)
     */
    public int getTotalPosts(String categoryId, String author, String status, String search, boolean includeInactiveCategories) {
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) FROM posts p " +
            "INNER JOIN postcategories pc ON p.category_id = pc.category_id " +
            "WHERE 1=1 "
        );
        List<Object> params = new ArrayList<>();

        if (!includeInactiveCategories) {
            sql.append("AND pc.status = 1 ");
        }

        // Xử lý categoryId
        if (categoryId != null && !categoryId.trim().isEmpty()) {
            try {
                int categoryIdInt = Integer.parseInt(categoryId);
                sql.append("AND p.category_id = ? ");
                params.add(categoryIdInt);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid categoryId in getTotalPosts: " + categoryId, e);
            }
        }

        // Xử lý author
        if (author != null && !author.trim().isEmpty()) {
            try {
                int authorIdInt = Integer.parseInt(author);
                sql.append("AND p.author_id = ? ");
                params.add(authorIdInt);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid authorId in getTotalPosts: " + author, e);
            }
        }

        // Xử lý status
        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND p.status = ? ");
            params.add(status);
        }

        // Xử lý tìm kiếm
        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND p.title LIKE ? ");
            params.add("%" + search + "%");
        }

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            setParameters(stmt, params);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getTotalPosts: " + e.getMessage(), e);
        }
        return 0;
    }

    /**
     * Phương thức tiện ích: Lấy tổng số bài viết (không bao gồm danh mục không hoạt động)
     */
    public int getTotalPosts(String categoryId, String author, String status, String search) {
        return getTotalPosts(categoryId, author, status, search, false);
    }

    /**
     * Lấy bài viết theo ID
     */
    public Post getPostById(int id, boolean includeInactiveCategory) {
        StringBuilder sql = new StringBuilder(
            "SELECT p.*, u.fullname AS author_name, u.avatar AS author_avatar, pc.name AS category_name, pc.status AS category_status " +
            "FROM posts p " +
            "LEFT JOIN users u ON p.author_id = u.user_id " +
            "INNER JOIN postcategories pc ON p.category_id = pc.category_id " +
            "WHERE p.post_id = ? "
        );
        if (!includeInactiveCategory) {
            sql.append("AND pc.status = 1 ");
        }

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Post post = extractPostFromResultSet(rs);
                post.setAuthorAvatar(rs.getString("author_avatar"));
                if (rs.getObject("category_id") != null) {
                    PostCategory category = new PostCategory();
                    category.setId(rs.getInt("category_id"));
                    category.setName(rs.getString("category_name"));
                    category.setStatus(rs.getBoolean("category_status"));
                    post.setPostCategory(category);
                }
                return post;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getPostById: " + e.getMessage(), e);
        }
        return null;
    }

    /**
     * Phương thức tiện ích: Lấy bài viết theo ID (bao gồm cả danh mục không hoạt động)
     */
    public Post getPostById(int id) {
        return getPostById(id, true);
    }

    /**
     * Phương thức tiện ích: Lấy bài viết công khai theo ID
     */
    public Post getPublicPostById(int id) {
        return getPostById(id, false);
    }

    /**
     * Thêm bài viết mới
     */
    public void addPost(Post post) {
        String sql = "INSERT INTO posts (title, content, updatedate, createdate, status, image, category_id, author_id) " +
                     "VALUES (?, ?, NOW(), NOW(), ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, post.getTitle());
            stmt.setString(2, post.getContent());
            stmt.setString(3, post.getStatus());
            stmt.setString(4, post.getImg());
            stmt.setInt(5, post.getCategoryId());
            stmt.setInt(6, Integer.parseInt(post.getAuthor()));
            stmt.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in addPost: " + e.getMessage(), e);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid authorId in addPost: " + post.getAuthor(), e);
        }
    }

    /**
     * Cập nhật bài viết
     */
    public void updatePost(Post post) {
        String sql = "UPDATE posts SET title = ?, content = ?, updatedate = NOW(), status = ?, image = ?, category_id = ?, author_id = ? " +
                     "WHERE post_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, post.getTitle());
            stmt.setString(2, post.getContent());
            stmt.setString(3, post.getStatus());
            stmt.setString(4, post.getImg());
            stmt.setInt(5, post.getCategoryId());
            stmt.setInt(6, Integer.parseInt(post.getAuthor()));
            stmt.setInt(7, post.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in updatePost: " + e.getMessage(), e);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid authorId in updatePost: " + post.getAuthor(), e);
        }
    }

    /**
     * Xóa bài viết
     */
    public void deletePost(int id) {
        String sql = "DELETE FROM posts WHERE post_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in deletePost: " + e.getMessage(), e);
        }
    }

    /**
     * Cập nhật trạng thái bài viết
     */
    public void updatePostStatus(int id, String status) {
        String sql = "UPDATE posts SET status = ? WHERE post_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in updatePostStatus: " + e.getMessage(), e);
        }
    }

    /**
     * Lấy danh sách bài viết theo danh mục
     */
    public ArrayList<Post> getPostsByCategoryId(int categoryId, boolean includeInactiveStatuses) {
        ArrayList<Post> posts = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT p.*, u.fullname AS author_name, pc.name AS category_name " +
            "FROM posts p " +
            "LEFT JOIN users u ON p.author_id = u.user_id " +
            "INNER JOIN postcategories pc ON p.category_id = pc.category_id " +
            "WHERE p.category_id = ? "
        );
        if (!includeInactiveStatuses) {
            sql.append("AND p.status = 1 AND pc.status = 1 ");
        }

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                posts.add(extractPostFromResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getPostsByCategoryId: " + e.getMessage(), e);
        }
        return posts;
    }

    /**
     * Phương thức tiện ích: Lấy danh sách bài viết theo danh mục (bao gồm cả trạng thái không hoạt động)
     */
    public ArrayList<Post> getPostsByCategoryId(int categoryId) {
        return getPostsByCategoryId(categoryId, true);
    }

    /**
     * Phương thức tiện ích: Lấy danh sách bài viết công khai theo danh mục
     */
    public ArrayList<Post> getPublicPostsByCategoryId(int categoryId) {
        return getPostsByCategoryId(categoryId, false);
    }

    /**
     * Lấy tất cả danh mục
     */
    public ArrayList<PostCategory> getAllCategories(boolean includeInactive) {
        ArrayList<PostCategory> categories = new ArrayList<>();
        String sql = "SELECT category_id, name, description, status FROM postcategories" +
                     (includeInactive ? "" : " WHERE status = 1") +
                     " ORDER BY name ASC";

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                PostCategory category = new PostCategory();
                category.setId(rs.getInt("category_id"));
                category.setName(rs.getString("name"));
                category.setDescription(rs.getString("description"));
                category.setStatus(rs.getBoolean("status"));
                categories.add(category);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getAllCategories: " + e.getMessage(), e);
        }
        return categories;
    }

    /**
     * Lấy danh sách tất cả tác giả (Marketing Staff)
     */
    public List<String[]> getAllAuthors() {
        List<String[]> authors = new ArrayList<>();
        String sql = "SELECT u.user_id, u.fullname " +
                     "FROM users u " +
                     "JOIN userroles ur ON u.email = ur.email " +
                     "JOIN roles r ON ur.role_id = r.role_id " +
                     "WHERE r.role_name = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "Marketing Staff");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                authors.add(new String[]{rs.getString("user_id"), rs.getString("fullname")});
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getAllAuthors: " + e.getMessage(), e);
        }
        return authors;
    }

    /**
     * Lấy danh sách bài viết cho trang chủ
     */
    public ArrayList<Post> getHomePosts() {
        ArrayList<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.fullname AS author_name, pc.name AS category_name " +
                     "FROM posts p " +
                     "INNER JOIN postcategories pc ON p.category_id = pc.category_id " +
                     "LEFT JOIN users u ON p.author_id = u.user_id " +
                     "WHERE p.status = 1 AND pc.status = 1 " +
                     "ORDER BY p.createdate DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                posts.add(extractPostFromResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getHomePosts: " + e.getMessage(), e);
        }
        return posts;
    }

    /**
     * Tìm kiếm bài viết với phân trang
     */
    public List<Post> searchPosts(String searchQuery, int currentPage, int itemsPerPage) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.fullname AS author_name, pc.name AS category_name " +
                     "FROM posts p " +
                     "INNER JOIN postcategories pc ON p.category_id = pc.category_id " +
                     "LEFT JOIN users u ON p.author_id = u.user_id " +
                     "WHERE (p.title LIKE ? OR p.content LIKE ?) AND p.status = 1 AND pc.status = 1 " +
                     "ORDER BY p.updatedate DESC LIMIT ? OFFSET ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "%" + searchQuery + "%");
            stmt.setString(2, "%" + searchQuery + "%");
            stmt.setInt(3, itemsPerPage);
            stmt.setInt(4, (currentPage - 1) * itemsPerPage);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                posts.add(extractPostFromResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in searchPosts: " + e.getMessage(), e);
        }
        return posts;
    }

    // Hàm phụ trợ: Trích xuất Post từ ResultSet
    private Post extractPostFromResultSet(ResultSet rs) throws SQLException {
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
        post.setAuthor(String.valueOf(rs.getInt("author_id")));
        return post;
    }

    // Hàm phụ trợ: Đặt tham số cho PreparedStatement
    private void setParameters(PreparedStatement stmt, List<Object> params) throws SQLException {
        for (int i = 0; i < params.size(); i++) {
            stmt.setObject(i + 1, params.get(i));
        }
    }
}