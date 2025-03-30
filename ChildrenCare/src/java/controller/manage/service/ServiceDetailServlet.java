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
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account account) throws ServletException, IOException {
        // Get the serviceId parameter and handle potential invalid input
        String serviceIdParam = request.getParameter("id");
        int serviceId = -1;

        try {
            if (serviceIdParam != null && !serviceIdParam.isEmpty()) {
                serviceId = Integer.parseInt(serviceIdParam);  // Parse serviceId safely
            }
        } catch (NumberFormatException e) {
            // If the ID is not a valid integer, redirect to the error page
            response.sendRedirect("../c/error.html");
            return;
        }

        // If serviceId is invalid (less than or equal to 0), redirect to error page
        if (serviceId <= 0) {
            response.sendRedirect("../c/error.html");
            return;
        }

        // Get service information from the database
        ServiceDAO serviceDAO = new ServiceDAO();
        Service service = serviceDAO.getServiceById(serviceId);

        if (service != null) {
            // Set service information as request attribute
            request.setAttribute("service", service);
        } else {
            // If service not found, redirect to error page
            response.sendRedirect("../c/error.html");
            return;
        }

        // Get all services (assuming needed for sidebar or recommendations)
        List<Service> services1 = serviceDAO.getAllServices();
        request.setAttribute("services1", services1);

        // Get list of service categories
        List<ServiceCategory> categoryList = serviceDAO.getCategoryNames();
        request.setAttribute("categoryList", categoryList);

        // Forward the request to the product-detail.jsp page
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
