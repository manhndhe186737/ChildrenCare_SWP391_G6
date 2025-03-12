/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.manage.reservation;

import dal.ReservationDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Reservation;
import model.Service;
import model.User;

/**
 *
 * @author FPTSHOP
 */
@WebServlet(name="ReservationInfor", urlPatterns={"/reserv-infor"})
public class ReservationInfor extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String rid_raw = request.getParameter("rid");
        int rid = -1;
        
        if(rid_raw != null){
            rid = Integer.parseInt(rid_raw);
        }
        
        ReservationDBContext rdb = new ReservationDBContext();
        Reservation reserv = rdb.getReservById(rid);
        
        Service s = rdb.getServicesById(reserv.getService().getId());
        User staff = rdb.getStaffById(reserv.getStaff().getId());
        
        reserv.setService(s);
        reserv.setStaff(staff);
        
        if(!staff.getProfiles().isEmpty() || staff.getProfiles() != null){
            request.setAttribute("profile", staff.getProfiles().get(0));
        }
        request.setAttribute("reserv", reserv);
        request.getRequestDispatcher("c/reserv-infor.jsp").forward(request, response);
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
