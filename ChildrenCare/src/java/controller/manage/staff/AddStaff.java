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
public class AddStaff extends BaseRBAC{

    @Override
    protected void doAuthorizedGet(HttpServletRequest req, HttpServletResponse resp, Account acocunt) throws ServletException, IOException {
        req.getRequestDispatcher("../admin/add-staff.jsp").forward(req, resp);
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        
    }
    
}
