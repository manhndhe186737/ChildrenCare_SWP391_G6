package controller.manage.feedback;

import dal.FeedbackDBContext;
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Feedback;

@WebServlet(name = "FeedbackList", urlPatterns = {"/feedbacklist"})
public class FeedbackList extends HttpServlet {

    private static final int PAGE_SIZE = 6; // 6 items per page
    private final FeedbackDBContext db; // Instance variable (avoid static singleton for now)

    // Initialize DBContext in constructor (better resource management)
    public FeedbackList() {
        this.db = new FeedbackDBContext(); // Consider dependency injection or connection pooling in production
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Pagination parameters
        int page = 1;
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
                if (page <= 0) {
                    page = 1; // Fallback to page 1 if invalid
                }
            }
        } catch (NumberFormatException e) {
            page = 1; // Fallback to page 1 if invalid
        }

        // Filter parameters
        String rating = request.getParameter("rating");
        String search = request.getParameter("search");

        // Validate rating (should be 1-5 or empty)
        if (rating != null && !rating.isEmpty() && !rating.matches("[1-5]")) {
            request.setAttribute("error", "Rating must be a number between 1 and 5.");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            return;
        }

        // Calculate offset for SQL query
        int offset = (page - 1) * PAGE_SIZE;
        if (offset < 0) {
            offset = 0; // Ensure offset is non-negative
        }

        try {
            // Fetch total number of feedbacks for pagination (considering filters)
            int totalFeedbacks = db.getTotalFeedbacks(rating, search);
            int totalPages = (int) Math.ceil((double) totalFeedbacks / PAGE_SIZE);
            if (totalPages < 1) {
                totalPages = 1; // Ensure at least one page if totalFeedbacks is 0
            }

            // Fetch feedbacks for the current page (considering filters)
            List<Feedback> feedbackList = db.getFeedbacksByPage(offset, PAGE_SIZE, rating, search);

            // Debug: Log the size of feedbackList
            System.out.println("FeedbackList size: " + (feedbackList != null ? feedbackList.size() : 0));

            // Ensure feedbackList is not null before passing to JSP
            if (feedbackList == null) {
                feedbackList = Collections.emptyList(); // Use empty list to avoid NullPointerException
            }

            // Set attributes for JSP
            request.setAttribute("feedbackList", feedbackList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("rating", rating != null ? rating : ""); // Retain filter values in JSP
            request.setAttribute("search", search != null ? search : "");

            // Forward to the correct JSP path (adjust based on your project structure)
            request.getRequestDispatcher("admin/feedback-list.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // Replace with proper logging in production (e.g., SLF4J)
            request.setAttribute("error", "Error loading feedback list: " + e.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect POST to GET to keep logic simple (consider handling POST separately if needed)
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for listing feedback operations with pagination and filtering.";
    }
}