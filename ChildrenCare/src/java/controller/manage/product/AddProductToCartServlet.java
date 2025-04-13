package controller.manage.product;

import controller.auth.BaseRBAC;
import dal.ProductDBContext;
import model.Account;
import model.Product;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/AddProductToCart")
public class AddProductToCartServlet extends BaseRBAC {
    private static final Logger LOGGER = Logger.getLogger(AddProductToCartServlet.class.getName());
    private ProductDBContext productDB = new ProductDBContext();

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String userInfo = "unknown user";
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                userInfo = "user ID " + user.getId();
            }
        }
        LOGGER.log(Level.WARNING, "Attempt to access AddProductToCart via GET method by " + userInfo);
        response.sendRedirect(request.getContextPath() + "/productlist");
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            LOGGER.log(Level.WARNING, "No session found. Redirecting to login.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            LOGGER.log(Level.WARNING, "No user found in session. Redirecting to login.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int productId;
        int quantity;

        // Lấy productId và log giá trị
        String productIdParam = request.getParameter("productId");
        LOGGER.log(Level.INFO, "Received productId: " + productIdParam);
        try {
            productId = Integer.parseInt(productIdParam);
        } catch (NumberFormatException | NullPointerException e) {
            LOGGER.log(Level.WARNING, "Invalid productId: " + productIdParam, e);
            session.setAttribute("cartMessage", "Invalid Product ID!");
            session.setAttribute("cartAlertType", "error");
            response.sendRedirect(request.getContextPath() + "/productlist");
            return;
        }

        // Lấy quantity từ request, nếu không có thì mặc định là 1
        try {
            String quantityParam = request.getParameter("quantity");
            if (quantityParam != null && !quantityParam.trim().isEmpty()) {
                quantity = Integer.parseInt(quantityParam);
                if (quantity < 1) {
                    throw new NumberFormatException("Quantity must be at least 1");
                }
            } else {
                quantity = 1;
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid quantity: " + request.getParameter("quantity"), e);
            session.setAttribute("cartMessage", "Invalid quantity!");
            session.setAttribute("cartAlertType", "error");
            response.sendRedirect(request.getContextPath() + "/productlist");
            return;
        }

        // Lấy userId từ session
        int userId = user.getId();

        // Kiểm tra sản phẩm trước khi thêm vào giỏ hàng
        Product product = productDB.getProductById(productId);
        if (product == null) {
            LOGGER.log(Level.WARNING, "Product with ID " + productId + " does not exist in database.");
            session.setAttribute("cartMessage", "Product does not exist!");
            session.setAttribute("cartAlertType", "error");
            response.sendRedirect(request.getContextPath() + "/productlist");
            return;
        }

        if (product.getStock() < quantity) {
            LOGGER.log(Level.WARNING, "Not enough stock for product ID " + productId + ". Requested: " + quantity + ", Available: " + product.getStock());
            session.setAttribute("cartMessage", "Product is out of stock!");
            session.setAttribute("cartAlertType", "error");
            response.sendRedirect(request.getContextPath() + "/productlist");
            return;
        }

        // Thêm sản phẩm vào giỏ hàng
        boolean success = productDB.addProductToCart(userId, productId, quantity);

        // Xử lý chuyển hướng dựa trên kết quả
        if (success) {
            LOGGER.log(Level.INFO, "Successfully added product ID " + productId + " to cart for user ID " + userId);
            session.setAttribute("cartMessage", "Product added to cart successfully!");
            session.setAttribute("cartAlertType", "success");
            String cartServletUrl = request.getContextPath() + "/c/ProductCart";
            response.sendRedirect(cartServletUrl);
        } else {
            LOGGER.log(Level.WARNING, "Failed to add product ID " + productId + " to cart for user ID " + userId + ". Possible database error.");
            session.setAttribute("cartMessage", "Failed to add product to cart! Please try again.");
            session.setAttribute("cartAlertType", "error");
            response.sendRedirect(request.getContextPath() + "/productlist");
        }
    }
}