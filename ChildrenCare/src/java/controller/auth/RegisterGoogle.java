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

/**
 *
 * @author vucon
 */
@WebServlet(name="RegisterGoogle", urlPatterns={"/registergoogle"})
public class RegisterGoogle extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
//                String avatar = request.getParameter("avatar");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String picture = request.getParameter("picture") != null ? request.getParameter("picture"):"/assets/images/avatar.jpg" ;
                Date dob = null;
                if (dobString != null && !dobString.isEmpty()) {
                    try {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        dob = sdf.parse(dobString);
                    } catch (ParseException e) {
                        e.printStackTrace();
                        request.setAttribute("error", "Ngày sinh không hợp lệ.");
                        request.getRequestDispatcher("account/register.jsp").forward(request, response);
                        return;
                    }
                } else {
                    request.setAttribute("error", "Ngày sinh không được để trống.");
                    request.getRequestDispatcher("account/register.jsp").forward(request, response);
                    return;
                }
                String hashedPassword = PasswordUtil.hashPassword(password);
                User user = new User();
                user.setFullname(fullName);
                user.setAddress(address);
                user.setDob(dob);
                user.setPhone(phone);
                user.setAvatar(picture);
                user.setIsVerified(true);
                UserDAO userDAO = new UserDAO();
                int userId = userDAO.registerUser(user, email, hashedPassword);
                if (userId > 0) {
                    User userLogin = userDAO.getUserByEmail(email);
                    HttpSession session = request.getSession();
                    session.setAttribute("userLogin", userLogin);
                    session.setAttribute("alertMessage", "Đăng nhập thành công");
                    session.setAttribute("alertType", "success");
                    response.sendRedirect("index.jsp");
                } else {
                    request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại.");
                    request.getRequestDispatcher("account/RegisterGoogle.jsp").forward(request, response);
                }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
