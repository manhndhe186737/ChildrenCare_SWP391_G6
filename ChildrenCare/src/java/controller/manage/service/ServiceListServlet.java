/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manage.service;

import controller.auth.BaseRBAC;
import dal.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import model.Service;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Account;
import model.ServiceCategory;

/**
 *
 * @author vucon
 */
public class ServiceListServlet extends BaseRBAC {


    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account acocunt) throws ServletException, IOException {
    ServiceDAO s = new ServiceDAO();
    
    String searchQuery = request.getParameter("search");
    String categoryIdStr = request.getParameter("categoryId");
    
    List<Service> services;
    
    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
        services = s.searchCategories(searchQuery);
    } else {
        services = s.getAllServices();
    }

    if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
        try {
            int categoryId = Integer.parseInt(categoryIdStr);
            services = s.getServicesByCategory(categoryId);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Lỗi định dạng categoryId.");
        }
    }
    
    List<ServiceCategory> categories = s.getCategoryNames();
    request.setAttribute("categories", categories);
    request.setAttribute("services", services);
    
    request.getRequestDispatcher("/admin/shop.jsp").forward(request, response);
}


    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account acocunt)
            throws ServletException, IOException {
        String name = request.getParameter("name");

        String priceStr = request.getParameter("price");
        String description = request.getParameter("description");
        String img = null;
        String categoryStr = request.getParameter("category");

        // Kiểm tra nếu giá trị price là null hoặc không hợp lệ
        float price = 0;
        if (priceStr != null && !priceStr.trim().isEmpty()) {
            try {
                price = Float.parseFloat(priceStr);
            } catch (NumberFormatException e) {
                // Nếu giá không hợp lệ, có thể đặt giá trị mặc định hoặc thông báo lỗi
                System.out.println("Price is invalid");
                response.sendRedirect("admin/error.jsp"); // Điều hướng đến trang lỗi nếu cần
                return;
            }
        } else {
            // Nếu không có giá, có thể đặt giá trị mặc định (ví dụ: 0)
            price = 0;
        }

        // Kiểm tra category có hợp lệ không
        int category = 0;
        if (categoryStr != null && !categoryStr.trim().isEmpty()) {
            try {
                category = Integer.parseInt(categoryStr);
            } catch (NumberFormatException e) {
                System.out.println("Category is invalid");
                response.sendRedirect("admin/error.jsp");
                return;
            }
        }

        Service service = new Service(name, description, price, category, img, Boolean.TRUE);
        ServiceDAO serviceDAO = new ServiceDAO();
        boolean isAdded = serviceDAO.addService(service);

        // Kiểm tra kết quả và điều hướng
        if (isAdded) {
            response.sendRedirect("ServiceListServlet"); // Chuyển hướng về trang shop sau khi thêm thành công
        } else {
            response.sendRedirect("admin/error.jsp"); // Nếu có lỗi, chuyển hướng tới trang lỗi
        }
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
