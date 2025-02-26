/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manage.service;

import dal.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import model.Service;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ServiceCategory;

/**
 *
 * @author vucon
 */
public class ServiceListServlet extends HttpServlet {

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
            out.println("<title>Servlet ServiceListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ServiceListServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServiceDAO s = new ServiceDAO();

    // Lấy từ khóa tìm kiếm từ request (có thể trống)
    String searchQuery = request.getParameter("search");
    List<Service> services;

    // Nếu không có từ khóa tìm kiếm (searchQuery rỗng hoặc null), lấy tất cả dịch vụ
    if (searchQuery == null || searchQuery.trim().isEmpty()) {
        services = s.getAllServices();  // Nếu không tìm kiếm, lấy tất cả dịch vụ
    } else {
        services = s.searchCategories(searchQuery);  // Tìm kiếm dịch vụ
    }

    List<ServiceCategory> categories = s.getCategoryNames();  // Lấy danh mục dịch vụ
    request.setAttribute("categories", categories);
    request.setAttribute("services", services);  // Truyền dịch vụ vào JSP
    request.getRequestDispatcher("/admin/shop.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String description = request.getParameter("description");
        String img = null;
        String categoryStr = request.getParameter("category");
        String x = request.getParameter("x");
        response.getWriter().print(name + priceStr + description + categoryStr + x);

        // Kiểm tra nếu giá trị price là null hoặc không hợp lệ
        float price = 0;
        if (priceStr != null && !priceStr.trim().isEmpty()) {
            try {
                price = Float.parseFloat(priceStr);
            } catch (NumberFormatException e) {
                System.out.println("Price is invalid");
                response.sendRedirect("admin/error.jsp"); // Điều hướng đến trang lỗi nếu cần
                return;
            }
        } else {
            price = 0;
        }

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
