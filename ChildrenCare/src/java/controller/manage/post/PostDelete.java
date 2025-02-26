package controller.manage.post;

import dal.PostDBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "PostDelete", urlPatterns = {"/post-delete"})
public class PostDelete extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy id của bài viết cần xóa từ tham số request
        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                // Tạo instance của PostDBContext và gọi hàm xóa bài viết
                PostDBContext db = new PostDBContext();
                db.deletePost(id);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        // Sau khi xóa, chuyển hướng về trang danh sách bài viết
        response.sendRedirect("post-list");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
