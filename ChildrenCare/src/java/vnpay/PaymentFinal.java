/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package vnpay;

import dal.ReservationDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Payment;
import model.Reservation;

/**
 *
 * @author FPTSHOP
 */
@WebServlet(name = "PaymentFinal", urlPatterns = {"/c/PaymentFinal"})
public class PaymentFinal extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy các tham số từ VNPay callback
        String responseCode = request.getParameter("vnp_ResponseCode");
        String txnRef = request.getParameter("vnp_TxnRef");
        String orderInfo = request.getParameter("vnp_OrderInfo");
        String amount = request.getParameter("vnp_Amount");
        String payDate = request.getParameter("vnp_PayDate");
        String bankCode = request.getParameter("vnp_BankCode");

        // Chuyển đổi số tiền từ VNPay (VNPay trả về số tiền nhân 100)
        long amountValue = amount != null ? Long.parseLong(amount) / 100 : 0;

        HttpSession session = request.getSession();
        Reservation r = (Reservation) session.getAttribute("reservation");
        String fromCart = (String) session.getAttribute("isFromCart");
        Payment p = new Payment();

        if (responseCode.equals("00")) {
            if (r != null) {

                r.setStatus("Scheduled");

                ReservationDBContext rdb = new ReservationDBContext();
                int reserv_id = rdb.insertReservation(r);

                r.setId(reserv_id);

                p = r.getPayment();
                p.setReservation(r);

                rdb.insertPayment(p);

                if (fromCart != null && fromCart.length() != 0) {
                    rdb.deleteCart(r.getService().getId());
                }

            }
        }

        // Đặt các giá trị vào request attribute để hiển thị trong JSP
        request.setAttribute("vnp_ResponseCode", responseCode);
        request.setAttribute("vnp_TxnRef", txnRef);
        request.setAttribute("vnp_OrderInfo", orderInfo);
        request.setAttribute("vnp_Amount", amountValue);
        request.setAttribute("vnp_PayDate", payDate);
        request.setAttribute("vnp_BankCode", bankCode);

        request.getSession().removeAttribute("reservation");
        request.getSession().removeAttribute("isFromCart");

        // Chuyển hướng đến trang JSP hiển thị kết quả
        request.getRequestDispatcher("vnpay-return.jsp").forward(request, response);
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
