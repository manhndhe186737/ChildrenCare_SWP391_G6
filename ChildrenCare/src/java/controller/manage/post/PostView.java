/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manage.post;

import controller.auth.BaseRBAC;
import dal.PostDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Account;
import model.Post;

/**
 *
 * @author DELL
 */
public class PostView extends BaseRBAC {

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
            out.println("<title>Servlet PostView</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PostView at " + request.getContextPath() + "</h1>");
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
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        // Nhận tham số ID bài viết
        String postIdStr = request.getParameter("id");

        if (postIdStr != null) {
            try {
                // Chuyển đổi ID sang kiểu long để xử lý số lớn
                long postId = Long.parseLong(postIdStr);

                // Kiểm tra nếu postId vượt quá giới hạn của kiểu int
                if (postId > Integer.MAX_VALUE || postId < Integer.MIN_VALUE) {
                    response.sendRedirect("post-list"); // Chuyển hướng nếu postId không hợp lệ
                    return;
                }

                // Chuyển postId thành kiểu int nếu nó hợp lệ
                PostDBContext postDAO = new PostDBContext();
                Post post = postDAO.getPostById((int) postId);

                if (post != null) {
                    // Đưa bài viết vào request và chuyển đến trang view.jsp
                    request.setAttribute("post", post);
                    request.getRequestDispatcher("admin/postView.jsp").forward(request, response);
                } else {
                    response.sendRedirect("post-list"); // Chuyển hướng nếu không tìm thấy bài viết
                }

            } catch (NumberFormatException e) {
                // Xử lý nếu ID không phải là số hợp lệ
                response.sendRedirect("post-list");
            }
        } else {
            response.sendRedirect("post-list");
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
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account account)
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
