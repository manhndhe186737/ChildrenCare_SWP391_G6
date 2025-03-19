package controller.manage.feedback;

import dal.FeedbackDBContext;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ReplyFeedback", urlPatterns = {"/c/reply-feedback"})
public class ReplyFeedback extends HttpServlet {

    private FeedbackDBContext feedbackDB;

    @Override
    public void init() throws ServletException {
        feedbackDB = new FeedbackDBContext();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy feedbackId và replyContent từ form
            int feedbackId = Integer.parseInt(request.getParameter("feedbackId"));
            String replyContent = request.getParameter("replyContent");

            // Kiểm tra dữ liệu đầu vào
            if (replyContent == null || replyContent.trim().isEmpty()) {
                request.setAttribute("error", "Reply content cannot be empty.");
                response.sendRedirect(request.getContextPath() + "/c/staff-feedback");
                return;
            }

            // Cập nhật nội dung trả lời vào cơ sở dữ liệu
            feedbackDB.updateFeedbackReply(feedbackId, replyContent);

            // Chuyển hướng về trang staff-feedback với thông báo thành công
            request.getSession().setAttribute("success", "Reply submitted successfully!");
            response.sendRedirect(request.getContextPath() + "/c/staff-feedback");

        } catch (SQLException e) {
            request.setAttribute("error", "Error submitting reply: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/c/staff-feedback");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid feedback ID.");
            response.sendRedirect(request.getContextPath() + "/c/staff-feedback");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet to handle replying to feedback by staff";
    }
}