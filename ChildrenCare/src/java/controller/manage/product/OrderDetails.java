package controller.manage.product;

import controller.auth.BaseRBAC;
import dal.ProductDBContext;
import model.Account;
import model.Order;
import model.OrderDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/order-details")
public class OrderDetails extends BaseRBAC {

    private ProductDBContext productDB = new ProductDBContext();

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("oid"));

        // Lấy thông tin đơn hàng
        Order order = productDB.getOrderById(orderId);
        // Lấy chi tiết đơn hàng
        List<OrderDetail> orderDetails = productDB.getOrderDetailsByOrderId(orderId);

        // Gửi dữ liệu đến JSP
        request.setAttribute("order", order);
        request.setAttribute("orderDetails", orderDetails);

        // Forward đến trang JSP
        request.getRequestDispatcher("c/order-details.jsp").forward(request, response);
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        response.sendRedirect("myorders");
    }
}