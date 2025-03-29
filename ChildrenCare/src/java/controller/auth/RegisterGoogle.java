/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import DAO.UserDAO;
import DAO.VerificationTokenDAO;
import config.EmailConfig;
import config.PasswordUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;
import model.Validate;
import java.util.ArrayList;

/**
 *
 * @author vucon
 */
@WebServlet(name = "RegisterGoogle", urlPatterns = {"/registergoogle"})
public class RegisterGoogle extends HttpServlet {

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
            throws ServletException, IOException, Exception {
        String fullName = request.getParameter("fullname");
        String address = request.getParameter("address");
        String dobString = request.getParameter("dob");
        String phone = request.getParameter("mobile");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String picture = request.getParameter("picture") != null ? request.getParameter("picture") : "uploads/avatar.jpg";

        // Tạo danh sách lỗi
        ArrayList<String> errors = new ArrayList<>();

        // Check password
        if (password == null || password.isEmpty()) {
            errors.add("Please enter a password");
        } else if (!Validate.checkPassword(password)) {
            errors.add("Password must be at least 8 characters long and include uppercase, lowercase, numbers, and special characters");
        }

        // Check phone number
        if (phone == null || phone.isEmpty()) {
            errors.add("Please enter a phone number");
        } else if (!Validate.checkPhone(phone)) {
            errors.add("Invalid phone number (must be 10 digits and start with 0)");
        }

        // Check date of birth
        Date dob = null;
        if (dobString == null || dobString.isEmpty()) {
            errors.add("Please enter a date of birth");
        } else {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                dob = sdf.parse(dobString);
            } catch (ParseException e) {
                errors.add("Invalid date of birth");
            }
        }

        // Nếu có lỗi, chuyển hướng về trang đăng ký với thông báo lỗi
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("name", fullName);
            request.setAttribute("email", email);
            request.setAttribute("mobile", phone);
            request.setAttribute("address", address);
            request.setAttribute("dob", dobString);
            request.setAttribute("Password", password);
            request.getRequestDispatcher("account/RegisterGoogle.jsp").forward(request, response);
            return;
        }

        // Nếu không có lỗi, tiếp tục xử lý đăng ký
        String hashedPassword = PasswordUtil.hashPassword(password);
        User user = new User();
        user.setFullname(fullName);
        user.setAddress(address);
        user.setDob(dob);
        user.setPhone(phone);
        user.setAvatar("uploads/avatar.jpg");
        user.setIsVerified(true);
        UserDAO userDAO = new UserDAO();
        int userId = userDAO.registerUser(user, email, hashedPassword);
        if (userId > 0) {
            User userLogin = userDAO.getUserByEmail(email);
            HttpSession session = request.getSession();
            session.setAttribute("userLogin", userLogin);
            session.setAttribute("alertMessage", "Đăng nhập thành công");
            session.setAttribute("alertType", "success");
            response.sendRedirect("login");
        } else {
            errors.add("Đăng ký thất bại. Vui lòng thử lại.");
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("account/RegisterGoogle.jsp").forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(RegisterGoogle.class.getName()).log(Level.SEVERE, null, ex);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(RegisterGoogle.class.getName()).log(Level.SEVERE, null, ex);
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


