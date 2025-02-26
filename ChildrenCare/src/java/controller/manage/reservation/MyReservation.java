package controller.manage.reservation;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 * Servlet for managing user reservations
 * Redirects to a profile page if the user is logged in
 */
@WebServlet(name="MyReservation", urlPatterns={"/myreservation"})
public class MyReservation extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false); // Get existing session, no new session created if not exists
        if (session != null) {
            User user = (User) session.getAttribute("user"); // Get user from session
            if (user != null) {
                // Set user as an attribute to forward to the JSP page
                request.setAttribute("user", user);  // Make sure user object is available in request
                request.getRequestDispatcher("c/pharmacy-shop-cart.jsp").forward(request, response); // Forward to JSP
            } else {
                // If no user in session, redirect to login page
                response.sendRedirect("login");
            }
        } else {
            // If session is null, redirect to login page
            response.sendRedirect("login");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet that handles user reservations and redirects to profile page if user is logged in";
    }
}
