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
import model.Account;

/**
 *
 * @author FPTSHOP
 */
public class DeleteStaff extends BaseRBAC {

    @Override
    protected void doAuthorizedGet(HttpServletRequest req, HttpServletResponse resp, Account acocunt) throws ServletException, IOException {
        String id_raw = req.getParameter("id");
        String action = req.getParameter("action");
        StaffDBContext sdb = new StaffDBContext();
        int id = -1;

        if(id_raw != null || !id_raw.trim().isEmpty()){
            id = Integer.parseInt(id_raw);
        }
        
        if (action.equals("deactive")) {
            sdb.deleteStaff(id);
        } else {
            sdb.activeStaff(id);
        }

        resp.sendRedirect("../admin/staff-profile?staff_id=" + id);
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
