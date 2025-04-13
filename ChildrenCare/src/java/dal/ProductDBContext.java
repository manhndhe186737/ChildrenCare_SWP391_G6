package dal;

import model.Product;
import model.ServiceCategory;
import model.CartItem;
import model.Order;
import model.OrderDetail;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProductDBContext extends DBContext {

    private static final Logger LOGGER = Logger.getLogger(ProductDBContext.class.getName());

    // Bắt đầu transaction
    public void beginTransaction() throws SQLException {
        connection.setAutoCommit(false);
    }

    // Commit transaction
    public void commitTransaction() throws SQLException {
        connection.commit();
        connection.setAutoCommit(true);
    }

    // Rollback transaction
    public void rollbackTransaction() throws SQLException {
        connection.rollback();
        connection.setAutoCommit(true);
    }

    // Kiểm tra xem sản phẩm với tên đã cho có tồn tại hay không
    public boolean checkProductExistsByName(String productName) {
        String sql = "SELECT COUNT(*) FROM products WHERE product_name = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, productName);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in checkProductExistsByName for name " + productName + ": " + e.getMessage(), e);
        }
        return false;
    }

    // Lấy tất cả sản phẩm có status = true
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.* FROM products p WHERE p.status = ? AND p.stock > 0 ORDER BY p.product_name ASC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setBoolean(1, true);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                products.add(extractProductFromResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getAllProducts: " + e.getMessage(), e);
        }
        return products;
    }

    // Lấy sản phẩm có status = true với tìm kiếm và phân trang
    public List<Product> getAllProducts(String search, int page, int pageSize) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT p.* FROM products p WHERE p.status = ? AND p.stock > 0"
        );
        List<Object> params = new ArrayList<>();
        params.add(true);

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (p.product_name LIKE ? OR p.description LIKE ?)");
            params.add("%" + search + "%");
            params.add("%" + search + "%");
        }

        sql.append(" ORDER BY p.product_name ASC LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add((page - 1) * pageSize);

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            setParameters(stmt, params);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                products.add(extractProductFromResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getAllProducts with search: " + e.getMessage(), e);
        }
        return products;
    }

    // Đếm tổng số sản phẩm có status = true
    public int getTotalProducts() {
        String sql = "SELECT COUNT(*) FROM products WHERE status = ? AND stock > 0";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setBoolean(1, true);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getTotalProducts: " + e.getMessage(), e);
        }
        return 0;
    }

    // Đếm tổng số sản phẩm có status = true với tìm kiếm
    public int getTotalProducts(String search) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM products WHERE status = ? AND stock > 0");
        List<Object> params = new ArrayList<>();
        params.add(true);

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (product_name LIKE ? OR description LIKE ?)");
            params.add("%" + search + "%");
            params.add("%" + search + "%");
        }

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            setParameters(stmt, params);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getTotalProducts with search: " + e.getMessage(), e);
        }
        return 0;
    }

    // Lấy sản phẩm theo ID (không lọc status để hỗ trợ quản trị)
    public Product getProductById(int id) {
        String sql = "SELECT p.* FROM products p WHERE p.product_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractProductFromResultSet(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getProductById for ID " + id + ": " + e.getMessage(), e);
        }
        return null;
    }

    // Lấy ID sản phẩm lớn nhất
    public int getMaxProductId() {
        String sql = "SELECT MAX(product_id) FROM products";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getMaxProductId: " + e.getMessage(), e);
        }
        return 0;
    }

    // Thêm sản phẩm mới
    public void addProduct(Product product) {
        String sql = "INSERT INTO products (product_id, product_name, category_id, price, description, status, img, stock) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, product.getProductId());
            stmt.setString(2, product.getProductName());
            stmt.setInt(3, product.getCategoryId());
            stmt.setFloat(4, product.getPrice());
            stmt.setString(5, product.getDescription());
            stmt.setBoolean(6, product.isStatus());
            stmt.setString(7, product.getImg());
            stmt.setInt(8, product.getStock());

            LOGGER.info("Executing SQL: " + sql);
            LOGGER.info("Parameters: " + product.getProductId() + ", " + product.getProductName() + ", " +
                        product.getCategoryId() + ", " + product.getPrice() + ", " + product.getDescription() + ", " +
                        product.isStatus() + ", " + product.getImg() + ", " + product.getStock());

            int rowsAffected = stmt.executeUpdate();
            LOGGER.info("Rows affected: " + rowsAffected);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in addProduct: " + e.getMessage(), e);
            throw new RuntimeException("Failed to add product: " + e.getMessage(), e);
        }
    }

    // Cập nhật sản phẩm
    public boolean updateProduct(Product product) {
        if (getProductById(product.getProductId()) == null) {
            LOGGER.log(Level.WARNING, "Product with ID " + product.getProductId() + " does not exist.");
            return false;
        }

        // Kiểm tra giá trị stock hợp lệ
        if (product.getStock() < 0) {
            LOGGER.log(Level.WARNING, "Invalid stock value for product ID " + product.getProductId() + ": stock cannot be negative.");
            return false;
        }

        String sql = "UPDATE products SET product_name = ?, category_id = ?, price = ?, description = ?, status = ?, img = ?, stock = ? WHERE product_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, product.getProductName());
            stmt.setInt(2, product.getCategoryId());
            stmt.setFloat(3, product.getPrice());
            stmt.setString(4, product.getDescription());
            stmt.setBoolean(5, product.isStatus());
            stmt.setString(6, product.getImg());
            stmt.setInt(7, product.getStock());
            stmt.setInt(8, product.getProductId());

            int rowsAffected = stmt.executeUpdate();
            LOGGER.info("Updated product ID " + product.getProductId() + ". Rows affected: " + rowsAffected);
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in updateProduct for ID " + product.getProductId() + ": " + e.getMessage(), e);
            return false;
        }
    }

    // Xóa sản phẩm
    public boolean deleteProduct(int id) {
        if (getProductById(id) == null) {
            LOGGER.log(Level.WARNING, "Product with ID " + id + " does not exist.");
            return false;
        }

        String sql = "DELETE FROM products WHERE product_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            LOGGER.info("Deleted product ID " + id + ". Rows affected: " + rowsAffected);
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in deleteProduct for ID " + id + ": " + e.getMessage(), e);
            return false;
        }
    }

    // Lấy sản phẩm theo danh mục, chỉ lấy status = true và stock > 0
    public List<Product> getProductsByCategoryId(int categoryId, int excludeProductId) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE category_id = ? AND product_id != ? AND status = ? AND stock > 0 LIMIT 5";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            stmt.setInt(2, excludeProductId);
            stmt.setBoolean(3, true);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                products.add(extractProductFromResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getProductsByCategoryId for categoryId " + categoryId + " and excludeProductId " + excludeProductId + ": " + e.getMessage(), e);
        }
        return products;
    }

    // Lấy sản phẩm theo trạng thái
    public List<Product> getProductsByStatus(boolean status) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.* FROM products p WHERE p.status = ? AND p.stock > 0 ORDER BY p.product_name ASC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setBoolean(1, status);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                products.add(extractProductFromResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getProductsByStatus for status " + status + ": " + e.getMessage(), e);
        }
        return products;
    }

    // Lấy sản phẩm với các bộ lọc và sắp xếp
    public List<Product> getProductsWithFiltersAndSorting(String searchQuery, String categoryId, Float minPrice, Float maxPrice, String statusFilter, String sortBy, String sortOrder, int page, int pageSize) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT p.* FROM products p WHERE 1=1"
        );
        List<Object> params = new ArrayList<>();

       
        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append(" AND p.status = ?");
            params.add(Boolean.parseBoolean(statusFilter));
        } else {
            sql.append(" AND p.status = ?");
            params.add(true);
        }

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            sql.append(" AND (p.product_name LIKE ? OR p.description LIKE ?)");
            params.add("%" + searchQuery + "%");
            params.add("%" + searchQuery + "%");
        }

        // Lọc theo danh mục
        if (categoryId != null && !categoryId.trim().isEmpty()) {
            try {
                int categoryIdInt = Integer.parseInt(categoryId);
                sql.append(" AND p.category_id = ?");
                params.add(categoryIdInt);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid categoryId: " + categoryId, e);
            }
        }

        // Lọc theo giá
        if (minPrice != null) {
            sql.append(" AND p.price >= ?");
            params.add(minPrice);
        }
        if (maxPrice != null) {
            sql.append(" AND p.price <= ?");
            params.add(maxPrice);
        }

        // Lọc sản phẩm còn hàng
        sql.append(" AND p.stock > 0");

        // Sắp xếp
        Set<String> validSortColumns = Set.of("product_name", "price");
        String validSortOrder = "DESC".equalsIgnoreCase(sortOrder) ? "DESC" : "ASC";
        String sortColumn = (sortBy != null && validSortColumns.contains(sortBy)) ? sortBy : "product_name";
        sql.append(" ORDER BY p.").append(sortColumn).append(" ").append(validSortOrder);

        // Phân trang
        sql.append(" LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add((page - 1) * pageSize);

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            setParameters(stmt, params);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                products.add(extractProductFromResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getProductsWithFiltersAndSorting: " + e.getMessage(), e);
        }
        return products;
    }

    // Đếm tổng số sản phẩm với các bộ lọc
    public int getTotalProductsWithFilters(String searchQuery, String categoryId, Float minPrice, Float maxPrice, String statusFilter) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM products WHERE 1=1");
        List<Object> params = new ArrayList<>();

        // Lọc theo trạng thái
        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append(" AND status = ?");
            params.add(Boolean.parseBoolean(statusFilter));
        } else {
            sql.append(" AND status = ?");
            params.add(true);
        }

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            String normalizedQuery = searchQuery.trim().replaceAll("\\s+", "%");
            sql.append(" AND (product_name LIKE ? OR description LIKE ?)");
            params.add("%" + searchQuery + "%");
            params.add("%" + searchQuery + "%");
        }

        if (categoryId != null && !categoryId.trim().isEmpty()) {
            try {
                int categoryIdInt = Integer.parseInt(categoryId);
                sql.append(" AND category_id = ?");
                params.add(categoryIdInt);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid categoryId: " + categoryId, e);
            }
        }

        if (minPrice != null) {
            sql.append(" AND price >= ?");
            params.add(minPrice);
        }
        if (maxPrice != null) {
            sql.append(" AND price <= ?");
            params.add(maxPrice);
        }

        sql.append(" AND stock > 0");

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            setParameters(stmt, params);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getTotalProductsWithFilters: " + e.getMessage(), e);
        }
        return 0;
    }

    // Lấy tất cả danh mục
    public List<ServiceCategory> getAllCategories() {
        List<ServiceCategory> categories = new ArrayList<>();
        String sql = "SELECT * FROM servicecategories WHERE status = true";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ServiceCategory category = new ServiceCategory();
                category.setId(rs.getInt("category_id"));
                category.setCategoryname(rs.getString("name"));
                category.setDescription(rs.getString("description"));
                category.setStatus(rs.getBoolean("status"));
                categories.add(category);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getAllCategories: " + e.getMessage(), e);
            throw new RuntimeException("Failed to get categories: " + e.getMessage(), e);
        }
        return categories;
    }

    // Lấy danh mục theo ID
    public ServiceCategory getCategoryById(int categoryId) {
        String sql = "SELECT * FROM servicecategories WHERE category_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                ServiceCategory category = new ServiceCategory();
                category.setId(rs.getInt("category_id"));
                category.setCategoryname(rs.getString("name"));
                category.setDescription(rs.getString("description"));
                category.setStatus(rs.getBoolean("status"));
                return category;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getCategoryById for categoryId " + categoryId + ": " + e.getMessage(), e);
        }
        return null;
    }

    // Tìm kiếm sản phẩm
    public List<Product> searchProducts(String searchQuery, int currentPage, int itemsPerPage) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.* FROM products p WHERE p.status = ? AND p.stock > 0 AND (p.product_name LIKE ? OR p.description LIKE ?) ORDER BY p.product_name ASC LIMIT ? OFFSET ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setBoolean(1, true);
            stmt.setString(2, "%" + searchQuery + "%");
            stmt.setString(3, "%" + searchQuery + "%");
            stmt.setInt(4, itemsPerPage);
            stmt.setInt(5, (currentPage - 1) * itemsPerPage);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                products.add(extractProductFromResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in searchProducts: " + e.getMessage(), e);
        }
        return products;
    }

    // Lấy danh sách mục trong giỏ hàng của một user
    public List<CartItem> getCartProductsByUserId(int userId) {
        List<CartItem> cartItems = new ArrayList<>();
        String sql = "SELECT pc.pcart_id, pc.product_id, pc.quantity, p.* " +
                     "FROM product_cart pc " +
                     "JOIN products p ON pc.product_id = p.product_id " +
                     "WHERE pc.user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = extractProductFromResultSet(rs);
                int quantity = rs.getInt("quantity");
                CartItem cartItem = new CartItem(product, quantity);
                cartItem.setCartId(rs.getInt("pcart_id"));
                cartItems.add(cartItem);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getCartProductsByUserId for userId " + userId + ": " + e.getMessage(), e);
        }
        return cartItems;
    }

    // Thêm sản phẩm vào giỏ hàng
    public boolean addProductToCart(int userId, int productId, int quantity) {
        // Kiểm tra số lượng tồn kho
        Product product = getProductById(productId);
        if (product == null) {
            LOGGER.log(Level.WARNING, "Product with ID " + productId + " does not exist.");
            return false;
        }
        if (product.getStock() < quantity) {
            LOGGER.log(Level.WARNING, "Not enough stock for product ID " + productId + ". Requested: " + quantity + ", Available: " + product.getStock());
            return false;
        }

        // Kiểm tra xem sản phẩm đã có trong giỏ hàng của user chưa
        String checkSql = "SELECT pcart_id, quantity FROM product_cart WHERE user_id = ? AND product_id = ?";
        try (PreparedStatement checkStmt = connection.prepareStatement(checkSql)) {
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, productId);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                // Nếu sản phẩm đã có trong giỏ, kiểm tra tổng số lượng
                int currentQuantity = rs.getInt("quantity");
                if (product.getStock() < (currentQuantity + quantity)) {
                    LOGGER.log(Level.WARNING, "Not enough stock for product ID " + productId + ". Requested: " + (currentQuantity + quantity) + ", Available: " + product.getStock());
                    return false;
                }

                // Cập nhật số lượng
                int cartId = rs.getInt("pcart_id");
                String updateSql = "UPDATE product_cart SET quantity = ? WHERE pcart_id = ?";
                try (PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {
                    updateStmt.setInt(1, currentQuantity + quantity);
                    updateStmt.setInt(2, cartId);
                    int rowsAffected = updateStmt.executeUpdate();
                    LOGGER.info("Updated cart for userId " + userId + ", productId " + productId + ". Rows affected: " + rowsAffected);
                    return rowsAffected > 0;
                }
            } else {
                // Nếu sản phẩm chưa có, thêm mới
                String insertSql = "INSERT INTO product_cart (user_id, product_id, quantity) VALUES (?, ?, ?)";
                try (PreparedStatement insertStmt = connection.prepareStatement(insertSql)) {
                    insertStmt.setInt(1, userId);
                    insertStmt.setInt(2, productId);
                    insertStmt.setInt(3, quantity);
                    int rowsAffected = insertStmt.executeUpdate();
                    LOGGER.info("Inserted new cart item for userId " + userId + ", productId " + productId + ". Rows affected: " + rowsAffected);
                    return rowsAffected > 0;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in addProductToCart for userId " + userId + ", productId " + productId + ": " + e.getMessage(), e);
            return false;
        }
    }

    // Cập nhật số lượng sản phẩm trong giỏ hàng
    public boolean updateCartQuantity(int cartId, int quantity) {
        // Kiểm tra số lượng tồn kho
        String sqlCheck = "SELECT pc.product_id, pc.quantity, p.stock FROM product_cart pc JOIN products p ON pc.product_id = p.product_id WHERE pc.pcart_id = ?";
        try (PreparedStatement checkStmt = connection.prepareStatement(sqlCheck)) {
            checkStmt.setInt(1, cartId);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                int productId = rs.getInt("product_id");
                int currentQuantity = rs.getInt("quantity");
                int stock = rs.getInt("stock");
                if (quantity > stock) {
                    LOGGER.log(Level.WARNING, "Not enough stock for product ID " + productId + ". Requested: " + quantity + ", Available: " + stock);
                    return false;
                }
            } else {
                LOGGER.log(Level.WARNING, "Cart item with ID " + cartId + " does not exist.");
                return false;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in updateCartQuantity (check stock) for cartId " + cartId + ": " + e.getMessage(), e);
            return false;
        }

        // Cập nhật số lượng
        String sql = "UPDATE product_cart SET quantity = ? WHERE pcart_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, cartId);
            int rowsAffected = stmt.executeUpdate();
            LOGGER.info("Updated cart quantity for cartId " + cartId + ". Rows affected: " + rowsAffected);
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in updateCartQuantity for pcartId " + cartId + ": " + e.getMessage(), e);
            return false;
        }
    }

    // Xóa sản phẩm khỏi giỏ hàng
    public boolean removeProductFromCart(int pcartId) {
        String sql = "DELETE FROM product_cart WHERE pcart_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, pcartId);
            int rowsAffected = stmt.executeUpdate();
            LOGGER.info("Removed product from cart for cartId " + pcartId + ". Rows affected: " + rowsAffected);
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in removeProductFromCart for cartId " + pcartId + ": " + e.getMessage(), e);
            return false;
        }
    }

    // Lấy danh sách đơn hàng của người dùng
   public List<Order> getOrdersByUserId(int userId, String sortColumn, String sortOrder, String searchQuery, String statusFilter) {
    List<Order> orders = new ArrayList<>();
    StringBuilder sql = new StringBuilder("SELECT o.* FROM orders o WHERE o.user_id = ?");
    List<Object> params = new ArrayList<>();
    params.add(userId);

    // Tìm kiếm theo order_id
    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
        sql.append(" AND o.order_id LIKE ?");
        params.add("%" + searchQuery + "%");
    }

    // Lọc theo trạng thái
    if (statusFilter != null && !statusFilter.trim().isEmpty()) {
        sql.append(" AND o.status = ?");
        params.add(statusFilter);
    }

    // Kiểm tra cột sắp xếp hợp lệ
    Set<String> validSortColumns = Set.of("order_id", "amount", "date", "status");
    String validSortColumn = validSortColumns.contains(sortColumn) ? sortColumn : "order_id";
    String validSortOrder = "DESC".equalsIgnoreCase(sortOrder) ? "DESC" : "ASC";

    sql.append(" ORDER BY ").append(validSortColumn).append(" ").append(validSortOrder);

    try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
        setParameters(stmt, params);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Order order = new Order();
            order.setOrderId(rs.getInt("order_id"));
            order.setPaymentMethod(rs.getString("payment_method"));
            order.setAmount(rs.getDouble("amount"));
            order.setPaymentStatus(rs.getString("payment_status"));
            order.setUserId(rs.getInt("user_id"));
            order.setOrderDate(rs.getDate("date"));
            order.setStatus(mapStatus(rs.getString("status")));
            order.setAddress(rs.getString("address"));
            order.setCustomerName(rs.getString("customer_name"));
            orders.add(order);
        }
    } catch (SQLException e) {
        LOGGER.log(Level.SEVERE, "Error in getOrdersByUserId for userId " + userId + ": " + e.getMessage(), e);
    }
    return orders;
}

    // Lấy thông tin đơn hàng theo orderId
    public Order getOrderById(int orderId) {
        Order order = null;
        String sql = "SELECT * FROM orders WHERE order_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setAmount(rs.getDouble("amount"));
                order.setPaymentStatus(rs.getString("payment_status"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderDate(rs.getDate("date"));
                order.setStatus(mapStatus(rs.getString("status")));
                order.setAddress(rs.getString("address"));
                order.setCustomerName(rs.getString("customer_name"));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getOrderById for orderId " + orderId + ": " + e.getMessage(), e);
        }
        return order;
    }

    // Lấy danh sách mục trong giỏ hàng của một user (đã sửa)
    public List<CartItem> getCartItemsByUserId(int userId) {
        List<CartItem> cartItems = new ArrayList<>();
        String sql = "SELECT pc.pcart_id, pc.quantity, p.* " +
                     "FROM product_cart pc " +
                     "JOIN products p ON pc.product_id = p.product_id " +
                     "WHERE pc.user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = extractProductFromResultSet(rs);
                int cartId = rs.getInt("pcart_id");
                int quantity = rs.getInt("quantity");
                CartItem cartItem = new CartItem(cartId, product, quantity);
                cartItems.add(cartItem);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting cart items for userId " + userId + ": " + e.getMessage(), e);
        }
        return cartItems;
    }

    // Lấy danh sách pcart_id từ product_cart dựa trên userId và danh sách productIds
    public List<Integer> getCartIdsByUserAndProductIds(int userId, List<Integer> productIds) throws SQLException {
        List<Integer> cartIds = new ArrayList<>();
        if (productIds == null || productIds.isEmpty()) {
            LOGGER.log(Level.WARNING, "getCartIdsByUserAndProductIds called with empty or null productIds list.");
            return cartIds;
        }

        String sql = "SELECT pcart_id FROM product_cart WHERE user_id = ? AND product_id IN ("
                + String.join(",", java.util.Collections.nCopies(productIds.size(), "?")) + ")";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            for (int i = 0; i < productIds.size(); i++) {
                stmt.setInt(i + 2, productIds.get(i));
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                cartIds.add(rs.getInt("pcart_id"));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getCartIdsByUserAndProductIds for userId {0} and productIds {1}: {2}",
                    new Object[]{userId, productIds, e.getMessage()});
            throw e;
        }
        return cartIds;
    }

    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "SELECT od.odetail_id, od.order_id, od.product_id, p.product_name, od.quantity, od.unit_price " +
                     "FROM order_detail od " +
                     "JOIN products p ON od.product_id = p.product_id " +
                     "WHERE od.order_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OrderDetail detail = new OrderDetail();
                detail.setOdetailId(rs.getInt("odetail_id"));
                detail.setOrderId(rs.getInt("order_id"));
                detail.setProductId(rs.getInt("product_id"));
                detail.setProductName(rs.getString("product_name"));
                detail.setQuantity(rs.getInt("quantity"));
                detail.setUnitPrice(rs.getDouble("unit_price"));
                // Tính amount = quantity * unit_price
                detail.setAmount(rs.getInt("quantity") * rs.getDouble("unit_price"));
                orderDetails.add(detail);
            }
            LOGGER.info("Fetched " + orderDetails.size() + " order details for orderId " + orderId);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getOrderDetailsByOrderId for orderId " + orderId + ": " + e.getMessage(), e);
        }
        return orderDetails;
    }

    // Lưu đơn hàng vào bảng orders và trả về order_id
    public int saveOrder(Order order) throws SQLException {
        String sql = "INSERT INTO orders (payment_method, amount, payment_status, user_id, date, status, address, customer_name) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, order.getPaymentMethod());
            stmt.setDouble(2, order.getAmount());
            stmt.setString(3, order.getPaymentStatus());
            stmt.setInt(4, order.getUserId());
            stmt.setDate(5, new java.sql.Date(order.getOrderDate().getTime()));
            stmt.setString(6, order.getStatus());
            stmt.setString(7, order.getAddress());
            stmt.setString(8, order.getCustomerName());

            LOGGER.info("Executing SQL: " + sql);
            LOGGER.info("Parameters: " + order.getPaymentMethod() + ", " + order.getAmount() + ", " +
                        order.getPaymentStatus() + ", " + order.getUserId() + ", " + order.getOrderDate() + ", " +
                        order.getStatus() + ", " + order.getAddress() + ", " + order.getCustomerName());

            int rowsAffected = stmt.executeUpdate();
            LOGGER.info("Rows affected by saveOrder: " + rowsAffected);

            if (rowsAffected == 0) {
                throw new SQLException("Creating order failed, no rows affected.");
            }

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    int orderId = rs.getInt(1);
                    LOGGER.info("Generated order_id: " + orderId);
                    if (orderId <= 0) {
                        throw new SQLException("Invalid order_id generated: " + orderId);
                    }
                    return orderId;
                } else {
                    throw new SQLException("Failed to retrieve generated order_id.");
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in saveOrder: " + e.getMessage(), e);
            throw e;
        }
    }

    // Lưu chi tiết đơn hàng vào bảng order_detail (đã sửa để lưu thêm unit_price)
    public void saveOrderDetails(int orderId, List<CartItem> cartItems) throws SQLException {
        String sql = "INSERT INTO order_detail (order_id, product_id, quantity, unit_price) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            for (CartItem item : cartItems) {
                stmt.setInt(1, orderId);
                stmt.setInt(2, item.getProduct().getProductId());
                stmt.setInt(3, item.getQuantity());
                stmt.setDouble(4, item.getProduct().getPrice()); // Lưu giá sản phẩm tại thời điểm mua
                stmt.addBatch();
            }
            int[] rowsAffected = stmt.executeBatch();
            for (int i = 0; i < rowsAffected.length; i++) {
                LOGGER.info("Rows affected for order detail " + (i + 1) + ": " + rowsAffected[i]);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in saveOrderDetails for orderId " + orderId + ": " + e.getMessage(), e);
            throw e;
        }
    }

    // Cập nhật số lượng tồn kho trong bảng products
    public void updateProductStock(List<CartItem> cartItems) throws SQLException {
        String sql = "UPDATE products SET stock = stock - ? WHERE product_id = ? AND stock >= ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            for (CartItem item : cartItems) {
                int productId = item.getProduct().getProductId();
                int quantity = item.getQuantity();

                Product product = getProductById(productId);
                if (product == null || product.getStock() < quantity) {
                    throw new SQLException("Not enough stock for product: " + productId);
                }

                stmt.setInt(1, quantity);
                stmt.setInt(2, productId);
                stmt.setInt(3, quantity);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected == 0) {
                    throw new SQLException("Failed to update stock for product: " + productId);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in updateProductStock: " + e.getMessage(), e);
            throw e;
        }
    }

    // Xóa các mục trong giỏ hàng
    public void deleteCartItems(List<Integer> cartIds) throws SQLException {
        if (cartIds == null || cartIds.isEmpty()) {
            LOGGER.log(Level.WARNING, "deleteCartItems called with null or empty cartIds list. Nothing to delete.");
            return;
        }

        List<Integer> validCartIds = new ArrayList<>();
        for (Integer cartId : cartIds) {
            if (cartId == null || cartId <= 0) {
                LOGGER.log(Level.WARNING, "Invalid cartId found in list: {0}. Skipping this cartId.", cartId);
                continue;
            }
            validCartIds.add(cartId);
        }

        if (validCartIds.isEmpty()) {
            LOGGER.log(Level.WARNING, "No valid cartIds to delete after filtering. Original cartIds: {0}", cartIds);
            return;
        }

        String checkSql = "SELECT pcart_id FROM product_cart WHERE pcart_id IN ("
                + String.join(",", java.util.Collections.nCopies(validCartIds.size(), "?")) + ")";
        List<Integer> existingCartIds = new ArrayList<>();
        try (PreparedStatement checkStmt = connection.prepareStatement(checkSql)) {
            for (int i = 0; i < validCartIds.size(); i++) {
                checkStmt.setInt(i + 1, validCartIds.get(i));
            }
            ResultSet rs = checkStmt.executeQuery();
            while (rs.next()) {
                existingCartIds.add(rs.getInt("pcart_id"));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking existing cartIds in product_cart: {0}", e.getMessage());
            throw e;
        }

        if (existingCartIds.isEmpty()) {
            LOGGER.log(Level.WARNING, "None of the cartIds exist in product_cart table. CartIds: {0}", validCartIds);
            return;
        }

        String deleteSql = "DELETE FROM product_cart WHERE pcart_id = ?";
        try (PreparedStatement deleteStmt = connection.prepareStatement(deleteSql)) {
            int totalRowsDeleted = 0;
            for (Integer cartId : existingCartIds) {
                deleteStmt.setInt(1, cartId);
                deleteStmt.addBatch();
            }

            int[] rowsAffected = deleteStmt.executeBatch();
            for (int i = 0; i < rowsAffected.length; i++) {
                totalRowsDeleted += rowsAffected[i];
                LOGGER.log(Level.INFO, "Deleted cart item with pcart_id={0}, rows affected={1}",
                        new Object[]{existingCartIds.get(i), rowsAffected[i]});
            }

            LOGGER.log(Level.INFO, "Total cart items deleted: {0} for cartIds: {1}",
                    new Object[]{totalRowsDeleted, existingCartIds});

            if (totalRowsDeleted != existingCartIds.size()) {
                LOGGER.log(Level.WARNING, "Mismatch in deleted rows. Expected to delete {0} items, but deleted {1}.",
                        new Object[]{existingCartIds.size(), totalRowsDeleted});
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting cart items for cartIds {0}: {1}",
                    new Object[]{existingCartIds, e.getMessage()});
            throw e;
        }
    }

    // Lấy trạng thái của đơn hàng dựa trên orderId
    public String getOrderStatusById(int orderId) throws SQLException {
        String status = null;
        String sql = "SELECT status FROM orders WHERE order_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                status = rs.getString("status");
                LOGGER.info("Fetched status for orderId " + orderId + ": " + status);
            } else {
                LOGGER.warning("Order not found for orderId: " + orderId);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching status for orderId: " + orderId, e);
            throw e;
        }
        return status;
    }

    // Cập nhật trạng thái của đơn hàng
    public boolean updateOrderStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                LOGGER.info("Updated status for orderId " + orderId + " to: " + status);
                return true;
            } else {
                LOGGER.warning("Failed to update status for orderId: " + orderId);
                return false;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating status for orderId: " + orderId, e);
            throw e;
        }
    }

    // Ánh xạ ResultSet thành đối tượng Product
    private Product extractProductFromResultSet(ResultSet rs) throws SQLException {
        return new Product(
            rs.getInt("product_id"),
            rs.getString("product_name"),
            rs.getInt("category_id"),
            rs.getFloat("price"),
            rs.getString("description"),
            rs.getBoolean("status"),
            rs.getString("img"),
            rs.getInt("stock")
        );
    }

    // Ánh xạ trạng thái từ giá trị trong DB sang giá trị hiển thị
    private String mapStatus(String status) {
        if (status == null) {
            return "Unknown";
        }
        switch (status.trim()) {
            case "Pending":
                return "Pending";
            case "Processing":
                return "Processing";
            case "Completed":
                return "Completed";
            case "Cancelled":
                return "Cancelled";
            default:
                return "Unknown";
        }
    }

    // Thiết lập tham số cho PreparedStatement
    private void setParameters(PreparedStatement stmt, List<Object> params) throws SQLException {
        for (int i = 0; i < params.size(); i++) {
            stmt.setObject(i + 1, params.get(i));
        }
    }
}