/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.auth;

import controller.auth.BaseRequireAuthentication;
import dal.AccountDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import model.Account;
import model.Feature;
import model.Role;
import model.User;

/**
 *
 * @author FPTSHOP
 */
public abstract class BaseRBAC extends BaseRequireAuthentication {

    private void grantAccessControls(Account account, HttpServletRequest req) {
        AccountDBContext db = new AccountDBContext();
        ArrayList<Role> roles = db.getRoles(account.getEmail());
        account.setRoles(roles);
        req.getSession().setAttribute("account", account);
    }

    private boolean isAuthorize(Account account, HttpServletRequest req) {
        grantAccessControls(account, req);
        String url = req.getServletPath();
        for (Role role : account.getRoles()) {
            for (Feature feature : role.getFeatures()) {
                if (feature.getUrl().equals(url)) {
                    return true;
                }
            }
        }
        return false;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        if (isAuthorize(account, req)) {
            doAuthorizedPost(req, resp, account);
        } else {
            resp.sendError(403, "You cannot acces this page!!!");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException {
        if (isAuthorize(account, req)) {
            doAuthorizedGet(req, resp, account);
        } else {
            resp.sendError(403, "You cannot acces this page!!!");
        }
    }

    protected abstract void doAuthorizedGet(HttpServletRequest req, HttpServletResponse resp, Account acocunt) throws ServletException, IOException;

    protected abstract void doAuthorizedPost(HttpServletRequest req, HttpServletResponse resp, Account account) throws ServletException, IOException;
}
