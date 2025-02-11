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
import java.sql.Date;
import model.User;

/**
 *
 * @author FPTSHOP
 */
public class EditCustomer extends BaseRBAC{

    @Override
    protected void doAuthorizedGet(HttpServletRequest req, HttpServletResponse resp, Account acocunt) throws ServletException, IOException {
        String id_raw = req.getParameter("id");
        String name_raw = req.getParameter("fullname");
        String dob_raw = req.getParameter("dob");
        String gender_raw = req.getParameter("gender");
        String phone_raw = req.getParameter("phone");
        String address_raw = req.getParameter("address");
        String img = req.getParameter("profileImage");
        
        if (!img.startsWith("client/")) {
            img = "client/" + img;
        }
        
        int id = Integer.parseInt(id_raw);
        String fullname = name_raw;
        
        Date dob = null;
        if(dob_raw != null && dob_raw.length() != 0){
            dob = Date.valueOf(dob_raw);
        }
        Boolean gender = gender_raw.equalsIgnoreCase("true");
        String phone = phone_raw;
        String address = address_raw;
        
        User customer = new User();
        customer.setId(id);
        customer.setFullname(fullname);
        customer.setDob(dob);
        customer.setGender(gender);
        customer.setPhone(phone);
        customer.setAddress(address);
        customer.setAvatar(img);
        
        CustomerDBContext cdb = new CustomerDBContext();
        cdb.editCustomer(customer);
        resp.sendRedirect("../admin/customers");
    
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
