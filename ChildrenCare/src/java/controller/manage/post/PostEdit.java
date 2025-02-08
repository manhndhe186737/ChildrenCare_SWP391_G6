/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manage.post;

import dal.PostDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Post;

/**
 *
 * @author DELL
 */
public class PostEdit extends HttpServlet {

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
            out.println("<title>Servlet PostEdit</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PostEdit at " + request.getContextPath() + "</h1>");
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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PostDBContext postDAO = new PostDBContext();

        String postIdStr = request.getParameter("id");
        if (postIdStr != null) {
            int postId = Integer.parseInt(postIdStr);

            Post post = postDAO.getPostById(postId);
            List<String> categories = postDAO.getAllCategories();
            List<String[]> authors = postDAO.getAllAuthors(); // Lấy danh sách tác giả

            if (post != null) {
                request.setAttribute("post", post);
                request.setAttribute("categories", categories);
                request.setAttribute("authors", authors);
                request.setAttribute("currentAuthorId", post.getAuthor()); // Lưu ID tác giả hiện tại

                request.getRequestDispatcher("admin/postEdit.jsp").forward(request, response);
            } else {
                response.sendRedirect("PostList"); // Chuyển hướng nếu không tìm thấy bài viết
            }
        } else {
            response.sendRedirect("PostList");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("postId"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String category = request.getParameter("category");
        String status = request.getParameter("status");
        String image = request.getParameter("image");
        String authorIdStr = request.getParameter("author");

        if (authorIdStr == null || authorIdStr.trim().isEmpty()) {
            response.sendRedirect("PostEdit?id=" + postId + "&error=missing_author");
            return;
        }

        int authorId;
        try {
            authorId = Integer.parseInt(authorIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("PostEdit?id=" + postId + "&error=invalid_author");
            return;
        }

        PostDBContext postDAO = new PostDBContext();
        Post post = new Post(postId, title, content, null, null, status, image, category, String.valueOf(authorId));
        postDAO.updatePost(post);

        response.sendRedirect("PostList");
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
