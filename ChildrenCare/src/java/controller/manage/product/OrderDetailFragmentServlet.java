package controller; // Hoặc package Servlet của bạn

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;

import model.OrderDetail;
import dal.OrderDAO;

@WebServlet(name = "OrderDetailFragmentServlet", urlPatterns = {"/getOrderDetailHtml"})
public class OrderDetailFragmentServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String orderIdParam = request.getParameter("orderId");
        List<OrderDetail> orderDetails = new ArrayList<>();
        String errorMessage = null;

        if (orderIdParam != null && !orderIdParam.trim().isEmpty()) {
            try {
                int orderId = Integer.parseInt(orderIdParam.trim());
                OrderDAO orderDAO = new OrderDAO();
                orderDetails = orderDAO.getOrderDetailsByOrderIdWithProductInfo(orderId);
                request.setAttribute("detailsForFragment", orderDetails);

            } catch (NumberFormatException e) {
                errorMessage = "Invalid Order ID format.";
                System.err.println("Invalid Order ID format for fragment: " + orderIdParam);
            } catch (SQLException e) {
                errorMessage = "Database error retrieving order details.";
                System.err.println("Error retrieving order details for fragment: " + e.getMessage());
                e.printStackTrace();
            } catch (Exception e) {
                 errorMessage = "An unexpected error occurred while fetching details.";
                 e.printStackTrace();
            }
        } else {
            errorMessage = "Missing Order ID.";
            System.err.println("Missing Order ID parameter for fragment");
        }

        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
        }

        // *** SỬA ĐỔI ĐƯỜNG DẪN Ở ĐÂY ***
        RequestDispatcher dispatcher = request.getRequestDispatcher("/c/order-detail-fragment.jsp"); // Trỏ đến thư mục 'c'

        // Thêm kiểm tra null cho dispatcher
        if (dispatcher != null) {
            dispatcher.forward(request, response);
        } else {
            System.err.println("CRITICAL ERROR: RequestDispatcher could not be obtained for path: /c/order-detail-fragment.jsp");
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Could not process the request due to a configuration error.");
        }
    }

    // doGet, doPost, getServletInfo giữ nguyên
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
    @Override
    public String getServletInfo() { return "Servlet to fetch order details (using combined OrderDAO) and forward to an HTML fragment JSP in /c/"; }
}