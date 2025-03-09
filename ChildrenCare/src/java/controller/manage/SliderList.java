/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manage;

import controller.auth.BaseRBAC;
import dal.SliderDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Account;
import model.Slider;

/**
 *
 * @author DELL
 */
public class SliderList extends BaseRBAC {

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
            out.println("<title>Servlet SliderList</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SliderList at " + request.getContextPath() + "</h1>");
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
        String status = request.getParameter("status");
        String search = request.getParameter("search");
        int page = 1;
        int pageSize = 5;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        SliderDBContext db = new SliderDBContext();
        ArrayList<Slider> sliders = db.getPaginatedSliders(status, search, page, pageSize);
        int totalSliders = db.getTotalSliders(status, search);
        int totalPages = (int) Math.ceil(totalSliders * 1.0 / pageSize);

        request.setAttribute("sliders", sliders);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.getRequestDispatcher("/admin/sliderList.jsp").forward(request, response);
    }

    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("sliderId"));
        boolean newStatus = Boolean.parseBoolean(request.getParameter("newStatus"));

        SliderDBContext db = new SliderDBContext();
        db.toggleSliderVisibility(id, newStatus);

        response.sendRedirect("slider");
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