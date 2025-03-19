package controller.manage.feedback;

import com.google.gson.Gson;
import java.io.IOException;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import dal.FeedbackDBContext;
import model.Feedback;
import model.Reservation;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10, // 10MB
    maxRequestSize = 1024 * 1024 * 50 // 50MB
)

@WebServlet(name = "FeedbackServlet", urlPatterns = {"/feedback"})
public class FeedbackServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FeedbackDBContext feedbackDB = new FeedbackDBContext();
        String reservIdParam = request.getParameter("reserv_id");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Gson gson = new Gson();
        Map<String, Object> responseMap = new HashMap<>();

        if (reservIdParam != null && !reservIdParam.isEmpty()) {
            // Lấy feedback của một reservId cụ thể
            try {
                int reservId = Integer.parseInt(reservIdParam);
                Feedback feedback = feedbackDB.getFeedbackByReservId(reservId);
                if (feedback != null) {
                    Map<String, Object> feedbackData = new HashMap<>();
                    feedbackData.put("id", feedback.getId());
                    feedbackData.put("date", feedback.getDate().toString());
                    feedbackData.put("rating", Integer.parseInt(feedback.getRating())); // Chuyển từ String sang int
                    feedbackData.put("comment", feedback.getComment());
                    feedbackData.put("img", feedback.getImg());
                    feedbackData.put("reservId", feedback.getReservation().getId());
                    feedbackData.put("status", feedback.getStatus());
                    feedbackData.put("reply", feedback.getReply() != null ? feedback.getReply() : "");

                    responseMap.put("success", true);
                    responseMap.put("data", feedbackData);
                } else {
                    responseMap.put("success", false);
                    responseMap.put("message", "Feedback not found for reserv_id: " + reservId);
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (NumberFormatException e) {
                responseMap.put("success", false);
                responseMap.put("message", "Invalid reserv_id: " + reservIdParam);
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            } catch (Exception e) {
                e.printStackTrace();
                responseMap.put("success", false);
                responseMap.put("message", "Error retrieving feedback: " + e.getMessage());
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } else {
            // Lấy tất cả feedback
            try {
                List<Feedback> feedbackList = feedbackDB.getAllFeedbacks();
                responseMap.put("success", true);
                responseMap.put("data", feedbackList);
            } catch (Exception e) {
                e.printStackTrace();
                responseMap.put("success", false);
                responseMap.put("message", "Error retrieving feedbacks: " + e.getMessage());
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        }

        String json = gson.toJson(responseMap);
        System.out.println("Feedback JSON sent: " + json);
        response.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Gson gson = new Gson();
        Map<String, Object> responseMap = new HashMap<>();

        try {
            String rating = request.getParameter("rating");
            String comment = request.getParameter("comment");
            String reservIdParam = request.getParameter("reserv_id");
            String statusParam = request.getParameter("status");
            String reply = request.getParameter("reply"); // Thêm reply

            if (reservIdParam == null || reservIdParam.isEmpty()) {
                responseMap.put("success", false);
                responseMap.put("message", "Reserv_id is missing or invalid.");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(responseMap));
                return;
            }

            int reservId;
            try {
                reservId = Integer.parseInt(reservIdParam);
            } catch (NumberFormatException e) {
                responseMap.put("success", false);
                responseMap.put("message", "Reserv_id must be an integer.");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(responseMap));
                return;
            }

            // Kiểm tra rating hợp lệ
            int ratingValue;
            try {
                ratingValue = Integer.parseInt(rating);
                if (ratingValue < 1 || ratingValue > 5) {
                    throw new IllegalArgumentException("Rating must be between 1 and 5.");
                }
            } catch (NumberFormatException e) {
                responseMap.put("success", false);
                responseMap.put("message", "Rating must be a number between 1 and 5.");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(responseMap));
                return;
            } catch (IllegalArgumentException e) {
                responseMap.put("success", false);
                responseMap.put("message", "Rating must be between 1 and 5.");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(responseMap));
                return;
            }

            // Kiểm tra status hợp lệ
            int status;
            try {
                if (statusParam != null && !statusParam.isEmpty()) {
                    status = Integer.parseInt(statusParam);
                    if (status != 0 && status != 1) {
                        throw new IllegalArgumentException("Status must be 0 (Hidden) or 1 (Visible).");
                    }
                } else {
                    status = 1; // Default to Visible
                }
            } catch (NumberFormatException e) {
                responseMap.put("success", false);
                responseMap.put("message", "Status must be 0 or 1.");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(responseMap));
                return;
            } catch (IllegalArgumentException e) {
                responseMap.put("success", false);
                responseMap.put("message", e.getMessage());
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(responseMap));
                return;
            }

            // Xử lý upload ảnh
            String imagePath = null;
            Part filePart = request.getPart("imageFile");
            FeedbackDBContext feedbackDB = new FeedbackDBContext();
            Feedback existingFeedback = feedbackDB.getFeedbackByReservId(reservId);

            if (filePart != null && filePart.getSize() > 0) {
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();

                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                imagePath = "uploads/" + fileName;
                filePart.write(uploadPath + File.separator + fileName);
            } else if (existingFeedback != null) {
                imagePath = existingFeedback.getImg();
            }

            Date date = new Date(System.currentTimeMillis());
            Reservation reservation = new Reservation();
            reservation.setId(reservId);

            // Tạo Feedback với tất cả các trường
            Feedback feedback = new Feedback(
                existingFeedback != null ? existingFeedback.getId() : 0, // Nếu tồn tại thì giữ ID
                date,
                String.valueOf(ratingValue),
                comment,
                imagePath,
                reservation,
                status,
                reply != null ? reply : (existingFeedback != null ? existingFeedback.getReply() : null)
            );

            // Kiểm tra nếu đã có feedback
            boolean exists = feedbackDB.hasFeedback(reservId);
            if (exists) {
                feedbackDB.updateFeedback(feedback);
                responseMap.put("success", true);
                responseMap.put("message", "Feedback updated successfully!");
            } else {
                feedbackDB.addFeedback(feedback);
                responseMap.put("success", true);
                responseMap.put("message", "Feedback added successfully!");
            }

            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace();
            responseMap.put("success", false);
            responseMap.put("message", "Error processing feedback: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

        String json = gson.toJson(responseMap);
        System.out.println("Feedback POST response: " + json);
        response.getWriter().write(json);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for handling feedback submissions and retrieving feedback data.";
    }
}