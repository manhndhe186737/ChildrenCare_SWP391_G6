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


/**
 *
 * @author vucon
 */
@WebServlet(name = "AddServiceServlet", urlPatterns = {"/admin/AddServiceServlet"})
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
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String name = request.getParameter("name");
    
    String priceStr = request.getParameter("price");
    String description = request.getParameter("description");
    String img = null;
    String categoryStr = request.getParameter("category");
    String x = request.getParameter("x");

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

     //Kiểm tra category có hợp lệ không
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
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
 String name = request.getParameter("name");
    
    String priceStr = request.getParameter("price");
    String description = request.getParameter("description");
    String img = null;
    String categoryStr = request.getParameter("category");
    String x = request.getParameter("x");
    response.getWriter().print(name + priceStr + description +categoryStr + x);
        
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
