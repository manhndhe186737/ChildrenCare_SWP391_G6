/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.auth;

import dal.RoleDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author FPTSHOP
 */
@WebServlet(name="AddFeature", urlPatterns={"/admin/AddFeature"})
public class AddFeature extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String roleId = request.getParameter("roleId");  
        String featureName = request.getParameter("featureName"); 
        String featureUrl = request.getParameter("featureUrl"); 
        
        HttpSession session = request.getSession();

        int rid = -1;
        if(roleId != null || !roleId.trim().isEmpty()){
            rid = Integer.parseInt(roleId);
        }
        
        if(roleId == null || roleId.trim().isEmpty()){
            return;
        }
        
        if(featureName == null || featureName.trim().isEmpty()){
            return;
        }
        
        if(featureUrl == null || featureUrl.trim().isEmpty()){
            return;
        }
        
        RoleDBContext rdb = new RoleDBContext();
        rdb.insertFeatureAndRoleFeature(featureName, featureUrl, rid);

       // response.getWriter().print(roleId +", " + featureName +", " + featureUrl);
        session.setAttribute("fsuccess", "Add feature successfully!");
        response.sendRedirect("authorization");
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
