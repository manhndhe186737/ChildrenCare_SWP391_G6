package controller.manage.product;

import controller.auth.BaseRBAC;
import dal.ProductDBContext;
import model.Account;
import model.Order;
import model.OrderDetail;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/myorders")
public class MyOrders extends BaseRBAC {

    private static final Logger LOGGER = Logger.getLogger(MyOrders.class.getName());
    private ProductDBContext productDB = new ProductDBContext();

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            LOGGER.info("User not logged in. Redirecting to login.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getId();
        LOGGER.info("Fetching orders for userId: " + userId);

        try {
            // Lấy các tham số từ request
            String searchQuery = request.getParameter("search") != null ? request.getParameter("search").trim() : "";
            String statusFilter = request.getParameter("status") != null ? request.getParameter("status").trim() : "";
            String sortByDate = request.getParameter("sortDate") != null ? request.getParameter("sortDate").trim() : "";
            String sortByPrice = request.getParameter("sortPrice") != null ? request.getParameter("sortPrice").trim() : "";
            int currentPage = 1;
            try {
                String pageStr = request.getParameter("page");
                if (pageStr != null) {
                    currentPage = Integer.parseInt(pageStr);
                }
            } catch (NumberFormatException e) {
                LOGGER.warning("Invalid page number: " + e.getMessage());
                currentPage = 1;
            }
            int itemsPerPage = 4;

            // Quyết định cột và thứ tự sắp xếp
            String sortColumn = "date";
            String sortOrderFinal = "desc";

            if ("asc".equals(sortByPrice) || "desc".equals(sortByPrice)) {
                sortColumn = "amount";
                sortOrderFinal = sortByPrice;
            } else if ("asc".equals(sortByDate) || "desc".equals(sortByDate)) {
                sortColumn = "date";
                sortOrderFinal = sortByDate;
            }

            // Lấy danh sách đơn hàng từ cơ sở dữ liệu
            List<Order> orders = productDB.getOrdersByUserId(userId, sortColumn, sortOrderFinal, searchQuery, statusFilter);
            if (orders == null) {
                LOGGER.warning("Orders list is null for userId: " + userId);
                orders = new ArrayList<>();
            }

            // Log trạng thái của các đơn hàng
            for (Order order : orders) {
                LOGGER.info("Order ID: " + order.getOrderId() + ", Status: " + order.getStatus());
            }

            // Lấy chi tiết đơn hàng cho từng đơn hàng
            Map<Integer, List<OrderDetail>> orderDetailsMap = new HashMap<>();
            for (Order order : orders) {
                List<OrderDetail> orderDetails = productDB.getOrderDetailsByOrderId(order.getOrderId());
                orderDetailsMap.put(order.getOrderId(), orderDetails);
            }

            // Phân trang
            int totalItems = orders.size();
            int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);

            if (currentPage > totalPages) {
                currentPage = totalPages;
            }
            if (currentPage < 1) {
                currentPage = 1;
            }

            int startIndex = (currentPage - 1) * itemsPerPage;
            if (startIndex < 0) {
                startIndex = 0;
            }
            int endIndex = Math.min(startIndex + itemsPerPage, totalItems);

            List<Order> paginatedOrders = new ArrayList<>();
            if (!orders.isEmpty() && startIndex < orders.size()) {
                paginatedOrders = new ArrayList<>(orders.subList(startIndex, endIndex));
            }

            // Log trạng thái của các đơn hàng trong paginatedOrders
            for (Order order : paginatedOrders) {
                LOGGER.info("Paginated Order ID: " + order.getOrderId() + ", Status: " + order.getStatus());
            }

            // Set attributes để gửi đến JSP
            request.setAttribute("paginatedOrders", paginatedOrders);
            request.setAttribute("orderDetailsMap", orderDetailsMap);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("search", searchQuery);
            request.setAttribute("status", statusFilter);
            request.setAttribute("sortDate", sortByDate);
            request.setAttribute("sortPrice", sortByPrice);

            // Thêm thông báo nếu không có kết quả
            if (totalItems == 0) {
                request.setAttribute("noResults", "No orders found with the specified criteria.");
            }

            // Forward đến trang JSP
            request.getRequestDispatcher("c/my-order.jsp").forward(request, response);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error fetching orders for userId: " + userId, e);
            throw new ServletException("Error fetching orders", e);
        }
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        response.sendRedirect("myorders");
    }
}