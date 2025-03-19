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
import model.User;
import dal.StaffDBContext;
import java.util.List;
import model.Appointment;
import model.Service;
/**
 *
 * @author FPTSHOP
 */
import jakarta.servlet.http.HttpSession;
import model.Account;

@WebServlet(name = "StaffReservation", urlPatterns = {"/c/staff-reserv"})
public class StaffReservation extends BaseRBAC {

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account acocunt)
            throws ServletException, IOException {
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String searchKeyword = request.getParameter("searchKeyword");


        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect("home.jsp");
            return;
        }

        User account = (User) session.getAttribute("user");
        int staffId = account.getId();

        StaffDBContext staffDB = new StaffDBContext();
        ReservationDBContext rdb = new ReservationDBContext();

        int page = 1;
        int pageSize = 2;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        // **Sử dụng phương thức lấy dữ liệu có lọc theo ngày**
        List<Appointment> appointments;
        int totalAppointments;

        if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
            appointments = staffDB.getAppointmentsByStaffIdAndDateRange(staffId, startDate, endDate, page, pageSize);
            totalAppointments = staffDB.getTotalAppointmentsByStaffIdAndDateRange(staffId, startDate, endDate);
        } else {
            appointments = staffDB.getAppointmentsByStaffId(staffId, page, pageSize);
            totalAppointments = staffDB.getTotalAppointmentsByStaffId(staffId);
        }

        for (Appointment appointment : appointments) {
            Service s = rdb.getServicesById(appointment.getServiceId());
            User u = staffDB.getUserById(appointment.getCustomerId());

            appointment.setService(s);
            appointment.setCustomer(u);
        }

        int totalPages = (int) Math.ceil((double) totalAppointments / pageSize);

        request.setAttribute("appointments", appointments);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);

        request.getRequestDispatcher("../c/staff-reserv.jsp").forward(request, response);
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest req, HttpServletResponse resp, Account account)
            throws ServletException, IOException {

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
