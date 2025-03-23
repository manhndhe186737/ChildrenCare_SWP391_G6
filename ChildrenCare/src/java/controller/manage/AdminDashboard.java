/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.manage;

import controller.auth.BaseRBAC;
import dal.AdminDashBoardDBContext;
import java.sql.SQLException; // Thêm dòng này để xử lý SQLException

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import model.Account;
import model.Role;

/**
 *
 * @author FPTSHOP
 */
public class AdminDashboard extends BaseRBAC {

    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account acocunt) throws ServletException, IOException {
        AdminDashBoardDBContext adminDAO = new AdminDashBoardDBContext();
        try {
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            java.sql.Date startDate = startDateStr != null ? java.sql.Date.valueOf(startDateStr) : java.sql.Date.valueOf("2025-03-13"); // 7 days ago
            java.sql.Date endDate = endDateStr != null ? java.sql.Date.valueOf(endDateStr) : java.sql.Date.valueOf("2025-03-19"); // Today

            int successReservations = adminDAO.getReservationCountByStatus("Completed", startDate, endDate);
            int cancelledReservations = adminDAO.getReservationCountByStatus("Cancelled", startDate, endDate);
            int submittedReservations = adminDAO.getReservationCountByStatus("Scheduled", startDate, endDate);
            double totalRevenue = adminDAO.getTotalRevenue(startDate, endDate);
            Map<String, Double> revenueByService = adminDAO.getRevenueByServiceCategory(startDate, endDate);
            int newlyReservedCustomers = adminDAO.getNewlyReservedCustomers(startDate, endDate);
            double avgStarTotal = adminDAO.getAverageStarFeedback(startDate, endDate);
            Map<String, Double> avgStarByService = adminDAO.getAverageStarByService(startDate, endDate);
            List<Map<String, Object>> reservationTrend = adminDAO.getReservationTrend(startDate, endDate);

            request.setAttribute("successReservations", successReservations);
            request.setAttribute("cancelledReservations", cancelledReservations);
            request.setAttribute("submittedReservations", submittedReservations);
            request.setAttribute("totalRevenue", String.format("%.2f", totalRevenue));
            request.setAttribute("revenueByService", revenueByService);
            request.setAttribute("newlyReservedCustomers", newlyReservedCustomers);
            request.setAttribute("avgStarTotal", String.format("%.1f", avgStarTotal));
            request.setAttribute("avgStarByService", avgStarByService);
            request.setAttribute("reservationTrend", reservationTrend);
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);

            request.getRequestDispatcher("../admin/admin-dashboard.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account acocunt) throws ServletException, IOException {
    }

}
