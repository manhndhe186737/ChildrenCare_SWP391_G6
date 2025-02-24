package controller.manage.blog;

import dal.PostDBContext; // Dùng PostDBContext thay vì BlogDBContext
import model.Post; // Dùng Post thay vì Blog
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
    private static final int POSTS_PER_PAGE = 6;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PostDBContext postDB = new PostDBContext();
        String postIdParam = request.getParameter("id");
        String searchQuery = request.getParameter("search");
        String category = request.getParameter("category");
        String author = request.getParameter("author");
        String status = request.getParameter("status");
        String sortBy = request.getParameter("sortBy");
        String order = request.getParameter("order") == null ? "ASC" : request.getParameter("order");
        String pageParam = request.getParameter("page");
        
        int currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;

        // Kiểm tra các tham số và đặt giá trị mặc định khi cần
        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid page number: " + pageParam, e);
            }
        }

        // Xử lý hiển thị bài viết theo ID nếu có
        if (postIdParam != null && !postIdParam.trim().isEmpty()) {
            try {
                int postId = Integer.parseInt(postIdParam);
                LOGGER.info("Fetching post with ID: " + postId);
                Post post = postDB.getPostById(postId);
                if (post == null) {
                    request.setAttribute("errorMessage", "Không tìm thấy bài viết.");
                    request.getRequestDispatcher("blogs.jsp").forward(request, response);
                    return;
                }
                request.setAttribute("post", post);
                request.getRequestDispatcher("blog-detail.jsp").forward(request, response);
                return;
            } catch (NumberFormatException e) {
                LOGGER.log(Level.SEVERE, "Invalid post ID: " + postIdParam, e);
                request.setAttribute("errorMessage", "ID bài viết không hợp lệ.");
                request.getRequestDispatcher("blogs.jsp").forward(request, response);
                return;
            }
        }

        // Lấy danh sách danh mục và tác giả từ cơ sở dữ liệu
        List<String> categories = postDB.getAllCategories();
        List<String[]> authors = postDB.getAllAuthors();

        // Lấy tổng số bài viết và tính số trang
        int totalPosts = postDB.getTotalPosts(category, author, status, searchQuery);
        int totalPages = (int) Math.ceil((double) totalPosts / POSTS_PER_PAGE);

        // Lấy danh sách bài viết theo trang hiện tại và các bộ lọc
        List<Post> posts = postDB.getPaginatedPosts(currentPage, POSTS_PER_PAGE, category, author, status, searchQuery, sortBy, order);

        // Đưa dữ liệu vào request
        request.setAttribute("posts", posts);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("categories", categories);
        request.setAttribute("authors", authors);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("order", order);

        request.getRequestDispatcher("blogs.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
