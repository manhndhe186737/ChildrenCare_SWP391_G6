/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manage;

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
public class PostAdd extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
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

        List<String> categories = postDAO.getAllCategories();
        List<String[]> authors = postDAO.getAllAuthors(); // Lấy danh sách tác giả

        request.setAttribute("categories", categories);
        request.setAttribute("authors", authors);

        request.getRequestDispatcher("admin/postAdd.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nhận dữ liệu từ form
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String category = request.getParameter("category");
        String status = request.getParameter("status");
        String image = request.getParameter("image");
        String authorIdStr = request.getParameter("author"); // Lấy giá trị từ dropdown list

        // Kiểm tra nếu authorId bị null hoặc trống
        if (authorIdStr == null || authorIdStr.trim().isEmpty()) {
            response.sendRedirect("PostAdd?error=missing_author"); // Chuyển hướng với thông báo lỗi
            return;
        }

        int authorId;
        try {
            authorId = Integer.parseInt(authorIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("PostAdd?error=invalid_author"); // Chuyển hướng với thông báo lỗi
            return;
        }

        // Thêm bài viết vào database
        PostDBContext postDAO = new PostDBContext();
        Post post = new Post(0, title, content, null, null, status, image, category, String.valueOf(authorId));
        postDAO.addPost(post);

        // Chuyển hướng về danh sách bài viết
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
