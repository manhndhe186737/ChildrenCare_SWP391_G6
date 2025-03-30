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
import java.util.ArrayList;
import model.Account;
import model.Profile;
import model.Role;
import model.User;

/**
 *
 * @author FPTSHOP
 */
public class StaffProfile extends BaseRBAC {

    @Override
    protected void doAuthorizedGet(HttpServletRequest req, HttpServletResponse resp, Account acocunt) throws ServletException, IOException {
        int id = -1;
        String id_raw = req.getParameter("staff_id");

        try {
            if (id_raw != null && id_raw.length() != 0) {
                // Kiểm tra xem id_raw có phải là một số hợp lệ không
                id = Integer.parseInt(id_raw);
            }
        } catch (NumberFormatException e) {
            // Nếu không phải là số hợp lệ, thì id sẽ giữ giá trị mặc định là -1
            resp.sendRedirect("../admin/staff");
            return;
        }

        // Kiểm tra xem id có hợp lệ không (ví dụ: không phải số âm hoặc số cực lớn)
        if (id < 0) {
            resp.sendRedirect("../admin/staff");
            return;
        }

        StaffDBContext sdb = new StaffDBContext();

        User user = sdb.getUserById(id);

        if (user == null) {
            resp.sendRedirect("../admin/staff");
            return;
        }

        User staff = sdb.getProfileStaff(id);
        staff.setReservations(sdb.getStaffReserv(id));
        req.setAttribute("staff", staff);
        req.getRequestDispatcher("../admin/staff-profile.jsp").forward(req, resp);
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
