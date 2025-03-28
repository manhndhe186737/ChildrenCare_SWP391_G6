package dal;

import model.Post;
import model.PostCategory;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class PostDBContext extends DBContext {

    /**
     * Lấy danh sách bài viết với các tiêu chí lọc và sắp xếp
     */
    public List<Post> getPostsWithSorting(String categoryId, java.sql.Date fromDate, java.sql.Date toDate,
                                          String sortBy, String sortOrder, int page, int pageSize) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.fullname AS author_name, pc.name AS category_name " +
                     "FROM posts p " +
                     "LEFT JOIN users u ON p.author_id = u.user_id " +
                     "INNER JOIN postcategories pc ON p.category_id = pc.category_id " +
                     "WHERE p.status = 1 AND pc.status = 1 ";

        List<Object> params = new ArrayList<>();

        // Xử lý categoryId với kiểm tra ngoại lệ
        Integer categoryIdInt = null;
        if (categoryId != null && !categoryId.trim().isEmpty()) {
            try {
                categoryIdInt = Integer.parseInt(categoryId);
                sql += " AND p.category_id = ? ";
                params.add(categoryIdInt);
            } catch (NumberFormatException e) {
                System.err.println("Invalid categoryId in getPostsWithSorting: " + categoryId);
            }
        }

        // Xử lý fromDate và toDate
        if (fromDate != null) {
            sql += " AND p.createdate >= ? ";
            params.add(fromDate);
        }

        if (toDate != null) {
            sql += " AND p.createdate <= ? ";
            params.add(toDate);
        }

        // Xử lý sắp xếp
        Set<String> validSortColumns = Set.of("p.createdate", "pc.name");
        String validSortOrder = "DESC".equalsIgnoreCase(sortOrder) ? "DESC" : "ASC";

        if (sortBy == null || !validSortColumns.contains(sortBy)) {
            sortBy = "p.createdate"; // Mặc định sắp xếp theo ngày tạo
        }

        sql += " ORDER BY " + sortBy + " " + validSortOrder;

        // Thêm phân trang
        sql += " LIMIT ? OFFSET ?";
        params.add(pageSize);
        params.add((page - 1) * pageSize);

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

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
                post.setAuthor(String.valueOf(rs.getInt("author_id")));
                posts.add(post);
            }
        } catch (SQLException e) {
            System.err.println("Error in getPostsWithSorting: " + e.getMessage());
            e.printStackTrace();
        }
        return posts;
    }

    /**
     * Lấy tổng số bài viết dựa trên các tiêu chí lọc
     */
    public int getTotalSearchPosts(String searchQuery, String categoryId, java.sql.Date fromDate, java.sql.Date toDate) {
        String sql = "SELECT COUNT(*) FROM posts p " +
                     "INNER JOIN postcategories pc ON p.category_id = pc.category_id " +
                     "WHERE p.status = 1 AND pc.status = 1 ";

        List<Object> params = new ArrayList<>();

        // Xử lý tìm kiếm
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            sql += " AND (p.title LIKE ? OR p.content LIKE ?) ";
            params.add("%" + searchQuery + "%");
            params.add("%" + searchQuery + "%");
        }

        // Xử lý categoryId
        Integer categoryIdInt = null;
        if (categoryId != null && !categoryId.trim().isEmpty()) {
            try {
                categoryIdInt = Integer.parseInt(categoryId);
                sql += " AND p.category_id = ? ";
                params.add(categoryIdInt);
            } catch (NumberFormatException e) {
                System.err.println("Invalid categoryId in getTotalSearchPosts: " + categoryId);
            }
        }

        // Xử lý fromDate và toDate
        if (fromDate != null) {
            sql += " AND p.createdate >= ? ";
            params.add(fromDate);
        }

        if (toDate != null) {
            sql += " AND p.createdate <= ? ";
            params.add(toDate);
        }

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error in getTotalSearchPosts: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Lấy danh sách bài viết với phân trang và các tiêu chí lọc (dành cho quản lý bài viết)
     */
    public List<Post> getPaginatedPosts(int page, int pageSize, String categoryId, String author, String status,
                                        String search, String sortBy, String order, boolean includeInactiveCategories) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.fullname AS author_name, pc.name AS category_name " +
                     "FROM posts p " +
                     "LEFT JOIN users u ON p.author_id = u.user_id " +
                     "INNER JOIN postcategories pc ON p.category_id = pc.category_id " +
                     "WHERE 1=1 ";

        List<Object> params = new ArrayList<>();

        if (!includeInactiveCategories) {
            sql += " AND pc.status = 1 ";
        }

        // Xử lý categoryId
        Integer categoryIdInt = null;
        if (categoryId != null && !categoryId.trim().isEmpty()) {
            try {
                categoryIdInt = Integer.parseInt(categoryId);
                sql += " AND p.category_id = ? ";
                params.add(categoryIdInt);
            } catch (NumberFormatException e) {
                System.err.println("Invalid categoryId in getPaginatedPosts: " + categoryId);
            }
        }

        // Xử lý author
        Integer authorIdInt = null;
        if (author != null && !author.trim().isEmpty()) {
            try {
                authorIdInt = Integer.parseInt(author);
                sql += " AND p.author_id = ? ";
                params.add(authorIdInt);
            } catch (NumberFormatException e) {
                System.err.println("Invalid authorId in getPaginatedPosts: " + author);
            }
        }

        // Xử lý status
        if (status != null && !status.trim().isEmpty()) {
            sql += " AND p.status = ? ";
            params.add(status);
        }

        // Xử lý tìm kiếm
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND p.title LIKE ? ";
            params.add("%" + search + "%");
        }

        // Xử lý sắp xếp
        Set<String> validSortColumns = Set.of("p.title", "pc.name", "u.fullname", "p.status", "p.updatedate");
        if (sortBy == null || !validSortColumns.contains(sortBy)) {
            sortBy = "p.updatedate";
        }
        String validOrder = "ASC".equalsIgnoreCase(order) ? "ASC" : "DESC";
        sql += " ORDER BY " + sortBy + " " + validOrder;

        // Thêm phân trang
        sql += " LIMIT ? OFFSET ?";
        params.add(pageSize);
        params.add((page - 1) * pageSize);

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

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
                post.setAuthor(String.valueOf(rs.getInt("author_id")));
                posts.add(post);
            }
        } catch (SQLException e) {
            System.err.println("Error in getPaginatedPosts: " + e.getMessage());
            e.printStackTrace();
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
        String sql = "SELECT COUNT(*) FROM posts p " +
                     "INNER JOIN postcategories pc ON p.category_id = pc.category_id " +
                     "WHERE 1=1 ";

        List<Object> params = new ArrayList<>();

        if (!includeInactiveCategories) {
            sql += " AND pc.status = 1 ";
        }

        // Xử lý categoryId
        Integer categoryIdInt = null;
        if (categoryId != null && !categoryId.trim().isEmpty()) {
            try {
                categoryIdInt = Integer.parseInt(categoryId);
                sql += " AND p.category_id = ? ";
                params.add(categoryIdInt);
            } catch (NumberFormatException e) {
                System.err.println("Invalid categoryId in getTotalPosts: " + categoryId);
            }
        }

        // Xử lý author
        Integer authorIdInt = null;
        if (author != null && !author.trim().isEmpty()) {
            try {
                authorIdInt = Integer.parseInt(author);
                sql += " AND p.author_id = ? ";
                params.add(authorIdInt);
            } catch (NumberFormatException e) {
                System.err.println("Invalid authorId in getTotalPosts: " + author);
            }
        }

        // Xử lý status
        if (status != null && !status.trim().isEmpty()) {
            sql += " AND p.status = ? ";
            params.add(status);
        }

        // Xử lý tìm kiếm
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND p.title LIKE ? ";
            params.add("%" + search + "%");
        }

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error in getTotalPosts: " + e.getMessage());
            e.printStackTrace();
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
        String sql = "SELECT p.*, u.fullname AS author_name, u.avatar AS author_avatar, pc.name AS category_name, pc.status AS category_status " +
                     "FROM posts p " +
                     "LEFT JOIN users u ON p.author_id = u.user_id " +
                     "INNER JOIN postcategories pc ON p.category_id = pc.category_id " +
                     "WHERE p.post_id = ? ";

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
                post.setAuthor(String.valueOf(rs.getInt("author_id")));

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
            System.err.println("Error in getPostById: " + e.getMessage());
            e.printStackTrace();
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
     * Phương thức tiện ích: Lấy bài viết công khai theo ID (không bao gồm danh mục không hoạt động)
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
            System.err.println("Error in addPost: " + e.getMessage());
            e.printStackTrace();
        } catch (NumberFormatException e) {
            System.err.println("Invalid authorId in addPost: " + post.getAuthor());
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
            System.err.println("Error in updatePost: " + e.getMessage());
            e.printStackTrace();
        } catch (NumberFormatException e) {
            System.err.println("Invalid authorId in updatePost: " + post.getAuthor());
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
            System.err.println("Error in deletePost: " + e.getMessage());
            e.printStackTrace();
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
            System.err.println("Error in updatePostStatus: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Lấy danh sách bài viết theo danh mục
     */
    public ArrayList<Post> getPostsByCategoryId(int categoryId, boolean includeInactiveStatuses) {
        ArrayList<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.fullname AS author_name, pc.name AS category_name " +
                     "FROM posts p " +
                     "LEFT JOIN users u ON p.author_id = u.user_id " +
                     "INNER JOIN postcategories pc ON p.category_id = pc.category_id " +
                     "WHERE p.category_id = ? ";

        if (!includeInactiveStatuses) {
            sql += " AND p.status = 1 AND pc.status = 1 ";
        }

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
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
                post.setCategoryId(categoryId);
                post.setAuthor(String.valueOf(rs.getInt("author_id")));
                posts.add(post);
            }
        } catch (SQLException e) {
            System.err.println("Error in getPostsByCategoryId: " + e.getMessage());
            e.printStackTrace();
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
    public List<Post> getPostsWithSorting(String searchQuery, String categoryId, java.sql.Date fromDate, java.sql.Date toDate,
                                      String sortBy, String sortOrder, int page, int pageSize) {
    List<Post> posts = new ArrayList<>();
    String sql = "SELECT p.*, u.fullname AS author_name, pc.name AS category_name " +
                 "FROM posts p " +
                 "LEFT JOIN users u ON p.author_id = u.user_id " +
                 "INNER JOIN postcategories pc ON p.category_id = pc.category_id " +
                 "WHERE p.status = 1 AND pc.status = 1 ";

    List<Object> params = new ArrayList<>();

    // Xử lý tìm kiếm
    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
        sql += " AND (p.title LIKE ? OR p.content LIKE ?) ";
        params.add("%" + searchQuery + "%");
        params.add("%" + searchQuery + "%");
    }

    // Xử lý categoryId
    Integer categoryIdInt = null;
    if (categoryId != null && !categoryId.trim().isEmpty()) {
        try {
            categoryIdInt = Integer.parseInt(categoryId);
            sql += " AND p.category_id = ? ";
            params.add(categoryIdInt);
        } catch (NumberFormatException e) {
            System.err.println("Invalid categoryId in getPostsWithSorting: " + categoryId);
        }
    }

    // Xử lý fromDate và toDate
    if (fromDate != null) {
        sql += " AND p.createdate >= ? ";
        params.add(fromDate);
    }

    if (toDate != null) {
        sql += " AND p.createdate <= ? ";
        params.add(toDate);
    }

    // Xử lý sắp xếp
    Set<String> validSortColumns = Set.of("p.createdate", "pc.name");
    String validSortOrder = "DESC".equalsIgnoreCase(sortOrder) ? "DESC" : "ASC";

    if (sortBy == null || !validSortColumns.contains(sortBy)) {
        sortBy = "p.createdate";
    }

    sql += " ORDER BY " + sortBy + " " + validSortOrder;

    // Thêm phân trang
    sql += " LIMIT ? OFFSET ?";
    params.add(pageSize);
    params.add((page - 1) * pageSize);

    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        for (int i = 0; i < params.size(); i++) {
            stmt.setObject(i + 1, params.get(i));
        }

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
            post.setAuthor(String.valueOf(rs.getInt("author_id")));
            posts.add(post);
        }
    } catch (SQLException e) {
        System.err.println("Error in getPostsWithSorting: " + e.getMessage());
        e.printStackTrace();
    }
    return posts;
}

    /**
     * Lấy tất cả danh mục
     */
    public ArrayList<PostCategory> getAllCategories(boolean includeInactive) {
        ArrayList<PostCategory> categories = new ArrayList<>();
        String sql = "SELECT category_id, name, description, status FROM postcategories";

        if (!includeInactive) {
            sql += " WHERE status = 1";
        }

        sql += " ORDER BY name ASC";

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
            System.err.println("Error in getAllCategories: " + e.getMessage());
            e.printStackTrace();
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
            System.err.println("Error in getAllAuthors: " + e.getMessage());
            e.printStackTrace();
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
        } catch (SQLException e) {
            System.err.println("Error in getHomePosts: " + e.getMessage());
            e.printStackTrace();
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
            System.err.println("Error in searchPosts: " + e.getMessage());
            e.printStackTrace();
        }
        return posts;
    }
}