package controller;

import dal.ProductDBContext;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/updateProductStatus")
public class UpdateProductStatusServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDBContext productDB = new ProductDBContext();
        int productId = Integer.parseInt(request.getParameter("id"));
        boolean currentStatus = Boolean.parseBoolean(request.getParameter("currentStatus"));
        
        Product product = productDB.getProductById(productId);
        product.setStatus(!currentStatus); // Đổi trạng thái
        productDB.updateProduct(product);

        response.getWriter().write("success");
    }
}