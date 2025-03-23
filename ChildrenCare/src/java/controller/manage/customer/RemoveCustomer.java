/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.manage.customer;

import controller.auth.BaseRBAC;
import dal.CustomerDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Account;

/**
 *
 * @author FPTSHOP
 */
public class RemoveCustomer extends BaseRBAC{

    @Override
    protected void doAuthorizedGet(HttpServletRequest req, HttpServletResponse resp, Account acocunt) throws ServletException, IOException {
        String id_raw = req.getParameter("user_id");
        
        String action = req.getParameter("action");
        
        CustomerDBContext cdb = new CustomerDBContext();
        
        int id = 0;
        if(id_raw != null && id_raw.length() != 0){
            id = Integer.parseInt(id_raw);
        }
        resp.getWriter().print(action);
        
        if(action.equals("deactive")){
            cdb.removeCustomer(id);
        }else{
            cdb.activeCustomer(id);
        }
        
        resp.sendRedirect("../admin/customers");
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
