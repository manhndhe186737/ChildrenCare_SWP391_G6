package dal;

import model.Product;
import model.ServiceCategory;
import model.CartItem;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Main {
    private static final Logger LOGGER = Logger.getLogger(Main.class.getName());

    // Thông tin kết nối cơ sở dữ liệu (thay đổi theo cấu hình của bạn)
    private static final String DB_URL = "jdbc:mysql://localhost:3306/swp391_fix";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "123456";
  
    public static void main(String[] args) {
        Connection connection = null;
        ProductDBContext productDB = new ProductDBContext();

        try {
            // 1. Kết nối đến cơ sở dữ liệu
            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            LOGGER.info("Connected to database successfully.");

            // 2. Gán kết nối cho ProductDBContext
            setConnection(productDB, connection);

            // 3. Kiểm tra getAllCategories
            System.out.println("=== Kiểm tra getAllCategories ===");
            List<ServiceCategory> categories = productDB.getAllCategories();
            Map<Integer, ServiceCategory> categoryMap = new HashMap<>();
            for (ServiceCategory category : categories) {
                categoryMap.put(category.getId(), category);
                System.out.println("Category ID: " + category.getId() +
                                   ", Name: " + category.getCategoryname());
            }

            // 4. Kiểm tra getAllProducts
            System.out.println("\n=== Kiểm tra getAllProducts ===");
            List<Product> allProducts = productDB.getAllProducts();
            for (Product product : allProducts) {
                ServiceCategory category = categoryMap.get(product.getCategoryId());
                System.out.println("Product: " + product.getProductName() +
                                   ", Category: " + (category != null ? category.getCategoryname() : "N/A") +
                                   ", Price: " + product.getPrice() +
                                   ", Stock: " + product.getStock() +
                                   ", Status: " + (product.isStatus() ? "Active" : "Inactive"));
            }

            // 5. Kiểm tra getProductById
            System.out.println("\n=== Kiểm tra getProductById (ID = 1) ===");
            Product product = productDB.getProductById(1);
            if (product != null) {
                ServiceCategory category = categoryMap.get(product.getCategoryId());
                System.out.println("Product: " + product.getProductName() +
                                   ", Category: " + (category != null ? category.getCategoryname() : "N/A") +
                                   ", Price: " + product.getPrice() +
                                   ", Stock: " + product.getStock() +
                                   ", Status: " + (product.isStatus() ? "Active" : "Inactive"));
            } else {
                System.out.println("Product not found!");
            }

            // 6. Kiểm tra addProductToCart
            System.out.println("\n=== Kiểm tra addProductToCart ===");
            int userId = 1; // Giả sử người dùng có ID = 1
            int productId = 1; // Giả sử sản phẩm có ID = 1
            int quantity = 2; // Thêm 2 đơn vị sản phẩm

            // In trạng thái giỏ hàng trước khi thêm
            System.out.println("Cart state before adding product:");
            printCartState(connection, userId, productId);

            // Thử thêm sản phẩm vào giỏ hàng
            boolean success = productDB.addProductToCart(userId, productId, quantity);
            if (success) {
                System.out.println("Successfully added product ID " + productId + " to cart for user ID " + userId);
            } else {
                System.out.println("Failed to add product ID " + productId + " to cart for user ID " + userId);
            }

            // In trạng thái giỏ hàng sau khi thêm
            System.out.println("Cart state after adding product:");
            printCartState(connection, userId, productId);

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error: " + e.getMessage(), e);
        } finally {
            // 7. Đóng kết nối
            if (connection != null) {
                try {
                    connection.close();
                    LOGGER.info("Database connection closed.");
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "Error closing connection: " + e.getMessage(), e);
                }
            }
        }
    }

    // Hàm in trạng thái giỏ hàng
    private static void printCartState(Connection connection, int userId, int productId) {
        String sql = "SELECT pcart_id, quantity FROM product_cart WHERE user_id = ? AND product_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int cartId = rs.getInt("pcart_id");
                int quantity = rs.getInt("quantity");
                System.out.println("Cart item found - pcart_id: " + cartId + ", quantity: " + quantity);
            } else {
                System.out.println("No cart item found for userId " + userId + " and productId " + productId);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error querying cart state: " + e.getMessage(), e);
        }
    }

    // Hàm gán kết nối cho ProductDBContext
    private static void setConnection(ProductDBContext productDB, Connection connection) {
        try {
            java.lang.reflect.Field connectionField = productDB.getClass().getSuperclass().getDeclaredField("connection");
            connectionField.setAccessible(true);
            connectionField.set(productDB, connection);
        } catch (NoSuchFieldException | IllegalAccessException e) {
            LOGGER.log(Level.SEVERE, "Error setting connection: " + e.getMessage(), e);
            throw new RuntimeException("Failed to set connection", e);
        }
    }
}