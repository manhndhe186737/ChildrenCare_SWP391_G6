package controller.manage.feedback;

import dal.FeedbackDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Feedback;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/feedback-detail")
public class FeedbackDetail extends HttpServlet {
    private FeedbackDBContext db;

    @Override
    public void init() throws ServletException {
        db = new FeedbackDBContext();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int feedbackId = Integer.parseInt(request.getParameter("id"));
            Feedback feedback = db.getFeedbackById(feedbackId);
            

            if (feedback != null) {
                request.setAttribute("feedback", feedback);
                request.getRequestDispatcher("/admin/feedback-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/feedbacklist?error=FeedbackNotFound");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/feedbacklist?error=InvalidFeedbackId");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/feedbacklist?error=DatabaseError");
        }
    }
    
       // Hàm phụ trợ: Kiểm tra tham số hợp lệ
    private boolean isValidParam(String param) {
        return param != null && !param.trim().isEmpty();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/feedbacklist?error=InvalidAction");
            return;
        }

        try {
            int feedbackId = Integer.parseInt(request.getParameter("feedback_id"));

            if ("updateStatus".equals(action)) {
                updateFeedbackStatus(request, response, feedbackId);
            } else if ("updateReply".equals(action)) {
                updateFeedbackReply(request, response, feedbackId);
            } else {
                response.sendRedirect(request.getContextPath() + "/feedbacklist?error=UnknownAction");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/feedbacklist?error=InvalidFeedbackId");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/feedbacklist?error=DatabaseError");
        }
    }

    private void updateFeedbackStatus(HttpServletRequest request, HttpServletResponse response, int feedbackId)
            throws SQLException, IOException {
        int status = Integer.parseInt(request.getParameter("status"));
        db.updateFeedbackStatus(feedbackId, status);
        response.sendRedirect(request.getContextPath() + "/feedback-detail?id=" + feedbackId + "&success=StatusUpdated");
    }

    private void updateFeedbackReply(HttpServletRequest request, HttpServletResponse response, int feedbackId)
            throws SQLException, IOException {
        String reply = request.getParameter("reply");
        db.updateFeedbackReply(feedbackId, reply);
        response.sendRedirect(request.getContextPath() + "/feedback-detail?id=" + feedbackId + "&success=ReplyUpdated");
    }
}