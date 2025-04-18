package controller.manage.blog;

import static controller.manage.Homepage.stripHtmlTags;
import dal.PostDBContext;
import model.Post;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.PostCategory;

public class BlogServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(BlogServlet.class.getName());
    private static final int POSTS_PER_PAGE = 6;
    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

    private final PostDBContext postDB = new PostDBContext(); 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy các tham số từ request
        String postIdParam = request.getParameter("id");
        String searchQuery = request.getParameter("search");
        String categoryIdParam = request.getParameter("category");
        String fromDateParam = request.getParameter("fromDate");
        String toDateParam = request.getParameter("toDate");
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");
        String pageParam = request.getParameter("page");
        
        if(searchQuery != null){
            searchQuery = searchQuery.trim();
        }

        // Xử lý số trang hiện tại
        int currentPage = parsePageNumber(pageParam);

        // Xử lý hiển thị bài viết chi tiết nếu có postId
        if (isValidParam(postIdParam)) {
            handlePostDetail(request, response, postIdParam);
            return;
        }

        // Lấy danh sách danh mục (chỉ active)
        ArrayList<PostCategory> categories = postDB.getAllCategories(false);

        // Chuyển đổi ngày tháng
        java.sql.Date fromDate = parseSqlDate(fromDateParam);
        java.sql.Date toDate = parseSqlDate(toDateParam);

        // Xác định cột và thứ tự sắp xếp
        String sortColumn = determineSortColumn(sortBy);
        String validSortOrder = normalizeSortOrder(sortOrder);
        searchQuery = searchQuery.trim().replaceAll("\\s+", "%");
        // Lấy tổng số bài viết với tất cả các bộ lọc
        int totalPosts = postDB.getTotalPostsWithFilters(searchQuery, categoryIdParam, fromDate, toDate);
        int totalPages = calculateTotalPages(totalPosts);

        // Điều chỉnh currentPage nếu vượt quá totalPages
        currentPage = adjustCurrentPage(currentPage, totalPages);

        // Lấy danh sách bài viết với tất cả các bộ lọc và sắp xếp
        List<Post> posts = postDB.getPostsWithFiltersAndSorting(
                searchQuery, categoryIdParam, fromDate, toDate,
                sortColumn, validSortOrder, currentPage, POSTS_PER_PAGE);

        for (Post post : posts) {
            String fullContent = post.getContent();
            String plainText = stripHtmlTags(fullContent);

            String shortContent = plainText;
            if (plainText.length() > 150) {
                shortContent = plainText.substring(0, 150) + "............";
            }
            post.setShortContent(shortContent);
        }

        // Đưa dữ liệu vào request
        setRequestAttributes(request, posts, currentPage, totalPages, searchQuery,
                categoryIdParam, fromDateParam, toDateParam, sortBy, validSortOrder, categories);

        // Chuyển hướng đến trang JSP
        request.getRequestDispatcher("blogs.jsp").forward(request, response);
    }

    public static String stripHtmlTags(String html) {
        return html.replaceAll("<[^>]*>", "").replaceAll("&nbsp;", " ").trim();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Xử lý POST giống GET
    }

    // Hàm phụ trợ: Chuyển đổi số trang
    private int parsePageNumber(String pageParam) {
        int currentPage = 1;
        if (isValidParam(pageParam)) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) {
                    currentPage = 1;
                }
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid page number: " + pageParam, e);
            }
        }
        return currentPage;
    }

    // Hàm phụ trợ: Kiểm tra tham số hợp lệ
    private boolean isValidParam(String param) {
        return param != null && !param.trim().isEmpty();
    }

    // Hàm phụ trợ: Xử lý hiển thị chi tiết bài viết
    private void handlePostDetail(HttpServletRequest request, HttpServletResponse response, String postIdParam)
            throws ServletException, IOException {
        try {
            int postId = Integer.parseInt(postIdParam);
            LOGGER.info("Fetching post with ID: " + postId);

            Post post = postDB.getPublicPostById(postId);
            if (post == null) {
                request.setAttribute("errorMessage", "Không tìm thấy bài viết hoặc bài viết không khả dụng.");
                request.getRequestDispatcher("blogs.jsp").forward(request, response);
                return;
            }
            request.setAttribute("post", post);
            request.getRequestDispatcher("blog-detail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "Invalid post ID: " + postIdParam, e);
            request.setAttribute("errorMessage", "ID bài viết không hợp lệ.");
            request.getRequestDispatcher("blogs.jsp").forward(request, response);
        }
    }

    // Hàm phụ trợ: Chuyển đổi chuỗi ngày thành java.sql.Date
    private java.sql.Date parseSqlDate(String dateStr) {
        if (!isValidParam(dateStr)) {
            return null;
        }
        try {
            java.util.Date parsedDate = DATE_FORMAT.parse(dateStr);
            return new java.sql.Date(parsedDate.getTime());
        } catch (ParseException e) {
            LOGGER.log(Level.WARNING, "Invalid date: " + dateStr, e);
            return null;
        }
    }

    // Hàm phụ trợ: Xác định cột sắp xếp
    private String determineSortColumn(String sortBy) {
        if (sortBy == null || (!"date".equals(sortBy) && !"category".equals(sortBy))) {
            return "p.createdate"; // Mặc định sắp xếp theo ngày
        }
        return "date".equals(sortBy) ? "p.createdate" : "pc.name";
    }

    // Hàm phụ trợ: Chuẩn hóa thứ tự sắp xếp
    private String normalizeSortOrder(String sortOrder) {
        if (sortOrder == null || (!"asc".equalsIgnoreCase(sortOrder) && !"desc".equalsIgnoreCase(sortOrder))) {
            return "DESC"; // Mặc định giảm dần
        }
        return sortOrder.toUpperCase();
    }

    // Hàm phụ trợ: Tính tổng số trang
    private int calculateTotalPages(int totalPosts) {
        return (int) Math.ceil((double) totalPosts / POSTS_PER_PAGE);
    }

    // Hàm phụ trợ: Điều chỉnh số trang hiện tại
    private int adjustCurrentPage(int currentPage, int totalPages) {
        if (currentPage > totalPages && totalPages > 0) {
            return totalPages;
        }
        return currentPage;
    }

    // Hàm phụ trợ: Đặt các thuộc tính vào request
    private void setRequestAttributes(HttpServletRequest request, List<Post> posts, int currentPage,
            int totalPages, String searchQuery, String categoryIdParam, String fromDateParam,
            String toDateParam, String sortBy, String sortOrder, ArrayList<PostCategory> categories) {
        request.setAttribute("posts", posts);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", searchQuery);
        request.setAttribute("category", categoryIdParam);
        request.setAttribute("fromDate", fromDateParam);
        request.setAttribute("toDate", toDateParam);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortOrder", sortOrder.toLowerCase());
        request.setAttribute("categories", categories);
    }
}
