/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manage.service;

import controller.auth.BaseRBAC;
import dal.ReservationDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.Account;
import model.Service;

/**
 *
 * @author FPTSHOP
 */
@WebServlet(name = "AddToCart", urlPatterns = {"/AddToCart"})
public class AddToCart extends BaseRBAC {

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Account acocunt)
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
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Account acocunt)
            throws ServletException, IOException {
        String service_id = request.getParameter("service_id");
        String user_id = request.getParameter("user_id");

        int sid = -1;
        int uid = -1;

        if (service_id != null) {
            sid = Integer.parseInt(service_id);
        }

        if (user_id != null) {
            uid = Integer.parseInt(user_id);
        }

        ReservationDBContext rdb = new ReservationDBContext();
        String mess = "";
        String alertType = ""; // Lưu loại thông báo (success hoặc error)

        if (service_id != null && user_id != null) {
            if (!isExistService(sid, rdb.getServicesInCart(uid))) {
                rdb.addToCart(uid, sid);
                mess = "Add Successfully!";
                alertType = "success"; // Thành công thì hiển thị icon success
            } else {
                mess = "Service already in cart!";
                alertType = "error"; // Nếu thất bại, hiển thị icon error
            }
        } else {
            mess = "Invalid request!";
            alertType = "warning";
        }

        // Lưu thông báo vào sessionScope
        HttpSession session = request.getSession();
        session.setAttribute("cartMessage", mess);
        session.setAttribute("cartAlertType", alertType);

        response.sendRedirect("service-list");
    }

    public boolean isExistService(int sid, ArrayList<Service> list) {
        for (Service s : list) {
            if (s.getId() == sid) {
                return true;
            }
        }
        return false;
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
