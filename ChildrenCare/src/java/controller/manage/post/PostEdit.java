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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.List;
import model.Account;
import model.Post;

/**
 *
 * @author DELL
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class PostEdit extends BaseRBAC {

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
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        PostDBContext postDAO = new PostDBContext();

        String postIdStr = request.getParameter("id");
        if (postIdStr != null) {
            try {
                int postId = Integer.parseInt(postIdStr);
                Post post = postDAO.getPostById(postId);
                List<String> categories = postDAO.getAllCategories();
                List<String[]> authors = postDAO.getAllAuthors(); // Lấy danh sách tác giả

                if (post != null) {
                    request.setAttribute("post", post);
                    request.setAttribute("categories", categories);
                    request.setAttribute("authors", authors);

                    // Kiểm tra nếu bài viết có tác giả thì đặt currentAuthorId, nếu không thì null
                    request.setAttribute("currentAuthorId", post.getAuthor() != null ? post.getAuthor() : "");

                    request.getRequestDispatcher("admin/postEdit.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // Nếu không tìm thấy bài viết hoặc có lỗi, chuyển hướng về danh sách bài viết
        response.sendRedirect("post-list");
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("postId"));
        String title = request.getParameter("title");
        String content = request.getParameter("content").trim();
        String category = request.getParameter("category");
        String status = request.getParameter("status");
        String authorIdStr = request.getParameter("author");
         System.out.println("🚀 Received content: " + content);

        // Xử lý lỗi tác giả
        if (authorIdStr == null || authorIdStr.trim().isEmpty()) {
            response.sendRedirect("post-edit?id=" + postId + "&error=missing_author");
            return;
        }

        int authorId;
        try {
            authorId = Integer.parseInt(authorIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("post-edit?id=" + postId + "&error=invalid_author");
            return;
        }
   
        String imagePath = null;
        Part filePart = request.getPart("imageFile");
        if (filePart != null && filePart.getSize() > 0) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();
            
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            imagePath = "uploads/" + fileName;
            filePart.write(uploadPath + File.separator + fileName);
        } else {
            imagePath = request.getParameter("currentImage"); // Giữ ảnh cũ nếu không có ảnh mới
        }

        // Cập nhật bài viết vào database
        PostDBContext postDAO = new PostDBContext();
        Post post = new Post(postId, title, content, null, null, status, imagePath, category, String.valueOf(authorId));
        postDAO.updatePost(post);

        response.sendRedirect("post-list");
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
