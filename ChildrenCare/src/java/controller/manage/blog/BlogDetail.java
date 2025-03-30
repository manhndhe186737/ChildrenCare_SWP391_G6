/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manage.blog;

import dal.PostDBContext;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.annotation.WebServlet;

import model.Post;

/**
 *
 * @author DELL
 */
@WebServlet(name = "BlogDetail", urlPatterns = {"/blog-detail"})
public class BlogDetail extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BlogDetaik</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BlogDetaik at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private PostDBContext postDBContext = new PostDBContext();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String blogId = request.getParameter("id");

        if (blogId != null && !blogId.isEmpty()) {
            try {
                int blogIdInt = Integer.parseInt(blogId);  // Parse blogId safely

                Post blog = postDBContext.getPostById(blogIdInt);

                if (blog != null) {
                    request.setAttribute("blog", blog);

                    // Fetch recent blog posts (for sidebar or recommendations)
                    List<Post> recentBlogs = postDBContext.getPaginatedPosts(1, 5, null, null, null, null, "updatedate", "DESC");
                    request.setAttribute("recentBlogs", recentBlogs);

                    // Forward the request to the blog-detail.jsp page
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/blog-detail.jsp");
                    dispatcher.forward(request, response);
                } else {
                    // If blog post doesn't exist
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Blog post not found.");
                }
            } catch (NumberFormatException e) {
                // If blogId is not a valid integer, return a bad request error
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid blog ID format.");
            }
        } else {
            // If blogId parameter is missing
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Blog ID is required.");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
