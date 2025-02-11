package controller.manage;

import dal.SliderDBContext;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Slider;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class SliderEdit extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        SliderDBContext db = new SliderDBContext();
        Slider slider = db.getSliderById(id);

        if (slider == null) {
            response.sendRedirect("SliderList");
            return;
        }

        request.setAttribute("slider", slider);
        request.getRequestDispatcher("/admin/sliderEdit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String status = request.getParameter("status");

        SliderDBContext db = new SliderDBContext();
        Slider slider = db.getSliderById(id);
        if (slider == null) {
            response.sendRedirect("SliderList");
            return;
        }

        // Xử lý upload ảnh
        String imagePath = slider.getImg(); // Mặc định giữ nguyên ảnh cũ
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
        }

        // Cập nhật slider trong database
        slider.setTitle(title);
        slider.setImg(imagePath);
        slider.setStatus(status);
        db.updateSlider(slider);

        response.sendRedirect("SliderList");
    }

    @Override
    public String getServletInfo() {
        return "Servlet chỉnh sửa slider với upload ảnh";
    }
}
