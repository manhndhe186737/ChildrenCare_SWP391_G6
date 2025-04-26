package controller.manage.product; // Hoặc package phù hợp

import controller.auth.BaseRBAC; // Giữ lại nếu bạn dùng RBAC
import dal.ProductDBContext;
import model.Account;
import model.CartItem;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest; // Import HttpServletRequest thay vì chỉ HttpServlet
import jakarta.servlet.http.HttpServletResponse;// Import HttpServletResponse thay vì chỉ HttpServlet
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger; // Thêm Logger nếu muốn ghi log

@WebServlet("/c/ProductCart") // Giữ nguyên hoặc đổi URL nếu cần
// Đảm bảo class kế thừa đúng (HttpServlet hoặc BaseRBAC nếu cần)
public class ProductCartServlet extends BaseRBAC { // Hoặc extends HttpServlet nếu không dùng RBAC

    private static final Logger LOGGER = Logger.getLogger(ProductCartServlet.class.getName());
    private final ProductDBContext productDB = new ProductDBContext(); // Khởi tạo DAO

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account account) // Hoặc doGet nếu extends HttpServlet
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // Lấy session, không tạo mới

        // Kiểm tra đăng nhập
        if (session == null || session.getAttribute("user") == null) {
            LOGGER.info("User not logged in. Redirecting to login.");
            // Sử dụng context path để đảm bảo đường dẫn đúng
            response.sendRedirect(request.getContextPath() + "/login");
            return; // Dừng xử lý
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getId();
        LOGGER.info("Fetching cart for userId: " + userId);

        try {
            // Gọi đúng phương thức DAO để lấy danh sách cart items
            List<CartItem> cartItems = productDB.getCartItemsByUserId(userId); // SỬA TÊN PHƯƠNG THỨC Ở ĐÂY

            // Tính tổng tiền giỏ hàng
            float totalCartPrice = 0;
            if (cartItems != null) { // Kiểm tra null phòng trường hợp DAO trả về null
                for (CartItem item : cartItems) {
                    if (item.getProduct() != null) { // Kiểm tra product null
                       totalCartPrice += item.getTotalPrice(); // Giả sử CartItem có phương thức này
                    }
                }
            } else {
                 LOGGER.warning("cartItems list is null for userId: " + userId);
            }


            LOGGER.info("Found " + (cartItems != null ? cartItems.size() : 0) + " items in cart for userId: " + userId);

            // Đặt danh sách cartItems và tổng tiền vào request attribute để JSP sử dụng
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("totalCartPrice", totalCartPrice); // Truyền tổng tiền sang JSP

            // Chuyển tiếp đến trang JSP hiển thị giỏ hàng
            // Nên dùng đường dẫn tuyệt đối từ webapp root, hoặc đặt trong WEB-INF
            // Ví dụ 1: Nếu JSP nằm trong webapp/view/product/
            // String jspPath = "/view/product/product-cart.jsp";
            // Ví dụ 2: Nếu JSP nằm trong webapp/WEB-INF/views/product/ (KHUYẾN NGHỊ)
            String jspPath = "../c/product-cart.jsp";
            // Sử dụng đường dẫn bạn cung cấp nếu chắc chắn đúng cấu trúc
            // String jspPath = "../view/product/product-cart.jsp"; // <-- Đường dẫn gốc của bạn

            LOGGER.info("Forwarding to JSP: " + jspPath);
            request.getRequestDispatcher(jspPath).forward(request, response);

        } catch (Exception e) {
            // Bắt các lỗi không mong muốn khác (ví dụ lỗi DB trong DAO)
             LOGGER.log(Level.SEVERE, "Error fetching cart for userId: " + userId, e);
             // Hiển thị trang lỗi chung hoặc thông báo lỗi
             request.setAttribute("errorMessage", "Error loading your shopping cart. Please try again later.");
             request.getRequestDispatcher("/error.jsp").forward(request, response); // Chuyển đến trang lỗi chung
             // Hoặc throw new ServletException(e);
        }
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account account) // Hoặc doPost
            throws ServletException, IOException {
        // Thông thường trang xem giỏ hàng không xử lý POST nhiều
        // Có thể gọi doGet hoặc nếu có action (update/remove) thì xử lý riêng
        doAuthorizedGet(request, response, account); // Gọi lại doGet cho đơn giản
    }
}