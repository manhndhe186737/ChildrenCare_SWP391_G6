/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.manage;

import controller.auth.BaseRBAC;
import dal.StaffDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import model.Account;
import model.Profile;
import model.User;

/**
 *
 * @author FPTSHOP
 */
public class StaffProfile extends BaseRBAC{

    @Override
    protected void doAuthorizedGet(HttpServletRequest req, HttpServletResponse resp, Account acocunt) throws ServletException, IOException {
        int id = -1;
        String id_raw = req.getParameter("staff_id");
        if(id_raw != null && id_raw.length() != 0){
            id = Integer.parseInt(id_raw);
        }
        
        StaffDBContext sdb = new StaffDBContext();
        
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
