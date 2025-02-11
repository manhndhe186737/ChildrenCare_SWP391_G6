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
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class PostAdd extends BaseRBAC {

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
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        PostDBContext postDAO = new PostDBContext();

        List<String> categories = postDAO.getAllCategories();
        List<String[]> authors = postDAO.getAllAuthors(); // Lấy danh sách tác giả

        request.setAttribute("categories", categories);
        request.setAttribute("authors", authors);

        request.getRequestDispatcher("admin/postAdd.jsp").forward(request, response);
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        // Nhận dữ liệu từ form
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String category = request.getParameter("category");
        String status = request.getParameter("status");
        String authorIdStr = request.getParameter("author");

        // Kiểm tra nếu authorId bị null hoặc trống
        if (authorIdStr == null || authorIdStr.trim().isEmpty()) {
            response.sendRedirect("post-add?error=missing_author");
            return;
        }

        int authorId;
        try {
            authorId = Integer.parseInt(authorIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("post-add?error=invalid_author");
            return;
        }

        // Xử lý upload ảnh
        String imagePath = null;
        Part filePart = request.getPart("imageFile");
        if (filePart != null && filePart.getSize() > 0) {
            // Đường dẫn thư mục lưu ảnh
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            // Lưu file
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            imagePath = "uploads/" + fileName;
            filePart.write(uploadPath + File.separator + fileName);
        } else {
            // Nếu không upload ảnh mới, giữ nguyên đường dẫn mặc định
            imagePath = "uploads/default.png"; // Có thể thay bằng ảnh mặc định
        }

        // Thêm bài viết vào database
        PostDBContext postDAO = new PostDBContext();
        Post post = new Post(0, title, content, null, null, status, imagePath, category, String.valueOf(authorId));
        postDAO.addPost(post);

        // Chuyển hướng về danh sách bài viết
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
