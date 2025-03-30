package controller.manage.post;

import controller.auth.BaseRBAC;
import dal.PostDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Account;
import model.Post;
import model.PostCategory;
import java.util.ArrayList;

public class PostList extends BaseRBAC {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PostList</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PostList at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private static final int PAGE_SIZE = 5;

    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        PostDBContext postDAO = new PostDBContext();

        // Lấy danh sách category & author từ database
        ArrayList<PostCategory> categories = postDAO.getAllCategories(true); // Lấy tất cả các danh mục (bao gồm cả inactive)
        List<String[]> authors = postDAO.getAllAuthors();

        // Nhận các tham số lọc từ request
        int page = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
        String categoryId = request.getParameter("categoryId");
        String author = request.getParameter("author");
        String status = request.getParameter("status");
        String search = request.getParameter("search");
        String sortBy = request.getParameter("sortBy");
        String order = request.getParameter("order") == null ? "ASC" : request.getParameter("order");
        
        if(search != null){
            search = search.trim();
        }

        // Kiểm tra cột sắp xếp hợp lệ
        if (sortBy == null || (!sortBy.equals("p.title") && !sortBy.equals("category_name") && !sortBy.equals("author_name") && !sortBy.equals("p.status"))) {
            sortBy = "p.updatedate"; // Mặc định sắp xếp theo ngày cập nhật
        }

        // Kiểm tra thứ tự sắp xếp hợp lệ
        if (!order.equalsIgnoreCase("ASC") && !order.equalsIgnoreCase("DESC")) {
            order = "ASC"; // Mặc định tăng dần
        }

        // Lấy danh sách bài viết theo bộ lọc và sắp xếp - Admin xem được tất cả
        List<Post> posts = postDAO.getPaginatedPosts(page, PAGE_SIZE, categoryId, author, status, search, sortBy, order, true); 
        int totalPosts = postDAO.getTotalPosts(categoryId, author, status, search, true);
        int totalPages = (int) Math.ceil((double) totalPosts / PAGE_SIZE);

        // Đưa dữ liệu vào request
        request.setAttribute("posts", posts);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("categories", categories);
        request.setAttribute("authors", authors);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("order", order);

        request.getRequestDispatcher("admin/postList.jsp").forward(request, response);
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        PostDBContext postDAO = new PostDBContext();

        String postIdStr = request.getParameter("postId");
        String action = request.getParameter("action");

        if (postIdStr != null && action != null) {
            int postId = Integer.parseInt(postIdStr);
            String newStatus = action.equals("hide") ? "0" : "1"; // Ẩn => 0, Hiện => 1
            postDAO.updatePostStatus(postId, newStatus);
        }

        response.sendRedirect("post-list");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}