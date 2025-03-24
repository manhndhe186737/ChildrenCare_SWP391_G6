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
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {

        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String searchKeyword = request.getParameter("searchKeyword");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect("home.jsp");
            return;
        }

        User acc = (User) session.getAttribute("user");
        int staffId = acc.getId();

        StaffDBContext staffDB = new StaffDBContext();
        ReservationDBContext rdb = new ReservationDBContext();

        int page = 1;
        int pageSize = 5;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        // Lấy danh sách cuộc hẹn từ DAO
        List<Appointment> appointments = staffDB.getAppointmentsByFilter(staffId, startDate, endDate, searchKeyword, page, pageSize);
        int totalAppointments = staffDB.getTotalAppointmentsByFilter(staffId, startDate, endDate, searchKeyword);
        
        for (Appointment apm : appointments) {
            Service s = rdb.getServicesById(apm.getServiceId());
            apm.setService(s);
            User customer = staffDB.getUserById(apm.getCustomerId());
            apm.setCustomer(customer);
        }

        // Tính toán tổng số trang
        int totalPages = (int) Math.ceil((double) totalAppointments / pageSize);

        // Chuyển các thông tin cần thiết vào request để hiển thị trong JSP
        request.setAttribute("appointments", appointments);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.setAttribute("searchKeyword", searchKeyword);

        // Forward request đến JSP để hiển thị
        request.getRequestDispatcher("../c/staff-reserv.jsp").forward(request, response);
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        // Chuyển hướng người dùng về trang login nếu không có session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect("home.jsp");
            return;
        }

        // Redirect to POST handler (doAuthorizedPost) for pagination
        doAuthorizedPost(request, response, account);
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
