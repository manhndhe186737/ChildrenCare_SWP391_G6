package controller.manage.reservation;

import controller.auth.BaseRBAC;
import dal.ReservationDBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.Account;
import model.Reservation;
import model.User;

/**
 * Servlet for managing user reservations
 */
@WebServlet(name = "MyReservation", urlPatterns = {"/myreservation"})
public class MyReservation extends BaseRBAC {

    private ReservationDBContext reservationDBContext = new ReservationDBContext();

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                int userId = user.getId();

                // Lấy các tham số từ request
                String searchQuery = request.getParameter("search") != null ? request.getParameter("search").trim() : "";
                String statusFilter = request.getParameter("status") != null ? request.getParameter("status").trim() : ""; // Lọc theo trạng thái
                String sortByName = request.getParameter("sort") != null ? request.getParameter("sort").trim() : "";
                String sortByPrice = request.getParameter("sortPrice") != null ? request.getParameter("sortPrice").trim() : "";
                int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                int itemsPerPage = 5;

                // Quyết định cột và thứ tự sắp xếp
                String sortColumn = "s.name"; // Mặc định sắp xếp theo Service Name
                String sortOrderFinal = "asc"; // Mặc định thứ tự tăng dần

                // Kiểm tra để xác định xem có yêu cầu sắp xếp theo Price không
                if ("asc".equals(sortByPrice) || "desc".equals(sortByPrice)) {
                    sortColumn = "s.price";
                    sortOrderFinal = sortByPrice;
                } // Kiểm tra để xác định xem có yêu cầu sắp xếp theo Service Name không
                else if ("asc".equals(sortByName) || "desc".equals(sortByName)) {
                    sortColumn = "s.name";
                    sortOrderFinal = sortByName;
                }

                // Lấy danh sách đặt chỗ từ DBContext với sorting và filter trong SQL
                ArrayList<Reservation> reservations = reservationDBContext.getReservationByUserId(userId, sortColumn, sortOrderFinal, searchQuery, statusFilter);

                // Pagination
                int totalItems = reservations.size();
                int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);

// Kiểm tra để tránh lỗi phân trang
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

// Kiểm tra danh sách có đủ phần tử không trước khi subList
                ArrayList<Reservation> paginatedReservations = new ArrayList<>();
                if (!reservations.isEmpty() && startIndex < reservations.size()) {
                    paginatedReservations = new ArrayList<>(reservations.subList(startIndex, endIndex));
                }

// Set attributes để gửi đến JSP
                request.setAttribute("paginatedReservations", paginatedReservations);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("currentPage", currentPage);
                request.setAttribute("search", searchQuery);
                request.setAttribute("status", statusFilter);
                request.setAttribute("sort", sortByName);
                request.setAttribute("sortPrice", sortByPrice);

// Thêm thông báo nếu không có kết quả tìm kiếm
                if (totalItems == 0) {
                    request.setAttribute("noResults", "No reservations found with the specified criteria.");
                }

// Forward đến trang JSP
                request.getRequestDispatcher("c/pharmacy-shop-cart.jsp").forward(request, response);

            } else {
                response.sendRedirect("login");
            }
        } else {
            response.sendRedirect("login");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet that handles user reservations with search, sorting by service name or price, and pagination";
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
