/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import java.io.IOException;
import java.io.PrintWriter;
import config.PasswordUtil;
import DAO.AccountDAO;
import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import model.Account;
import model.Validate;

/**
 *
 * @author vucon
 */
@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/ChangePasswordServlet"})
public class ChangePasswordServlet extends HttpServlet {

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
            out.println("<title>Servlet ChangePasswordServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePasswordServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Không tạo session mới nếu chưa có
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect("home.jsp"); // Nếu chưa đăng nhập, quay về trang chủ
            return;
        }

        Account user = (Account) session.getAttribute("account");
        String email = user.getEmail(); // Lấy email từ đối tượng Account

        // Lấy dữ liệu từ form
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        if (!Validate.checkPassword(newPassword)) {
        request.setAttribute("errorMessage", "New password must be at least 8 characters long, " +
                "contain at least one lowercase letter, one uppercase letter, one number, and one special character.");
        request.getRequestDispatcher("c/doctor-profile-setting.jsp").forward(request, response);
        return;
    }

        // Kiểm tra mật khẩu mới nhập lại có khớp không
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "New password and confirm password do not match.");
            request.getRequestDispatcher("c/doctor-profile-setting.jsp").forward(request, response);
            return;
        }
        try {
            AccountDAO accountDAO = new AccountDAO();
            String storedPassword = accountDAO.getPasswordByEmail(email); // Lấy mật khẩu cũ từ database
//            System.out.println(storedPassword + user.getPassword());
            // Kiểm tra mật khẩu cũ có đúng không
            if (!PasswordUtil.verifyPassword(oldPassword, storedPassword)) {
                
                request.setAttribute("errorMessage", "Old password is incorrect.");
                request.getRequestDispatcher("c/doctor-profile-setting.jsp").forward(request, response);
                return;
            }

            // Kiểm tra nếu mật khẩu mới trùng với mật khẩu cũ
            if (PasswordUtil.verifyPassword(newPassword, storedPassword)) {
                request.setAttribute("errorMessage", "New password cannot be the same as the old password.");
                request.getRequestDispatcher("c/doctor-profile-setting.jsp").forward(request, response);
                return;
            }

            // **Mã hóa mật khẩu mới trước khi cập nhật**
           
            boolean success = accountDAO.updatePassword(email, newPassword);
            if (success) {
                session.removeAttribute("account");
                request.setAttribute("successMessage", "Password changed successfully.");
                user.setPassword(accountDAO.getPasswordByEmail(email));
                session.setAttribute("account", user);
            } else {
                request.setAttribute("errorMessage", "Failed to update password. Please try again.");
            }
            request.getRequestDispatcher("c/doctor-profile-setting.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred. Please try again.");
            request.getRequestDispatcher("c/doctor-profile-setting.jsp").forward(request, response);
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
