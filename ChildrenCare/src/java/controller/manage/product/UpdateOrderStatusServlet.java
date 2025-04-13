package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays; // Import Arrays
import java.util.List;   // Import List
import dal.OrderDAO;

@WebServlet(name = "UpdateOrderStatusServlet", urlPatterns = {"/updateOrderStatus"})
public class UpdateOrderStatusServlet extends HttpServlet {

    // Trạng thái hợp lệ (nên khớp với DAO và JSP dropdown)
    private static final List<String> VALID_STATUSES = Arrays.asList("Pending", "Processing", "Completed", "Cancelled");

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        // --- Lấy tham số từ form ---
        String orderIdParam = request.getParameter("orderId");
        String newStatus = request.getParameter("newStatus");

        // --- Lấy các tham số ngữ cảnh để redirect ---
        String currentPage = request.getParameter("currentPage");
        String searchKeyword = request.getParameter("searchKeyword");
        // *** Thêm lấy tham số filter ***
        String dateMin = request.getParameter("dateMin");
        String dateMax = request.getParameter("dateMax");
        String filterStatus = request.getParameter("filterStatus");
        // *** Hết phần thêm filter ***
        String sortField = request.getParameter("sortField");
        String sortDir = request.getParameter("sortDir");

        String redirectURL = "order-list"; // URL cơ sở để redirect

        if (orderIdParam != null && newStatus != null && !newStatus.trim().isEmpty()) {
            // *** Thêm kiểm tra trạng thái hợp lệ trước khi parse ID ***
            if (!VALID_STATUSES.contains(newStatus)) {
                 session.setAttribute("alertMessage", "Invalid target status value provided.");
                 session.setAttribute("alertType", "error");
            } else {
                try {
                    int orderId = Integer.parseInt(orderIdParam);
                    OrderDAO orderDAO = new OrderDAO();

                    // *** Thêm Log để Debug ***
                    System.out.println("Attempting to update Order ID: " + orderId + " to Status: " + newStatus);

                    boolean success = orderDAO.updateOrderStatus(orderId, newStatus);

                    System.out.println("DAO updateOrderStatus returned: " + success); // In kết quả DAO

                    if (success) {
                        session.setAttribute("alertMessage", "Order #" + orderId + " status updated successfully to '" + newStatus + "'.");
                        session.setAttribute("alertType", "success");
                    } else {
                        // Thông báo lỗi cụ thể hơn một chút
                        session.setAttribute("alertMessage", "Failed to update status for Order #" + orderId + ". The order might not exist, or the status update is not allowed/valid.");
                        session.setAttribute("alertType", "error");
                    }

                } catch (NumberFormatException e) {
                    session.setAttribute("alertMessage", "Invalid Order ID format received: " + orderIdParam);
                    session.setAttribute("alertType", "error");
                    System.err.println("Error parsing orderId: " + orderIdParam); // Log lỗi parsing
                } catch (SQLException e) {
                    session.setAttribute("alertMessage", "Database error updating order status. Please check server logs.");
                    session.setAttribute("alertType", "error");
                    System.err.println("SQL Error in UpdateOrderStatusServlet for orderId=" + orderIdParam + ": " + e.getMessage()); // Log lỗi SQL
                    e.printStackTrace(); // In stack trace chi tiết
                } catch (Exception e) {
                    session.setAttribute("alertMessage", "An unexpected error occurred. Please check server logs.");
                    session.setAttribute("alertType", "error");
                     System.err.println("Unexpected Error in UpdateOrderStatusServlet for orderId=" + orderIdParam + ": " + e.getMessage()); // Log lỗi khác
                    e.printStackTrace();
                }
            } // Kết thúc else của kiểm tra VALID_STATUSES
        } else {
            session.setAttribute("alertMessage", "Missing required information (Order ID or New Status).");
            session.setAttribute("alertType", "warning");
            System.err.println("Missing orderId or newStatus in UpdateOrderStatusServlet request."); // Log lỗi thiếu tham số
        }

        // --- Xây dựng URL redirect với đầy đủ các tham số ngữ cảnh ---
        StringBuilder params = new StringBuilder("?");
        // Thêm các tham số vào URL nếu chúng không null và không rỗng
        if (currentPage != null && !currentPage.isEmpty()) params.append("page=").append(currentPage).append("&");
        if (searchKeyword != null && !searchKeyword.isEmpty()) params.append("searchKeyword=").append(java.net.URLEncoder.encode(searchKeyword, "UTF-8")).append("&");
        if (dateMin != null && !dateMin.isEmpty()) params.append("dateMin=").append(dateMin).append("&"); // Thêm dateMin
        if (dateMax != null && !dateMax.isEmpty()) params.append("dateMax=").append(dateMax).append("&"); // Thêm dateMax
        if (filterStatus != null && !filterStatus.isEmpty()) params.append("filterStatus=").append(filterStatus).append("&"); // Thêm filterStatus
        if (sortField != null && !sortField.isEmpty()) params.append("sortField=").append(sortField).append("&");
        if (sortDir != null && !sortDir.isEmpty()) params.append("sortDir=").append(sortDir).append("&");

        // Xóa dấu '&' cuối cùng nếu có
        String finalParams = params.length() > 1 ? params.substring(0, params.length() - 1) : "";

        // *** Thêm Log để Debug URL Redirect ***
        System.out.println("Redirecting to: " + redirectURL + finalParams);

        response.sendRedirect(redirectURL + finalParams);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Không nên cho phép update qua GET, redirect về trang list
        System.out.println("GET request received by UpdateOrderStatusServlet, redirecting to order-list.");
        response.sendRedirect("order-list");
    }

    @Override
    public String getServletInfo() {
        return "Servlet to update the status of an order and redirect back with context";
    }
}