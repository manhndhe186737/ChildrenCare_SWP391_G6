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
import java.util.ArrayList;
import model.Account;
import model.User;

/**
 *
 * @author FPTSHOP
 */
public class CustomerList extends BaseRBAC{

    @Override
    protected void doAuthorizedGet(HttpServletRequest req, HttpServletResponse resp, Account acocunt) throws ServletException, IOException {
        CustomerDBContext cdb = new CustomerDBContext();
        ArrayList<User> customers = cdb.getUsers("Customer");
        
        req.setAttribute("customers", customers);
        req.getRequestDispatcher("list.jsp").forward(req, resp);
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
