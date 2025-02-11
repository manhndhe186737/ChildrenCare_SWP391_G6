package controller.manage.blog;

import dal.BlogDBContext;
import model.Blog;
import model.BlogDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BlogServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(BlogServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        BlogDBContext blogDB = new BlogDBContext();

        // Kiểm tra kết nối cơ sở dữ liệu
        if (!blogDB.testConnection()) {
            LOGGER.severe("Không thể kết nối tới cơ sở dữ liệu!");
            request.setAttribute("errorMessage", "Không thể kết nối tới cơ sở dữ liệu!");
            request.getRequestDispatcher("blogs.jsp").forward(request, response);
            return;
        }
        LOGGER.info("✅ Kết nối database thành công!");

        // Lấy 3 bài viết gần nhất
        List<Blog> recentBlogs = blogDB.getLatestBlogs();
        request.setAttribute("recentBlogs", recentBlogs);

        // Kiểm tra tham số "id" trong URL
        String blogIdParam = request.getParameter("id");

        if (blogIdParam != null && !blogIdParam.trim().isEmpty()) {
            try {
                int blogId = Integer.parseInt(blogIdParam);
                LOGGER.info("Truy vấn blog với ID: " + blogId);

                // Lấy blog theo ID
                Blog blog = blogDB.getBlogById(blogId);
                if (blog == null) {
                    LOGGER.warning("Không tìm thấy blog với ID: " + blogId);
                    request.setAttribute("errorMessage", "Không tìm thấy blog với ID: " + blogId);
                    request.getRequestDispatcher("blogs.jsp").forward(request, response);
                    return;
                }

                // Lấy chi tiết blog theo blogId
                BlogDetail blogDetail = blogDB.getBlogDetailByBlogId(blogId);
                if (blogDetail == null) {
                    LOGGER.warning("Không tìm thấy chi tiết blog với ID: " + blogId);
                    request.setAttribute("errorMessage", "Không tìm thấy chi tiết blog với ID: " + blogId);
                    request.getRequestDispatcher("blogs.jsp").forward(request, response);
                    return;
                }

                // Truyền thông tin blog và chi tiết blog cho trang blog-detail.jsp
                request.setAttribute("blog", blog);
                request.setAttribute("blogdetail", blogDetail);
                request.getRequestDispatcher("blog-detail.jsp").forward(request, response);

            } catch (NumberFormatException e) {
                LOGGER.log(Level.SEVERE, "ID Blog không hợp lệ: " + blogIdParam, e);
                request.setAttribute("errorMessage", "ID Blog không hợp lệ.");
                request.getRequestDispatcher("blogs.jsp").forward(request, response);
            }
        } else {
            // Nếu không có tham số "id", truy vấn danh sách blog
            List<Blog> blogs = blogDB.getAllBlogs();

            if (blogs != null && !blogs.isEmpty()) {
                request.setAttribute("blogs", blogs);
                request.getRequestDispatcher("blogs.jsp").forward(request, response);
            } else {
                LOGGER.warning("Không có blog nào để hiển thị.");
                request.setAttribute("errorMessage", "Không có blog nào để hiển thị.");
                request.getRequestDispatcher("blogs.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
