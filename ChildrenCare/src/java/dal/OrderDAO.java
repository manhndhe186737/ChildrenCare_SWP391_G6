package dal;

import model.Order;
import model.OrderDetail;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays; // Import để dùng List kiểm tra whitelist
import java.util.List;
import java.util.logging.Level; // Optional: For more standard logging
import java.util.logging.Logger; // Optional: For more standard logging

/**
 * Data Access Object for Order and OrderDetail entities.
 * Handles database operations: fetching orders with pagination, filtering, sorting,
 * fetching order details, and updating order status.
 * Inherits database connection management from DBContext.
 */
public class OrderDAO extends DBContext {

    // Optional: Logger for standard logging instead of System.out/err
    // private static final Logger LOGGER = Logger.getLogger(OrderDAO.class.getName());

    // Whitelist of database column names allowed for sorting (security measure)
    private static final List<String> ALLOWED_SORT_FIELDS = Arrays.asList(
        "order_id", "customer_name", "date", "amount", "payment_method", "payment_status", "status"
    );
    // Whitelist of valid status values for filtering
    private static final List<String> ALLOWED_FILTER_STATUSES = Arrays.asList(
        "Pending", "Processing", "Completed", "Cancelled"
    );
     // Whitelist of valid status values allowed for updating
     private static final List<String> VALID_UPDATE_STATUSES = Arrays.asList(
        "Pending", "Processing", "Completed", "Cancelled"
    );


    public OrderDAO() {
        super(); // Initialize connection from DBContext
    }

    // ====================================================
    // METHODS RELATED TO FETCHING ORDERS (COUNT & LIST)
    // ====================================================

    /**
     * Gets the total count of orders, applying filters for keyword, date range, and status.
     * @param searchKeyword Keyword to search in order_id, customer_name, or status. Can be null or empty.
     * @param dateMin Start date for filtering (yyyy-MM-dd). Can be null or empty.
     * @param dateMax End date for filtering (yyyy-MM-dd). Can be null or empty.
     * @param filterStatus Specific status to filter by. Can be null or empty for all statuses.
     * @return The total number of matching orders.
     * @throws SQLException If a database access error occurs or date format is invalid.
     */
    public int getTotalOrderCount(String searchKeyword, String dateMin, String dateMax, String filterStatus) throws SQLException {
        if (this.connection == null || this.connection.isClosed()) {
            // LOGGER.log(Level.SEVERE, "Database connection is not available or closed in getTotalOrderCount.");
            System.err.println("DAO: Database connection is not available or closed in getTotalOrderCount.");
            throw new SQLException("Database connection is not available.");
        }

        int count = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM orders WHERE 1=1");
        List<Object> params = new ArrayList<>();

        // Append Keyword Filter
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            sql.append(" AND (CAST(order_id AS CHAR) LIKE ? OR customer_name LIKE ? OR status LIKE ?)");
            String keywordPattern = "%" + searchKeyword.trim() + "%";
            params.add(keywordPattern);
            params.add(keywordPattern);
            params.add(keywordPattern);
        }

        // Append Date Filter (handle potential invalid date format)
        try {
            if (dateMin != null && !dateMin.trim().isEmpty()) {
                sql.append(" AND DATE(date) >= ?"); // Compare only the date part
                params.add(Date.valueOf(dateMin.trim()));
            }
            if (dateMax != null && !dateMax.trim().isEmpty()) {
                sql.append(" AND DATE(date) <= ?"); // Compare only the date part
                params.add(Date.valueOf(dateMax.trim()));
            }
        } catch (IllegalArgumentException e) {
             // LOGGER.log(Level.WARNING, "Invalid date format provided for filtering: " + e.getMessage());
             System.err.println("DAO: Invalid date format provided for filtering: " + e.getMessage());
             throw new SQLException("Invalid date format (YYYY-MM-DD required).", e);
        }

