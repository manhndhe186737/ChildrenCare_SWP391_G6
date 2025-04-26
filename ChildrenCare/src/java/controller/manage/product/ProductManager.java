package jakarta.servlet.http;

import dal.ProductDBContext;
import model.Product;
import model.ServiceCategory;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ProductManager", urlPatterns = {"/admin/product-manager"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ProductManager extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ProductManager.class.getName());
    private static final String UPLOAD_DIR = "assets/images";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDBContext productDB = new ProductDBContext();

        String search = request.getParameter("search");
        String pageStr = request.getParameter("page");
        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        int pageSize = 10;

        List<Product> products = productDB.getAllProducts(search, page, pageSize);
        int totalProducts = productDB.getTotalProducts(search);
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        List<ServiceCategory> categories = productDB.getAllCategories();

        request.setAttribute("products", products);
        request.setAttribute("categoryList", categories);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", search);

        request.getRequestDispatcher("/admin/product-manager.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("add".equals(action)) {
            ProductDBContext productDB = new ProductDBContext();
            Product product = new Product();

            try {
                LOGGER.info("Starting to process add product request...");

                // Lấy dữ liệu từ form
                String productName = request.getParameter("productName");
                String categoryIdStr = request.getParameter("categoryId");
                String priceStr = request.getParameter("price");
                String description = request.getParameter("description");
                String statusStr = request.getParameter("status");
                Part filePart = request.getPart("imageFile");

                // Kiểm tra xem sản phẩm với tên này đã tồn tại chưa
                LOGGER.info("Checking if product with name '" + productName + "' exists...");
                if (productDB.checkProductExistsByName(productName)) {
                    LOGGER.warning("Product with name '" + productName + "' already exists.");
                    session.setAttribute("error", "Product with this name already exists.");
                    response.sendRedirect(request.getContextPath() + "/admin/product-manager");
                    return;
                }

                // Product Name
                if (productName == null || productName.trim().isEmpty()) {
                    throw new IllegalArgumentException("Product name is required.");
                }
                product.setProductName(productName);
                LOGGER.info("Product name: " + productName);

                // Category ID
                int categoryId = 0;
                if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
                    categoryId = Integer.parseInt(categoryIdStr);
                } else {
                    throw new IllegalArgumentException("Category is required.");
                }
                product.setCategoryId(categoryId);
                LOGGER.info("Category ID: " + categoryId);

                // Price
                float price = 0.0f;
                if (priceStr != null && !priceStr.trim().isEmpty()) {
                    price = Float.parseFloat(priceStr);
                } else {
                    throw new IllegalArgumentException("Price is required.");
                }
                product.setPrice(price);
                LOGGER.info("Price: " + price);

                // Description
                if (description == null || description.trim().isEmpty()) {
                    throw new IllegalArgumentException("Description is required.");
                }
                product.setDescription(description);
                LOGGER.info("Description: " + description);

                // Status
                if (statusStr == null || statusStr.trim().isEmpty()) {
                    throw new IllegalArgumentException("Status is required.");
                }
                boolean status = Boolean.parseBoolean(statusStr);
                product.setStatus(status);
                LOGGER.info("Status: " + status);

                // Xử lý upload ảnh
                String fileName = null;
                if (filePart != null && filePart.getSize() > 0) {
                    fileName = extractFileName(filePart);
                    String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        boolean created = uploadDir.mkdirs();
                        LOGGER.info("Upload directory created: " + created + " at " + uploadPath);
                    }
                    if (!uploadDir.canWrite()) {
                        throw new IOException("Upload directory is not writable: " + uploadPath);
                    }
                    String filePath = uploadPath + File.separator + fileName;
                    LOGGER.info("Saving file to: " + filePath);
                    filePart.write(filePath);
                    product.setImg(UPLOAD_DIR + "/" + fileName);
                    LOGGER.info("Image saved: " + product.getImg());
                } else {
                    throw new IllegalArgumentException("Image is required.");
                }

                // Tạo product_id
                int newProductId = productDB.getMaxProductId() + 1;
                product.setProductId(newProductId);
                LOGGER.info("Generated product_id: " + newProductId);

                // Thêm sản phẩm vào cơ sở dữ liệu
                LOGGER.info("Adding product to database...");
                productDB.addProduct(product);
                LOGGER.info("Product added successfully.");

                // Chuyển hướng về trang danh sách sản phẩm
                response.sendRedirect(request.getContextPath() + "/admin/product-manager");
            } catch (IllegalArgumentException e) {
                LOGGER.log(Level.WARNING, "Invalid input: " + e.getMessage(), e);
                session.setAttribute("error", e.getMessage());
                response.sendRedirect(request.getContextPath() + "/admin/product-manager");
            } catch (IOException e) {
                LOGGER.log(Level.SEVERE, "Error while uploading image: " + e.getMessage(), e);
                session.setAttribute("error", "Error while uploading image: " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/admin/product-manager");
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Error while adding product: " + e.getMessage(), e);
                session.setAttribute("error", "An error occurred while adding the product: " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/admin/product-manager");
            }
        }
    }

    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                String fileName = item.substring(item.indexOf("=") + 2, item.length() - 1);
                return System.currentTimeMillis() + "_" + fileName;
            }
        }
        return null;
    }

    @Override
    public String getServletInfo() {
        return "Product Manager Servlet";
    }
}