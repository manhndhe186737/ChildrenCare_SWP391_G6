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

@WebServlet("/productlist")
public class ProductListServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ProductListServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ProductDBContext productDB = new ProductDBContext();
            int page = 1;
            int pageSize = 6;

            // Lấy tham số từ request
            if (request.getParameter("page") != null) {
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                    if (page < 1) {
                        page = 1; // Đảm bảo page không nhỏ hơn 1
                    }
                } catch (NumberFormatException e) {
                    LOGGER.log(Level.WARNING, "Invalid page number: " + request.getParameter("page"), e);
                    page = 1; // Mặc định về trang 1 nếu lỗi
                }
            }

            String searchQuery = request.getParameter("search");
            String categoryId = request.getParameter("category");
            Float minPrice = null;
            Float maxPrice = null;
            String sortBy = request.getParameter("sortBy");
            String sortOrder = request.getParameter("sortOrder");
            String statusFilter = request.getParameter("status"); // Lấy tham số status

            // Xử lý sortBy và sortOrder
            if (sortBy == null || sortBy.trim().isEmpty()) {
                sortBy = "product_name"; // Mặc định sắp xếp theo tên sản phẩm
            }
            if (sortOrder == null || sortOrder.trim().isEmpty() || (!sortOrder.equalsIgnoreCase("ASC") && !sortOrder.equalsIgnoreCase("DESC"))) {
                sortOrder = "ASC"; // Mặc định sắp xếp tăng dần
            }

            // Xử lý minPrice và maxPrice
            try {
                if (request.getParameter("minPrice") != null && !request.getParameter("minPrice").trim().isEmpty()) {
                    minPrice = Float.parseFloat(request.getParameter("minPrice"));
                    if (minPrice < 0) {
                        request.setAttribute("errorMessage", "Minimum price cannot be negative.");
                        minPrice = null; // Bỏ qua giá trị không hợp lệ
                    }
                }
                if (request.getParameter("maxPrice") != null && !request.getParameter("maxPrice").trim().isEmpty()) {
                    maxPrice = Float.parseFloat(request.getParameter("maxPrice"));
                    if (maxPrice < 0) {
                        request.setAttribute("errorMessage", "Maximum price cannot be negative.");
                        maxPrice = null; // Bỏ qua giá trị không hợp lệ
                    }
                }

                // Hoán đổi minPrice và maxPrice nếu minPrice > maxPrice
                if (minPrice != null && maxPrice != null && minPrice > maxPrice) {
                    Float temp = minPrice;
                    minPrice = maxPrice;
                    maxPrice = temp;
                    request.setAttribute("minPrice", minPrice);
                    request.setAttribute("maxPrice", maxPrice);
                    request.setAttribute("warningMessage", "Min price was greater than max price, values have been swapped.");
                }
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid price format: " + e.getMessage(), e);
                request.setAttribute("errorMessage", "Invalid price format. Please enter valid numbers.");
            }

            // Xử lý statusFilter
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                if (!statusFilter.equals("true") && !statusFilter.equals("false")) {
                    statusFilter = null; // Bỏ qua nếu giá trị không hợp lệ
                    LOGGER.log(Level.WARNING, "Invalid status filter: " + request.getParameter("status"));
                }
            }

            // Lấy danh sách danh mục
            List<ServiceCategory> categories = productDB.getAllCategories();
            if (categories == null || categories.isEmpty()) {
                LOGGER.log(Level.WARNING, "No categories found in the database.");
                request.setAttribute("errorMessage", "No categories available. Please add categories to continue.");
            }
            request.setAttribute("categories", categories);

            // Lấy danh sách sản phẩm với các tiêu chí lọc
            LOGGER.log(Level.INFO, "Fetching products for page: " + page + ", search: " + searchQuery + ", category: " + categoryId +
                    ", minPrice: " + minPrice + ", maxPrice: " + maxPrice + ", sortBy: " + sortBy + ", sortOrder: " + sortOrder +
                    ", status: " + statusFilter);
            List<Product> productList = productDB.getProductsWithFiltersAndSorting(searchQuery, categoryId, minPrice, maxPrice, statusFilter, sortBy, sortOrder, page, pageSize);
            int totalProducts = productDB.getTotalProductsWithFilters(searchQuery, categoryId, minPrice, maxPrice, statusFilter);
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

            LOGGER.log(Level.INFO, "Fetched " + productList.size() + " products, total pages: " + totalPages);

            // Kiểm tra nếu không có sản phẩm nào
            if (productList == null || productList.isEmpty()) {
                request.setAttribute("noProductsMessage", "No products available with the current filters.");
            }

            // Đặt các thuộc tính vào request để hiển thị trên JSP
            request.setAttribute("productList", productList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("searchQuery", searchQuery);
            request.setAttribute("minPrice", minPrice);
            request.setAttribute("maxPrice", maxPrice);
            request.setAttribute("selectedCategory", categoryId);
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("sortOrder", sortOrder);
            request.setAttribute("statusFilter", statusFilter);

            request.getRequestDispatcher("c/productList.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error in ProductListServlet: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "An error occurred while fetching the product list. Please try again later.");
            request.getRequestDispatcher("c/productList.jsp").forward(request, response);
        }
    }
}