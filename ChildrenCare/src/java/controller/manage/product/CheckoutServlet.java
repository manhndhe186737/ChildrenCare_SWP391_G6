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
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/Checkout")
public class CheckoutServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(CheckoutServlet.class.getName());
    private ProductDBContext productDB;

    @Override
    public void init() throws ServletException {
        productDB = new ProductDBContext();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        LOGGER.info("Session exists: " + (session != null));

        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            LOGGER.log(Level.WARNING, "User not logged in while attempting to checkout.");
            response.sendRedirect("login.jsp");
            return;
        }

        Object userObj = session.getAttribute("user");
        if (!(userObj instanceof User)) {
            LOGGER.log(Level.SEVERE, "Invalid user object in session: " + (userObj != null ? userObj.getClass().getName() : "null"));
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) userObj;
        int userId = user.getId();
        LOGGER.info("User ID from session: " + userId);

        // Get product ID and quantity from request parameters
        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");

        // Validate input parameters
        if (productIdStr == null || quantityStr == null || productIdStr.trim().isEmpty() || quantityStr.trim().isEmpty()) {
            LOGGER.log(Level.WARNING, "Invalid input data: productId or quantity is null or empty.");
            request.setAttribute("error", "Invalid product data. Please try again.");
            forwardToProductDetail(request, response);
            return;
        }

        try {
            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);

            // Validate quantity
            if (quantity <= 0) {
                LOGGER.log(Level.WARNING, "Invalid quantity: quantity=" + quantity);
                request.setAttribute("error", "Quantity must be greater than 0.");
                forwardToProductDetail(request, response);
                return;
            }

            // Get product from database
            Product product = productDB.getProductById(productId);
            if (product == null) {
                LOGGER.log(Level.WARNING, "Product not found: productId=" + productId);
                request.setAttribute("error", "Product not found: ID " + productId);
                forwardToProductDetail(request, response);
                return;
            }

            // Check if product is active
            if (!product.isStatus()) {
                LOGGER.log(Level.WARNING, "Product is inactive: productId=" + productId);
                request.setAttribute("error", "Product " + product.getProductName() + " is no longer available.");
                forwardToProductDetail(request, response);
                return;
            }

            // Check stock availability
            if (product.getStock() < quantity) {
                LOGGER.log(Level.WARNING, "Not enough stock for product: productId=" + productId + ", requested=" + quantity + ", available=" + product.getStock());
                request.setAttribute("error", "Not enough stock for product: " + product.getProductName() + ". Available: " + product.getStock());
                forwardToProductDetail(request, response);
                return;
            }

            // Prepare cart items and total amount
            List<CartItem> cartItems = new ArrayList<>();
            double totalAmount = product.getPrice() * quantity;

            CartItem cartItem = new CartItem();
            cartItem.setCartId(0);
            cartItem.setQuantity(quantity);
            cartItem.setProduct(product);
            cartItems.add(cartItem);

            // Set attributes for the checkout page
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("isFromCart", false);

            // Forward to checkout page
            LOGGER.info("Forwarding to /WEB-INF/views/product-checkout.jsp with totalAmount=" + totalAmount + ", cartItems size=" + cartItems.size());
            forwardToCheckout(request, response);

        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "Invalid number format in input: " + e.getMessage(), e);
            request.setAttribute("error", "Invalid product data format. Please try again.");
            forwardToProductDetail(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error during checkout: " + e.getMessage(), e);
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            forwardToProductDetail(request, response);
        }
    }

    // Helper method to forward to product detail page
    private void forwardToProductDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/product-detail.jsp");
        if (dispatcher == null) {
            LOGGER.log(Level.SEVERE, "RequestDispatcher is null for path: /product-detail.jsp");
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to forward to product detail page.");
            return;
        }
        dispatcher.forward(request, response);
    }

    // Helper method to forward to checkout page
    private void forwardToCheckout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("c/product-checkout.jsp");
        if (dispatcher == null) {
            LOGGER.log(Level.SEVERE, "RequestDispatcher is null for path: ../product-checkout.jsp");
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to forward to checkout page.");
            return;
        }
        dispatcher.forward(request, response);
    }
}