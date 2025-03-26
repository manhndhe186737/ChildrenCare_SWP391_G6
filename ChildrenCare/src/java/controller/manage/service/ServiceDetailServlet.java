/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manage.service;

import controller.auth.BaseRBAC;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dal.ServiceDAO;
import java.util.List;
import model.Account;
import model.Service;
import model.ServiceCategory;

/**
 *
 * @author vucon
 */
public class ServiceDetailServlet extends BaseRBAC {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account acocunt) throws ServletException, IOException {
        int serviceId = Integer.parseInt(request.getParameter("id"));

        // Lấy thông tin sản phẩm từ database
        ServiceDAO serviceDAO = new ServiceDAO();
        Service service = serviceDAO.getServiceById(serviceId);

        if (service != null) {
            // Truyền thông tin sản phẩm vào request
            request.setAttribute("service", service);
        } else {
            // Nếu không tìm thấy sản phẩm
            response.sendRedirect("error.jsp");
            return;
        }
        ServiceDAO s = new ServiceDAO();
        List<Service> services1;
        services1 = s.getAllServices();
        request.setAttribute("services1", services1);

        List<ServiceCategory> categoryList = serviceDAO.getCategoryNames();

        request.setAttribute("categoryList", categoryList);

        // Forward đến JSP để hiển thị thông tin sản phẩm
        request.getRequestDispatcher("/admin/product-detail.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   @Override
protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account account)
        throws ServletException, IOException {
    
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
