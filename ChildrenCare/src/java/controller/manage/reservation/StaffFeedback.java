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
            // Validate staff login and role
            User user = (User) request.getSession().getAttribute("user");
            Object roleObj = request.getSession().getAttribute("role");
            if (user == null || roleObj == null || !roleObj.toString().contains("Staffs")) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            int staffId = user.getId();

            if (staffId <= 0) {
                request.setAttribute("error", "Invalid staff ID. Please log in with a valid staff account.");
                request.getRequestDispatcher("../c/staff-feedback.jsp").forward(request, response);
                return;
            }

            // Get pagination parameters
            int page = 1;
            int pageSize = 5; // Matches JSP table size
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                try {
                    page = Integer.parseInt(pageStr);
                    if (page < 1) page = 1;
                } catch (NumberFormatException e) {
                    page = 1; // Default to page 1 on invalid input
                }
            }
            int offset = (page - 1) * pageSize;

            // Get sorting, filtering, and search parameters
            String sortService = request.getParameter("sortService"); // "asc" or "desc"
            String sortDate = request.getParameter("sortDate");       // "asc" or "desc"
            String sortCustomer = request.getParameter("sortCustomer"); // "asc" or "desc"
            String filterRating = request.getParameter("filterRating"); // "1" to "5" or empty
            String search = request.getParameter("search");           // Search string or empty

            // Fetch total feedbacks with filters
            int totalFeedbacks = feedbackDB.getTotalFeedbacksByStaffId(staffId, filterRating, search);
            int totalPages = (int) Math.ceil((double) totalFeedbacks / pageSize);

            // Fetch feedback list with sorting, filtering, searching, and pagination
            List<Feedback> feedbackList = feedbackDB.getFeedbacksByStaffId(
                staffId, sortService, sortDate, sortCustomer, filterRating, search, offset, pageSize
            );

            // Set request attributes for JSP
            request.setAttribute("feedbackList", feedbackList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalFeedbacks", totalFeedbacks);
            request.setAttribute("pageSize", pageSize);
            // Preserve parameters for JSP to use in links
            request.setAttribute("sortService", sortService);
            request.setAttribute("sortDate", sortDate);
            request.setAttribute("sortCustomer", sortCustomer);
            request.setAttribute("filterRating", filterRating);
            request.setAttribute("search", search);

            // Forward to JSP
            request.getRequestDispatcher("../c/staff-feedback.jsp").forward(request, response);

        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("../c/staff-feedback.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Unexpected error: " + e.getMessage());
            request.getRequestDispatcher("../c/staff-feedback.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle POST requests the same as GET (e.g., form submission for filters)
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to display feedback for a specific staff member with sorting, filtering, searching, and pagination";
    }
}