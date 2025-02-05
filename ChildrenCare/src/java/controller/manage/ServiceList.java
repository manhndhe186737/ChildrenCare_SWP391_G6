/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manage;
import dal.ServiceCategoryDBContext;
import dal.ServiceDBContext;
import model.Service;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import model.ServiceCategory;

public class ServiceList extends HttpServlet {
    private static final int PAGE_SIZE = 5; 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        String searchQuery = request.getParameter("search") != null ? request.getParameter("search").trim() : "";
        String[] selectedCategories = request.getParameterValues("category");

        ServiceDBContext serviceDB = new ServiceDBContext();
        ArrayList<Service> services = serviceDB.getFilteredServices(page, PAGE_SIZE, searchQuery, selectedCategories);
        int totalServices = serviceDB.getTotalFilteredServices(searchQuery, selectedCategories);
        int totalPages = (int) Math.ceil((double) totalServices / PAGE_SIZE);

        ServiceCategoryDBContext categoryDB = new ServiceCategoryDBContext();
        ArrayList<ServiceCategory> categories = categoryDB.getAllCategoriesWithServices();

        request.setAttribute("services", services);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("categories", categories);
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("selectedCategories", selectedCategories);

        request.getRequestDispatcher("services.jsp").forward(request, response);
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ServiceList</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ServiceList at " + request.getContextPath() + "</h1>");
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


    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