        // Append Status Filter (validate against whitelist)
        if (filterStatus != null && !filterStatus.trim().isEmpty() && ALLOWED_FILTER_STATUSES.contains(filterStatus)) {
            sql.append(" AND status = ?");
            params.add(filterStatus);
        }

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = this.connection.prepareStatement(sql.toString());
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            // Optional: Log the final query (without actual values for PreparedStatement)
            // LOGGER.log(Level.INFO, "Executing SQL (Count): {0}", sql.toString());
             System.out.println("Executing SQL (Count): " + ps.toString()); // Note: toString might not show exact values

            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
             // LOGGER.log(Level.INFO, "Total order count found: {0}", count);
             System.out.println("DAO: Total order count found: " + count);
        } catch (SQLException e) {
            // LOGGER.log(Level.SEVERE, "SQL Error getting total filtered order count. SQL: " + sql.toString(), e);
            System.err.println("DAO: SQL Error getting total filtered order count: " + e.getMessage() + " SQL: " + sql.toString());
            throw e; // Re-throw to let the caller handle it
        } finally {
            closeResultSet(rs);
            closePreparedStatement(ps);
            // Connection managed by DBContext
        }
        return count;
    }

   
   public List<Order> getOrdersPaginated(String searchKeyword, String dateMin, String dateMax, String filterStatus,
                                      int offset, int limit, String sortField, String sortDir) throws SQLException {
    if (this.connection == null || this.connection.isClosed()) {
        System.err.println("DAO: Database connection is not available or closed in getOrdersPaginated.");
        throw new SQLException("Database connection is not available.");
    }

    // --- Build safe ORDER BY clause ---
    String orderByClause = " ORDER BY order_id DESC "; // Default sort: Newest first
    if (sortField != null && !sortField.trim().isEmpty()) {
        String validatedField = sortField.trim().toLowerCase();
        if (ALLOWED_SORT_FIELDS.contains(validatedField)) { // Security check
            String direction = (sortDir != null && sortDir.equalsIgnoreCase("asc")) ? "ASC" : "DESC";
            orderByClause = " ORDER BY " + validatedField + " " + direction + " ";
        } else {
            System.err.println("DAO: Invalid sort field requested: " + sortField + ". Using default sort.");
        }
    }

    List<Order> list = new ArrayList<>();
    StringBuilder sql = new StringBuilder(
        "SELECT o.order_id, o.payment_method, o.amount, o.payment_status, o.user_id, o.date, o.status, o.address, o.customer_name, " +
        "u.phone " + // Lấy cột phone từ bảng users, không cần đổi tên thành user_phone
        "FROM orders o " +
        "JOIN users u ON o.user_id = u.user_id " + // Sửa LEFT JOIN thành JOIN (INNER JOIN)
        "WHERE 1=1"
    );
    List<Object> params = new ArrayList<>();

    // --- Build WHERE clause with filters ---
    if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
        sql.append(" AND (CAST(order_id AS CHAR) LIKE ? OR customer_name LIKE ? OR status LIKE ?)");
        String keywordPattern = "%" + searchKeyword.trim() + "%";
        params.add(keywordPattern);
        params.add(keywordPattern);
        params.add(keywordPattern);
    }
    try {
        if (dateMin != null && !dateMin.trim().isEmpty()) {
            sql.append(" AND DATE(date) >= ?");
            params.add(Date.valueOf(dateMin.trim()));
        }
        if (dateMax != null && !dateMax.trim().isEmpty()) {
            sql.append(" AND DATE(date) <= ?");
            params.add(Date.valueOf(dateMax.trim()));
        }
    } catch (IllegalArgumentException e) {
        System.err.println("DAO: Invalid date format provided for filtering: " + e.getMessage());
        throw new SQLException("Invalid date format (YYYY-MM-DD required).", e);
    }
    if (filterStatus != null && !filterStatus.trim().isEmpty() && ALLOWED_FILTER_STATUSES.contains(filterStatus)) {
        sql.append(" AND status = ?");
        params.add(filterStatus);
    }
    // --- End WHERE clause ---

    sql.append(orderByClause);         // Append sorting
    sql.append(" LIMIT ? OFFSET ?");   // Append pagination
    params.add(limit);
    params.add(offset);

    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        ps = this.connection.prepareStatement(sql.toString());
        // Set parameters
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }

        System.out.println("Executing SQL (Paginated): " + ps.toString());

        rs = ps.executeQuery();
        while (rs.next()) {
            Order order = new Order();
            order.setOrderId(rs.getInt("order_id"));
            order.setPaymentMethod(rs.getString("payment_method"));
            order.setAmount(rs.getDouble("amount"));
            order.setPaymentStatus(rs.getString("payment_status"));
            order.setUserId(rs.getInt("user_id"));
            order.setOrderDate(rs.getTimestamp("date")); // Get timestamp for accurate date/time
            order.setStatus(rs.getString("status"));
            order.setAddress(rs.getString("address"));
            order.setCustomerName(rs.getString("customer_name"));
            order.setPhoneNumber(rs.getString("phone")); // Ánh xạ cột phone trực tiếp
            list.add(order);
        }
        System.out.println("DAO: Fetched " + list.size() + " orders for pagination/filter.");
    } catch (SQLException e) {
        System.err.println("DAO: SQL Error getting paginated/filtered orders: " + e.getMessage() + " SQL: " + sql.toString());
        throw e;
    } finally {
        closeResultSet(rs);
        closePreparedStatement(ps);
    }
    return list;
}

    // ====================================================
    // METHOD RELATED TO FETCHING ORDER DETAILS
    // ====================================================

    /**
     * Retrieves the details for a specific order, including product information.
     * @param orderId The ID of the order.
     * @return A list of OrderDetail objects. Returns an empty list if no details found.
     * @throws SQLException If a database access error occurs.
     */
    public List<OrderDetail> getOrderDetailsByOrderIdWithProductInfo(int orderId) throws SQLException {
         if (this.connection == null || this.connection.isClosed()) {
            // LOGGER.log(Level.SEVERE, "Database connection is not available or closed in getOrderDetailsByOrderIdWithProductInfo.");
             System.err.println("DAO: Database connection is not available or closed in getOrderDetailsByOrderIdWithProductInfo.");
            throw new SQLException("Database connection is not available.");
         }

        List<OrderDetail> list = new ArrayList<>();
        // Ensure table and column names match your DB schema
        String sql = "SELECT od.odetail_id, od.order_id, od.product_id, od.quantity, od.unit_price, "
                   + " p.product_name AS product_name " // Use the correct product name column
                   + " FROM order_detail od "
                   + " JOIN products p ON od.product_id = p.product_id " // Ensure join columns are correct
                   + " WHERE od.order_id = ?";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = this.connection.prepareStatement(sql);
            ps.setInt(1, orderId);

            // LOGGER.log(Level.INFO, "Executing SQL (Order Details): {0} with orderId={1}", new Object[]{sql, orderId});
             System.out.println("Executing SQL (Order Details): " + ps.toString());

            rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetail detail = new OrderDetail();
                detail.setOdetailId(rs.getInt("odetail_id"));
                detail.setOrderId(rs.getInt("order_id"));
                detail.setProductId(rs.getInt("product_id"));
                detail.setQuantity(rs.getInt("quantity"));
                detail.setProductName(rs.getString("product_name"));
                detail.setUnitPrice(rs.getDouble("unit_price"));
                // Calculate amount if needed
                // detail.setAmount(rs.getInt("quantity") * rs.getDouble("unit_price"));
                list.add(detail);
            }
             // LOGGER.log(Level.INFO, "Fetched {0} order details for orderId={1}", new Object[]{list.size(), orderId});
             System.out.println("DAO: Fetched " + list.size() + " order details for orderId=" + orderId);
        } catch (SQLException e) {
            // LOGGER.log(Level.SEVERE, "SQL Error getting order details for orderId=" + orderId + ". SQL: " + sql, e);
            System.err.println("DAO: SQL Error getting order details for orderId=" + orderId + ": " + e.getMessage() + " SQL: " + sql);
            throw e;
        } finally {
             closeResultSet(rs);
             closePreparedStatement(ps);
        }
        return list; // Return empty list if no details found
    }

    // ====================================================
    // METHOD FOR UPDATING ORDER STATUS
    // ====================================================

    /**
     * Updates the status of a specific order.
     * @param orderId The ID of the order to update.
     * @param newStatus The new status value (must be in VALID_UPDATE_STATUSES).
     * @return true if exactly one row was updated, false otherwise.
     * @throws SQLException If a database access error occurs.
     */
    public boolean updateOrderStatus(int orderId, String newStatus) throws SQLException {
        if (this.connection == null || this.connection.isClosed()) {
             // LOGGER.log(Level.SEVERE, "Database connection is not available or closed in updateOrderStatus.");
             System.err.println("DAO: Database connection is not available or closed in updateOrderStatus.");
             throw new SQLException("Database connection is not available.");
         }

        // Validate the new status against the allowed list
        if (newStatus == null || !VALID_UPDATE_STATUSES.contains(newStatus.trim())) {
             // LOGGER.log(Level.WARNING, "DAO: Attempted to update order #{0} with invalid status: {1}", new Object[]{orderId, newStatus});
             System.err.println("DAO: Attempted to update order #" + orderId + " with invalid status: " + newStatus);
             return false;
        }

        // Optional: Add more complex business logic validation here if needed
        // (e.g., check current status before allowing update)

        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
        PreparedStatement ps = null;
        boolean success = false;
        int rowsAffected = 0; // Initialize rowsAffected

        try {
            ps = this.connection.prepareStatement(sql);
            ps.setString(1, newStatus.trim()); // Trim the status just in case
            ps.setInt(2, orderId);

             // LOGGER.log(Level.INFO, "Executing SQL (Update Status): {0} with status={1}, orderId={2}", new Object[]{sql, newStatus, orderId});
             System.out.println("Executing SQL (Update Status): " + ps.toString());

            rowsAffected = ps.executeUpdate();
            success = (rowsAffected == 1); // Strict check: Exactly one row must be affected

            // Log the outcome
             // LOGGER.log(Level.INFO, "Update status for orderId={0} to ''{1}''. Rows affected: {2}. Success: {3}", new Object[]{orderId, newStatus, rowsAffected, success});
             System.out.println("DAO: Update status for orderId=" + orderId + " to '" + newStatus + "'. Rows affected: " + rowsAffected + ". Success: " + success);

        } catch (SQLException e) {
             // LOGGER.log(Level.SEVERE, "SQL Error updating order status for order #" + orderId, e);
             System.err.println("DAO: SQL Error updating order status for order #" + orderId + ": " + e.getMessage());
            throw e;
        } finally {
            closePreparedStatement(ps);
        }
        return success;
    }

    // ====================================================
    // HELPER METHODS FOR CLOSING RESOURCES
    // ====================================================
    private void closeResultSet(ResultSet rs) {
        if (rs != null) { try { rs.close(); } catch (SQLException e) { System.err.println("Error closing ResultSet: " + e.getMessage()); /* LOGGER.log(Level.WARNING, "Error closing ResultSet", e); */ } }
    }
    private void closePreparedStatement(PreparedStatement ps) {
         if (ps != null) { try { ps.close(); } catch (SQLException e) { System.err.println("Error closing PreparedStatement: " + e.getMessage()); /* LOGGER.log(Level.WARNING, "Error closing PreparedStatement", e); */ } }
    }
    // Connection is managed by DBContext, no closeConnection method here.
}