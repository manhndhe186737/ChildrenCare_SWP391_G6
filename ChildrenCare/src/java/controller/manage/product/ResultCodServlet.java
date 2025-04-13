package controller;

import dal.ProductDBContext;
import model.CartItem;
import model.Order;
import model.Product;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/resultCod")
public class ResultCodServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ResultCodServlet.class.getName());
    private ProductDBContext productDB;

    @Override
    public void init() throws ServletException {
        productDB = new ProductDBContext();
        LOGGER.log(Level.INFO, "ResultCodServlet initialized with ProductDBContext");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy session và kiểm tra đăng nhập
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Integer userId = (user != null) ? user.getId() : null;

        LOGGER.log(Level.INFO, "Processing request. Session ID: {0}, User: {1}, UserId: {2}",
                new Object[]{session.getId(), user, userId});

        if (userId == null) {
            LOGGER.log(Level.WARNING, "User not logged in. Redirecting to login page.");
            request.setAttribute("error", "Please log in to place an order.");
            request.getRequestDispatcher("login").forward(request, response);
            return;
        }

        // Lấy thông tin từ form
        String paymentMethod = request.getParameter("payment_method");
        String paymentStatus = request.getParameter("payment_status");
        String date = request.getParameter("date");
        String status = request.getParameter("status");
        String address = request.getParameter("address");
        String customerName = request.getParameter("customer_name");
        String isFromCartStr = request.getParameter("isFromCart");
        String[] cartIds = request.getParameterValues("cartIds");
        String[] productIds = request.getParameterValues("productIds");
        String[] quantities = request.getParameterValues("quantities");

        // Ghi log dữ liệu form
        LOGGER.log(Level.INFO, "Received form data: payment_method={0}, payment_status={1}, date={2}, status={3}, " +
                        "address={4}, customer_name={5}, isFromCart={6}, cartIds={7}, productIds={8}, quantities={9}",
                new Object[]{paymentMethod, paymentStatus, date, status, address, customerName, isFromCartStr,
                        Arrays.toString(cartIds), Arrays.toString(productIds), Arrays.toString(quantities)});

        // Kiểm tra dữ liệu đầu vào
        if (!validateFormData(paymentMethod, paymentStatus, date, status, address, customerName, isFromCartStr,
                cartIds, productIds, quantities, request, response)) {
            return;
        }

        // Parse isFromCart
        boolean isFromCart;
        try {
            isFromCart = Boolean.parseBoolean(isFromCartStr);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Invalid isFromCart format: {0}", isFromCartStr);
            request.setAttribute("error", "Invalid data format for cart selection.");
            request.getRequestDispatcher("c/product-checkout.jsp").forward(request, response);
            return;
        }

        // Tạo danh sách CartItem và tính tổng tiền
        List<CartItem> cartItems = new ArrayList<>();
        List<Integer> cartIdList = new ArrayList<>();
        List<Integer> productIdList = new ArrayList<>();
        double amount = 0.0;

        for (int i = 0; i < productIds.length; i++) {
            int productId, quantity, cartId;
            try {
                productId = Integer.parseInt(productIds[i]);
                quantity = Integer.parseInt(quantities[i]);
                cartId = (cartIds != null && cartIds.length > i) ? Integer.parseInt(cartIds[i]) : 0;
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid number format: productId={0}, quantity={1}, cartId={2}, error={3}",
                        new Object[]{productIds[i], quantities[i], (cartIds != null && cartIds.length > i ? cartIds[i] : "null"), e.getMessage()});
                request.setAttribute("error", "Invalid product data format.");
                request.getRequestDispatcher("c/product-checkout.jsp").forward(request, response);
                return;
            }

            Product product = productDB.getProductById(productId);
            if (product == null) {
                LOGGER.log(Level.WARNING, "Product not found for ID: {0}", productId);
                request.setAttribute("error", "Product with ID " + productId + " does not exist.");
                request.getRequestDispatcher("c/product-checkout.jsp").forward(request, response);
                return;
            }

            // Kiểm tra số lượng tồn kho
            if (product.getStock() < quantity) {
                LOGGER.log(Level.WARNING, "Insufficient stock for product ID {0}. Available: {1}, Requested: {2}",
                        new Object[]{productId, product.getStock(), quantity});
                request.setAttribute("error", "Insufficient stock for product: " + product.getProductName() +
                        ". Available: " + product.getStock() + ", Requested: " + quantity);
                request.getRequestDispatcher("c/product-checkout.jsp").forward(request, response);
                return;
            }

            CartItem cartItem = new CartItem(cartId, product, quantity);
            cartItems.add(cartItem);
            if (cartId > 0) {
                cartIdList.add(cartId);
            }
            productIdList.add(productId);
            amount += product.getPrice() * quantity;

            LOGGER.log(Level.INFO, "Added CartItem: productId={0}, quantity={1}, cartId={2}, price={3}, subtotal={4}",
                    new Object[]{productId, quantity, cartId, product.getPrice(), product.getPrice() * quantity});
        }

        // Kiểm tra cartItems và amount
        if (cartItems.isEmpty()) {
            LOGGER.log(Level.WARNING, "Cart items list is empty after processing.");
            request.setAttribute("error", "No items to process order.");
            request.getRequestDispatcher("c/product-checkout.jsp").forward(request, response);
            return;
        }

        if (amount <= 0) {
            LOGGER.log(Level.WARNING, "Invalid total amount: {0}", amount);
            request.setAttribute("error", "Total amount is invalid. Please check your cart.");
            request.getRequestDispatcher("c/product-checkout.jsp").forward(request, response);
            return;
        }

        LOGGER.log(Level.INFO, "Total amount calculated: {0}, Number of cart items: {1}", new Object[]{amount, cartItems.size()});

        // Tạo đối tượng Order
        Order order = new Order();
        order.setPaymentMethod(paymentMethod);
        order.setAmount(amount);
        order.setPaymentStatus(paymentStatus);
        order.setUserId(userId);
        try {
            Date orderDateParsed = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            order.setOrderDate(orderDateParsed);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Invalid date format from request: {0}. Using current date instead.", date);
            order.setOrderDate(new Date());
        }
        order.setStatus(status);
        order.setAddress(address);
        order.setCustomerName(customerName);

        // Log thông tin Order
        LOGGER.log(Level.INFO, "Preparing to save order: userId={0}, amount={1}, paymentMethod={2}, date={3}, status={4}, address={5}, customerName={6}",
                new Object[]{userId, amount, paymentMethod, order.getOrderDate(), status, address, customerName});

        // Xử lý database
        try {
            productDB.beginTransaction();
            LOGGER.log(Level.INFO, "Transaction started for saving order.");

            // Lưu đơn hàng chính vào bảng 'orders'
            int orderId = productDB.saveOrder(order);
            if (orderId <= 0) {
                LOGGER.log(Level.SEVERE, "saveOrder failed or returned invalid orderId: {0}", orderId);
                throw new SQLException("Failed to save order. Invalid order ID returned: " + orderId);
            }
            LOGGER.log(Level.INFO, "Order saved successfully to 'orders' table with ID: {0}", orderId);

            // Lưu chi tiết đơn hàng vào bảng 'order_detail'
            LOGGER.log(Level.INFO, "Saving order details for order ID: {0}, cartItems: {1}", new Object[]{orderId, cartItems.size()});
            productDB.saveOrderDetails(orderId, cartItems);
            LOGGER.log(Level.INFO, "Order details saved successfully for order ID: {0}", orderId);

            // Cập nhật số lượng tồn kho (stock)
            LOGGER.log(Level.INFO, "Updating product stock for order ID: {0}", orderId);
            productDB.updateProductStock(cartItems);
            LOGGER.log(Level.INFO, "Product stock updated successfully for order ID: {0}", orderId);

            // Xóa giỏ hàng
            List<Integer> cartIdsToDelete = new ArrayList<>();

            // Trường hợp thanh toán từ giỏ hàng
            if (isFromCart && !cartIdList.isEmpty()) {
                LOGGER.log(Level.INFO, "Order is from cart. Preparing to delete cart items: {0}", cartIdList);
                cartIdsToDelete.addAll(cartIdList);
            }

            // Trường hợp thanh toán sản phẩm lẻ: Kiểm tra xem sản phẩm có trong giỏ hàng không
            if (!isFromCart) {
                LOGGER.log(Level.INFO, "Order is for individual products. Checking if products exist in cart for userId: {0}", userId);
                List<Integer> cartIdsFromProducts = productDB.getCartIdsByUserAndProductIds(userId, productIdList);
                if (!cartIdsFromProducts.isEmpty()) {
                    LOGGER.log(Level.INFO, "Found products in cart for userId {0}. Cart IDs to delete: {1}",
                            new Object[]{userId, cartIdsFromProducts});
                    cartIdsToDelete.addAll(cartIdsFromProducts);
                } else {
                    LOGGER.log(Level.INFO, "No matching products found in cart for userId {0} and productIds {1}",
                            new Object[]{userId, productIdList});
                }
            }

            // Xóa các mục trong giỏ hàng nếu có
            if (!cartIdsToDelete.isEmpty()) {
                LOGGER.log(Level.INFO, "Deleting cart items for order ID: {0}, cartIds: {1}", new Object[]{orderId, cartIdsToDelete});
                productDB.deleteCartItems(cartIdsToDelete);
                LOGGER.log(Level.INFO, "Cart items deleted successfully for order ID: {0}, cartIds: {1}",
                        new Object[]{orderId, cartIdsToDelete});
            } else {
                LOGGER.log(Level.INFO, "No cart items to delete for order ID: {0}", orderId);
            }

            // Commit transaction
            productDB.commitTransaction();
            LOGGER.log(Level.INFO, "Transaction committed successfully for order ID: {0}", orderId);

            // Chuyển hướng thành công
            request.setAttribute("message", "Your order has been placed successfully! It will be delivered soon.");
            request.getRequestDispatcher("c/order-confirmation.jsp").forward(request, response);

        } catch (SQLException e) {
            // Rollback nếu có lỗi
            LOGGER.log(Level.SEVERE, "SQL Error occurred while processing order: " + e.getMessage(), e);
            try {
                productDB.rollbackTransaction();
                LOGGER.log(Level.WARNING, "Transaction rolled back due to error.");
            } catch (SQLException rollbackEx) {
                LOGGER.log(Level.SEVERE, "Error during rollback: " + rollbackEx.getMessage(), rollbackEx);
            }
            request.setAttribute("error", "An error occurred while processing your order: " + e.getMessage());
            request.getRequestDispatcher("c/product-checkout.jsp").forward(request, response);
        } catch (Exception ex) {
            // Bắt các lỗi khác không phải SQLException
            LOGGER.log(Level.SEVERE, "An unexpected error occurred: " + ex.getMessage(), ex);
            try {
                productDB.rollbackTransaction();
                LOGGER.log(Level.WARNING, "Transaction rolled back due to unexpected error.");
            } catch (SQLException rollbackEx) {
                LOGGER.log(Level.SEVERE, "Error during rollback: " + rollbackEx.getMessage(), rollbackEx);
            }
            request.setAttribute("error", "An unexpected error occurred while processing your order.");
            request.getRequestDispatcher("c/product-checkout.jsp").forward(request, response);
        }
    }

    private boolean validateFormData(String paymentMethod, String paymentStatus, String date, String status,
                                    String address, String customerName, String isFromCartStr,
                                    String[] cartIds, String[] productIds, String[] quantities,
                                    HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra các tham số bắt buộc
        if (paymentMethod == null || paymentStatus == null || date == null ||
                status == null || address == null || customerName == null || isFromCartStr == null ||
                productIds == null || quantities == null) {
            LOGGER.log(Level.WARNING, "Missing required form parameters: " +
                    "paymentMethod={0}, paymentStatus={1}, date={2}, status={3}, address={4}, customerName={5}, " +
                    "isFromCartStr={6}, productIds={7}, quantities={8}",
                    new Object[]{paymentMethod, paymentStatus, date, status, address, customerName, isFromCartStr,
                            Arrays.toString(productIds), Arrays.toString(quantities)});
            request.setAttribute("error", "Missing required information. Please fill out all fields.");
            request.getRequestDispatcher("c/product-checkout.jsp").forward(request, response);
            return false;
        }

        // Kiểm tra độ dài của các mảng
        if (productIds.length == 0 || quantities.length == 0) {
            LOGGER.log(Level.WARNING, "Product IDs or quantities array is empty: productIds={0}, quantities={1}",
                    new Object[]{Arrays.toString(productIds), Arrays.toString(quantities)});
            request.setAttribute("error", "No products selected for the order.");
            request.getRequestDispatcher("c/product-checkout.jsp").forward(request, response);
            return false;
        }

        // Kiểm tra độ dài chỉ khi cartIds không null (trường hợp đến từ giỏ hàng)
        if (cartIds != null && (cartIds.length != productIds.length || productIds.length != quantities.length)) {
            LOGGER.log(Level.WARNING, "Mismatched array lengths: cartIds={0}, productIds={1}, quantities={2}",
                    new Object[]{cartIds.length, productIds.length, quantities.length});
            request.setAttribute("error", "Invalid order data. Please check your cart.");
            request.getRequestDispatcher("c/product-checkout.jsp").forward(request, response);
            return false;
        } else if (cartIds == null && (productIds.length != quantities.length)) {
            LOGGER.log(Level.WARNING, "Mismatched array lengths (buy now): productIds={0}, quantities={1}",
                    new Object[]{productIds.length, quantities.length});
            request.setAttribute("error", "Invalid order data.");
            request.getRequestDispatcher("c/product-checkout.jsp").forward(request, response);
            return false;
        }

        // Kiểm tra các trường không được rỗng
        if (address.trim().isEmpty() || customerName.trim().isEmpty()) {
            LOGGER.log(Level.WARNING, "Address or Customer Name is empty: address={0}, customerName={1}",
                    new Object[]{address, customerName});
            request.setAttribute("error", "Address and Customer Name cannot be empty.");
            request.getRequestDispatcher("c/product-checkout.jsp").forward(request, response);
            return false;
        }

        return true;
    }
}