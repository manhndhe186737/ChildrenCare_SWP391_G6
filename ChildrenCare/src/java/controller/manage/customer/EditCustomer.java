
package controller.manage.customer;

import controller.auth.BaseRBAC;
import dal.CustomerDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import model.Account;
import java.sql.Date;
import model.User;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10, // 10MB
    maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class EditCustomer extends BaseRBAC {

    @Override
    protected void doAuthorizedPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        try {
            // Lấy thông tin từ form
            int id = Integer.parseInt(req.getParameter("id"));
            String fullname = req.getParameter("fullname");
            String dob_raw = req.getParameter("dob");
            String gender_raw = req.getParameter("gender");
            String phone = req.getParameter("phone");
            String address = req.getParameter("address");
            String oldImage = req.getParameter("oldImage");

            // Xử lý ngày sinh
            Date dob = null;
            if (dob_raw != null && !dob_raw.isEmpty()) {
                dob = Date.valueOf(dob_raw);
            }

            Boolean gender = gender_raw.equalsIgnoreCase("true");

            // Xử lý file ảnh
            String imagePath = oldImage;
            Part filePart = req.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();
                
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                imagePath = "uploads/" + fileName;
                filePart.write(uploadPath + File.separator + fileName);
            }

            // Tạo đối tượng User
            User customer = new User();
            customer.setId(id);
            customer.setFullname(fullname);
            customer.setDob(dob);
            customer.setGender(gender);
            customer.setPhone(phone);
            customer.setAddress(address);
            customer.setAvatar(imagePath);

            // Cập nhật database
            CustomerDBContext cdb = new CustomerDBContext();
            cdb.editCustomer(customer);

            // Chuyển hướng về danh sách khách hàng
            resp.sendRedirect("../admin/customers");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình cập nhật!");
            req.getRequestDispatcher("../admin/editCustomer.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest req, HttpServletResponse resp, Account acocunt) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
