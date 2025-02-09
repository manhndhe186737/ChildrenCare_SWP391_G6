package controller.home;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

import java.io.IOException;
import java.util.List;

import dal.BlogDBContext;
import model.Blog;


public class BlogSearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy tham số tìm kiếm từ URL
        String searchQuery = request.getParameter("search"); // Lấy từ khóa tìm kiếm
        if (searchQuery == null) {
            searchQuery = ""; // Nếu không có từ khóa tìm kiếm, mặc định là chuỗi rỗng
        }

        // Xử lý số trang
        int currentPage = 1; // Mặc định là trang 1
        try {
            String pageStr = request.getParameter("page");
            if (pageStr != null) {
                currentPage = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException e) {
            // Nếu không có số trang hợp lệ, giữ mặc định trang 1
            currentPage = 1;
        }

        // Số bài viết mỗi trang
        int itemsPerPage = 3;

        // Tạo đối tượng BlogDBContext để truy vấn dữ liệu từ database
        BlogDBContext blogDBContext = new BlogDBContext();
        
        // Gọi phương thức tìm kiếm với phân trang từ BlogDBContext
        List<Blog> allBlogs = blogDBContext.searchBlogs(searchQuery, currentPage, itemsPerPage);

        // Tính tổng số blog và tổng số trang cần hiển thị
        int totalBlogs = blogDBContext.getTotalBlogs(searchQuery); // Lấy tổng số blog từ BlogDBContext
        int totalPages = (int) Math.ceil((double) totalBlogs / itemsPerPage);

        // Cập nhật dữ liệu vào request để chuyển cho JSP
        request.setAttribute("blogs", allBlogs);  // Trả về danh sách blog tìm kiếm
        request.setAttribute("searchQuery", searchQuery); // Lưu từ khóa tìm kiếm vào request
        request.setAttribute("currentPage", currentPage); // Lưu trang hiện tại vào request
        request.setAttribute("totalPages", totalPages); // Lưu tổng số trang vào request

        // Chuyển hướng đến trang JSP để hiển thị kết quả
        RequestDispatcher dispatcher = request.getRequestDispatcher("blogs.jsp");
        dispatcher.forward(request, response);
    }
}
