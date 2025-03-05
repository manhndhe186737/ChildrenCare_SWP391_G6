package controller.manage.service;

import dal.ServiceDAO;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10, // 10MB
    maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class UpdateProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        float price = Float.parseFloat(request.getParameter("price"));
        String description = request.getParameter("description");
        
        // Xử lý upload ảnh
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
            imagePath = request.getParameter("img"); // Giữ ảnh cũ nếu không có ảnh mới
        }
        
        // Cập nhật dữ liệu vào database
        ServiceDAO serviceDAO = new ServiceDAO();
        boolean updated = serviceDAO.updateProduct(productId, name, price, description, imagePath);

        if (updated) {
            response.sendRedirect("serviceDetails?id=" + productId);
        } else {
            response.getWriter().write("Failed to update product");
        }
    }
}
