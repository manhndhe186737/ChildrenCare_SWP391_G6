package controller.manage.product; // Hoặc package phù hợp

import controller.auth.BaseRBAC; // Giữ lại nếu dùng
import dal.ProductDBContext;
import model.Account;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;


@WebServlet("/UpdateCartQuantity")
public class UpdateCartQuantity extends BaseRBAC { // Hoặc extends HttpServlet

    private static final Logger LOGGER = Logger.getLogger(UpdateCartQuantity.class.getName());
    private final ProductDBContext productDB = new ProductDBContext();

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        // GET request không nên dùng để thay đổi dữ liệu giỏ hàng
        response.sendRedirect(request.getContextPath() + "/c/ProductCart"); // Chuyển hướng về trang giỏ hàng
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String cartPageUrl = request.getContextPath() + "/c/ProductCart"; // URL trang giỏ hàng để redirect
        String loginPageUrl = request.getContextPath() + "/login";

        // --- Kiểm tra đăng nhập ---
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(loginPageUrl);
            return;
        }
        User user = (User) session.getAttribute("user");
        // int userId = user.getId(); // Lấy userId nếu cần cho việc kiểm tra bảo mật trong DAO

        int cartId = 0;
        int newQuantity = 0;

        try {
            // --- Lấy và Validate cartId ---
            String cartIdStr = request.getParameter("cartId"); // Đảm bảo tên khớp với input hidden trong form
            if (cartIdStr == null || cartIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Cart ID is missing.");
            }
            cartId = Integer.parseInt(cartIdStr);

            // --- Lấy và Validate quantity mới ---
            String quantityStr = request.getParameter("quantity"); // Đảm bảo tên khớp với input number trong form
             if (quantityStr == null || quantityStr.trim().isEmpty()) {
                throw new IllegalArgumentException("New quantity is missing.");
            }
            newQuantity = Integer.parseInt(quantityStr);

            // Kiểm tra số lượng phải lớn hơn 0
            if (newQuantity < 1) {
                // Nếu muốn xóa khi số lượng < 1, gọi hàm remove thay vì báo lỗi
                // boolean removed = productDB.removeProductFromCart(cartId);
                // if(removed) { ... thông báo xóa ... } else { ... thông báo lỗi xóa ...}
                // Hoặc báo lỗi như dưới:
                LOGGER.log(Level.WARNING, "Attempted to update cartId {0} with quantity {1} < 1 for userId {2}", new Object[]{cartId, newQuantity, user.getId()});
                session.setAttribute("cartMessage", "Quantity cannot be less than 1.");
                session.setAttribute("cartAlertType", "warning"); // Dùng warning thay vì error
                response.sendRedirect(cartPageUrl);
                return;
            }

            // --- Gọi DAO để cập nhật (DAO sẽ kiểm tra stock) ---
            // Nên thêm userId vào đây để kiểm tra quyền sở hữu cartId trong DAO
            // boolean success = productDB.updateCartQuantity(cartId, newQuantity, userId);
            boolean success = productDB.updateCartQuantity(cartId, newQuantity); // Dùng phiên bản hiện tại

            // --- Xử lý kết quả ---
            if (success) {
                LOGGER.info("Successfully updated quantity for cartId " + cartId + " to " + newQuantity + " for userId " + user.getId());
                session.setAttribute("cartMessage", "Cart quantity updated successfully!");
                session.setAttribute("cartAlertType", "success");
            } else {
                // Lý do thất bại có thể là hết hàng hoặc lỗi DB, hoặc cartId không tồn tại
                LOGGER.log(Level.WARNING, "Failed to update quantity for cartId {0} to {1} for userId {2}. Might be out of stock or item not found.", new Object[]{cartId, newQuantity, user.getId()});
                session.setAttribute("cartMessage", "Failed to update quantity. Item might be out of stock or unavailable.");
                session.setAttribute("cartAlertType", "error");
            }

            // --- Chuyển hướng về trang giỏ hàng ---
            response.sendRedirect(cartPageUrl);

        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid number format for cartId or quantity for userId " + user.getId() + ". cartId=" + request.getParameter("cartId") + ", quantity=" + request.getParameter("quantity"), e);
            session.setAttribute("cartMessage", "Invalid input value.");
            session.setAttribute("cartAlertType", "error");
            response.sendRedirect(cartPageUrl);
        } catch (IllegalArgumentException e) {
             LOGGER.log(Level.WARNING, "Missing parameter for cart update for userId " + user.getId() + ": " + e.getMessage());
             session.setAttribute("cartMessage", e.getMessage()); // Hiển thị lỗi cụ thể hơn
             session.setAttribute("cartAlertType", "error");
             response.sendRedirect(cartPageUrl);
        } catch (Exception e) {
             // Bắt các lỗi không mong muốn khác
            LOGGER.log(Level.SEVERE, "Unexpected error updating cart quantity for userId " + user.getId() + ", cartId " + cartId, e);
            session.setAttribute("cartMessage", "An unexpected error occurred. Please try again.");
            session.setAttribute("cartAlertType", "error");
            response.sendRedirect(cartPageUrl);
        }
    }
}