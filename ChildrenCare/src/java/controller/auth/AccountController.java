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
import model.Validate;

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
                    request.setAttribute("error", "Vui lòng nhập email.");
                    request.getRequestDispatcher("account/login.jsp").forward(request, response);
                    return;
                }

                if (password == null || password.isEmpty()) {
                    request.setAttribute("error", "Vui lòng nhập mật khẩu.");
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
                        response.sendRedirect("c/home");
                    } else {
                        request.setAttribute("error", "Tài khoản của bạn chưa được xác minh.");
                        request.getRequestDispatcher("account/login.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("error", "Email hoặc mật khẩu không đúng.");
                    request.getRequestDispatcher("account/login.jsp").forward(request, response);
                }
            }

            case "register" -> {
                // Nhận dữ liệu từ form
                String fullName = request.getParameter("fullname");
                String address = request.getParameter("address");
                String dobString = request.getParameter("dob");
                String phone = request.getParameter("mobile");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String picture = request.getParameter("picture") != null ? request.getParameter("picture") : "/assets/images/avatar.jpg";

                // Tạo đối tượng Validate để kiểm tra dữ liệu
                Validate validate = new Validate();

                // Biến lưu lỗi
                String errorMessage = "";
                Date dob = null;

                if (fullName == null || fullName.trim().isEmpty()) {
                    request.setAttribute("error", "Họ và tên không được để trống!");
                    request.getRequestDispatcher("account/register.jsp").forward(request, response);
                    return;
                }

                // Kiểm tra địa chỉ không được để trống
                if (address == null || address.trim().isEmpty()) {
                    errorMessage += "Địa chỉ không được để trống!<br>";
                }

                // Kiểm tra ngày sinh hợp lệ
                if (dobString != null && !dobString.isEmpty()) {
                    try {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        dob = sdf.parse(dobString);

                        // Kiểm tra ngày sinh không phải tương lai
                        if (dob.after(new Date())) {
                            errorMessage += "Ngày sinh không thể là ngày trong tương lai!<br>";
                        }
                    } catch (ParseException e) {
                        errorMessage += "Ngày sinh không hợp lệ!<br>";
                    }
                } else {
                    errorMessage += "Ngày sinh không được để trống!<br>";
                }

                // Kiểm tra số điện thoại hợp lệ
                if (!validate.checkPhone(phone)) {
                    errorMessage += "Số điện thoại không hợp lệ!<br>";
                }

                // Kiểm tra email hợp lệ
                if (!validate.checkEmail(email)) {
                    errorMessage += "Email không hợp lệ!<br>";
                }

                // Kiểm tra mật khẩu hợp lệ
//                if (!validate.checkPassword(password)) {
//                    errorMessage += "Mật khẩu phải có ít nhất 8 ký tự, gồm chữ hoa, chữ thường, số và ký tự đặc biệt!<br>";
//                }

                // Nếu có lỗi, quay lại trang đăng ký và hiển thị lỗi
                if (!errorMessage.isEmpty()) {
                    request.setAttribute("error", errorMessage);
                    request.getRequestDispatcher("account/register.jsp").forward(request, response);
                    return;
                }
                // Nếu có lỗi, lưu dữ liệu vào request và quay lại trang đăng ký
                if (!errorMessage.isEmpty()) {
                    request.setAttribute("error", errorMessage);
                    request.setAttribute("fullname", fullName);
                    request.setAttribute("address", address);
                    request.setAttribute("dob", dobString);
                    request.setAttribute("mobile", phone);
                    request.setAttribute("email", email);
                    request.getRequestDispatcher("account/register.jsp").forward(request, response);
                    return;
                }
                // Nếu dữ liệu hợp lệ, thực hiện đăng ký
                String hashedPassword = PasswordUtil.hashPassword(password);
                User user = new User();
                user.setFullname(fullName);
                user.setAddress(address);
                user.setDob(dob);
                user.setPhone(phone);
                user.setAvatar(picture);
                user.setIsVerified(false);

                String token = UUID.randomUUID().toString();
                Timestamp expiryTime = new Timestamp(System.currentTimeMillis() + (60 * 60 * 1000)); // Hết hạn sau 1 giờ

                UserDAO userDAO = new UserDAO();
                int userId = userDAO.registerUser(user, email, hashedPassword);

                if (userId > 0) {
                    // Lưu token xác thực
                    VerificationTokenDAO tokenDAO = new VerificationTokenDAO();
                    tokenDAO.saveVerificationToken(email, token, expiryTime);

                    // Gửi email xác nhận
                    EmailConfig emailSender = new EmailConfig();
                    emailSender.sendVerificationEmail(email, token);

                    request.setAttribute("message", "Đăng ký thành công! Vui lòng kiểm tra email để xác thực.");
                    request.getRequestDispatcher("account/login.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại.");
                    request.getRequestDispatcher("account/register.jsp").forward(request, response);
                }
            }
            case "forgotPassword" -> {
                String email = request.getParameter("email");
                if (email == null || email.isEmpty()) {
                    request.setAttribute("error", "Vui lòng nhập email.");
                    request.getRequestDispatcher("account/forgotpassword.jsp").forward(request, response);
                    return;
                }
                UserDAO userDAO = new UserDAO();
                User user = userDAO.getUserByEmail(email);
                if (user == null) {
                    request.setAttribute("error", "Không tìm thấy tài khoản của bạn. Vui lòng thử lại.");
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
                    request.setAttribute("message", "Email reset mật khẩu đã được gửi tới " + email);
                } catch (MessagingException e) {
                    request.setAttribute("error", "Có lỗi xảy ra khi gửi email. Vui lòng thử lại.");
                }

                request.getRequestDispatcher("account/forgotpassword.jsp").forward(request, response);
            }

            case "resetPassword" -> {
                String token = request.getParameter("token");
                String newPassword = request.getParameter("newPassword");

                if (token == null || token.isEmpty()) {
                    request.setAttribute("error", "Token không hợp lệ!");
                    request.getRequestDispatcher("account/error.jsp").forward(request, response);
                    return;
                }

                VerificationTokenDAO tokenDAO = new VerificationTokenDAO();
                String email = tokenDAO.getEmailByToken(token);

                if (email == null) {
                    request.setAttribute("error", "Token không hợp lệ hoặc đã hết hạn.");
                    request.getRequestDispatcher("account/error.jsp").forward(request, response);
                    return;
                }

                if (tokenDAO.isTokenExpired(token)) {
                    request.setAttribute("error", "Token đã hết hạn!");
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
                    request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin.");
                    request.getRequestDispatcher("account/newpassword.jsp").forward(request, response);
                    return;
                }

                if (!newPassword.equals(confirmPassword)) {
                    request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
                    request.getRequestDispatcher("account/newpassword.jsp").forward(request, response);
                    return;
                }

                VerificationTokenDAO tokenDAO = new VerificationTokenDAO();
                String email = tokenDAO.getEmailByToken(token);
                if (email == null) {
                    request.setAttribute("error", "Liên kết đặt lại mật khẩu không hợp lệ.");
                    request.getRequestDispatcher("account/error.jsp").forward(request, response);
                    return;
                }

                AccountDAO accountDAO = new AccountDAO();
                accountDAO.updatePassword(email, newPassword);

                tokenDAO.deleteToken(token);

                request.setAttribute("message", "Mật khẩu của bạn đã được thay đổi thành công.");
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
                            request.setAttribute("message", "Xác nhận email thành công!");
                            request.getRequestDispatcher("account/login.jsp").forward(request, response);
                        } else {
                            request.setAttribute("message", "Token đã hết hạn!");
                            request.getRequestDispatcher("account/error.jsp").forward(request, response);
                        }
                    } else {
                        request.setAttribute("message", "Token không hợp lệ!");
                        request.getRequestDispatcher("account/error.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("message", "Token không được cung cấp!");
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
