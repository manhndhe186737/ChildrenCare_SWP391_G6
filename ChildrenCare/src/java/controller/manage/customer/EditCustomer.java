package controller.manage.customer;

import controller.auth.BaseRBAC;
import dal.CustomerDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
            
            HttpSession session = req.getSession();

            // Validate fullname
            if (fullname == null || fullname.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Full name cannot be empty!");
                resp.sendRedirect("../admin/customers");
                return;
            }

            // Xử lý ngày sinh
            Date dob = null;
            if (dob_raw != null && !dob_raw.isEmpty()) {
                try {
                    dob = Date.valueOf(dob_raw);
                    if (dob.after(new Date(System.currentTimeMillis()))) {
                        session.setAttribute("errorMessage", "Date of birth cannot be in the future!");
                        resp.sendRedirect("../admin/customers");
                        return;
                    }
                } catch (IllegalArgumentException e) {
                    session.setAttribute("errorMessage", "Invalid date of birth format!");
                    resp.sendRedirect("../admin/customers");
                    return;
                }
            } else {
                session.setAttribute("errorMessage", "Date of birth cannot be empty!");
                resp.sendRedirect("../admin/customers");
                return;
            }

            // Validate gender
            Boolean gender = null;
            if (gender_raw != null && !gender_raw.isEmpty()) {
                gender = gender_raw.equalsIgnoreCase("true");
            } else {
                session.setAttribute("errorMessage", "Invalid gender value!");
                resp.sendRedirect("../admin/customers");
                return;
            }

            // Validate phone number
            if (phone == null || phone.trim().isEmpty() || !phone.matches("\\d{10}")) {
                session.setAttribute("errorMessage", "Invalid phone number!");
                resp.sendRedirect("../admin/customers");
                return;
            }

            // Validate address
            if (address == null || address.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Address cannot be empty!");
                resp.sendRedirect("../admin/customers");
                return;
            }

            // Xử lý file ảnh
            String imagePath = oldImage;
            Part filePart = req.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

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
            session.setAttribute("success", "Update successfully!");
            resp.sendRedirect("../admin/customers");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest req, HttpServletResponse resp, Account acocunt) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
