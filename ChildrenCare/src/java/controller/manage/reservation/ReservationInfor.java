/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manage.reservation;

import dal.FeedbackDBContext;
import controller.auth.BaseRBAC;
import dal.ReservationDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Reservation;
import model.Service;
import model.User;

/**
 *
 * @author FPTSHOP
 */
@WebServlet(name = "ReservationInfor", urlPatterns = {"/reserv-infor"})
public class ReservationInfor extends BaseRBAC {

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        String rid_raw = request.getParameter("rid");
        int rid = -1;

        try {
            if (rid_raw != null && !rid_raw.isEmpty()) {
                rid = Integer.parseInt(rid_raw);
            }
        } catch (NumberFormatException e) {
            // Nếu rid không hợp lệ, chuyển hướng về trang danh sách
            response.sendRedirect("myreservation");
            return;
        }

        ReservationDBContext rdb = new ReservationDBContext();
        Reservation reserv = rdb.getReservById(rid);

        if (reserv == null) {
            response.sendRedirect("myreservation");
            return;
        }

        Service s = rdb.getServicesById(reserv.getService().getId());
        User staff = rdb.getStaffById(reserv.getStaff().getId());

        reserv.setService(s);
        reserv.setStaff(staff);

        if (!staff.getProfiles().isEmpty() || staff.getProfiles() != null) {
            request.setAttribute("profile", staff.getProfiles().get(0));
        }

        // Kiểm tra xem reservation có feedback hay không (SỬA LỖI Ở ĐÂY)
        FeedbackDBContext feedbackDB = new FeedbackDBContext();
        boolean hasFeedback = false; // Mặc định là false
        try {
            hasFeedback = feedbackDB.hasFeedback(rid); // Ghi log lỗi
            // Tránh lỗi làm gián đoạn chương trình
        } catch (SQLException ex) {
            Logger.getLogger(ReservationInfor.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Đặt dữ liệu vào request scope
        request.setAttribute("reserv", reserv);
        request.setAttribute("hasFeedback", hasFeedback);

        // Forward đến JSP
        request.getRequestDispatcher("c/reserv-infor.jsp").forward(request, response);
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
