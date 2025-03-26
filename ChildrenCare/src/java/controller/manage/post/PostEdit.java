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
import java.util.ArrayList;
import model.Account;
import model.Post;
import model.PostCategory;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class PostEdit extends BaseRBAC {

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

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        PostDBContext postDAO = new PostDBContext();

        String postIdStr = request.getParameter("id");
        if (postIdStr != null) {
            try {
                int postId = Integer.parseInt(postIdStr);
                Post post = postDAO.getPostById(postId);
                ArrayList<PostCategory> categories = postDAO.getAllCategories(true); // Lấy tất cả categories bao gồm cả inactive
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
        String categoryIdStr = request.getParameter("categoryId");
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
        
        // Xử lý categoryId
        int categoryId;
        try {
            categoryId = Integer.parseInt(categoryIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("post-edit?id=" + postId + "&error=invalid_category");
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
        Post post = new Post();
        post.setId(postId);
        post.setTitle(title);
        post.setContent(content);
        post.setStatus(status);
        post.setImg(imagePath);
        post.setCategoryId(categoryId);
        post.setAuthor(String.valueOf(authorId));
        
        postDAO.updatePost(post);

        response.sendRedirect("post-list");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}