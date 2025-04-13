package controller;

import dal.ProductDBContext;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CancelOrderServlet", urlPatterns = {"/cancel-order"})
public class CancelOrderServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CancelOrderServlet.class.getName());
    private ProductDBContext productDB;

    @Override
    public void init() throws ServletException {
        productDB = new ProductDBContext();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy orderId từ tham số URL
        String orderIdStr = request.getParameter("oid");
        int orderId;
        try {
            orderId = Integer.parseInt(orderIdStr);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "Invalid order ID: " + orderIdStr, e);
            response.sendRedirect("myorders?error=Invalid order ID");
            return;
        }

        try {
            // Kiểm tra trạng thái hiện tại của đơn hàng
            String currentStatus = productDB.getOrderStatusById(orderId);
            if (currentStatus == null) {
                // Không tìm thấy đơn hàng
                response.sendRedirect("myorders?error=Order not found");
                return;
            }

            if (!"Pending".equalsIgnoreCase(currentStatus)) {
                // Nếu trạng thái không phải là Pending, không cho phép hủy
                response.sendRedirect("order-details?oid=" + orderId + "&error=Cannot cancel order with status " + currentStatus);
                return;
            }

            // Cập nhật trạng thái thành Cancelled
            boolean updated = productDB.updateOrderStatus(orderId, "Cancelled");
            if (updated) {
                LOGGER.info("Order " + orderId + " has been cancelled successfully.");
                // Chuyển hướng về trang chi tiết đơn hàng
                response.sendRedirect("order-details?oid=" + orderId + "&message=Order cancelled successfully");
            } else {
                LOGGER.warning("Failed to cancel order " + orderId);
                response.sendRedirect("order-details?oid=" + orderId + "&error=Failed to cancel order");
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error cancelling order " + orderId, e);
            response.sendRedirect("order-details?oid=" + orderId + "&error=Error cancelling order");
        }
    }
}