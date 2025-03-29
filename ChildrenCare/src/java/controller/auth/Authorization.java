/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.auth;

import dal.AccountDBContext;
import dal.RoleDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.Account;
import model.Role;

/**
 *
 * @author FPTSHOP
 */
@WebServlet(name="Authorization", urlPatterns={"/admin/authorization"})
public class Authorization extends BaseRBAC {
    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account acocunt)
    throws ServletException, IOException {
        RoleDBContext rdb = new RoleDBContext();
        ArrayList<Role> roles = rdb.getRoles();
        
        request.setAttribute("roles", roles);
        request.getRequestDispatcher("roles.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account acocunt)
    throws ServletException, IOException {
        String rid_raw = request.getParameter("roleId");
        String fid_raw = request.getParameter("featureId");
        String fname = request.getParameter("featureName");
        String furl = request.getParameter("featureUrl");
        String status = request.getParameter("featureStatus");
        
        HttpSession session = request.getSession();
        
        if(rid_raw.equals("1")){
            response.sendRedirect("authorization");
            return;
        }
        
        int rid = -1;
        if(rid_raw != null || !rid_raw.trim().isEmpty()){
            rid = Integer.parseInt(rid_raw);
        }
        
        int fid = -1;
        if(fid_raw != null || !fid_raw.trim().isEmpty()){
            fid = Integer.parseInt(fid_raw);
        }
        
        Boolean isActive = status.equals("true");
        
        RoleDBContext roleDb = new RoleDBContext();
        roleDb.activeFeatureStatus(fid, isActive);
        
        session.setAttribute("success", "Successfully!");
        response.sendRedirect("authorization");
        
        //response.getWriter().print(rid +", " + fid +", " + fname +", " + furl +", " + isActive);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}


