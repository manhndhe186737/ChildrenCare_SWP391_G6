/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manage.service;

import dal.ServiceDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Service;

/**
 *
 * @author DELL
 */
@WebServlet(name = "ServiceDetail", urlPatterns = {"/service-detail"})
public class ServiceDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy service_id từ request
        String serviceIdParam = request.getParameter("id");
        int serviceId = serviceIdParam != null ? Integer.parseInt(serviceIdParam) : 0;

        // Lấy thông tin chi tiết của dịch vụ từ database
        ServiceDBContext serviceDB = new ServiceDBContext();
        Service service = serviceDB.getServiceById(serviceId);

        // Kiểm tra nếu dịch vụ không tồn tại
        if (service == null) {
            response.sendRedirect("service-list");
            return;
        }

        // Lấy danh sách các dịch vụ cùng loại (liên quan)
        int categoryId = service.getCategory().getId();
        // Sử dụng hàm getServicesByCategoryId đã có
        // (Nếu muốn hiển thị thêm ảnh, bạn có thể mở rộng hàm này để lấy thêm cột image)
        java.util.ArrayList<Service> relatedServices = serviceDB.getServicesByCategoryId(categoryId);
        // Loại bỏ dịch vụ hiện tại nếu có trong danh sách
        relatedServices.removeIf(s -> s.getId() == service.getId());

        // Gửi dữ liệu đến JSP
        request.setAttribute("service", service);
        request.setAttribute("relatedServices", relatedServices);
        request.getRequestDispatcher("c/service-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý POST nếu cần
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Ví dụ hiển thị thông báo
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><head><title>Service Detail</title></head><body>");
            out.println("<h1>Service Detail</h1>");
            out.println("</body></html>");
        }
    }

    @Override
    public String getServletInfo() {
        return "Service Detail Servlet";
    }
}
