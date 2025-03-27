package controller.manage.blog;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

import java.io.IOException;
import java.util.List;

import dal.BlogDBContext;
import dal.PostDBContext;
import java.io.PrintWriter;
import model.Blog;
import model.Post;


public class BlogSearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy tham số tìm kiếm từ request
        String searchQuery = request.getParameter("search");
        if (searchQuery == null) {
            searchQuery = "";
        }

        // Xử lý số trang (mặc định là trang 1)
        int currentPage = 1;
        try {
            String pageStr = request.getParameter("page");
            if (pageStr != null) {
                currentPage = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException e) {
            currentPage = 1;
        }

        // Số bài viết trên mỗi trang
        int itemsPerPage = 6;

        // Lấy danh sách bài viết từ database
        PostDBContext postDB = new PostDBContext();
        List<Post> allPosts = postDB.searchPosts(searchQuery, currentPage, itemsPerPage);

        // Tính tổng số bài viết và số trang cần hiển thị
        int totalPosts = postDB.getTotalSearchPosts(searchQuery);
        int totalPages = (int) Math.ceil((double) totalPosts / itemsPerPage);

        
        // Truyền dữ liệu vào request để hiển thị trên JSP
        request.setAttribute("posts", allPosts);
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        // Chuyển hướng đến `blogs.jsp`
        RequestDispatcher dispatcher = request.getRequestDispatcher("./blogs.jsp");
        dispatcher.forward(request, response);
    }
}
