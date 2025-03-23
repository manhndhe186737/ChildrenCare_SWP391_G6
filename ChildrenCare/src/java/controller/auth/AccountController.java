/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import DAO.AccountDAO;
import DAO.UserDAO;
import DAO.VerificationTokenDAO;
import java.io.IOException;
import config.EmailConfig;
import config.PasswordUtil;
import java.util.UUID;
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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import model.Account;
import model.Role;

import model.User;

@WebServlet(name = "AccountController", urlPatterns = {"/login"})
public class AccountController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, MessagingException, ParseException, Exception {
        String service = request.getParameter("service");
        if (service == null) {
            service = "login";
        }
        switch (service) {
            case "login" -> {
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                if (email == null || email.isEmpty()) {
                    request.setAttribute("error", "Please enter email");
                    request.getRequestDispatcher("account/login.jsp").forward(request, response);
                    return;
                }

                if (password == null || password.isEmpty()) {
                    request.setAttribute("error", "Please enter password");
                    request.getRequestDispatcher("account/login.jsp").forward(request, response);
                    return;
                }

                UserDAO userDAO = new UserDAO();
                User user = userDAO.getUserByEmail(email);
                Account acc = userDAO.getUserRoles(email);
                user.setAccount(acc);

                String roles = "";
                if (acc != null) {
                    for (Role r : acc.getRoles()) {
                        roles += r.getRname() + ", ";
                    }
                }

                if (user != null && PasswordUtil.verifyPassword(password, user.getAccount().getPassword())) {
                    if (user.isIsVerified()) {
                        HttpSession session = request.getSession();
                        session.setAttribute("user", user);
                        session.setAttribute("account", acc);
                        session.setAttribute("role", roles);
                        session.setAttribute("isLoggedIn", true);
                        session.setAttribute("alertMessage", "Login successfully!");
                        session.setAttribute("alertType", "success");
                        response.sendRedirect("c/home");
                    } else {
                        request.setAttribute("error", "Your account has not been verified.");
                        request.getRequestDispatcher("account/login.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("error", "Email or password is incorrect!");
                    request.getRequestDispatcher("account/login.jsp").forward(request, response);
                }
            }

            case "register" -> {
                String fullName = request.getParameter("fullname");
                String address = request.getParameter("address");
                String dobString = request.getParameter("dob");
                String phone = request.getParameter("mobile");
                String avatar = request.getParameter("avatar");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                Date dob = null;
                if (dobString != null && !dobString.isEmpty()) {
                    try {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        dob = sdf.parse(dobString);
                    } catch (ParseException e) {
                        e.printStackTrace();
                        request.setAttribute("error", "Invalid date of birth!");
                        request.getRequestDispatcher("account/register.jsp").forward(request, response);
                        return;
                    }
                } else {
                    request.setAttribute("error", "Date of birth must not be empty!");
                    request.getRequestDispatcher("account/register.jsp").forward(request, response);
                    return;
                }
                String hashedPassword = PasswordUtil.hashPassword(password);
                User user = new User();
                user.setFullname(fullName);
                user.setAddress(address);
                user.setDob(dob);
                user.setPhone(phone);
                user.setAvatar(avatar);
                user.setIsVerified(false);
                String token = UUID.randomUUID().toString();
                Timestamp expiryTime = new Timestamp(System.currentTimeMillis() + (60 * 60 * 1000));
                UserDAO userDAO = new UserDAO();
                int userId = userDAO.registerUser(user, email, hashedPassword);
                if (userId > 0) {
                    VerificationTokenDAO tokenDAO = new VerificationTokenDAO();
                    tokenDAO.saveVerificationToken(email, token, expiryTime);
                    EmailConfig emailSender = new EmailConfig();
                    emailSender.sendVerificationEmail(email, token);
                    request.setAttribute("message", "Register successfully! Please check your email to verify.");
                    request.getRequestDispatcher("account/login.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Register fail! Please try again.");
                    request.getRequestDispatcher("account/register.jsp").forward(request, response);
                }
            }
            case "forgotPassword" -> {
                String email = request.getParameter("email");
                if (email == null || email.isEmpty()) {
                    request.setAttribute("error", "Please enter email");
                    request.getRequestDispatcher("account/forgotpassword.jsp").forward(request, response);
                    return;
                }
                UserDAO userDAO = new UserDAO();
                User user = userDAO.getUserByEmail(email);
                if (user == null) {
                    request.setAttribute("error", "Your account is not found. Please try again!");
                    request.getRequestDispatcher("account/forgotpassword.jsp").forward(request, response);
                    return;
                }
                String token = UUID.randomUUID().toString();
                VerificationTokenDAO tokenDAO = new VerificationTokenDAO();
                Timestamp expiryTime = new Timestamp(System.currentTimeMillis() + (60 * 60 * 1000));
                tokenDAO.saveVerificationToken(email, token, expiryTime);

                EmailConfig emailSender = new EmailConfig();
                try {
                    emailSender.sendPasswordResetEmail(email, token);
                    request.setAttribute("message", "Email reset password has been sent to " + email);
                } catch (MessagingException e) {
                    request.setAttribute("error", "An error occur when send to your email. Please try again.");
                }

                request.getRequestDispatcher("account/forgotpassword.jsp").forward(request, response);
            }

            case "resetPassword" -> {
                String token = request.getParameter("token");
                String newPassword = request.getParameter("newPassword");

                if (token == null || token.isEmpty()) {
                    request.setAttribute("error", "Invalid token!");
                    request.getRequestDispatcher("account/error.jsp").forward(request, response);
                    return;
                }

                VerificationTokenDAO tokenDAO = new VerificationTokenDAO();
                String email = tokenDAO.getEmailByToken(token);

                if (email == null) {
                    request.setAttribute("error", "Token is invalid or expired!");
                    request.getRequestDispatcher("account/error.jsp").forward(request, response);
                    return;
                }

                if (tokenDAO.isTokenExpired(token)) {
                    request.setAttribute("error", "Token has been expired!");
                    request.getRequestDispatcher("account/error.jsp").forward(request, response);
                    return;
                }
                request.setAttribute("token", token);
                request.getRequestDispatcher("account/newpassword.jsp").forward(request, response);
            }
            case "resetPasswordSubmit" -> {
                String token = request.getParameter("token");
                String newPassword = request.getParameter("newPassword");
                String confirmPassword = request.getParameter("confirmPassword");
                if (newPassword == null || newPassword.isEmpty() || confirmPassword == null || confirmPassword.isEmpty()) {
                    request.setAttribute("error", "Please enter all information");
                    request.getRequestDispatcher("account/newpassword.jsp").forward(request, response);
                    return;
                }

                if (!newPassword.equals(confirmPassword)) {
                    request.setAttribute("error", "Confirm password is not match");
                    request.getRequestDispatcher("account/newpassword.jsp").forward(request, response);
                    return;
                }

                VerificationTokenDAO tokenDAO = new VerificationTokenDAO();
                String email = tokenDAO.getEmailByToken(token);
                if (email == null) {
                    request.setAttribute("error", "Url is invalid!");
                    request.getRequestDispatcher("account/error.jsp").forward(request, response);
                    return;
                }

                AccountDAO accountDAO = new AccountDAO();
                accountDAO.updatePassword(email, newPassword);

                tokenDAO.deleteToken(token);

                request.setAttribute("message", "Your password has been changed successfully!");
                request.getRequestDispatcher("account/login.jsp").forward(request, response);
            }

            case "verify" -> {
                String token = request.getParameter("token");
                String type = request.getParameter("type");
                if (token != null && !token.isEmpty() && "register".equals(type)) {
                    UserDAO userDAO = new UserDAO();
                    VerificationTokenDAO tokenDAO = new VerificationTokenDAO();
                    String email = tokenDAO.getEmailByToken(token);
                    if (email != null) {
                        boolean tokenExpired = tokenDAO.isTokenExpired(token);
                        if (!tokenExpired) {
                            userDAO.verifyUser(email);
                            tokenDAO.deleteToken(token);
                            request.setAttribute("message", "Confirm email successfully!");
                            request.getRequestDispatcher("account/login.jsp").forward(request, response);
                        } else {
                            request.setAttribute("message", "Token has been expired!");
                            request.getRequestDispatcher("account/error.jsp").forward(request, response);
                        }
                    } else {
                        request.setAttribute("message", "Token is invalid!");
                        request.getRequestDispatcher("account/error.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("message", "Token is not provided!");
                    request.getRequestDispatcher("account/error.jsp").forward(request, response);
                }
            }
            default -> {
                request.getRequestDispatcher("account/login.jsp").forward(request, response);
            }
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
        } catch (MessagingException ex) {
            Logger.getLogger(AccountController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(AccountController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(AccountController.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (MessagingException ex) {
            Logger.getLogger(AccountController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(AccountController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(AccountController.class.getName()).log(Level.SEVERE, null, ex);
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
