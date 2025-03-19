package controller.manage.reservation;

import dal.FeedbackDBContext;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Feedback;
import model.User;

@WebServlet(name = "StaffFeedback", urlPatterns = {"/c/staff-feedback"})
public class StaffFeedback extends HttpServlet {

    private FeedbackDBContext feedbackDB;

    @Override
    public void init() throws ServletException {
        feedbackDB = new FeedbackDBContext();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy staffId từ session (giả định user đang đăng nhập là staff)
            Integer staffId = (Integer) request.getSession().getAttribute("staffId");
            User user = (User) request.getSession().getAttribute("user");
            if (user != null) {
                staffId = user.getId();
            }

            if (staffId == null || staffId <= 0) {
                request.setAttribute("error", "Invalid or missing staff ID.");
                request.getRequestDispatcher("../c/staff-feedback.jsp").forward(request, response);
                return;
            }

            // Lấy fullname từ user (nếu user không null)
            String staffName = (user != null && user.getFullname() != null) ? user.getFullname() : "";

            // Xử lý phân trang
            int page = 1; // Trang mặc định
            int pageSize = 5; // Số feedback mỗi trang
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                try {
                    page = Integer.parseInt(pageStr);
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
            int offset = (page - 1) * pageSize;

            // Lấy tổng số feedback để tính số trang
            int totalFeedbacks = feedbackDB.getTotalFeedbacks(null, null, staffName, null);
            int totalPages = (int) Math.ceil((double) totalFeedbacks / pageSize);

            // Lấy danh sách feedback theo staffId với phân trang
            List<Feedback> feedbackList = feedbackDB.getFeedbacksByPage(offset, pageSize, null, null, staffName, null);

            // Đặt các thuộc tính vào request để JSP sử dụng
            request.setAttribute("feedbackList", feedbackList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalFeedbacks", totalFeedbacks);
            request.setAttribute("pageSize", pageSize);

            // Chuyển hướng đến JSP để hiển thị
            request.getRequestDispatcher("../c/staff-feedback.jsp").forward(request, response);

        } catch (SQLException e) {
            request.setAttribute("error", "Error retrieving feedback: " + e.getMessage());
            request.getRequestDispatcher("../c/staff-feedback.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to display feedback for a specific staff member";
    }
}