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
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import model.Reservation;

/**
 *
 * @author FPTSHOP
 */
@WebServlet(name = "NewServlet", urlPatterns = {"/c/NewServlet"})
public class NewServlet extends HttpServlet {

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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy các tham số từ request VNPay gửi về
        Map<String, String> fields = new HashMap<>();
        for (Enumeration<String> params = req.getParameterNames(); params.hasMoreElements();) {
            String fieldName = params.nextElement();
            String fieldValue = req.getParameter(fieldName);
            fields.put(fieldName, fieldValue);
        }

        // Xác minh chữ ký VNPay
        String vnp_SecureHash = fields.remove("vnp_SecureHash");
        List<String> fieldNames = new ArrayList<>(fields.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        for (String fieldName : fieldNames) {
            hashData.append(fieldName).append('=').append(fields.get(fieldName)).append('&');
        }
        hashData.deleteCharAt(hashData.length() - 1);

        try {
            String calculatedHash = hmacSHA512(VNPayServlet.VNP_HASH_SECRET, hashData.toString());
            if (calculatedHash.equals(vnp_SecureHash) && "00".equals(fields.get("vnp_ResponseCode"))) {
                req.setAttribute("message", "Payment successful!");

                // Lưu thông tin reservation vào database
                HttpSession session = req.getSession();
                Reservation r = (Reservation) session.getAttribute("reservation");

                if (r != null) {

                    r.setStatus("Scheduled");

                    ReservationDBContext rdb = new ReservationDBContext();
                    rdb.insertReservation(r);

                }
            } else {
                req.setAttribute("message", "Payment failed!");
            }
        } catch (Exception e) {
            req.setAttribute("message", "Payment verification error!");
        }

        // Gửi toàn bộ dữ liệu sang JSP để hiển thị
        for (Map.Entry<String, String> entry : fields.entrySet()) {
            req.setAttribute(entry.getKey(), entry.getValue());
        }

        req.getRequestDispatcher("vnpay-return.jsp").forward(req, resp);
    }

    private static String hmacSHA512(String key, String data) throws NoSuchAlgorithmException, InvalidKeyException {
        Mac sha512_HMAC = Mac.getInstance("HmacSHA512");
        SecretKeySpec secret_key = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
        sha512_HMAC.init(secret_key);
        byte[] hash = sha512_HMAC.doFinal(data.getBytes(StandardCharsets.UTF_8));
        StringBuilder result = new StringBuilder();
        for (byte b : hash) {
            result.append(String.format("%02x", b));
        }
        return result.toString();
    }

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
