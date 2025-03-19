package controller.manage.feedback;

import dal.FeedbackDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Feedback;
import model.Service;

@WebServlet(name = "feedbackList", urlPatterns = {"/feedbacklist"})
public class FeedbackList extends HttpServlet {
    private static final int PAGE_SIZE = 6;
    final FeedbackDBContext db;

    public FeedbackList() {
        this.db = new FeedbackDBContext();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý tham số page
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) {
                    page = 1;
                }
            } catch (NumberFormatException e) {
                page = 1;
                request.setAttribute("error", "Invalid page number, defaulting to page 1.");
            }
        }

        // Tính offset
        int offset = (page - 1) * PAGE_SIZE;

        // Lấy các tham số lọc (nếu có)
        String rating = request.getParameter("rating");
        String serviceName = request.getParameter("serviceName");
        String staffName = request.getParameter("staffName");
        String search = request.getParameter("search");

        // Lấy dữ liệu từ cơ sở dữ liệu
        List<Feedback> feedbackList;
        int totalFeedbacks;
          List<Service> serviceList;
        try {
            serviceList = db.getAllServices();
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackList.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            feedbackList = db.getFeedbacksByPage(offset, PAGE_SIZE, rating, serviceName, staffName, search);
            totalFeedbacks = db.getTotalFeedbacks(rating, serviceName, staffName, search);
            serviceList = db.getAllServices(); // Lấy danh sách dịch vụ cho dropdown
        } catch (Exception e) {
            feedbackList = new ArrayList<>();
            totalFeedbacks = 0;
            serviceList = new ArrayList<>();
            request.setAttribute("error", "Error retrieving feedback: " + e.getMessage());
        }

        // Tính tổng số trang
        int totalPages = (int) Math.ceil((double) totalFeedbacks / PAGE_SIZE);

        // Đặt các thuộc tính để hiển thị trên JSP
        request.setAttribute("feedbackList", feedbackList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("rating", rating);
        request.setAttribute("serviceName", serviceName);
        request.setAttribute("search", search);
        request.setAttribute("serviceList", serviceList);

        // Chuyển hướng đến JSP
        request.getRequestDispatcher("/admin/feedback-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        try {
            String action = request.getParameter("action");
            int feedbackId = Integer.parseInt(request.getParameter("feedback_id"));
            String reply = request.getParameter("reply");

            if (action == null || feedbackId <= 0 || reply == null) {
                throw new IllegalArgumentException("Invalid parameters.");
            }

            if (action.equals("reply")) {
                // Thêm mới reply
                Feedback feedback = db.getFeedbackById(feedbackId);
                if (feedback == null) {
                    throw new IllegalArgumentException("Feedback not found.");
                }
                feedback.setReply(reply);
                db.updateFeedbackReply(feedbackId, reply);
                out.write("success=true&message=Reply added successfully.");
            } else if (action.equals("updateReply")) {
                // Cập nhật reply
                Feedback feedback = db.getFeedbackById(feedbackId);
                if (feedback == null) {
                    throw new IllegalArgumentException("Feedback not found.");
                }
                feedback.setReply(reply);
                db.updateFeedbackReply(feedbackId, reply);
                out.write("success=true&message=Reply updated successfully.");
            } else {
                throw new IllegalArgumentException("Invalid action.");
            }
        } catch (Exception e) {
            out.write("success=false&message=" + e.getMessage());
        } finally {
            out.flush();
            out.close();
        }
    }
}