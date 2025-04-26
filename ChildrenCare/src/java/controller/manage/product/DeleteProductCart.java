package controller.manage.product;

import controller.auth.BaseRBAC;
import dal.ProductDBContext;
import model.Account;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/deleteProductCart")
public class DeleteProductCart extends BaseRBAC {

    private ProductDBContext productDB = new ProductDBContext();

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
         
                int pcartId;
                try {
                    pcartId = Integer.parseInt(request.getParameter("pcartId"));
                } catch (NumberFormatException e) {
                    session.setAttribute("cartMessage", "Invalid cart ID!");
                    session.setAttribute("cartAlertType", "error");
                    response.sendRedirect("c/ProductCart");
                    return;
                }

                // Xóa sản phẩm khỏi giỏ hàng
                boolean success = productDB.removeProductFromCart(pcartId);

                // Thiết lập thông báo
                if (success) {
                    session.setAttribute("cartMessage", "Product removed from cart successfully!");
                    session.setAttribute("cartAlertType", "success");
                } else {
                    session.setAttribute("cartMessage", "Failed to remove product from cart!");
                    session.setAttribute("cartAlertType", "error");
                }

                // Chuyển hướng lại trang giỏ hàng
                response.sendRedirect("c/ProductCart");
            } else {
                response.sendRedirect("../login");
            }
        } else {
            response.sendRedirect("../login");
        }
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        doAuthorizedGet(request, response, account);
    }
}