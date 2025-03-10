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
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Payment;
import model.Reservation;
import static vnpay.VNPayUtils.hmacSHA512;

/**
 *
 * @author FPTSHOP
 */
@WebServlet(name = "VNPayReturnServlet", urlPatterns = {"/vnpay-return"})
public class VNPayReturnServlet extends HttpServlet {

    private static final String VNP_HASH_SECRET = "23AW8VTNBO09FPULD7UPI7T6W72JIDOO";

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, String> fields = new HashMap<>();
        for (Enumeration<String> params = req.getParameterNames(); params.hasMoreElements();) {
            String fieldName = params.nextElement();
            String fieldValue = req.getParameter(fieldName);
            fields.put(fieldName, fieldValue);
        }

        String vnp_SecureHash = fields.remove("vnp_SecureHash");
        List<String> fieldNames = new ArrayList<>(fields.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        for (String fieldName : fieldNames) {
            hashData.append(fieldName).append('=').append(fields.get(fieldName)).append('&');
        }
        hashData.deleteCharAt(hashData.length() - 1);
        
        HttpSession session = req.getSession();
        Reservation r = (Reservation) session.getAttribute("reservation");
        String fromCart = (String) session.getAttribute("isFromCart");
        Payment p = new Payment();
        
        String responseCode = req.getParameter("vnp_ResponseCode");
        
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

        try {
            String calculatedHash = hmacSHA512(VNP_HASH_SECRET, hashData.toString());
            if (calculatedHash.equals(vnp_SecureHash) && "00".equals(fields.get("vnp_ResponseCode"))) {              
                req.setAttribute("message", "Payment successful!");
            } else {
                req.setAttribute("message", "Payment failed!");
            }
        } catch (Exception e) {
            req.setAttribute("message", "Payment verification error!");
        }
        
        req.getSession().removeAttribute("reservation");
        req.getSession().removeAttribute("isFromCart");
        req.getRequestDispatcher("c/vnpay-return.jsp").forward(req, resp);
        //req.getRequestDispatcher("c/PaymentFinal").forward(req, resp);
    }
}
