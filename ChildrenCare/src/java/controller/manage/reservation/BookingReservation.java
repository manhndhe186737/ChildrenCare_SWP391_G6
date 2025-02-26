/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.manage.reservation;

import controller.auth.BaseRBAC;
import dal.ReservationDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import model.Account;
import model.Service;


/**
 *
 * @author FPTSHOP
 */
public class BookingReservation extends BaseRBAC{

    protected void doAuthorizedGet(HttpServletRequest req, HttpServletResponse resp, Account acocunt) throws ServletException, IOException {
        resp.sendRedirect("../c/BookingStaff");
    }

    protected void doAuthorizedPost(HttpServletRequest req, HttpServletResponse resp, Account acocunt) throws ServletException, IOException {
        String isBooked = req.getParameter("booked");
        if(isBooked == null || isBooked.length() == 0){
            resp.sendRedirect("../c/BookingStaff");
            return;
        }
        
        ReservationDBContext sdb = new ReservationDBContext();
        String staff_id = req.getParameter("staff_id");
        String date = req.getParameter("date");
        String start = req.getParameter("starttime");
        String end = req.getParameter("endtime");
        String service_id = req.getParameter("service_id");
        String sname = req.getParameter("service_name");
        int id = -1;
        int sid = -1;
        
        if(service_id != null){
            sid = Integer.parseInt(service_id);
        }
        
        if(staff_id != null && staff_id.length() != 0){
            id = Integer.parseInt(staff_id);
        }
        
        String[] serviceList = req.getParameterValues("inputSelectedService");
        String serviceCart = req.getParameter("serviceCart");
        
        String isFromCart = req.getParameter("isFromCart");
        
        int serviceCartId = -1;
        
        if(serviceCart != null){
            serviceCartId = Integer.parseInt(serviceCart);
        }else{
            serviceCartId = Integer.parseInt(serviceList[0]);
        }
        
        Service service = sdb.getServicesById(serviceCartId);
        
        //resp.getWriter().print(isFromCart);
//        resp.getWriter().println(serviceList[0]);
//        resp.getWriter().print(serviceCart);
        
        req.setAttribute("service", service);
        req.setAttribute("isFromCart", isFromCart);
        req.setAttribute("date", date);
        req.setAttribute("starttime", start);
        req.setAttribute("endtime", end);
        req.setAttribute("staff", sdb.getStaffById(id));
        req.setAttribute("services", sdb.getServices());
        req.getRequestDispatcher("../c/booking-reservation.jsp").forward(req, resp);
    }
    
}
