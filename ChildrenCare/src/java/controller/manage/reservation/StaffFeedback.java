package controller.manage.reservation;

import controller.auth.BaseRBAC;
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
import model.Account;

@WebServlet(name = "StaffFeedback", urlPatterns = {"/c/staff-feedback"})
public class StaffFeedback extends BaseRBAC {

    private FeedbackDBContext feedbackDB;

    @Override
    public void init() throws ServletException {
        feedbackDB = new FeedbackDBContext();
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account account)
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
                request.setAttribute("error", "Invalid staff ID.  Please log in with a valid staff account.");
                request.getRequestDispatcher("../c/staff-feedback.jsp").forward(request, response);
                return;
            }

            // Pagination parameters
            int page = 1;
            int pageSize = 5;
            try {
                String pageStr = request.getParameter("page");
                if (pageStr != null && !pageStr.isEmpty()) {
                    page = Integer.parseInt(pageStr);
                    if (page < 1) page = 1;
                }
            } catch (NumberFormatException e) {
                // Log the error (optional, but recommended for debugging)
                System.err.println("Invalid page number: " + request.getParameter("page"));
                // Keep the default page = 1
            }
            int offset = (page - 1) * pageSize;

            // Sorting, filtering, and search parameters
            String sortService = request.getParameter("sortService");
            String sortDate = request.getParameter("sortDate");
            String sortCustomer = request.getParameter("sortCustomer");
            String filterRating = request.getParameter("filterRating");
            String search = request.getParameter("search");
            
            if(search != null){
                search = search.trim();
            }

            // Fetch total feedbacks with filters
            int totalFeedbacks = feedbackDB.getTotalFeedbacksByStaffId(staffId, filterRating, search);
            int totalPages = (int) Math.ceil((double) totalFeedbacks / pageSize);

            // Handle edge case where requested page is beyond the total pages
            if (page > totalPages && totalPages > 0) {
                page = totalPages;  // Go to the last page if the requested page is too high
                offset = (page - 1) * pageSize; // Recalculate offset
            }

            // Fetch feedback list
            List<Feedback> feedbackList = feedbackDB.getFeedbacksByStaffId(
                    staffId, sortService, sortDate, sortCustomer, filterRating, search, offset, pageSize
            );

            // Set request attributes
            request.setAttribute("feedbackList", feedbackList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalFeedbacks", totalFeedbacks);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("sortService", sortService);
            request.setAttribute("sortDate", sortDate);
            request.setAttribute("sortCustomer", sortCustomer);
            request.setAttribute("filterRating", filterRating);
            request.setAttribute("search", search);

            // Forward to JSP
            request.getRequestDispatcher("../c/staff-feedback.jsp").forward(request, response);

        } catch (SQLException e) {
            // Log the error
            System.err.println("SQL Exception: " + e.getMessage());
            e.printStackTrace();  //Print the stack trace for debugging.
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("../c/staff-feedback.jsp").forward(request, response);
        } catch (Exception e) {
            // Log the error
            System.err.println("Exception: " + e.getMessage());
            e.printStackTrace(); //Print the stack trace for debugging.
            request.setAttribute("error", "Unexpected error: " + e.getMessage());
            request.getRequestDispatcher("../c/staff-feedback.jsp").forward(request, response);
        }
    }


   @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account acocunt)
            throws ServletException, IOException {
        // Handle POST requests the same as GET (e.g., form submission for filters)
        doAuthorizedGet(request, response, acocunt);
    }


    @Override
    public String getServletInfo() {
        return "Servlet to display feedback for a specific staff member with sorting, filtering, searching, and pagination";
    }
}
