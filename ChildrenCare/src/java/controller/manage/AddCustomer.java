/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.manage;

import controller.auth.BaseRBAC;
import dal.CustomerDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Account;
import java.sql.Date;
import model.User;

/**
 *
 * @author FPTSHOP
 */
public class AddCustomer extends BaseRBAC{

    @Override
    protected void doAuthorizedGet(HttpServletRequest req, HttpServletResponse resp, Account acocunt) throws ServletException, IOException {
        req.getRequestDispatcher("../admin/add-customer.jsp").forward(req, resp);
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        String firstName_raw = req.getParameter("first-name");
        String lastName_raw = req.getParameter("last-name");
        String email_raw = req.getParameter("email");
        String phone_raw = req.getParameter("number");
        String date_raw = req.getParameter("date");
        
        Date date = Date.valueOf(date_raw);
        String fullName = firstName_raw + " " + lastName_raw;
        
        CustomerDBContext cdb = new CustomerDBContext();
        
        User customer = new User();
        customer.setFullname(fullName);
        customer.setDob(date);
        customer.setPhone(phone_raw);
        
        Account acc = new Account();
        account.setEmail(email_raw);
        
        customer.setAccount(acc);
        
        cdb.addCustomer(customer);
        
        //New comment 2/6
    }
    
}
