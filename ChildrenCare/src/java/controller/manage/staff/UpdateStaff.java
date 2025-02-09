/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.manage.staff;

import controller.auth.BaseRBAC;
import dal.StaffDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import model.Account;
import model.User;

/**
 *
 * @author FPTSHOP
 */
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
        String avatarUrl_raw = req.getParameter("avatar_url");
        String avatarUrl = "";

        int id = -1;
        if (id_raw != null && id_raw.length() != 0) {
            id = Integer.parseInt(id_raw);
        }
        Date date = null;
        if (date_raw != null && date_raw.length() != 0) {
            date = Date.valueOf(date_raw);
        }

        if (!avatarUrl_raw.startsWith("staff/")) {
            avatarUrl_raw = "staff/" + avatarUrl_raw;
        }

        User staff = new User();
        staff.setId(id);
        staff.setFullname(name_raw);
        staff.setAvatar(avatarUrl_raw);
        staff.setPhone(phone_raw);
        staff.setBio(bio);
        staff.setAddress(address_raw);
        staff.setDob(date);

        StaffDBContext sdb = new StaffDBContext();
        sdb.updateStaff(staff);

        resp.sendRedirect("../admin/staff-profile?staff_id=" + id_raw);
    }

}
