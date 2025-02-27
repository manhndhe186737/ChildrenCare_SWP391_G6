/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manage.service;

import java.io.PrintWriter;
import dal.ServiceDAO;
import model.Service;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import jakarta.servlet.http.Part;
import java.nio.file.Paths;
import jakarta.servlet.annotation.MultipartConfig;
import java.io.File;

/**
 *
 * @author vucon
 */
@WebServlet(name = "AddServiceServlet", urlPatterns = {"/admin/AddServiceServlet"})

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10, // 10MB
    maxRequestSize = 1024 * 1024 * 50 // 50MB
)

public class AddServiceServlet extends HttpServlet {

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
            out.println("<title>Servlet AddServiceServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddServiceServlet at " + request.getContextPath() + "</h1>");
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
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String description = request.getParameter("description");
        String categoryStr = request.getParameter("category");

        float price = 0;
        int category = 0;
        String imagePath = null;

        // Xử lý giá tiền
        if (priceStr != null && !priceStr.trim().isEmpty()) {
            try {
                price = Float.parseFloat(priceStr);
            } catch (NumberFormatException e) {
                System.out.println("Price is invalid");
                response.sendRedirect("admin/error.jsp");
                return;
            }
        }

        // Xử lý category
        if (categoryStr != null && !categoryStr.trim().isEmpty()) {
            try {
                category = Integer.parseInt(categoryStr);
            } catch (NumberFormatException e) {
                System.out.println("Category is invalid");
                response.sendRedirect("admin/error.jsp");
                return;
            }
        }

        // Xử lý file ảnh
    Part filePart = request.getPart("imageFile");
    if (filePart != null && filePart.getSize() > 0) {
        // Đường dẫn lưu ảnh
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        // Lưu file
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        imagePath = "uploads/" + fileName;
        filePart.write(uploadPath + File.separator + fileName);
    } else {
        imagePath = request.getParameter("image");
    }

        // Tạo đối tượng service và lưu vào DB
        Service service = new Service(name, description, price, category, imagePath, Boolean.TRUE);
        ServiceDAO serviceDAO = new ServiceDAO();
        boolean isAdded = serviceDAO.addService(service);

        if (isAdded) {
            response.sendRedirect("ServiceListServlet");
        } else {
            response.sendRedirect("admin/error.jsp");
        }
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
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");

        String priceStr = request.getParameter("price");
        String description = request.getParameter("description");
        String img = null;
        String categoryStr = request.getParameter("category");
        

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
