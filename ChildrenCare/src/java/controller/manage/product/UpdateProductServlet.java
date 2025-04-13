package controller;

import dal.ProductDBContext;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/admin/updateProduct")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class UpdateProductServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(UpdateProductServlet.class.getName());
    private static final String UPLOAD_DIR = "uploads"; // Thư mục lưu ảnh

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // Đảm bảo xử lý đúng ký tự tiếng Việt nếu có
        ProductDBContext productDB = new ProductDBContext();

        String productIdStr = request.getParameter("id"); // Lấy ID trước để log lỗi tốt hơn
        int productId = -1; // Giá trị mặc định không hợp lệ

        try {
            // Lấy và kiểm tra productId
            if (productIdStr == null || productIdStr.trim().isEmpty()) {
                LOGGER.log(Level.WARNING, "Product ID is missing in the request.");
                request.getSession().setAttribute("error", "Product ID is required.");
                response.sendRedirect(request.getContextPath() + "/admin/product-manager"); // Chuyển hướng về trang quản lý
                return;
            }
            try {
                productId = Integer.parseInt(productIdStr);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid Product ID format: " + productIdStr, e);
                request.getSession().setAttribute("error", "Invalid Product ID format.");
                 response.sendRedirect(request.getContextPath() + "/admin/product-manager");
                return;
            }

            // Kiểm tra sản phẩm có tồn tại không
            Product existingProduct = productDB.getProductById(productId);
            if (existingProduct == null) {
                LOGGER.log(Level.WARNING, "Product not found with ID: " + productId);
                 request.getSession().setAttribute("error", "Product not found.");
                 response.sendRedirect(request.getContextPath() + "/admin/product-manager");
                return;
            }

            // Tạo đối tượng Product và điền thông tin
            Product product = new Product();
            product.setProductId(productId);

            // Lấy và kiểm tra productName
            String productName = request.getParameter("productName");
            if (productName == null || productName.trim().isEmpty()) {
                LOGGER.log(Level.WARNING, "Product name is missing for product ID: " + productId);
                request.getSession().setAttribute("error", "Product name is required.");
                 response.sendRedirect(request.getContextPath() + "/admin/productDetail1?id=" + productId); // Quay lại trang chi tiết
                return;
            }
            product.setProductName(productName);

            // Lấy và kiểm tra price
            String priceStr = request.getParameter("price");
            if (priceStr == null || priceStr.trim().isEmpty()) {
                LOGGER.log(Level.WARNING, "Price is missing for product ID: " + productId);
                request.getSession().setAttribute("error", "Price is required.");
                response.sendRedirect(request.getContextPath() + "/admin/productDetail1?id=" + productId);
                return;
            }
            try {
                float price = Float.parseFloat(priceStr);
                if (price < 0) {
                    LOGGER.log(Level.WARNING, "Price must be non-negative for product ID: " + productId);
                     request.getSession().setAttribute("error", "Price must be non-negative.");
                     response.sendRedirect(request.getContextPath() + "/admin/productDetail1?id=" + productId);
                    return;
                }
                product.setPrice(price);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid price format: " + priceStr + " for product ID: " + productId, e);
                request.getSession().setAttribute("error", "Invalid price format.");
                response.sendRedirect(request.getContextPath() + "/admin/productDetail1?id=" + productId);
                return;
            }

            // ==================== LẤY VÀ KIỂM TRA STOCK ====================
            String stockStr = request.getParameter("stock");
            if (stockStr == null || stockStr.trim().isEmpty()) {
                LOGGER.log(Level.WARNING, "Stock quantity is missing for product ID: " + productId);
                request.getSession().setAttribute("error", "Stock quantity is required.");
                response.sendRedirect(request.getContextPath() + "/admin/productDetail1?id=" + productId);
                return;
            }
            try {
                int stock = Integer.parseInt(stockStr);
                if (stock < 0) {
                    LOGGER.log(Level.WARNING, "Stock quantity must be non-negative for product ID: " + productId);
                    request.getSession().setAttribute("error", "Stock quantity must be non-negative.");
                    response.sendRedirect(request.getContextPath() + "/admin/productDetail1?id=" + productId);
                    return;
                }
                product.setStock(stock); // Đặt giá trị stock vào đối tượng product
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid stock quantity format: " + stockStr + " for product ID: " + productId, e);
                request.getSession().setAttribute("error", "Invalid stock quantity format.");
                response.sendRedirect(request.getContextPath() + "/admin/productDetail1?id=" + productId);
                return;
            }
            // ================================================================

            // Lấy và kiểm tra categoryId
            String categoryIdStr = request.getParameter("categoryId");
             if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
                LOGGER.log(Level.WARNING, "Category ID is missing for product ID: " + productId);
                request.getSession().setAttribute("error", "Category is required.");
                 response.sendRedirect(request.getContextPath() + "/admin/productDetail1?id=" + productId);
                return;
            }
            try {
                int categoryId = Integer.parseInt(categoryIdStr);
                product.setCategoryId(categoryId);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid category ID format: " + categoryIdStr + " for product ID: " + productId, e);
                request.getSession().setAttribute("error", "Invalid category format.");
                 response.sendRedirect(request.getContextPath() + "/admin/productDetail1?id=" + productId);
                return;
            }

            // Lấy và kiểm tra description
            String description = request.getParameter("description");
             if (description == null) { // Cho phép description trống
                product.setDescription(""); // Gán chuỗi rỗng nếu null
            } else {
                 product.setDescription(description.trim()); // Trim khoảng trắng thừa
            }

            // Giữ trạng thái hiện tại của sản phẩm (status không được gửi từ form cập nhật này)
            product.setStatus(existingProduct.isStatus());

            // Xử lý upload ảnh
            String imgPath = existingProduct.getImg(); // Giữ ảnh cũ mặc định
            Part filePart = request.getPart("imageFile");
            String oldImageRelativePath = existingProduct.getImg(); // Lưu lại đường dẫn ảnh cũ để xóa nếu cần

            if (filePart != null && filePart.getSize() > 0) {
                String fileName = extractFileName(filePart);
                if (fileName != null && !fileName.isEmpty() && isImageFile(fileName)) { // Kiểm tra đuôi file ảnh
                    // Tạo tên file duy nhất để tránh ghi đè
                    String uniqueFileName = System.currentTimeMillis() + "_" + fileName.replaceAll("[^a-zA-Z0-9.\\-]", "_"); // Giữ dấu chấm và gạch nối

                    String applicationPath = request.getServletContext().getRealPath("");
                    String uploadPath = applicationPath + File.separator + UPLOAD_DIR;
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }

                    String filePath = uploadPath + File.separator + uniqueFileName;
                    try {
                         filePart.write(filePath); // Lưu file mới
                         imgPath = UPLOAD_DIR + "/" + uniqueFileName; // Cập nhật đường dẫn tương đối mới
                         LOGGER.info("Uploaded new image for product ID " + productId + ": " + imgPath);

                         // Xóa ảnh cũ nếu upload ảnh mới thành công VÀ ảnh cũ tồn tại
                         if(oldImageRelativePath != null && !oldImageRelativePath.isEmpty()) {
                            String oldFilePathAbsolute = applicationPath + File.separator + oldImageRelativePath.replace("/", File.separator); // Chuyển đổi sang đường dẫn tuyệt đối của hệ thống
                            File oldFile = new File(oldFilePathAbsolute);
                            if(oldFile.exists() && oldFile.isFile() && !oldFile.getAbsolutePath().equals(filePath)) { // Đảm bảo không xóa chính file mới lưu
                                boolean deleted = oldFile.delete();
                                if(deleted) {
                                    LOGGER.info("Deleted old image: " + oldFilePathAbsolute);
                                } else {
                                     LOGGER.warning("Failed to delete old image: " + oldFilePathAbsolute);
                                }
                            }
                         }

                    } catch (IOException ioEx) {
                         LOGGER.log(Level.SEVERE, "Error writing uploaded file: " + filePath, ioEx);
                         request.getSession().setAttribute("error", "Error saving uploaded image.");
                         response.sendRedirect(request.getContextPath() + "/admin/productDetail1?id=" + productId);
                         return; // Dừng xử lý nếu không lưu được ảnh
                    }
                } else if (fileName != null && !fileName.isEmpty()) {
                    // File không phải là ảnh hợp lệ
                     LOGGER.log(Level.WARNING, "Invalid image file type uploaded: " + fileName);
                     request.getSession().setAttribute("error", "Invalid image file type. Please upload JPG, PNG, or GIF.");
                     response.sendRedirect(request.getContextPath() + "/admin/productDetail1?id=" + productId);
                     return;
                }
                 // Nếu không có file mới hoặc file không hợp lệ, imgPath vẫn giữ giá trị cũ
            }
            product.setImg(imgPath); // Gán đường dẫn ảnh (mới hoặc cũ)

            // Cập nhật sản phẩm trong cơ sở dữ liệu
            boolean updated = productDB.updateProduct(product); // DAO đã được cập nhật để bao gồm stock

            if (updated) {
                LOGGER.info("Successfully updated product ID: " + productId);
                request.getSession().setAttribute("message", "Product updated successfully!"); // Thông báo thành công
                response.sendRedirect(request.getContextPath() + "/admin/productDetail1?id=" + productId); // Chuyển hướng về trang chi tiết
            } else {
                LOGGER.log(Level.WARNING, "Failed to update product ID: " + productId + " in database.");
                 request.getSession().setAttribute("error", "Failed to update product in database."); // Thông báo lỗi cụ thể hơn
                response.sendRedirect(request.getContextPath() + "/admin/productDetail1?id=" + productId); // Quay lại trang chi tiết để sửa
            }

        } catch (Exception e) {
            // Bắt các lỗi không mong muốn khác
            LOGGER.log(Level.SEVERE, "Unexpected error in UpdateProductServlet for product ID: " + productIdStr + ": " + e.getMessage(), e);
            request.getSession().setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            // Chuyển hướng về trang quản lý hoặc trang lỗi chung
            if (productId > 0) {
                 response.sendRedirect(request.getContextPath() + "/admin/productDetail1?id=" + productId);
            } else {
                 response.sendRedirect(request.getContextPath() + "/admin/product-manager");
            }
        }
    }

    // (extractFileName và isImageFile giữ nguyên)
    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
         if (contentDisposition == null) return null;
        String[] items = contentDisposition.split(";");
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                String fileName = item.substring(item.indexOf("=") + 2, item.length() - 1);
                 if (fileName.contains("\\")) {
                    fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
                }
                 if (fileName.contains("/")) {
                     fileName = fileName.substring(fileName.lastIndexOf("/") + 1);
                 }
                return fileName;
            }
        }
        return null;
    }

    private boolean isImageFile(String fileName) {
        if (fileName == null || fileName.isEmpty()) {
            return false;
        }
        String lowerCaseFileName = fileName.toLowerCase();
        return lowerCaseFileName.endsWith(".jpg") ||
               lowerCaseFileName.endsWith(".jpeg") ||
               lowerCaseFileName.endsWith(".png") ||
               lowerCaseFileName.endsWith(".gif");
    }
}