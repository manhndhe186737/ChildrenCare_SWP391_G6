package controller.manage;

import controller.auth.BaseRBAC;
import dal.SliderDBContext;
import java.io.IOException;
import java.io.File;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Account; // Giả sử bạn có class Account
import model.Slider;

@WebServlet(name = "SliderAdd", urlPatterns = {"/slider-add"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class SliderAdd extends BaseRBAC {

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account acocunt)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/sliderAdd.jsp").forward(request, response);
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account acocunt)
            throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String title = request.getParameter("title");
        String backlink = request.getParameter("backlink");
        String status = request.getParameter("status");

        // Kiểm tra dữ liệu đầu vào
        if (title == null || title.trim().isEmpty() || backlink == null || backlink.trim().isEmpty() || status == null) {
            request.setAttribute("error", "All fields are required!");
            request.getRequestDispatcher("/admin/sliderAdd.jsp").forward(request, response);
            return;
        }
        
        if (title != null) {
            title = title.trim();
        }

        // Xử lý upload ảnh
        String imagePath = null;
        Part filePart = request.getPart("imageFile");
        if (filePart != null && filePart.getSize() > 0) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            imagePath = "uploads/" + fileName;
            filePart.write(uploadPath + File.separator + fileName);
        } else {
            imagePath = "uploads/default.png";
        }

        // Tạo đối tượng Slider
        Slider slider = new Slider();
        slider.setTitle(title);
        slider.setBacklink(backlink);
        slider.setStatus(status);
        slider.setImg(imagePath);

        
        // Thêm slider vào database
        SliderDBContext sliderDAO = new SliderDBContext();
        try {
            sliderDAO.addSlider(slider);
            response.sendRedirect("slider");
        } catch (Exception e) {
            request.setAttribute("error", "Error adding slider: " + e.getMessage());
            request.getRequestDispatcher("/admin/sliderAdd.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for adding new sliders";
    }

}