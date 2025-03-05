package controller.manage;

import controller.auth.BaseRBAC;
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
import java.io.PrintWriter;
import model.Account;
import model.Slider;

/**
 *
 * @author DELL
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class SliderEdit extends BaseRBAC {

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
            out.println("<title>Servlet SliderEdit</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SliderEdit at " + request.getContextPath() + "</h1>");
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
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        SliderDBContext db = new SliderDBContext();
        Slider slider = db.getSliderById(id);

        if (slider == null) {
            response.sendRedirect("slider");
            return;
        }

        request.setAttribute("slider", slider);
        request.getRequestDispatcher("/admin/sliderEdit.jsp").forward(request, response);
    }

    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("slider"); // Chuyển hướng nếu không có ID
            return;
        }

        int id = Integer.parseInt(idParam);
        String title = request.getParameter("title");
        String status = request.getParameter("status");
        String backlink = request.getParameter("backlink"); // Lấy backlink từ form

        SliderDBContext db = new SliderDBContext();
        Slider slider = db.getSliderById(id);
        if (slider == null) {
            response.sendRedirect("slider");
            return;
        }

        // Xử lý upload ảnh
        String imagePath = slider.getImg(); // Mặc định giữ nguyên ảnh cũ
        Part filePart = request.getPart("imageFile");
        if (filePart != null && filePart.getSize() > 0) {
            // Đường dẫn thư mục lưu ảnh
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            // Lưu file
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            imagePath = "uploads/" + fileName;
            filePart.write(uploadPath + File.separator + fileName);
        }

        // Cập nhật slider trong database
        slider.setTitle(title);
        slider.setImg(imagePath);
        slider.setBacklink(backlink); // Cập nhật backlink
        slider.setStatus(status);

        db.updateSlider(slider);

        response.sendRedirect("slider");
    }

    @Override
    public String getServletInfo() {
        return "Servlet chỉnh sửa slider với upload ảnh";
    }
}
