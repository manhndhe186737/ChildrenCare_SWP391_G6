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
        //String avatarUrl_raw = req.getParameter("avatar_url");
        String avatarUrl = "";
        
        String oldImage = req.getParameter("avatar_url");

        int id = -1;
        if (id_raw != null && id_raw.length() != 0) {
            id = Integer.parseInt(id_raw);
        }
        Date date = null;
        if (date_raw != null && date_raw.length() != 0) {
            date = Date.valueOf(date_raw);
        }
        
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

        resp.sendRedirect("../admin/staff-profile?staff_id=" + id_raw);
    }

}
