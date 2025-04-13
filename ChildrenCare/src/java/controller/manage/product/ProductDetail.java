package controller;

import dal.ProductDBContext;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/product-detail")
public class ProductDetail extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ProductDetailServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ProductDBContext productDB = new ProductDBContext();

            // Lấy product_id từ request
            String productIdStr = request.getParameter("id");
            if (productIdStr == null || productIdStr.trim().isEmpty()) {
                LOGGER.log(Level.WARNING, "Product ID is missing in the request.");
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is required.");
                return;
            }

            int productId;
            try {
                productId = Integer.parseInt(productIdStr);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid Product ID format: " + productIdStr, e);
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Product ID format.");
                return;
            }

            // Lấy thông tin sản phẩm
            Product product = productDB.getProductById(productId);
            if (product == null) {
                LOGGER.log(Level.WARNING, "Product not found with ID: " + productId);
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found.");
                return;
            }

            // Lấy danh sách sản phẩm liên quan (cùng danh mục, không bao gồm sản phẩm hiện tại)
            List<Product> relatedProducts = productDB.getProductsByCategoryId(product.getCategoryId(), productId);

            // Đặt các thuộc tính vào request
            request.setAttribute("product", product);
            request.setAttribute("relatedProducts", relatedProducts);

            // Chuyển hướng đến product-detail.jsp
            LOGGER.info("Forwarding to product-detail.jsp for product ID: " + productId);
            request.getRequestDispatcher("c/product-detail.jsp").forward(request, response);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error in ProductDetailServlet for product ID: " + request.getParameter("id") + ": " + e.getMessage(), e);
            throw new ServletException("Error while processing product detail", e);
        }
    }
}