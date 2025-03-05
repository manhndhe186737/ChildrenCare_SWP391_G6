/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package vnpay;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
        for (Enumeration<String> params = req.getParameterNames(); params.hasMoreElements(); ) {
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
        req.getRequestDispatcher("payment-result.jsp").forward(req, resp);
    }
}
