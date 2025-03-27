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
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class PostAdd extends BaseRBAC {

   @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        PostDBContext postDAO = new PostDBContext();

        ArrayList<PostCategory> categories = postDAO.getAllCategories(true); // Lấy tất cả categories
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
        String categoryIdStr = request.getParameter("categoryId");
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
        
        // Xử lý categoryId
        int categoryId;
        try {
            categoryId = Integer.parseInt(categoryIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("post-add?error=invalid_category");
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
        Post post = new Post();
        post.setTitle(title);
        post.setContent(content);
        post.setStatus(status);
        post.setImg(imagePath);
        post.setCategoryId(categoryId);
        post.setAuthor(String.valueOf(authorId));
        
        postDAO.addPost(post);

        // Chuyển hướng về danh sách bài viết
        response.sendRedirect("post-list");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}