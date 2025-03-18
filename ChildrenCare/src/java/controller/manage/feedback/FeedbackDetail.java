package servlet;

import dal.FeedbackDBContext;
import jakarta.servlet.http.HttpServletRequest;
import model.Feedback;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/FeedbackDetail")
public class FeedbackDetail extends HttpServlet {
    private FeedbackDBContext db;

    @Override
    public void init() throws ServletException {
        db = new FeedbackDBContext(); // Khởi tạo FeedbackDBContext
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy feedbackId từ request parameter
            int feedbackId = Integer.parseInt(request.getParameter("id"));

            // Lấy feedback từ database
            Feedback feedback = db.getFeedbackById(feedbackId);

            if (feedback != null) {
                // Đặt feedback vào request attribute để JSP sử dụng
                request.setAttribute("feedback", feedback);
                // Chuyển tiếp đến trang JSP
                request.getRequestDispatcher("/feedbackDetail.jsp").forward(request, response);
            } else {
                // Nếu không tìm thấy feedback, chuyển hướng về danh sách với thông báo lỗi
                response.sendRedirect("feedbacklist.jsp?error=FeedbackNotFound");
            }
        } catch (NumberFormatException e) {
            // Xử lý trường hợp ID không hợp lệ
            response.sendRedirect("feedbacklist.jsp?error=InvalidFeedbackId");
        } catch (SQLException e) {
            // Xử lý lỗi database
            e.printStackTrace();
            response.sendRedirect("feedbacklist.jsp?error=DatabaseError");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            int feedbackId = Integer.parseInt(request.getParameter("feedback_id"));

            if ("update".equals(action)) {
                updateFeedback(request, response);
            } else if ("delete".equals(action)) {
                deleteFeedback(request, response);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("feedbacklist.jsp?error=InvalidFeedbackId");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("feedbacklist.jsp?error=DatabaseError");
        }
    }

    private void updateFeedback(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int feedbackId = Integer.parseInt(request.getParameter("feedback_id"));
        String rating = request.getParameter("rating");
        String comment = request.getParameter("comment");
        String img = request.getParameter("img");
        int status = Integer.parseInt(request.getParameter("status"));

        // Lấy feedback hiện tại để lấy thông tin reservation
        Feedback feedback = db.getFeedbackById(feedbackId);
        if (feedback != null) {
            // Cập nhật thông tin feedback
            feedback.setRating(rating);
            feedback.setComment(comment);
            feedback.setImg(img);
            feedback.setStatus(status);

            // Thực hiện update trong database
            db.updateFeedback(feedback);

            // Chuyển hướng về danh sách với thông báo thành công
            response.sendRedirect("feedbacklist.jsp?success=FeedbackUpdated");
        } else {
            response.sendRedirect("feedbacklist.jsp?error=FeedbackNotFound");
        }
    }

    private void deleteFeedback(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int feedbackId = Integer.parseInt(request.getParameter("feedback_id"));

        // Xóa feedback
        db.deleteFeedback(feedbackId);

        // Chuyển hướng về danh sách với thông báo thành công
        response.sendRedirect("feedbacklist.jsp?success=FeedbackDeleted");
    }
}