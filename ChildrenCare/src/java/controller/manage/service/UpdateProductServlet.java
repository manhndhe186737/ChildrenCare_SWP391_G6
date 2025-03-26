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
import model.Service;
import java.util.List;
import model.ServiceCategory;

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
    int categoryId = Integer.parseInt(request.getParameter("categoryId"));
    
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
    boolean updated = serviceDAO.updateProduct(productId, name, price, description, imagePath, categoryId);

    if (updated) {
        response.sendRedirect("serviceDetails?id=" + productId);
    } else {
        response.getWriter().write("Cập nhật sản phẩm thất bại");
    }
}

@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    int serviceId = Integer.parseInt(request.getParameter("id"));
    
    ServiceDAO serviceDAO = new ServiceDAO();
    Service service = serviceDAO.getServiceById(serviceId);
    List<ServiceCategory> categoryList = serviceDAO.getCategoryNames();
    
    request.setAttribute("service", service);
    request.setAttribute("categoryList", categoryList);
    
    request.getRequestDispatcher("/admin/product-detail.jsp").forward(request, response);
}
}
