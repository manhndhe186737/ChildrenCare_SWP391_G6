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
import java.sql.Time;
import java.time.Duration;
import java.time.LocalDate;
import model.Reservation;
import model.Service;
import model.User;

/**
 *
 * @author FPTSHOP
 */
@WebServlet(name = "resultCod", urlPatterns = {"/c/resultCod"})
public class resultCod extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Reservation reservation = new Reservation();
        reservation.setBookdate(java.sql.Date.valueOf(request.getParameter("date")));
        LocalDate current = LocalDate.now();
        reservation.setCreatedate(java.sql.Date.valueOf(current));
        reservation.setNote(request.getParameter("comments"));

        Time starttime = Time.valueOf(request.getParameter("starttime") + ":00");
        Time endtime = Time.valueOf(request.getParameter("endtime") + ":00");
        reservation.setStart(Time.valueOf(request.getParameter("starttime") + ":00"));
        reservation.setEnd(Time.valueOf(request.getParameter("endtime") + ":00"));
        reservation.setCustomerName(request.getParameter("name"));
        reservation.setCustomerAddress(request.getParameter("address"));

        User customer = new User();
        customer.setId(Integer.parseInt(request.getParameter("cus_id")));

        User staff = new User();
        staff.setId(Integer.parseInt(request.getParameter("staff")));

        ReservationDBContext rdb = new ReservationDBContext();
        Service s = rdb.getServicesById(Integer.parseInt(request.getParameter("service")));
        //Service s = new Service();
        //s.setId(Integer.parseInt(req.getParameter("service")));

        staff = rdb.getStaffById(Integer.parseInt(request.getParameter("staff")));

        reservation.setCustomer(customer);
        reservation.setStaff(staff);
        reservation.setService(s);

        HttpSession session = request.getSession();
        session.setAttribute("reservation", reservation);

        int amount = 0;
        double amountVND = 0;

        String amount_raw = request.getParameter("service_price");

        if (amount_raw != null && !amount_raw.isEmpty()) {

            double amountUSD = Double.parseDouble(amount_raw);

            double exchangeRate = 23500.0;

            amountVND = amountUSD * exchangeRate;

            // Tính số phút giữa starttime và endtime
            long totalMinutes = Duration.between(starttime.toLocalTime(), endtime.toLocalTime()).toMinutes();
            double totalHours = totalMinutes / 60.0; // Chuyển đổi thành giờ

            // Nếu dịch vụ có categoryId = 5, nhân giá theo số giờ
            if (s.getCategoryId() == 5) {
                amountVND *= totalHours;
            }
        }

        amount = (int) amountVND;

        if (reservation != null) {

            reservation.setStatus("Scheduled");
            rdb.insertReservation(reservation);

        }

        request.setAttribute("reservation", reservation);
        request.setAttribute("amount", amount);
        request.getRequestDispatcher("result-cod.jsp").forward(request, response);
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
