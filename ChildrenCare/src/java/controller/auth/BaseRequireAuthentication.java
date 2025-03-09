/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Account;

/**
 *
 * @author FPTSHOP
 */
public abstract class BaseRequireAuthentication extends HttpServlet {
    private boolean isAuthentical(HttpServletRequest req){
        Account account = (Account)req.getSession().getAttribute("account");
        return account != null;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(isAuthentical(req)){
            Account account = (Account)req.getSession().getAttribute("account");
            doPost(req, resp, account);
        }else{
            //resp.getWriter().print("access denied!!");
            resp.sendRedirect(req.getContextPath() + "/c/error.html");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(isAuthentical(req)){
            Account account = (Account)req.getSession().getAttribute("account");
            doGet(req, resp, account);
        }else{
            //resp.getWriter().print("access denied!!");
            resp.sendRedirect(req.getContextPath() + "/c/error.html");
        }
    }
    
    protected abstract void doPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException;

    protected abstract void doGet(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException;
}
