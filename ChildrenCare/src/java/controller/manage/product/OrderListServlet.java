package controller;

import controller.auth.BaseRBAC;
import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Order;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "OrderListServlet", urlPatterns = {"/order-list"})
public class OrderListServlet extends BaseRBAC {

    private static final Logger LOGGER = Logger.getLogger(OrderListServlet.class.getName());
    private static final int RECORDS_PER_PAGE = 10;
    private static final List<String> VALID_SORT_FIELDS = Arrays.asList(
        "order_id", "customer_name", "date", "amount", "payment_method", "payment_status", "status"
    );
    private static final List<String> VALID_FILTER_STATUSES = Arrays.asList(
        "Pending", "Processing", "Completed", "Cancelled", "" // Cho phép rỗng (All)
    );

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // Kiểm tra session và vai trò
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            LOGGER.info("User not logged in. Redirecting to login.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

      

        OrderDAO orderDAO = new OrderDAO();
        String forwardPage = "c/order-list.jsp";

        try {
            // Lấy và vệ sinh tham số
            String searchKeyword = sanitizeInput(request.getParameter("searchKeyword"));
            String barcode = sanitizeInput(request.getParameter("barcode"));
            if (barcode != null && !barcode.isEmpty()) {
                searchKeyword = barcode; // Ưu tiên tìm kiếm theo barcode
                LOGGER.info("Searching by barcode: " + barcode);
            }

            // Filter Parameters
            String dateMin = sanitizeInput(request.getParameter("dateMin"));
            String dateMax = sanitizeInput(request.getParameter("dateMax"));
            String filterStatus = sanitizeInput(request.getParameter("filterStatus"));
            if (filterStatus != null && !VALID_FILTER_STATUSES.contains(filterStatus)) {
                filterStatus = "";
            }
            if (filterStatus == null) {
                filterStatus = "";
            }

            // Pagination
            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                    if (currentPage < 1) {
                        currentPage = 1;
                    }
                } catch (NumberFormatException e) {
                    LOGGER.warning("Invalid page number: " + pageParam);
                    currentPage = 1;
                }
            }

            // Sorting Parameters
            String sortField = sanitizeInput(request.getParameter("sortField"));
            String sortDir = sanitizeInput(request.getParameter("sortDir"));
            if (sortField == null || sortField.isEmpty() || !VALID_SORT_FIELDS.contains(sortField.toLowerCase())) {
                sortField = "order_id";
            }
            if (sortDir == null || !(sortDir.equalsIgnoreCase("asc") || sortDir.equalsIgnoreCase("desc"))) {
                sortDir = "desc";
            }
            sortField = sortField.toLowerCase();
            sortDir = sortDir.toLowerCase();

            // Tính tổng số bản ghi
            int totalRecords = orderDAO.getTotalOrderCount(searchKeyword, dateMin, dateMax, filterStatus);
            int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

            if (totalPages == 0) {
                currentPage = 1;
            } else if (currentPage > totalPages) {
                currentPage = totalPages;
            }

            int offset = (currentPage - 1) * RECORDS_PER_PAGE;

            // Lấy danh sách đơn hàng
            List<Order> ordersList = orderDAO.getOrdersPaginated(
                searchKeyword, dateMin, dateMax, filterStatus, offset, RECORDS_PER_PAGE, sortField, sortDir
            );

            // Log thông tin đơn hàng
            for (Order order : ordersList) {
                LOGGER.info("Order ID: " + order.getOrderId() + ", Status: " + order.getStatus());
            }

            // Đặt các thuộc tính vào request
            request.setAttribute("ordersList", ordersList);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("searchKeyword", searchKeyword);
            request.setAttribute("barcode", barcode);
            request.setAttribute("currentDateMin", dateMin);
            request.setAttribute("currentDateMax", dateMax);
            request.setAttribute("currentFilterStatus", filterStatus);
            request.setAttribute("currentSortField", sortField);
            request.setAttribute("currentSortDir", sortDir);

            // Thêm thông báo nếu không có đơn hàng
            if (ordersList.isEmpty()) {
                request.setAttribute("noResults", "No orders found with the specified criteria.");
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error while fetching orders", e);
            request.setAttribute("errorMessage", "An error occurred while retrieving orders. Please try again later.");
            forwardPage = "error.jsp";
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error while fetching orders", e);
            request.setAttribute("errorMessage", "An unexpected error occurred. Please try again later.");
            forwardPage = "error.jsp";
        }

        // Chuyển hướng đến trang JSP
        try {
            request.getRequestDispatcher(forwardPage).forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error forwarding to page: " + forwardPage, e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to forward to the requested page");
        }
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        // Chuyển hướng về GET để xử lý lại
        response.sendRedirect(request.getContextPath() + "/order-list");
    }

    // Hàm vệ sinh dữ liệu đầu vào
    private String sanitizeInput(String input) {
        if (input == null) {
            return "";
        }
        return input.trim().replaceAll("[<>\"'%;()&+]", "");
    }

    @Override
    public String getServletInfo() {
        return "Servlet to display list of orders with pagination, search, sorting, filtering, and barcode support for admin/shipper";
    }
}