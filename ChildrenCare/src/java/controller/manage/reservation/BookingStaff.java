/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manage.reservation;

import controller.auth.BaseRBAC;
import dal.ReservationDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import model.Account;
import model.Service;

/**
 *
 * @author FPTSHOP
 */
@WebServlet(name = "BookingStaff", urlPatterns = {"/c/BookingStaff"})
public class BookingStaff extends BaseRBAC {

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account acocunt)
            throws ServletException, IOException {
        ReservationDBContext sdb = new ReservationDBContext();
        LocalDate currentDate = LocalDate.now();
        LocalTime currentTimeStart = LocalTime.now();
        LocalTime currentTimeEnd = currentTimeStart.plusHours(1);
        DateTimeFormatter format = DateTimeFormatter.ofPattern("HH:mm");
        String start = currentTimeStart.format(format);
        String end = currentTimeEnd.format(format);
        String date = currentDate.toString();

        request.setAttribute("services", sdb.getServices());
        request.setAttribute("date", currentDate);
        request.setAttribute("starttime", start);
        request.setAttribute("endtime", end);
        request.setAttribute("staff", sdb.getAvailableStaff(date, start, end));
        request.getRequestDispatcher("../c/booking-staff.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        ReservationDBContext sdb = new ReservationDBContext();
        String date = request.getParameter("date");
        String start = request.getParameter("starttime");
        String end = request.getParameter("endtime");

        LocalDate currentDate = LocalDate.now();
        LocalTime currentTimeStart = LocalTime.now();
        LocalTime currentTimeEnd = currentTimeStart.plusHours(1);
        DateTimeFormatter format = DateTimeFormatter.ofPattern("HH:mm");

        // Set default values if parameters are null
        date = (date == null) ? currentDate.toString() : date;
        start = (start == null) ? currentTimeStart.format(format) : start;
        end = (end == null) ? currentTimeEnd.format(format) : end;

        // Check if end time is at least 30 minutes after start time
        if (!LocalTime.parse(end).isAfter(LocalTime.parse(start).plusMinutes(30))) {
            request.setAttribute("err", "End time must be greater than start time by at least 30 minutes!");
        }

        // Common attributes for request
        String id_raw = request.getParameter("service_id");
        String sname_raw = request.getParameter("service_name");
        String[] serviceList = request.getParameterValues("inputSelectedService");
        String serviceCart = request.getParameter("serviceCart");
        String isFromCart = request.getParameter("isFromCart");

        if (serviceList != null && serviceList.length != 0) {
            request.setAttribute("service", serviceList[0]);
        }

        // Set all common attributes
        request.setAttribute("isFromCart", isFromCart);
        request.setAttribute("service_id", id_raw);
        request.setAttribute("service_name", sname_raw);
        request.setAttribute("services", sdb.getServices());
        request.setAttribute("starttime", start);
        request.setAttribute("endtime", end);
        request.setAttribute("date", date);
        request.setAttribute("staff", sdb.getAvailableStaff(date, start, end));

        // Forward to the booking staff page
        request.getRequestDispatcher("../c/booking-staff.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
