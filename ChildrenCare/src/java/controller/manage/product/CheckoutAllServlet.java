package controller;

import dal.ProductDBContext;
import model.CartItem;
import model.Product;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/CheckoutAll")
public class CheckoutAllServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CheckoutAllServlet.class.getName());
    private ProductDBContext productDB;

    @Override
    public void init() throws ServletException {
        productDB = new ProductDBContext();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Kiểm tra đăng nhập
        if (session == null || session.getAttribute("user") == null) {
            LOGGER.log(Level.WARNING, "User not logged in while attempting to checkout. " +
                    "Session: " + (session == null ? "null" : "exists"));
            session = request.getSession(true);
            session.setAttribute("cartMessage", "Please log in to proceed with checkout.");
            session.setAttribute("cartAlertType", "error");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getId();
        LOGGER.info("Processing checkout for userId: " + userId);

        // Lấy dữ liệu từ form
        String[] cartIds = request.getParameterValues("cartIds");
        String[] quantities = request.getParameterValues("quantities");
        String[] productIds = request.getParameterValues("productIds");

        // Kiểm tra dữ liệu đầu vào
        if (cartIds == null || quantities == null || productIds == null ||
                cartIds.length != quantities.length || cartIds.length != productIds.length) {
            LOGGER.log(Level.WARNING, "Invalid input data: cartIds, quantities, or productIds are null or have mismatched lengths. " +
                    "cartIds=" + Arrays.toString(cartIds) + ", quantities=" + Arrays.toString(quantities) + ", productIds=" + Arrays.toString(productIds));
            session.setAttribute("cartMessage", "Invalid cart data. Please try again.");
            session.setAttribute("cartAlertType", "error");
            request.getRequestDispatcher("c/product-cart.jsp").forward(request, response);
            return;
        }

        // Chuyển đổi dữ liệu
        List<Integer> cartIdList = new ArrayList<>();
        List<Integer> quantityList = new ArrayList<>();
        List<Integer> productIdList = new ArrayList<>();

        try {
            for (int i = 0; i < cartIds.length; i++) {
                cartIdList.add(Integer.parseInt(cartIds[i]));
                quantityList.add(Integer.parseInt(quantities[i]));
                productIdList.add(Integer.parseInt(productIds[i]));
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "Invalid number format in input: " + e.getMessage(), e);
            session.setAttribute("cartMessage", "Invalid cart data format. Please try again.");
            session.setAttribute("cartAlertType", "error");
            request.getRequestDispatcher("c/product-cart.jsp").forward(request, response);
            return;
        }

        // Tạo danh sách CartItem và tính tổng tiền
        List<CartItem> cartItems = new ArrayList<>();
        double totalAmount = 0;

        try {
            // Lấy danh sách cart items của user để kiểm tra quyền sở hữu
            List<CartItem> userCartItems = productDB.getCartItemsByUserId(userId);

            for (int i = 0; i < cartIdList.size(); i++) {
                int cartId = cartIdList.get(i);
                int quantity = quantityList.get(i);
                int productId = productIdList.get(i);

                // Kiểm tra xem cartId có thuộc về userId không
                CartItem cartItem = userCartItems.stream()
                        .filter(item -> item.getCartId() == cartId && item.getProduct().getProductId() == productId)
                        .findFirst()
                        .orElse(null);

                if (cartItem == null) {
                    LOGGER.log(Level.WARNING, "Cart item does not belong to user: cartId=" + cartId + ", userId=" + userId + ", productId=" + productId);
                    session.setAttribute("cartMessage", "Invalid cart item or product is no longer available.");
                    session.setAttribute("cartAlertType", "error");
                    request.getRequestDispatcher("c/product-cart.jsp").forward(request, response);
                    return;
                }

                // Lấy thông tin sản phẩm
                Product product = productDB.getProductById(productId);
                if (product == null || !product.isStatus()) {
                    LOGGER.log(Level.WARNING, "Product not found or inactive: productId=" + productId);
                    session.setAttribute("cartMessage", "Product " + (product != null ? product.getProductName() : "ID " + productId) + " is no longer available.");
                    session.setAttribute("cartAlertType", "error");
                    request.getRequestDispatcher("c/product-cart.jsp").forward(request, response);
                    return;
                }

                // Kiểm tra số lượng tồn kho
                if (product.getStock() < quantity) {
                    LOGGER.log(Level.WARNING, "Not enough stock for product: productId=" + productId + ", requested=" + quantity + ", available=" + product.getStock());
                    session.setAttribute("cartMessage", "Not enough stock for product: " + product.getProductName() + ". Available: " + product.getStock());
                    session.setAttribute("cartAlertType", "error");
                    request.getRequestDispatcher("c/product-cart.jsp").forward(request, response);
                    return;
                }

                // Tạo CartItem
                double subtotal = product.getPrice() * quantity;
                totalAmount += subtotal;

                cartItem.setQuantity(quantity);
                cartItem.setProduct(product);
                cartItems.add(cartItem);
            }

            // Kiểm tra nếu giỏ hàng rỗng
            if (cartItems.isEmpty()) {
                LOGGER.log(Level.WARNING, "Cart is empty for userId=" + userId);
                session.setAttribute("cartMessage", "Your cart is empty. Please add products to proceed with checkout.");
                session.setAttribute("cartAlertType", "error");
                request.getRequestDispatcher("c/product-cart.jsp").forward(request, response);
                return;
            }

            // Đặt thông tin vào request scope
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("isFromCart", true);

            // Chuyển tiếp đến trang thanh toán
            LOGGER.info("Forwarding to product-checkout.jsp with totalAmount=" + totalAmount + ", cartItems size=" + cartItems.size() + ", userId=" + userId);
            request.getRequestDispatcher("c/product-checkout.jsp").forward(request, response);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error during checkout for userId=" + userId + ": " + e.getMessage(), e);
            session.setAttribute("cartMessage", "An unexpected error occurred. Please try again.");
            session.setAttribute("cartAlertType", "error");
            request.getRequestDispatcher("c/product-cart.jsp").forward(request, response);
        }
    }
}