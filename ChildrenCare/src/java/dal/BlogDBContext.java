package dal;

import model.Blog;
import model.BlogDetail;
import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Post;

public class BlogDBContext extends DBContext {

    private static final Logger LOGGER = Logger.getLogger(BlogDBContext.class.getName());

    // Kiểm tra kết nối cơ sở dữ liệu
    public boolean testConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                return true;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối database", e);
        }
        return false;
    }

    // Lấy tất cả blog từ database
    public List<Blog> getAllBlogs() {
        return getBlogsFromQuery("SELECT blog_id, title, content, created_at, updated_at, author_id, status, featured_image, slug, meta_description, meta_keywords FROM blogs");
    }

    // Lấy blog theo ID
    public Blog getBlogById(int id) {
        Blog blog = null;
        String sql = "SELECT blog_id, title, content, created_at, updated_at, author_id, status, featured_image, slug, meta_description, meta_keywords FROM blogs WHERE blog_id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    blog = mapResultSetToBlog(rs);
                    LOGGER.info("Lấy thành công blog với ID: " + id);
                } else {
                    LOGGER.warning("Không tìm thấy blog với ID: " + id);
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy blog theo ID: " + id, ex);
        }
        return blog;
    }

    public List<Blog> getLatestBlogs() {
        // Lấy 3 bài viết có ID cao nhất (cuối cùng)
        return getBlogsFromQuery("SELECT blog_id, title, content, created_at, updated_at, author_id, status, featured_image, slug, meta_description, meta_keywords FROM blogs ORDER BY blog_id DESC LIMIT 3");
    }

    // Tìm kiếm blog theo từ khóa trong title với phân trang
    public List<Blog> searchBlogs(String query, int page, int pageSize) {
        List<Blog> blogs = new ArrayList<>();
        
        String normalizedQuery = query.trim().replaceAll("\\s+", "%");

        String sql = "SELECT blog_id, title, content, created_at, updated_at, author_id, status, featured_image, slug, meta_description, meta_keywords "
                + "FROM blogs WHERE title LIKE ? LIMIT ? OFFSET ?";  // Only search in title

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, "%" + query + "%");  // Tìm trong title
            stm.setInt(2, pageSize);  // Số lượng kết quả trên mỗi trang
            stm.setInt(3, (page - 1) * pageSize);  // Offset cho phân trang

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Blog blog = mapResultSetToBlog(rs);  // Assuming you have this method to map the result to Blog
                    blogs.add(blog);
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm kiếm blog với từ khóa: " + query, ex);
        }
        return blogs;
    }

    // Lấy tổng số blog dựa trên từ khóa tìm kiếm
    public int getTotalBlogs(String query) {
        String sql = "SELECT COUNT(*) FROM blogs WHERE title LIKE ?";  // Only count in title
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, "%" + query + "%");  // Tìm trong title

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);  // Trả về tổng số bài viết
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Lỗi khi đếm số blog với từ khóa: " + query, ex);
        }
        return 0;  // Nếu có lỗi hoặc không tìm thấy kết quả
    }

    // Phương thức dùng chung để lấy blogs từ một câu truy vấn
    private List<Blog> getBlogsFromQuery(String sql) {
        List<Blog> blogs = new ArrayList<>();
        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                Blog blog = mapResultSetToBlog(rs);
                blogs.add(blog);
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Lỗi khi thực thi truy vấn lấy blogs", ex);
        }
        LOGGER.log(Level.INFO, "Đã lấy được {0} bài viết.", blogs.size());
        return blogs;
    }

    // Chuyển đổi ResultSet thành đối tượng Blog
    private Blog mapResultSetToBlog(ResultSet rs) throws SQLException {
        Blog blog = new Blog();
        blog.setBlogId(rs.getInt("blog_id"));
        blog.setTitle(rs.getString("title"));
        blog.setContent(rs.getString("content"));
        blog.setCreatedAt(rs.getTimestamp("created_at"));
        blog.setUpdatedAt(rs.getTimestamp("updated_at"));
        blog.setAuthorId(rs.getInt("author_id"));
        blog.setStatus(rs.getByte("status"));
        blog.setFeaturedImage(rs.getString("featured_image"));
        blog.setSlug(rs.getString("slug"));
        blog.setMetaDescription(rs.getString("meta_description"));
        blog.setMetaKeywords(rs.getString("meta_keywords"));
        return blog;
    }

    // Lấy chi tiết của blog từ bảng blog_details
    public BlogDetail getBlogDetailByBlogId(int blogId) {
        BlogDetail blogDetail = null;
        String sql = "SELECT * FROM blog_details WHERE blog_id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, blogId);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    blogDetail = new BlogDetail();
                    blogDetail.setDetailId(rs.getInt("detail_id"));
                    blogDetail.setBlogId(rs.getInt("blog_id"));
                    blogDetail.setContent(rs.getString("content"));
                    blogDetail.setSectionTitle(rs.getString("section_title"));
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy chi tiết blog theo ID: " + blogId, ex);
        }
        return blogDetail;
    }

    public Blog getNewestBlog() {
        Blog blog = new Blog();
        String sql = "SELECT * FROM posts\n"
                + "ORDER BY created_at DESC\n"
                + "LIMIT 1";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                blog.setBlogId(rs.getInt("blog_id"));
                blog.setTitle(rs.getString("title"));
                blog.setContent(rs.getString("content"));
                blog.setFeaturedImage(rs.getString("featured_image"));
            }
        } catch (Exception e) {
        }
        return blog;
    }

    public Post getPostNew() {
        String sql = "SELECT p.*, u.fullname AS author_name, u.avatar AS author_avatar\n"
                + "FROM posts p\n"
                + "LEFT JOIN users u ON p.author_id = u.user_id\n"
                + "LEFT JOIN postcategories pc ON p.category_id = pc.category_id\n"
                + "WHERE pc.status = 1 AND p.status = 1\n"
                + "ORDER BY createdate DESC\n"
                + "LIMIT 1;";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
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
                        null,
                        rs.getString("author_name")
                );
                // Gán avatar từ kết quả truy vấn cho post
                post.setAuthorAvatar(rs.getString("author_avatar"));
                return post;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
