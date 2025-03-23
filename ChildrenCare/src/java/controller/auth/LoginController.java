package controller.auth;

import DAO.UserDAO;
import dal.AccountDBContext;
import model.Account;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.UserGoogleDto;
import controller.manage.Constants;
import jakarta.servlet.http.HttpSession;
import model.Role;
import model.User;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;

/**
 * Servlet xử lý đăng nhập bằng Google OAuth và tài khoản thường.
 */
public class LoginController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("code");
        String error = request.getParameter("error"); // Kiểm tra lỗi từ Google
        if (error != null && error.equals("access_denied")) {
            // Nếu người dùng bấm "Cancel", chuyển hướng về trang login với thông báo
            response.sendRedirect("login");
            return;
        }

//        if (code == null || code.isEmpty()) {
//            // Nếu không có code từ Google, trả về lỗi
//            request.setAttribute("error", "Không nhận được mã xác thực từ Google.");
//            request.getRequestDispatcher("account/login.jsp").forward(request, response);
//            return;
//        }
        try {
            // Lấy Access Token từ Google
            String accessToken = getToken(code);
            UserGoogleDto user = getUserInfo(accessToken);

            // Kiểm tra email đã tồn tại trong database chưa
            UserDAO userDao = new UserDAO();

            User existingUser = userDao.getUserByEmail(user.getEmail());
            Account acc = userDao.getUserRoles(user.getEmail());

            String roles = "";
            if (acc != null) {
                for (Role r : acc.getRoles()) {
                    roles += r.getRname() + ", ";
                }
            }

            if (existingUser != null) {
                // Nếu người dùng đã đăng ký, lưu session và chuyển hướng về home
                HttpSession session = request.getSession();
                session.setAttribute("user", existingUser);
                session.setAttribute("account", acc);
                session.setAttribute("role", roles);
                session.setAttribute("isLoggedIn", true);
                session.setAttribute("alertMessage", "Login successfully!");
                session.setAttribute("alertType", "success");  //danger,error , ...
                response.sendRedirect("c/home");
            } else {
                // Nếu chưa có tài khoản, chuyển hướng về trang đăng ký bằng Google
                request.setAttribute("email", user.getEmail());
                request.setAttribute("name", user.getName());
                request.setAttribute("picture", user.getPicture());
                request.getRequestDispatcher("/account/RegisterGoogle.jsp").forward(request, response);
            }
        } catch (ServletException | IOException e) {
            request.setAttribute("error", "An error occur when login with Google");
            request.getRequestDispatcher("account/login.jsp").forward(request, response);
        }
    }

    /**
     * Lấy Access Token từ Google dựa trên code nhận được.
     */
    public static String getToken(final String code) throws ClientProtocolException, IOException {
        String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form()
                        .add("client_id", Constants.GOOGLE_CLIENT_ID)
                        .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI)
                        .add("code", code)
                        .add("grant_type", Constants.GOOGLE_GRANT_TYPE)
                        .build())
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        return jobj.get("access_token").getAsString();
    }

    /**
     * Lấy thông tin người dùng từ Google bằng Access Token.
     */
    public static UserGoogleDto getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();
        return new Gson().fromJson(response, UserGoogleDto.class);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("pass");

        AccountDBContext adb = new AccountDBContext();
        Account account = adb.getAccount(email, password);

        if (account != null) {
            request.getSession().setAttribute("account", account);
            response.getWriter().print(account.getEmail());
        } else {
            response.getWriter().println("Login fail! Please check your email or password");
        }
    }

    @Override
    public String getServletInfo() {
        return "Login Controller - Xử lý đăng nhập bằng tài khoản thường và Google OAuth";
    }
}
