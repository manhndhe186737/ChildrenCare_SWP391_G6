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
import jakarta.servlet.http.HttpSession;
import model.Reservation;

/**
 *
 * @author FPTSHOP
 */
@WebServlet(name="updateReservation", urlPatterns={"/updateReservation"})
public class updateReservation extends HttpServlet {

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
        String id_raw = request.getParameter("rid");
        String name_raw = request.getParameter("cus_name");
        String address_raw = request.getParameter("cus_address");
        String note = request.getParameter("comments");
        
        HttpSession session = request.getSession();
        
        int id = -1;
        if(id_raw != null || id_raw.length() != 0){
            id = Integer.parseInt(id_raw);
        }
        
        Reservation r = new Reservation();
        r.setId(id);
        r.setCustomerName(name_raw);
        r.setCustomerAddress(address_raw);
        if(note != null || note.length() != 0){
            r.setNote(note);
        }
        
        if(name_raw == null || name_raw.trim().isEmpty()){
            session.setAttribute("errorMessage", "Name cannot be empty!");
            response.sendRedirect("reserv-infor?rid=" + r.getId());
            return;
        }
        
        if(address_raw == null || address_raw.trim().isEmpty()){
            session.setAttribute("errorMessage", "Address cannot be empty!");
            response.sendRedirect("reserv-infor?rid=" + r.getId());
            return;
        }
        
        ReservationDBContext rdb = new ReservationDBContext();
        rdb.updateReserv(r);
        
        response.sendRedirect("reserv-infor?rid=" + r.getId());
        //response.getWriter().print(id_raw +", " + name_raw +", " + address_raw +", " + note);
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
