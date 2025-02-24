package controller.manage;

import model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;

@WebServlet("/profile")  
public class Profile extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
        HttpSession session = request.getSession(false); 
        if (session != null) {
            User user = (User) session.getAttribute("user"); 
            if (user != null) {
               
                request.setAttribute("user", user);  
                request.getRequestDispatcher("c/doctor-profile-setting.jsp").forward(request, response); // Forward to JSP
            } else {
              
                response.sendRedirect("login");
            }
        } else {
            
            response.sendRedirect("login");
        }
    }
}
