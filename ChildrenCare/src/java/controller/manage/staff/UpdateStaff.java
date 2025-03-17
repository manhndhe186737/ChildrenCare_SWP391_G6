/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.manage.staff;

import controller.auth.BaseRBAC;
import dal.StaffDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Date;
import model.Account;
import model.User;

/**
 *
 * @author FPTSHOP
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)

public class UpdateStaff extends BaseRBAC {

    @Override
    protected void doAuthorizedGet(HttpServletRequest req, HttpServletResponse resp, Account acocunt) throws ServletException, IOException {

    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        String name_raw = req.getParameter("name");
        String date_raw = req.getParameter("dob");
        String address_raw = req.getParameter("address");
        String phone_raw = req.getParameter("phone");
        String bio = req.getParameter("bio");
        String id_raw = req.getParameter("id");
        String avatarUrl = "";

        HttpSession session = req.getSession();

        String oldImage = req.getParameter("avatar_url");

        int id = -1;
        if (id_raw != null && id_raw.length() != 0) {
            id = Integer.parseInt(id_raw);
        }

        // Validation for Full Name
        if (name_raw == null || name_raw.trim().isEmpty()) {
            session.setAttribute("error", "Full Name cannot be empty.");
            resp.sendRedirect("../admin/staff-profile?staff_id=" + id_raw);
            return;
        }

        // Validation for Date of Birth
        Date date = null;
        if (date_raw != null && date_raw.length() != 0) {
            try {
                date = Date.valueOf(date_raw);

                // Kiểm tra nếu ngày sinh là ngày trong tương lai
                Date currentDate = new Date(System.currentTimeMillis());
                if (date.after(currentDate)) {
                    session.setAttribute("error", "Date of Birth cannot be in the future.");
                    resp.sendRedirect("../admin/staff-profile?staff_id=" + id_raw);
                    return;
                }

            } catch (IllegalArgumentException e) {
                session.setAttribute("error", "Invalid Date format for Date of Birth.");
                resp.sendRedirect("../admin/staff-profile?staff_id=" + id_raw);
                return;
            }
        }

        // Validation for Address
        if (address_raw == null || address_raw.trim().isEmpty()) {
            session.setAttribute("error", "Address cannot be empty.");
            resp.sendRedirect("../admin/staff-profile?staff_id=" + id_raw);
            return;
        }

        // Validation for Phone number
        if (phone_raw == null || phone_raw.trim().isEmpty() || !phone_raw.matches("^[0-9+\\- ]+$")) {
            session.setAttribute("error", "Invalid Phone Number.");
            resp.sendRedirect("../admin/staff-profile?staff_id=" + id_raw);
            return;
        }

        // Validation for Bio (optional field, can be empty)
        if (bio != null && bio.length() > 500) {
            session.setAttribute("error", "Bio cannot exceed 500 characters.");
            resp.sendRedirect("../admin/staff-profile?staff_id=" + id_raw);
            return;
        }

        // Handling the Avatar Image
        String imagePath = oldImage;
        Part filePart = req.getPart("imageFile");
        if (filePart != null && filePart.getSize() > 0) {
            String contentType = filePart.getContentType();
            if (!contentType.startsWith("image/")) {
                session.setAttribute("error", "Only image files are allowed for Avatar.");
                resp.sendRedirect("../admin/staff-profile?staff_id=" + id_raw);
                return;
            }

            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            imagePath = "uploads/" + fileName;
            filePart.write(uploadPath + File.separator + fileName);
        }

        // Create staff object and update
        User staff = new User();
        staff.setId(id);
        staff.setFullname(name_raw);
        staff.setAvatar(imagePath);
        staff.setPhone(phone_raw);
        staff.setBio(bio);
        staff.setAddress(address_raw);
        staff.setDob(date);

        StaffDBContext sdb = new StaffDBContext();
        sdb.updateStaff(staff);

        session.setAttribute("success", "Update successfully!");
        resp.sendRedirect("../admin/staff-profile?staff_id=" + id_raw);
    }

}
