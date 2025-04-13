package controller;

import dal.ProductDBContext;
import model.Product;
import model.ServiceCategory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/admin/productDetail1")
public class ProductDetailServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ProductDetailServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDBContext productDB = new ProductDBContext();

        // Lấy productId từ tham số và xử lý lỗi
        int productId;
        try {
            String productIdStr = request.getParameter("id");
            if (productIdStr == null || productIdStr.trim().isEmpty()) {
                throw new NumberFormatException("Product ID is missing.");
            }
            productId = Integer.parseInt(productIdStr);
            if (productId <= 0) {
                throw new NumberFormatException("Product ID must be a positive integer.");
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid product ID: " + request.getParameter("id"), e);
            request.setAttribute("error", "Invalid product ID: " + e.getMessage());
            request.getRequestDispatcher("/admin/product-manager").forward(request, response);
            return;
        }

        // Lấy sản phẩm theo ID
        Product product = productDB.getProductById(productId);
        if (product == null) {
            LOGGER.log(Level.WARNING, "Product not found for ID: " + productId);
            request.setAttribute("error", "Product not found.");
            request.getRequestDispatcher("/admin/product-manager").forward(request, response);
            return;
        }

        // Lấy danh sách danh mục
        List<ServiceCategory> categories = productDB.getAllCategories();

        // Tìm tên danh mục tương ứng với product.categoryId
        String categoryName = "No category";
        for (ServiceCategory category : categories) {
            if (category.getId() == product.getCategoryId()) {
                categoryName = category.getCategoryname();
                break;
            }
        }

        // Lấy danh sách sản phẩm liên quan (cùng danh mục, nhưng không bao gồm sản phẩm hiện tại)
        List<Product> relatedProducts = productDB.getProductsByCategoryId(product.getCategoryId(), productId);

        // Đặt các thuộc tính vào request
        request.setAttribute("product", product);
        request.setAttribute("categoryList", categories); 
        request.setAttribute("categoryName", categoryName); 
        request.setAttribute("relatedProducts", relatedProducts);

        // Chuyển hướng đến JSP
        LOGGER.info("Forwarding to productDetail1.jsp for product ID: " + productId);
        request.getRequestDispatcher("/admin/productDetail1.jsp").forward(request, response);
    }
}